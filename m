Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE4D6F63C9
	for <lists+linux-crypto@lfdr.de>; Thu,  4 May 2023 05:59:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjEDD7r (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 3 May 2023 23:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjEDD7r (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 3 May 2023 23:59:47 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64A6FE45;
        Wed,  3 May 2023 20:59:45 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1puQ7v-0051wS-Ps; Thu, 04 May 2023 11:59:33 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 May 2023 11:59:32 +0800
Date:   Thu, 4 May 2023 11:59:32 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, olivia@selenic.com,
        syzkaller-bugs@googlegroups.com, Jason Wang <jasowang@redhat.com>,
        Laurent Vivier <lvivier@redhat.com>,
        Rusty Russell <rusty@rustcorp.com.au>
Subject: [v2 PATCH] hwrng: virtio - Fix race on data_avail and actual data
Message-ID: <ZFMtpC18ykLd/jf2@gondor.apana.org.au>
References: <00000000000050327205f9d993b2@google.com>
 <CACT4Y+awU85RHZjf3+_85AvJOHghoOhH3c9E-70p+a=FrRDYkg@mail.gmail.com>
 <ZFI9bHr1o2Cvdebp@gondor.apana.org.au>
 <20230503073220-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230503073220-mutt-send-email-mst@kernel.org>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, May 03, 2023 at 07:37:00AM -0400, Michael S. Tsirkin wrote:
>
> On the surface of it, it looks like you removed this store
> which isn't described in the commit log.
> I do not, offhand, remember why we stored 0 in data_idx here
> when we also zero it in request_entropy.
> It was added with

Yes I removed because it's redundant.  But you're right I'll add
a note about it in the log:

---8<---
The virtio rng device kicks off a new entropy request whenever the
data available reaches zero.  When a new request occurs at the end
of a read operation, that is, when the result of that request is
only needed by the next reader, then there is a race between the
writing of the new data and the next reader.

This is because there is no synchronisation whatsoever between the
writer and the reader.

Fix this by writing data_avail with smp_store_release and reading
it with smp_load_acquire when we first enter read.  The subsequent
reads are safe because they're either protected by the first load
acquire, or by the completion mechanism.

Also remove the redundant zeroing of data_idx in random_recv_done
(data_idx must already be zero at this point) and data_avail in
request_entropy (ditto).

Reported-by: syzbot+726dc8c62c3536431ceb@syzkaller.appspotmail.com
Fixes: f7f510ec1957 ("virtio: An entropy device, as suggested by hpa.")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
index f7690e0f92ed..e41a84e6b4b5 100644
--- a/drivers/char/hw_random/virtio-rng.c
+++ b/drivers/char/hw_random/virtio-rng.c
@@ -4,6 +4,7 @@
  *  Copyright (C) 2007, 2008 Rusty Russell IBM Corporation
  */
 
+#include <asm/barrier.h>
 #include <linux/err.h>
 #include <linux/hw_random.h>
 #include <linux/scatterlist.h>
@@ -37,13 +38,13 @@ struct virtrng_info {
 static void random_recv_done(struct virtqueue *vq)
 {
 	struct virtrng_info *vi = vq->vdev->priv;
+	unsigned int len;
 
 	/* We can get spurious callbacks, e.g. shared IRQs + virtio_pci. */
-	if (!virtqueue_get_buf(vi->vq, &vi->data_avail))
+	if (!virtqueue_get_buf(vi->vq, &len))
 		return;
 
-	vi->data_idx = 0;
-
+	smp_store_release(&vi->data_avail, len);
 	complete(&vi->have_data);
 }
 
@@ -52,7 +53,6 @@ static void request_entropy(struct virtrng_info *vi)
 	struct scatterlist sg;
 
 	reinit_completion(&vi->have_data);
-	vi->data_avail = 0;
 	vi->data_idx = 0;
 
 	sg_init_one(&sg, vi->data, sizeof(vi->data));
@@ -88,7 +88,7 @@ static int virtio_read(struct hwrng *rng, void *buf, size_t size, bool wait)
 	read = 0;
 
 	/* copy available data */
-	if (vi->data_avail) {
+	if (smp_load_acquire(&vi->data_avail)) {
 		chunk = copy_data(vi, buf, size);
 		size -= chunk;
 		read += chunk;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
