Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 162E4252FF7
	for <lists+linux-crypto@lfdr.de>; Wed, 26 Aug 2020 15:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730322AbgHZNc1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 26 Aug 2020 09:32:27 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:33154 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730289AbgHZNa5 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 26 Aug 2020 09:30:57 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kAvUu-00052u-Ib; Wed, 26 Aug 2020 23:29:53 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 26 Aug 2020 23:29:52 +1000
Date:   Wed, 26 Aug 2020 23:29:52 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andrew Zaborowski <andrew.zaborowski@intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Caleb Jorden <caljorden@hotmail.com>,
        Sasha Levin <sashal@kernel.org>, iwd@lists.01.org,
        "# 3.4.x" <stable@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: af_alg - Work around empty control messages without
 MSG_MORE
Message-ID: <20200826132952.GA4752@gondor.apana.org.au>
References: <20200826055150.2753.90553@ml01.vlan13.01.org>
 <b34f7644-a495-4845-0a00-0aebf4b9db52@molgen.mpg.de>
 <CAMj1kXEUQdmQDCDXPBNb3hRrbui=HVyDjCDoiFwDr+mDSjP43A@mail.gmail.com>
 <20200826114952.GA2375@gondor.apana.org.au>
 <CAMj1kXGjytfJEbLMbz50it3okQfiLScHB5YK2FMqR5CsmFEBbg@mail.gmail.com>
 <20200826120832.GA2996@gondor.apana.org.au>
 <CAOq732JaP=4X9Yh_KjER5_ctQWoauxzXTZqyFP9KsLSxvVH8=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOq732JaP=4X9Yh_KjER5_ctQWoauxzXTZqyFP9KsLSxvVH8=w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The iwd daemon uses libell which sets up the skcipher operation with
two separate control messages.  This is fine by itself but the first
control message is sent without MSG_MORE.  This means that the first
control message is interpreted as an empty request.

While libell should be fixed to use MSG_MORE where appropriate, this
patch works around the bug in the kernel so that existing binaries
continue to work.

We will print a warning however.

Reported-by: Caleb Jorden <caljorden@hotmail.com>
Fixes: f3c802a1f300 ("crypto: algif_aead - Only wake up when...")
Cc: <stable@vger.kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index a6f581ab200c..3da21cadc326 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -16,6 +16,7 @@
 #include <linux/module.h>
 #include <linux/net.h>
 #include <linux/rwsem.h>
+#include <linux/sched.h>
 #include <linux/sched/signal.h>
 #include <linux/security.h>
 
@@ -846,8 +847,14 @@ int af_alg_sendmsg(struct socket *sock, struct msghdr *msg, size_t size,
 
 	lock_sock(sk);
 	if (ctx->init && (init || !ctx->more)) {
-		err = -EINVAL;
-		goto unlock;
+		if (ctx->used) {
+			err = -EINVAL;
+			goto unlock;
+		}
+
+		pr_info_once(
+			"%s sent an empty control message without MSG_MORE.\n",
+			current->comm);
 	}
 	ctx->init = true;
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
