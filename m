Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6541E7E78
	for <lists+linux-crypto@lfdr.de>; Fri, 29 May 2020 15:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgE2NSV (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 29 May 2020 09:18:21 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:40788 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgE2NSV (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 29 May 2020 09:18:21 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jeetn-0006gL-7k; Fri, 29 May 2020 23:18:12 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 29 May 2020 23:18:11 +1000
Date:   Fri, 29 May 2020 23:18:11 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>
Subject: [PATCH] crypto: algif_aead - Only wake up when ctx->more is zero
Message-ID: <20200529131811.GA9137@gondor.apana.org.au>
References: <20200529045443.GA475@gondor.apana.org.au>
 <20200529124048.GA7283@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529124048.GA7283@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

AEAD does not support partial requests so we must not wake up
while ctx->more is set.  While we're fixing this also change
algif_skcipher to only wake up when at least a block is available
as otherwise we'd just fail straight away with -EINVAL.

Fixes: 2d97591ef43d ("crypto: af_alg - consolidation of...")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index b1cd3535c5256..474a9511f0ed4 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -738,9 +738,10 @@ EXPORT_SYMBOL_GPL(af_alg_wmem_wakeup);
  *
  * @sk socket of connection to user space
  * @flags If MSG_DONTWAIT is set, then only report if function would sleep
+ * @min Set to minimum request size if partial requests are allowed.
  * @return 0 when writable memory is available, < 0 upon error
  */
-int af_alg_wait_for_data(struct sock *sk, unsigned flags)
+int af_alg_wait_for_data(struct sock *sk, unsigned flags, unsigned min)
 {
 	DEFINE_WAIT_FUNC(wait, woken_wake_function);
 	struct alg_sock *ask = alg_sk(sk);
@@ -758,7 +759,8 @@ int af_alg_wait_for_data(struct sock *sk, unsigned flags)
 		if (signal_pending(current))
 			break;
 		timeout = MAX_SCHEDULE_TIMEOUT;
-		if (sk_wait_event(sk, &timeout, (ctx->used || !ctx->more),
+		if (sk_wait_event(sk, &timeout,
+				  (min && ctx->used >= min) || !ctx->more,
 				  &wait)) {
 			err = 0;
 			break;
diff --git a/crypto/algif_aead.c b/crypto/algif_aead.c
index eb1910b6d434c..efea00046be65 100644
--- a/crypto/algif_aead.c
+++ b/crypto/algif_aead.c
@@ -107,7 +107,7 @@ static int _aead_recvmsg(struct socket *sock, struct msghdr *msg,
 	size_t processed = 0;		/* [in]  TX bufs to be consumed */
 
 	if (!ctx->used) {
-		err = af_alg_wait_for_data(sk, flags);
+		err = af_alg_wait_for_data(sk, flags, 0);
 		if (err)
 			return err;
 	}
diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index 24dd2fc2431cc..5b334fd9432c0 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -62,7 +62,7 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
 	size_t len = 0;
 
 	if (!ctx->used) {
-		err = af_alg_wait_for_data(sk, flags);
+		err = af_alg_wait_for_data(sk, flags, bs);
 		if (err)
 			return err;
 	}
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index 56527c85d1222..e1e5525473e4c 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -226,7 +226,7 @@ unsigned int af_alg_count_tsgl(struct sock *sk, size_t bytes, size_t offset);
 void af_alg_pull_tsgl(struct sock *sk, size_t used, struct scatterlist *dst,
 		      size_t dst_offset);
 void af_alg_wmem_wakeup(struct sock *sk);
-int af_alg_wait_for_data(struct sock *sk, unsigned flags);
+int af_alg_wait_for_data(struct sock *sk, unsigned flags, unsigned min);
 int af_alg_sendmsg(struct socket *sock, struct msghdr *msg, size_t size,
 		   unsigned int ivsize);
 ssize_t af_alg_sendpage(struct socket *sock, struct page *page,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
