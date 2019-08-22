Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5814D992E3
	for <lists+linux-crypto@lfdr.de>; Thu, 22 Aug 2019 14:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfHVMJT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 22 Aug 2019 08:09:19 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:58490 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731326AbfHVMJS (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 22 Aug 2019 08:09:18 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1i0ltz-0002EZ-S2; Thu, 22 Aug 2019 22:09:15 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1i0ltz-0001tZ-Di; Thu, 22 Aug 2019 22:09:15 +1000
Date:   Thu, 22 Aug 2019 22:09:15 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: crypto: talitos - Fix build warning in aead_des3_setkey
Message-ID: <20190822120915.GA7267@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch removes the variable flags which is now unused thanks
to the new DES helpers.

Fixes: 9d574ae8ebc1 ("crypto: talitos/des - switch to new...")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/talitos.c b/drivers/crypto/talitos.c
index 117c831..cb6c10b 100644
--- a/drivers/crypto/talitos.c
+++ b/drivers/crypto/talitos.c
@@ -925,7 +925,6 @@ static int aead_des3_setkey(struct crypto_aead *authenc,
 	struct talitos_ctx *ctx = crypto_aead_ctx(authenc);
 	struct device *dev = ctx->dev;
 	struct crypto_authenc_keys keys;
-	u32 flags;
 	int err;
 
 	err = crypto_authenc_extractkeys(&keys, key, keylen);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
