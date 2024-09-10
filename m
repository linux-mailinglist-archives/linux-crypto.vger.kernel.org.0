Return-Path: <linux-crypto+bounces-6745-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA39973ABA
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Sep 2024 16:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0CE289236
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Sep 2024 14:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF3D8195FEC;
	Tue, 10 Sep 2024 14:57:12 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mailout3.hostsharing.net (mailout3.hostsharing.net [176.9.242.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 278851DFD1;
	Tue, 10 Sep 2024 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725980232; cv=none; b=I34PGIjs0KKZYTyvC2cYBb2lytUC2Vq2rXJP4hvqZ+slnjIzj3A0WzCYzWkU3JIFLqAsMnjhYSAudCc/WxbMh+7i/TYB5e5QHc0+u+LXvTNMApspZXcW0umkrbjXzeuUiz4Nf+5IHkElzzDaOQZLvspYPLHrBTfVFzjZ4454wWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725980232; c=relaxed/simple;
	bh=D8vEEU2OdO86aOOH5yOagFYVheqyrECTJgudWl1Et5s=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=UgPVljYz7UuvFg/VN0oCY7qZcCDQNONrr2PJreD4zjfc/H6y80AwHMQgfPKW5kj+JzGO1/bE5H4XQAJhJUKxPUv6vsZen6HKPHro4Xil5Fl/wfgED7Yj0Bx48rsmnQN+xKTwAC5a9CNog07m5gkyMzsY9ARg0PFn7hj+cEJImvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=176.9.242.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout3.hostsharing.net (Postfix) with ESMTPS id D0AC6101EA41A;
	Tue, 10 Sep 2024 16:57:07 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 817866039371;
	Tue, 10 Sep 2024 16:57:07 +0200 (CEST)
X-Mailbox-Line: From 4118042ba36ee09d0761d53a809d3b2e250270c5 Mon Sep 17 00:00:00 2001
Message-ID: <4118042ba36ee09d0761d53a809d3b2e250270c5.1725972334.git.lukas@wunner.de>
In-Reply-To: <cover.1725972333.git.lukas@wunner.de>
References: <cover.1725972333.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Tue, 10 Sep 2024 16:30:13 +0200
Subject: [PATCH v2 03/19] crypto: ecdsa - Migrate to sig_alg backend
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Eric Biggers <ebiggers@google.com>, Stefan Berger <stefanb@linux.ibm.com>, Vitaly Chikunov <vt@altlinux.org>, Tadeusz Struk <tstruk@gigaio.com>
Cc: David Howells <dhowells@redhat.com>, Andrew Zaborowski <andrew.zaborowski@intel.com>, Saulo Alessandre <saulo.alessandre@tse.jus.br>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, Ignat Korchagin <ignat@cloudflare.com>, Marek Behun <kabel@kernel.org>, Varad Gautam <varadgautam@google.com>, Stephan Mueller <smueller@chronox.de>, Denis Kenzior <denkenz@gmail.com>, linux-crypto@vger.kernel.org, keyrings@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

A sig_alg backend has just been introduced with the intent of moving all
asymmetric sign/verify algorithms to it one by one.

Migrate ecdsa.c to the new backend.

One benefit of the new API is the use of kernel buffers instead of
sglists, which avoids the overhead of copying signature and digest
sglists back into kernel buffers.  ecdsa.c is thus simplified quite
a bit.

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 crypto/Kconfig   |  2 +-
 crypto/ecdsa.c   | 99 ++++++++++++++++++++----------------------------
 crypto/testmgr.c | 17 ++++-----
 crypto/testmgr.h | 27 ++-----------
 4 files changed, 55 insertions(+), 90 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 84778611e2d7..89b728c72f07 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -290,7 +290,7 @@ config CRYPTO_ECDH
 config CRYPTO_ECDSA
 	tristate "ECDSA (Elliptic Curve Digital Signature Algorithm)"
 	select CRYPTO_ECC
-	select CRYPTO_AKCIPHER
+	select CRYPTO_SIG
 	select ASN1
 	help
 	  ECDSA (Elliptic Curve Digital Signature Algorithm) (FIPS 186,
diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index d5a10959ec28..3b9873f56b0a 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -4,12 +4,11 @@
  */
 
 #include <linux/module.h>
-#include <crypto/internal/akcipher.h>
 #include <crypto/internal/ecc.h>
-#include <crypto/akcipher.h>
+#include <crypto/internal/sig.h>
 #include <crypto/ecdh.h>
+#include <crypto/sig.h>
 #include <linux/asn1_decoder.h>
-#include <linux/scatterlist.h>
 
 #include "ecdsasignature.asn1.h"
 
@@ -126,46 +125,31 @@ static int _ecdsa_verify(struct ecc_ctx *ctx, const u64 *hash, const u64 *r, con
 /*
  * Verify an ECDSA signature.
  */
-static int ecdsa_verify(struct akcipher_request *req)
+static int ecdsa_verify(struct crypto_sig *tfm,
+			const void *src, unsigned int slen,
+			const void *digest, unsigned int dlen)
 {
-	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
-	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct ecc_ctx *ctx = crypto_sig_ctx(tfm);
 	size_t bufsize = ctx->curve->g.ndigits * sizeof(u64);
 	struct ecdsa_signature_ctx sig_ctx = {
 		.curve = ctx->curve,
 	};
 	u64 hash[ECC_MAX_DIGITS];
-	unsigned char *buffer;
 	int ret;
 
 	if (unlikely(!ctx->pub_key_set))
 		return -EINVAL;
 
-	buffer = kmalloc(req->src_len + req->dst_len, GFP_KERNEL);
-	if (!buffer)
-		return -ENOMEM;
-
-	sg_pcopy_to_buffer(req->src,
-		sg_nents_for_len(req->src, req->src_len + req->dst_len),
-		buffer, req->src_len + req->dst_len, 0);
-
-	ret = asn1_ber_decoder(&ecdsasignature_decoder, &sig_ctx,
-			       buffer, req->src_len);
+	ret = asn1_ber_decoder(&ecdsasignature_decoder, &sig_ctx, src, slen);
 	if (ret < 0)
-		goto error;
-
-	if (bufsize > req->dst_len)
-		bufsize = req->dst_len;
-
-	ecc_digits_from_bytes(buffer + req->src_len, bufsize,
-			      hash, ctx->curve->g.ndigits);
+		return ret;
 
-	ret = _ecdsa_verify(ctx, hash, sig_ctx.r, sig_ctx.s);
+	if (bufsize > dlen)
+		bufsize = dlen;
 
-error:
-	kfree(buffer);
+	ecc_digits_from_bytes(digest, bufsize, hash, ctx->curve->g.ndigits);
 
-	return ret;
+	return _ecdsa_verify(ctx, hash, sig_ctx.r, sig_ctx.s);
 }
 
 static int ecdsa_ecc_ctx_init(struct ecc_ctx *ctx, unsigned int curve_id)
@@ -201,9 +185,10 @@ static int ecdsa_ecc_ctx_reset(struct ecc_ctx *ctx)
  * Set the public ECC key as defined by RFC5480 section 2.2 "Subject Public
  * Key". Only the uncompressed format is supported.
  */
-static int ecdsa_set_pub_key(struct crypto_akcipher *tfm, const void *key, unsigned int keylen)
+static int ecdsa_set_pub_key(struct crypto_sig *tfm, const void *key,
+			     unsigned int keylen)
 {
-	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct ecc_ctx *ctx = crypto_sig_ctx(tfm);
 	unsigned int digitlen, ndigits;
 	const unsigned char *d = key;
 	int ret;
@@ -237,28 +222,28 @@ static int ecdsa_set_pub_key(struct crypto_akcipher *tfm, const void *key, unsig
 	return ret;
 }
 
-static void ecdsa_exit_tfm(struct crypto_akcipher *tfm)
+static void ecdsa_exit_tfm(struct crypto_sig *tfm)
 {
-	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct ecc_ctx *ctx = crypto_sig_ctx(tfm);
 
 	ecdsa_ecc_ctx_deinit(ctx);
 }
 
-static unsigned int ecdsa_max_size(struct crypto_akcipher *tfm)
+static unsigned int ecdsa_max_size(struct crypto_sig *tfm)
 {
-	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct ecc_ctx *ctx = crypto_sig_ctx(tfm);
 
 	return DIV_ROUND_UP(ctx->curve->nbits, 8);
 }
 
-static int ecdsa_nist_p521_init_tfm(struct crypto_akcipher *tfm)
+static int ecdsa_nist_p521_init_tfm(struct crypto_sig *tfm)
 {
-	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct ecc_ctx *ctx = crypto_sig_ctx(tfm);
 
 	return ecdsa_ecc_ctx_init(ctx, ECC_CURVE_NIST_P521);
 }
 
-static struct akcipher_alg ecdsa_nist_p521 = {
+static struct sig_alg ecdsa_nist_p521 = {
 	.verify = ecdsa_verify,
 	.set_pub_key = ecdsa_set_pub_key,
 	.max_size = ecdsa_max_size,
@@ -273,14 +258,14 @@ static struct akcipher_alg ecdsa_nist_p521 = {
 	},
 };
 
-static int ecdsa_nist_p384_init_tfm(struct crypto_akcipher *tfm)
+static int ecdsa_nist_p384_init_tfm(struct crypto_sig *tfm)
 {
-	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct ecc_ctx *ctx = crypto_sig_ctx(tfm);
 
 	return ecdsa_ecc_ctx_init(ctx, ECC_CURVE_NIST_P384);
 }
 
-static struct akcipher_alg ecdsa_nist_p384 = {
+static struct sig_alg ecdsa_nist_p384 = {
 	.verify = ecdsa_verify,
 	.set_pub_key = ecdsa_set_pub_key,
 	.max_size = ecdsa_max_size,
@@ -295,14 +280,14 @@ static struct akcipher_alg ecdsa_nist_p384 = {
 	},
 };
 
-static int ecdsa_nist_p256_init_tfm(struct crypto_akcipher *tfm)
+static int ecdsa_nist_p256_init_tfm(struct crypto_sig *tfm)
 {
-	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct ecc_ctx *ctx = crypto_sig_ctx(tfm);
 
 	return ecdsa_ecc_ctx_init(ctx, ECC_CURVE_NIST_P256);
 }
 
-static struct akcipher_alg ecdsa_nist_p256 = {
+static struct sig_alg ecdsa_nist_p256 = {
 	.verify = ecdsa_verify,
 	.set_pub_key = ecdsa_set_pub_key,
 	.max_size = ecdsa_max_size,
@@ -317,14 +302,14 @@ static struct akcipher_alg ecdsa_nist_p256 = {
 	},
 };
 
-static int ecdsa_nist_p192_init_tfm(struct crypto_akcipher *tfm)
+static int ecdsa_nist_p192_init_tfm(struct crypto_sig *tfm)
 {
-	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct ecc_ctx *ctx = crypto_sig_ctx(tfm);
 
 	return ecdsa_ecc_ctx_init(ctx, ECC_CURVE_NIST_P192);
 }
 
-static struct akcipher_alg ecdsa_nist_p192 = {
+static struct sig_alg ecdsa_nist_p192 = {
 	.verify = ecdsa_verify,
 	.set_pub_key = ecdsa_set_pub_key,
 	.max_size = ecdsa_max_size,
@@ -345,42 +330,42 @@ static int __init ecdsa_init(void)
 	int ret;
 
 	/* NIST p192 may not be available in FIPS mode */
-	ret = crypto_register_akcipher(&ecdsa_nist_p192);
+	ret = crypto_register_sig(&ecdsa_nist_p192);
 	ecdsa_nist_p192_registered = ret == 0;
 
-	ret = crypto_register_akcipher(&ecdsa_nist_p256);
+	ret = crypto_register_sig(&ecdsa_nist_p256);
 	if (ret)
 		goto nist_p256_error;
 
-	ret = crypto_register_akcipher(&ecdsa_nist_p384);
+	ret = crypto_register_sig(&ecdsa_nist_p384);
 	if (ret)
 		goto nist_p384_error;
 
-	ret = crypto_register_akcipher(&ecdsa_nist_p521);
+	ret = crypto_register_sig(&ecdsa_nist_p521);
 	if (ret)
 		goto nist_p521_error;
 
 	return 0;
 
 nist_p521_error:
-	crypto_unregister_akcipher(&ecdsa_nist_p384);
+	crypto_unregister_sig(&ecdsa_nist_p384);
 
 nist_p384_error:
-	crypto_unregister_akcipher(&ecdsa_nist_p256);
+	crypto_unregister_sig(&ecdsa_nist_p256);
 
 nist_p256_error:
 	if (ecdsa_nist_p192_registered)
-		crypto_unregister_akcipher(&ecdsa_nist_p192);
+		crypto_unregister_sig(&ecdsa_nist_p192);
 	return ret;
 }
 
 static void __exit ecdsa_exit(void)
 {
 	if (ecdsa_nist_p192_registered)
-		crypto_unregister_akcipher(&ecdsa_nist_p192);
-	crypto_unregister_akcipher(&ecdsa_nist_p256);
-	crypto_unregister_akcipher(&ecdsa_nist_p384);
-	crypto_unregister_akcipher(&ecdsa_nist_p521);
+		crypto_unregister_sig(&ecdsa_nist_p192);
+	crypto_unregister_sig(&ecdsa_nist_p256);
+	crypto_unregister_sig(&ecdsa_nist_p384);
+	crypto_unregister_sig(&ecdsa_nist_p521);
 }
 
 subsys_initcall(ecdsa_init);
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index bb21378aa510..81ac32c9dd3e 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4411,7 +4411,6 @@ static int test_sig(struct crypto_sig *tfm, const char *alg,
 	return 0;
 }
 
-__maybe_unused
 static int alg_test_sig(const struct alg_test_desc *desc, const char *driver,
 			u32 type, u32 mask)
 {
@@ -5221,30 +5220,30 @@ static const struct alg_test_desc alg_test_descs[] = {
 		}
 	}, {
 		.alg = "ecdsa-nist-p192",
-		.test = alg_test_akcipher,
+		.test = alg_test_sig,
 		.suite = {
-			.akcipher = __VECS(ecdsa_nist_p192_tv_template)
+			.sig = __VECS(ecdsa_nist_p192_tv_template)
 		}
 	}, {
 		.alg = "ecdsa-nist-p256",
-		.test = alg_test_akcipher,
+		.test = alg_test_sig,
 		.fips_allowed = 1,
 		.suite = {
-			.akcipher = __VECS(ecdsa_nist_p256_tv_template)
+			.sig = __VECS(ecdsa_nist_p256_tv_template)
 		}
 	}, {
 		.alg = "ecdsa-nist-p384",
-		.test = alg_test_akcipher,
+		.test = alg_test_sig,
 		.fips_allowed = 1,
 		.suite = {
-			.akcipher = __VECS(ecdsa_nist_p384_tv_template)
+			.sig = __VECS(ecdsa_nist_p384_tv_template)
 		}
 	}, {
 		.alg = "ecdsa-nist-p521",
-		.test = alg_test_akcipher,
+		.test = alg_test_sig,
 		.fips_allowed = 1,
 		.suite = {
-			.akcipher = __VECS(ecdsa_nist_p521_tv_template)
+			.sig = __VECS(ecdsa_nist_p521_tv_template)
 		}
 	}, {
 		.alg = "ecrdsa",
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 39dd1d558883..a4987610fcb5 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -663,7 +663,7 @@ static const struct akcipher_testvec rsa_tv_template[] = {
 /*
  * ECDSA test vectors.
  */
-static const struct akcipher_testvec ecdsa_nist_p192_tv_template[] = {
+static const struct sig_testvec ecdsa_nist_p192_tv_template[] = {
 	{
 	.key = /* secp192r1(sha1) */
 	"\x04\xf7\x46\xf8\x2f\x15\xf6\x22\x8e\xd7\x57\x4f\xcc\xe7\xbb\xc1"
@@ -682,7 +682,6 @@ static const struct akcipher_testvec ecdsa_nist_p192_tv_template[] = {
 	"\x80\x6f\xa5\x79\x77\xda\xd0",
 	.c_size = 55,
 	.public_key_vec = true,
-	.siggen_sigver_test = true,
 	}, {
 	.key = /* secp192r1(sha224) */
 	"\x04\xb6\x4b\xb1\xd1\xac\xba\x24\x8f\x65\xb2\x60\x00\x90\xbf\xbd"
@@ -701,7 +700,6 @@ static const struct akcipher_testvec ecdsa_nist_p192_tv_template[] = {
 	"\x5c\x99\xdb\x92\x5b\x36",
 	.c_size = 54,
 	.public_key_vec = true,
-	.siggen_sigver_test = true,
 	}, {
 	.key = /* secp192r1(sha256) */
 	"\x04\xe2\x51\x24\x9b\xf7\xb6\x32\x82\x39\x66\x3d\x5b\xec\x3b\xae"
@@ -720,7 +718,6 @@ static const struct akcipher_testvec ecdsa_nist_p192_tv_template[] = {
 	"\x3a\x97\xd9\xcd\x1a\x6a\x49",
 	.c_size = 55,
 	.public_key_vec = true,
-	.siggen_sigver_test = true,
 	}, {
 	.key = /* secp192r1(sha384) */
 	"\x04\x5a\x13\xfe\x68\x86\x4d\xf4\x17\xc7\xa4\xe5\x8c\x65\x57\xb7"
@@ -740,7 +737,6 @@ static const struct akcipher_testvec ecdsa_nist_p192_tv_template[] = {
 	"\x12\x3b\x3b\x28\xfb\x6d\xe1",
 	.c_size = 55,
 	.public_key_vec = true,
-	.siggen_sigver_test = true,
 	}, {
 	.key = /* secp192r1(sha512) */
 	"\x04\xd5\xf2\x6e\xc3\x94\x5c\x52\xbc\xdf\x86\x6c\x14\xd1\xca\xea"
@@ -761,11 +757,10 @@ static const struct akcipher_testvec ecdsa_nist_p192_tv_template[] = {
 	"\x6a\xdf\x97\xfd\x82\x76\x24",
 	.c_size = 55,
 	.public_key_vec = true,
-	.siggen_sigver_test = true,
 	},
 };
 
-static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
+static const struct sig_testvec ecdsa_nist_p256_tv_template[] = {
 	{
 	.key = /* secp256r1(sha1) */
 	"\x04\xb9\x7b\xbb\xd7\x17\x64\xd2\x7e\xfc\x81\x5d\x87\x06\x83\x41"
@@ -786,7 +781,6 @@ static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
 	"\xfb\x9d\x8b\xde\xd4\x8d\x6f\xad",
 	.c_size = 72,
 	.public_key_vec = true,
-	.siggen_sigver_test = true,
 	}, {
 	.key = /* secp256r1(sha224) */
 	"\x04\x8b\x6d\xc0\x33\x8e\x2d\x8b\x67\xf5\xeb\xc4\x7f\xa0\xf5\xd9"
@@ -807,7 +801,6 @@ static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
 	"\x2e\x8b\xde\x5a\x04\x0e",
 	.c_size = 70,
 	.public_key_vec = true,
-	.siggen_sigver_test = true,
 	}, {
 	.key = /* secp256r1(sha256) */
 	"\x04\xf1\xea\xc4\x53\xf3\xb9\x0e\x9f\x7e\xad\xe3\xea\xd7\x0e\x0f"
@@ -828,7 +821,6 @@ static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
 	"\x2a\x65\x35\x23\xe3\x1d\xfa",
 	.c_size = 71,
 	.public_key_vec = true,
-	.siggen_sigver_test = true,
 	}, {
 	.key = /* secp256r1(sha384) */
 	"\x04\xc5\xc6\xea\x60\xc9\xce\xad\x02\x8d\xf5\x3e\x24\xe3\x52\x1d"
@@ -850,7 +842,6 @@ static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
 	"\xc0\x60\x11\x92\xdc\x17\x89\x12",
 	.c_size = 72,
 	.public_key_vec = true,
-	.siggen_sigver_test = true,
 	}, {
 	.key = /* secp256r1(sha512) */
 	"\x04\xd7\x27\x46\x49\xf6\x26\x85\x12\x40\x76\x8e\xe2\xe6\x2a\x7a"
@@ -873,11 +864,10 @@ static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
 	"\x31\x79\x4a\xe9\x81\x6a\xee",
 	.c_size = 71,
 	.public_key_vec = true,
-	.siggen_sigver_test = true,
 	},
 };
 
-static const struct akcipher_testvec ecdsa_nist_p384_tv_template[] = {
+static const struct sig_testvec ecdsa_nist_p384_tv_template[] = {
 	{
 	.key = /* secp384r1(sha1) */
 	"\x04\x89\x25\xf3\x97\x88\xcb\xb0\x78\xc5\x72\x9a\x14\x6e\x7a\xb1"
@@ -902,7 +892,6 @@ static const struct akcipher_testvec ecdsa_nist_p384_tv_template[] = {
 	"\x79\x12\x2a\xb7\xc5\x15\x92\xc5",
 	.c_size = 104,
 	.public_key_vec = true,
-	.siggen_sigver_test = true,
 	}, {
 	.key = /* secp384r1(sha224) */
 	"\x04\x69\x6c\xcf\x62\xee\xd0\x0d\xe5\xb5\x2f\x70\x54\xcf\x26\xa0"
@@ -927,7 +916,6 @@ static const struct akcipher_testvec ecdsa_nist_p384_tv_template[] = {
 	"\x88\x2b\x82\x26\x5e\x1c\xda\xfb",
 	.c_size = 104,
 	.public_key_vec = true,
-	.siggen_sigver_test = true,
 	}, {
 	.key = /* secp384r1(sha256) */
 	"\x04\xee\xd6\xda\x3e\x94\x90\x00\x27\xed\xf8\x64\x55\xd6\x51\x9a"
@@ -952,7 +940,6 @@ static const struct akcipher_testvec ecdsa_nist_p384_tv_template[] = {
 	"\xf4\x1f\x39\xca\x4d\x43",
 	.c_size = 102,
 	.public_key_vec = true,
-	.siggen_sigver_test = true,
 	}, {
 	.key = /* secp384r1(sha384) */
 	"\x04\x3a\x2f\x62\xe7\x1a\xcf\x24\xd0\x0b\x7c\xe0\xed\x46\x0a\x4f"
@@ -978,7 +965,6 @@ static const struct akcipher_testvec ecdsa_nist_p384_tv_template[] = {
 	"\xab\x8d\x4e\xde\xe6\x6d\x9b\x66",
 	.c_size = 104,
 	.public_key_vec = true,
-	.siggen_sigver_test = true,
 	}, {
 	.key = /* secp384r1(sha512) */
 	"\x04\xb4\xe7\xc1\xeb\x64\x25\x22\x46\xc3\x86\x61\x80\xbe\x1e\x46"
@@ -1005,11 +991,10 @@ static const struct akcipher_testvec ecdsa_nist_p384_tv_template[] = {
 	"\x3c\x93\xff\x50\x5d",
 	.c_size = 101,
 	.public_key_vec = true,
-	.siggen_sigver_test = true,
 	},
 };
 
-static const struct akcipher_testvec ecdsa_nist_p521_tv_template[] = {
+static const struct sig_testvec ecdsa_nist_p521_tv_template[] = {
 	{
 	.key = /* secp521r1(sha224) */
 	"\x04\x01\x4f\x43\x18\xb6\xa9\xc9\x5d\x68\xd3\xa9\x42\xf8\x98\xc0"
@@ -1038,7 +1023,6 @@ static const struct akcipher_testvec ecdsa_nist_p521_tv_template[] = {
 	"\xa3\x50\xb1\xa5\x98\x92\x2a\xa5\x52",
 	.c_size = 137,
 	.public_key_vec = true,
-	.siggen_sigver_test = true,
 	},
 	{
 	.key = /* secp521r1(sha256) */
@@ -1068,7 +1052,6 @@ static const struct akcipher_testvec ecdsa_nist_p521_tv_template[] = {
 	"\xb7\x1d\x91\x55\x38\xb6\xf6\x34\x65\xc7\xbd",
 	.c_size = 139,
 	.public_key_vec = true,
-	.siggen_sigver_test = true,
 	},
 	{
 	.key = /* secp521r1(sha384) */
@@ -1099,7 +1082,6 @@ static const struct akcipher_testvec ecdsa_nist_p521_tv_template[] = {
 	"\x8f\xb4\x22\xc6\x4f\xab\x2b\x62\xc1\x42\xb1",
 	.c_size = 139,
 	.public_key_vec = true,
-	.siggen_sigver_test = true,
 	},
 	{
 	.key = /* secp521r1(sha512) */
@@ -1131,7 +1113,6 @@ static const struct akcipher_testvec ecdsa_nist_p521_tv_template[] = {
 	"\xa6\xe5\x25\x46\x1e\x77\x44\x78\xe0\xd1\x04",
 	.c_size = 139,
 	.public_key_vec = true,
-	.siggen_sigver_test = true,
 	},
 };
 
-- 
2.43.0


