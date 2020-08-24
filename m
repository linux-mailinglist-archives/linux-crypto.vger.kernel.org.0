Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E53224FEE5
	for <lists+linux-crypto@lfdr.de>; Mon, 24 Aug 2020 15:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgHXNau (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 24 Aug 2020 09:30:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:55260 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbgHXNad (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 24 Aug 2020 09:30:33 -0400
Received: from e123331-lin.arnhem.chello.nl (dhcp-077-251-017-237.chello.nl [77.251.17.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2A08720706;
        Mon, 24 Aug 2020 13:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598275833;
        bh=EyNe/Jqx1lEy+gis8qzIi7lgHKCZTcsoHSdgF9p8kIw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QzFppfWSXcpqgDj6sj6eapLzV/bylB2cr/ca8L1XG3FY2URc0sjb2a7h+h+OtoKVZ
         jB22RMuRw7PIfKtcCs6xVL/8WjzDHmYg5nTKftVxomtXJvM05uC9GFFQ5CRzHBWpG6
         4cH3uv8eKA2ethY741wRK+ozvLVcti47lTSmWgf0=
From:   Ard Biesheuvel <ardb@kernel.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Eric Biggers <ebiggers@google.com>,
        Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-nfs@vger.kernel.org
Subject: [PATCH v2 4/7] crypto: n2 - remove ecb(arc4) support
Date:   Mon, 24 Aug 2020 15:29:58 +0200
Message-Id: <20200824133001.9546-5-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824133001.9546-1-ardb@kernel.org>
References: <20200824133001.9546-1-ardb@kernel.org>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/crypto/n2_core.c | 46 --------------------
 1 file changed, 46 deletions(-)

diff --git a/drivers/crypto/n2_core.c b/drivers/crypto/n2_core.c
index d8aec5153b21..8c8e17d5fb20 100644
--- a/drivers/crypto/n2_core.c
+++ b/drivers/crypto/n2_core.c
@@ -662,7 +662,6 @@ struct n2_skcipher_context {
 		u8		aes[AES_MAX_KEY_SIZE];
 		u8		des[DES_KEY_SIZE];
 		u8		des3[3 * DES_KEY_SIZE];
-		u8		arc4[258]; /* S-box, X, Y */
 	} key;
 };
 
@@ -789,36 +788,6 @@ static int n2_3des_setkey(struct crypto_skcipher *skcipher, const u8 *key,
 	return 0;
 }
 
-static int n2_arc4_setkey(struct crypto_skcipher *skcipher, const u8 *key,
-			  unsigned int keylen)
-{
-	struct crypto_tfm *tfm = crypto_skcipher_tfm(skcipher);
-	struct n2_skcipher_context *ctx = crypto_tfm_ctx(tfm);
-	struct n2_skcipher_alg *n2alg = n2_skcipher_alg(skcipher);
-	u8 *s = ctx->key.arc4;
-	u8 *x = s + 256;
-	u8 *y = x + 1;
-	int i, j, k;
-
-	ctx->enc_type = n2alg->enc_type;
-
-	j = k = 0;
-	*x = 0;
-	*y = 0;
-	for (i = 0; i < 256; i++)
-		s[i] = i;
-	for (i = 0; i < 256; i++) {
-		u8 a = s[i];
-		j = (j + key[k] + a) & 0xff;
-		s[i] = s[j];
-		s[j] = a;
-		if (++k >= keylen)
-			k = 0;
-	}
-
-	return 0;
-}
-
 static inline int skcipher_descriptor_len(int nbytes, unsigned int block_size)
 {
 	int this_len = nbytes;
@@ -1122,21 +1091,6 @@ struct n2_skcipher_tmpl {
 };
 
 static const struct n2_skcipher_tmpl skcipher_tmpls[] = {
-	/* ARC4: only ECB is supported (chaining bits ignored) */
-	{	.name		= "ecb(arc4)",
-		.drv_name	= "ecb-arc4",
-		.block_size	= 1,
-		.enc_type	= (ENC_TYPE_ALG_RC4_STREAM |
-				   ENC_TYPE_CHAINING_ECB),
-		.skcipher	= {
-			.min_keysize	= 1,
-			.max_keysize	= 256,
-			.setkey		= n2_arc4_setkey,
-			.encrypt	= n2_encrypt_ecb,
-			.decrypt	= n2_decrypt_ecb,
-		},
-	},
-
 	/* DES: ECB CBC and CFB are supported */
 	{	.name		= "ecb(des)",
 		.drv_name	= "ecb-des",
-- 
2.17.1

