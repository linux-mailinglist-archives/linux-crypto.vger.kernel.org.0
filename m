Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BA6468FC8F
	for <lists+linux-crypto@lfdr.de>; Thu,  9 Feb 2023 02:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbjBIBRB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 8 Feb 2023 20:17:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbjBIBQw (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 8 Feb 2023 20:16:52 -0500
Received: from formenos.hmeau.com (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89125B771
        for <linux-crypto@vger.kernel.org>; Wed,  8 Feb 2023 17:16:50 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pPvYL-0096N3-5E; Thu, 09 Feb 2023 09:16:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 09 Feb 2023 09:16:45 +0800
Date:   Thu, 9 Feb 2023 09:16:45 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH] crypto: proc - Print fips status
Message-ID: <Y+RJfZ5o59azXqSc@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_RDNS_DYNAMIC_FP,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

As FIPS may disable algorithms it is useful to show their status
in /proc/crypto.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/proc.c b/crypto/proc.c
index 12fccb9c5205..56c7c78df297 100644
--- a/crypto/proc.c
+++ b/crypto/proc.c
@@ -11,6 +11,7 @@
 #include <linux/atomic.h>
 #include <linux/init.h>
 #include <linux/crypto.h>
+#include <linux/fips.h>
 #include <linux/module.h>	/* for module_name() */
 #include <linux/rwsem.h>
 #include <linux/proc_fs.h>
@@ -48,6 +49,11 @@ static int c_show(struct seq_file *m, void *p)
 	seq_printf(m, "internal     : %s\n",
 		   (alg->cra_flags & CRYPTO_ALG_INTERNAL) ?
 		   "yes" : "no");
+	if (fips_enabled) {
+		seq_printf(m, "fips         : %s\n",
+			   (alg->cra_flags & CRYPTO_ALG_FIPS_INTERNAL) ?
+			   "no" : "yes");
+	}
 
 	if (alg->cra_flags & CRYPTO_ALG_LARVAL) {
 		seq_printf(m, "type         : larval\n");
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
