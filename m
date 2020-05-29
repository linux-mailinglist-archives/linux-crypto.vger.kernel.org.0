Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73EBD1E7524
	for <lists+linux-crypto@lfdr.de>; Fri, 29 May 2020 06:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgE2Eyt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 29 May 2020 00:54:49 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:39650 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbgE2Eyt (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 29 May 2020 00:54:49 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jeX2Z-0004Nr-GN; Fri, 29 May 2020 14:54:44 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 29 May 2020 14:54:43 +1000
Date:   Fri, 29 May 2020 14:54:43 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>
Subject: [PATCH] crypto: algif_skcipher - Cap recv SG list at ctx->used
Message-ID: <20200529045443.GA475@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Somewhere along the line the cap on the SG list length for receive
was lost.  This patch restores it and removes the subsequent test
which is now redundant.

Fixes: 2d97591ef43d ("crypto: af_alg - consolidation of...")
Cc: <stable@vger.kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index e2c8ab408bed..4c3bdffe0c3a 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -74,14 +74,10 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
 		return PTR_ERR(areq);
 
 	/* convert iovecs of output buffers into RX SGL */
-	err = af_alg_get_rsgl(sk, msg, flags, areq, -1, &len);
+	err = af_alg_get_rsgl(sk, msg, flags, areq, ctx->used, &len);
 	if (err)
 		goto free;
 
-	/* Process only as much RX buffers for which we have TX data */
-	if (len > ctx->used)
-		len = ctx->used;
-
 	/*
 	 * If more buffers are to be expected to be processed, process only
 	 * full block size buffers.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
