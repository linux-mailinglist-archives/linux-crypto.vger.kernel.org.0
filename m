Return-Path: <linux-crypto+bounces-375-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 080057FCF44
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Nov 2023 07:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A015282382
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Nov 2023 06:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0FC107AC
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Nov 2023 06:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA17819A6
	for <linux-crypto@vger.kernel.org>; Tue, 28 Nov 2023 22:29:43 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1r8E4p-004jEw-I3; Wed, 29 Nov 2023 14:29:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 29 Nov 2023 14:29:48 +0800
From: "Herbert Xu" <herbert@gondor.apana.org.au>
Date: Wed, 29 Nov 2023 14:29:48 +0800
Subject: [PATCH 3/4] crypto: arc4 - Add internal state
References: <ZWbZEnSPIP5aHydB@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>, Linux Crypto Mailing List <linux-crypto@vger.kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Message-Id: <E1r8E4p-004jEw-I3@formenos.hmeau.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

The arc4 algorithm has always had internal state.  It's been buggy
from day one in that the state has been stored in the shared tfm
object.  That means two users sharing the same tfm will end up
affecting each other's output, or worse, they may end up with the
same output.

Fix this by declaring an internal state and storing the state there
instead of within the tfm context.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 crypto/arc4.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/crypto/arc4.c b/crypto/arc4.c
index 2150f94e7d03..e285bfcef667 100644
--- a/crypto/arc4.c
+++ b/crypto/arc4.c
@@ -23,10 +23,15 @@ static int crypto_arc4_setkey(struct crypto_lskcipher *tfm, const u8 *in_key,
 }
 
 static int crypto_arc4_crypt(struct crypto_lskcipher *tfm, const u8 *src,
-			     u8 *dst, unsigned nbytes, u8 *iv, u32 flags)
+			     u8 *dst, unsigned nbytes, u8 *siv, u32 flags)
 {
 	struct arc4_ctx *ctx = crypto_lskcipher_ctx(tfm);
 
+	if (!(flags & CRYPTO_LSKCIPHER_FLAG_CONT))
+		memcpy(siv, ctx, sizeof(*ctx));
+
+	ctx = (struct arc4_ctx *)siv;
+
 	arc4_crypt(ctx, dst, src, nbytes);
 	return 0;
 }
@@ -48,6 +53,7 @@ static struct lskcipher_alg arc4_alg = {
 	.co.base.cra_module		=	THIS_MODULE,
 	.co.min_keysize			=	ARC4_MIN_KEY_SIZE,
 	.co.max_keysize			=	ARC4_MAX_KEY_SIZE,
+	.co.statesize			=	sizeof(struct arc4_ctx),
 	.setkey				=	crypto_arc4_setkey,
 	.encrypt			=	crypto_arc4_crypt,
 	.decrypt			=	crypto_arc4_crypt,

