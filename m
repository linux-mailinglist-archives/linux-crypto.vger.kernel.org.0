Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A111E7D66
	for <lists+linux-crypto@lfdr.de>; Fri, 29 May 2020 14:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgE2MlB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 29 May 2020 08:41:01 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:40720 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725901AbgE2MlB (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 29 May 2020 08:41:01 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jeeJc-0005xg-GM; Fri, 29 May 2020 22:40:49 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 29 May 2020 22:40:48 +1000
Date:   Fri, 29 May 2020 22:40:48 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Stephan Mueller <smueller@chronox.de>
Subject: [PATCH] crypto: algif_skcipher - Do not perform zero-length ops
Message-ID: <20200529124048.GA7283@gondor.apana.org.au>
References: <20200529045443.GA475@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529045443.GA475@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

If a read(2) of less than a full block size is attempted we will
end up doing a zero-length operation.  This patch makes that return
-EINVAL instead, which is what we did originally.

Fixes: e870456d8e7c ("crypto: algif_skcipher - overhaul memory...")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
index 4c3bdffe0c3a5..24dd2fc2431cc 100644
--- a/crypto/algif_skcipher.c
+++ b/crypto/algif_skcipher.c
@@ -85,6 +85,10 @@ static int _skcipher_recvmsg(struct socket *sock, struct msghdr *msg,
 	if (ctx->more || len < ctx->used)
 		len -= len % bs;
 
+	err = -EINVAL;
+	if (!len)
+		goto free;
+
 	/*
 	 * Create a per request TX SGL for this request which tracks the
 	 * SG entries from the global TX SGL.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
