Return-Path: <linux-crypto+bounces-5736-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BDA93F773
	for <lists+linux-crypto@lfdr.de>; Mon, 29 Jul 2024 16:20:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8AFA91F22585
	for <lists+linux-crypto@lfdr.de>; Mon, 29 Jul 2024 14:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1412414A4F5;
	Mon, 29 Jul 2024 14:20:52 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mailout2.hostsharing.net (mailout2.hostsharing.net [83.223.78.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708DC1E4A2;
	Mon, 29 Jul 2024 14:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722262851; cv=none; b=AJao8ntbY85xgaq4P9c0TOBboH2CuL8bJX1UE5/8uwddI3bkg27RM6nIVBB5/HxffvvltxP16rPc9tCWxbRc0kysFaQr3G+ttpQh5TqRjekaWIYg+KbRzld2K/63dyA1FQyrhx/fTbePetBcFjypbu3TQ1ndiQ8IOAPRq+GsPlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722262851; c=relaxed/simple;
	bh=qvRRahZRgXTd6radb5kTJRTWfMzonb1kfgIHXPa+rvE=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:To:Cc; b=MOAIZAv4e2kmQoWpo8RHJkwjr7S3QUv802sLc5tvuCJYF6j8qYZN6iY0wLel5ugNj065EEMyrSSTF5cAy3aCl46IzVuaRqp50PBFBjuU/j9ETUTQ4Gi/Ax/FXrXtXfCwarlU8wSul2IrXoW16GZ91xMqkDEQVt4e5n37ZQ53VE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=pass smtp.mailfrom=wunner.de; arc=none smtp.client-ip=83.223.78.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wunner.de
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by mailout2.hostsharing.net (Postfix) with ESMTPS id 9191A10189DCE;
	Mon, 29 Jul 2024 16:11:28 +0200 (CEST)
Received: from localhost (unknown [89.246.108.87])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by h08.hostsharing.net (Postfix) with ESMTPSA id 5D3B0617CB2C;
	Mon, 29 Jul 2024 16:11:28 +0200 (CEST)
X-Mailbox-Line: From 0d360e4c1502a81c48d74c8cd6b842cc5e6dbd9e Mon Sep 17 00:00:00 2001
Message-ID: <0d360e4c1502a81c48d74c8cd6b842cc5e6dbd9e.1722260176.git.lukas@wunner.de>
In-Reply-To: <cover.1722260176.git.lukas@wunner.de>
References: <cover.1722260176.git.lukas@wunner.de>
From: Lukas Wunner <lukas@wunner.de>
Date: Mon, 29 Jul 2024 15:50:00 +0200
Subject: [PATCH 4/5] crypto: ecdsa - Move X9.62 signature decoding into
 template
To: Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, Stefan Berger <stefanb@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>, Vitaly Chikunov <vt@altlinux.org>, Tadeusz Struk <tstruk@gigaio.com>, Andrew Zaborowski <andrew.zaborowski@intel.com>, Saulo Alessandre <saulo.alessandre@tse.jus.br>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-crypto@vger.kernel.org, keyrings@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

Unlike the rsa driver, which separates signature decoding and
signature verification into two steps, the ecdsa driver does both in one.

This restricts users to the one signature format currently supported
(X9.62) and prevents addition of others such as P1363, which is needed
by the forthcoming SPDM library (Security Protocol and Data Model) for
PCI device authentication.

Per Herbert's suggestion, change ecdsa to use a "raw" signature encoding
and then implement X9.62 and P1363 as templates which convert their
respective encodings to the raw one.  One may then specify
"x962(ecdsa-nist-XXX)" or "p1363(ecdsa-nist-XXX)" to pick the encoding.

The present commit moves X9.62 decoding to a template.  A separate
commit is going to introduce another template for P1363 decoding.

The ecdsa driver internally represents a signature as two u64 arrays of
size ECC_MAX_BYTES.  This appears to be the most natural choice for the
raw format as it can directly be used for verification without having to
further decode signature data or copy it around.

Repurpose all the existing test vectors for "x962(ecdsa-nist-XXX)" and
create a duplicate of them to test the raw encoding.

Link: https://lore.kernel.org/all/ZoHXyGwRzVvYkcTP@gondor.apana.org.au/
Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 crypto/Makefile                     |   3 +-
 crypto/asymmetric_keys/public_key.c |   3 +
 crypto/ecdsa-x962.c                 | 211 ++++++++
 crypto/ecdsa.c                      |  86 +--
 crypto/testmgr.c                    |  27 +
 crypto/testmgr.h                    | 813 +++++++++++++++++++++++++++-
 include/crypto/internal/ecc.h       |   1 +
 7 files changed, 1077 insertions(+), 67 deletions(-)
 create mode 100644 crypto/ecdsa-x962.c

diff --git a/crypto/Makefile b/crypto/Makefile
index 4c99e5d376f6..eb6479493f6c 100644
--- a/crypto/Makefile
+++ b/crypto/Makefile
@@ -51,8 +51,9 @@ rsa_generic-y += rsa-pkcs1pad.o
 obj-$(CONFIG_CRYPTO_RSA) += rsa_generic.o
 
 $(obj)/ecdsasignature.asn1.o: $(obj)/ecdsasignature.asn1.c $(obj)/ecdsasignature.asn1.h
-$(obj)/ecdsa.o: $(obj)/ecdsasignature.asn1.h
+$(obj)/ecdsa-x962.o: $(obj)/ecdsasignature.asn1.h
 ecdsa_generic-y += ecdsa.o
+ecdsa_generic-y += ecdsa-x962.o
 ecdsa_generic-y += ecdsasignature.asn1.o
 obj-$(CONFIG_CRYPTO_ECDSA) += ecdsa_generic.o
 
diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index 422940a6706a..5391f1158bcd 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -124,6 +124,9 @@ software_key_determine_akcipher(const struct public_key *pkey,
 		    strcmp(hash_algo, "sha3-384") != 0 &&
 		    strcmp(hash_algo, "sha3-512") != 0)
 			return -EINVAL;
+		n = snprintf(alg_name, CRYPTO_MAX_ALG_NAME, "%s(%s)",
+			     encoding, pkey->pkey_algo);
+		return n >= CRYPTO_MAX_ALG_NAME ? -EINVAL : 0;
 	} else if (strcmp(pkey->pkey_algo, "ecrdsa") == 0) {
 		if (strcmp(encoding, "raw") != 0)
 			return -EINVAL;
diff --git a/crypto/ecdsa-x962.c b/crypto/ecdsa-x962.c
new file mode 100644
index 000000000000..ff2da5be1355
--- /dev/null
+++ b/crypto/ecdsa-x962.c
@@ -0,0 +1,211 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * ECDSA X9.62 signature encoding
+ *
+ * Copyright (c) 2021 IBM Corporation
+ * Copyright (c) 2024 Intel Corporation
+ */
+
+#include <linux/asn1_decoder.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <crypto/akcipher.h>
+#include <crypto/algapi.h>
+#include <crypto/internal/akcipher.h>
+#include <crypto/internal/ecc.h>
+
+#include "ecdsasignature.asn1.h"
+
+struct ecdsa_x962_ctx {
+	struct crypto_akcipher *child;
+};
+
+struct ecdsa_x962_request {
+	u64 r[ECC_MAX_DIGITS];
+	u64 s[ECC_MAX_DIGITS];
+	struct akcipher_request child_req;
+};
+
+/* Get the r and s components of a signature from the X.509 certificate. */
+static int ecdsa_get_signature_rs(u64 *dest, size_t hdrlen, unsigned char tag,
+				  const void *value, size_t vlen,
+				  unsigned int ndigits)
+{
+	size_t bufsize = ndigits * sizeof(u64);
+	const char *d = value;
+
+	if (!value || !vlen || vlen > bufsize + 1)
+		return -EINVAL;
+
+	if (vlen > bufsize) {
+		/* skip over leading zeros that make 'value' a positive int */
+		if (*d == 0) {
+			vlen -= 1;
+			d++;
+		} else {
+			return -EINVAL;
+		}
+	}
+
+	ecc_digits_from_bytes(d, vlen, dest, ndigits);
+
+	return 0;
+}
+
+static unsigned int ecdsa_get_ndigits(struct akcipher_request *req)
+{
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct ecdsa_x962_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	return DIV_ROUND_UP(crypto_akcipher_maxsize(ctx->child), sizeof(u64));
+}
+
+int ecdsa_get_signature_r(void *context, size_t hdrlen, unsigned char tag,
+			  const void *value, size_t vlen)
+{
+	struct akcipher_request *req = context;
+	struct ecdsa_x962_request *req_ctx = akcipher_request_ctx(req);
+
+	return ecdsa_get_signature_rs(req_ctx->r, hdrlen, tag, value, vlen,
+				      ecdsa_get_ndigits(req));
+}
+
+int ecdsa_get_signature_s(void *context, size_t hdrlen, unsigned char tag,
+			  const void *value, size_t vlen)
+{
+	struct akcipher_request *req = context;
+	struct ecdsa_x962_request *req_ctx = akcipher_request_ctx(req);
+
+	return ecdsa_get_signature_rs(req_ctx->s, hdrlen, tag, value, vlen,
+				      ecdsa_get_ndigits(req));
+}
+
+static int ecdsa_x962_verify(struct akcipher_request *req)
+{
+	struct ecdsa_x962_request *req_ctx = akcipher_request_ctx(req);
+	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
+	struct ecdsa_x962_ctx *ctx = akcipher_tfm_ctx(tfm);
+	int err;
+
+	err = asn1_ber_decoder(&ecdsasignature_decoder, req,
+			       req->sig, req->sig_len);
+	if (err < 0)
+		return err;
+
+	akcipher_request_set_tfm(&req_ctx->child_req, ctx->child);
+	akcipher_request_set_crypt(&req_ctx->child_req, req_ctx, req->digest,
+				   ECC_MAX_BYTES * 2, req->digest_len);
+
+	return crypto_akcipher_verify(&req_ctx->child_req);
+}
+
+static unsigned int ecdsa_x962_max_size(struct crypto_akcipher *tfm)
+{
+	struct ecdsa_x962_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	return crypto_akcipher_maxsize(ctx->child);
+}
+
+static int ecdsa_x962_set_pub_key(struct crypto_akcipher *tfm, const void *key,
+				  unsigned int keylen)
+{
+	struct ecdsa_x962_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	return crypto_akcipher_set_pub_key(ctx->child, key, keylen);
+}
+
+static int ecdsa_x962_init_tfm(struct crypto_akcipher *tfm)
+{
+	struct akcipher_instance *inst = akcipher_alg_instance(tfm);
+	struct crypto_akcipher_spawn *spawn = akcipher_instance_ctx(inst);
+	struct ecdsa_x962_ctx *ctx = akcipher_tfm_ctx(tfm);
+	struct crypto_akcipher *child_tfm;
+
+	child_tfm = crypto_spawn_akcipher(spawn);
+	if (IS_ERR(child_tfm))
+		return PTR_ERR(child_tfm);
+
+	ctx->child = child_tfm;
+
+	akcipher_set_reqsize(tfm, sizeof(struct ecdsa_x962_request) +
+				  crypto_akcipher_reqsize(child_tfm));
+
+	return 0;
+}
+
+static void ecdsa_x962_exit_tfm(struct crypto_akcipher *tfm)
+{
+	struct ecdsa_x962_ctx *ctx = akcipher_tfm_ctx(tfm);
+
+	crypto_free_akcipher(ctx->child);
+}
+
+static void ecdsa_x962_free(struct akcipher_instance *inst)
+{
+	struct crypto_akcipher_spawn *spawn = akcipher_instance_ctx(inst);
+
+	crypto_drop_akcipher(spawn);
+	kfree(inst);
+}
+
+static int ecdsa_x962_create(struct crypto_template *tmpl, struct rtattr **tb)
+{
+	struct crypto_akcipher_spawn *spawn;
+	struct akcipher_instance *inst;
+	struct akcipher_alg *ecdsa_alg;
+	u32 mask;
+	int err;
+
+	err = crypto_check_attr_type(tb, CRYPTO_ALG_TYPE_AKCIPHER, &mask);
+	if (err)
+		return err;
+
+	inst = kzalloc(sizeof(*inst) + sizeof(*spawn), GFP_KERNEL);
+	if (!inst)
+		return -ENOMEM;
+
+	spawn = akcipher_instance_ctx(inst);
+
+	err = crypto_grab_akcipher(spawn, akcipher_crypto_instance(inst),
+				   crypto_attr_alg_name(tb[1]), 0, mask);
+	if (err)
+		goto err_free_inst;
+
+	ecdsa_alg = crypto_spawn_akcipher_alg(spawn);
+
+	err = -EINVAL;
+	if (strncmp(ecdsa_alg->base.cra_name, "ecdsa", 5) != 0)
+		goto err_free_inst;
+
+	err = crypto_inst_setname(akcipher_crypto_instance(inst), tmpl->name,
+				  &ecdsa_alg->base);
+	if (err)
+		goto err_free_inst;
+
+	inst->alg.base.cra_priority = ecdsa_alg->base.cra_priority;
+	inst->alg.base.cra_ctxsize = sizeof(struct ecdsa_x962_ctx);
+
+	inst->alg.init = ecdsa_x962_init_tfm;
+	inst->alg.exit = ecdsa_x962_exit_tfm;
+
+	inst->alg.verify = ecdsa_x962_verify;
+	inst->alg.max_size = ecdsa_x962_max_size;
+	inst->alg.set_pub_key = ecdsa_x962_set_pub_key;
+
+	inst->free = ecdsa_x962_free;
+
+	err = akcipher_register_instance(tmpl, inst);
+	if (err) {
+err_free_inst:
+		ecdsa_x962_free(inst);
+	}
+	return err;
+}
+
+struct crypto_template ecdsa_x962_tmpl = {
+	.name = "x962",
+	.create = ecdsa_x962_create,
+	.module = THIS_MODULE,
+};
+
+MODULE_ALIAS_CRYPTO("x962");
diff --git a/crypto/ecdsa.c b/crypto/ecdsa.c
index 03f608132242..86fc64cb1aee 100644
--- a/crypto/ecdsa.c
+++ b/crypto/ecdsa.c
@@ -8,9 +8,6 @@
 #include <crypto/internal/ecc.h>
 #include <crypto/akcipher.h>
 #include <crypto/ecdh.h>
-#include <linux/asn1_decoder.h>
-
-#include "ecdsasignature.asn1.h"
 
 struct ecc_ctx {
 	unsigned int curve_id;
@@ -22,57 +19,6 @@ struct ecc_ctx {
 	struct ecc_point pub_key;
 };
 
-struct ecdsa_signature_ctx {
-	const struct ecc_curve *curve;
-	u64 r[ECC_MAX_DIGITS];
-	u64 s[ECC_MAX_DIGITS];
-};
-
-/*
- * Get the r and s components of a signature from the X509 certificate.
- */
-static int ecdsa_get_signature_rs(u64 *dest, size_t hdrlen, unsigned char tag,
-				  const void *value, size_t vlen, unsigned int ndigits)
-{
-	size_t bufsize = ndigits * sizeof(u64);
-	const char *d = value;
-
-	if (!value || !vlen || vlen > bufsize + 1)
-		return -EINVAL;
-
-	if (vlen > bufsize) {
-		/* skip over leading zeros that make 'value' a positive int */
-		if (*d == 0) {
-			vlen -= 1;
-			d++;
-		} else {
-			return -EINVAL;
-		}
-	}
-
-	ecc_digits_from_bytes(d, vlen, dest, ndigits);
-
-	return 0;
-}
-
-int ecdsa_get_signature_r(void *context, size_t hdrlen, unsigned char tag,
-			  const void *value, size_t vlen)
-{
-	struct ecdsa_signature_ctx *sig = context;
-
-	return ecdsa_get_signature_rs(sig->r, hdrlen, tag, value, vlen,
-				      sig->curve->g.ndigits);
-}
-
-int ecdsa_get_signature_s(void *context, size_t hdrlen, unsigned char tag,
-			  const void *value, size_t vlen)
-{
-	struct ecdsa_signature_ctx *sig = context;
-
-	return ecdsa_get_signature_rs(sig->s, hdrlen, tag, value, vlen,
-				      sig->curve->g.ndigits);
-}
-
 static int _ecdsa_verify(struct ecc_ctx *ctx, const u64 *hash, const u64 *r, const u64 *s)
 {
 	const struct ecc_curve *curve = ctx->curve;
@@ -121,19 +67,14 @@ static int ecdsa_verify(struct akcipher_request *req)
 	struct crypto_akcipher *tfm = crypto_akcipher_reqtfm(req);
 	struct ecc_ctx *ctx = akcipher_tfm_ctx(tfm);
 	size_t bufsize = ctx->curve->g.ndigits * sizeof(u64);
-	struct ecdsa_signature_ctx sig_ctx = {
-		.curve = ctx->curve,
-	};
 	u64 hash[ECC_MAX_DIGITS];
-	int ret;
+	const u64 *r, *s;
 
 	if (unlikely(!ctx->pub_key_set))
 		return -EINVAL;
 
-	ret = asn1_ber_decoder(&ecdsasignature_decoder, &sig_ctx,
-			       req->sig, req->sig_len);
-	if (ret < 0)
-		return ret;
+	if (req->sig_len != ECC_MAX_BYTES * 2)
+		return -EINVAL;
 
 	if (bufsize > req->digest_len)
 		bufsize = req->digest_len;
@@ -141,7 +82,17 @@ static int ecdsa_verify(struct akcipher_request *req)
 	ecc_digits_from_bytes(req->digest, bufsize,
 			      hash, ctx->curve->g.ndigits);
 
-	return _ecdsa_verify(ctx, hash, sig_ctx.r, sig_ctx.s);
+	/*
+	 * The integers r and s making up the signature are expected to be
+	 * formatted as two consecutive u64 arrays of size ECC_MAX_BYTES.
+	 * The bytes within each u64 digit are in native endianness,
+	 * but the order of the u64 digits themselves is little endian.
+	 * This format allows direct usage by internal vli_*() functions.
+	 */
+	r = req->sig;
+	s = req->sig + ECC_MAX_BYTES;
+
+	return _ecdsa_verify(ctx, hash, r, s);
 }
 
 static int ecdsa_ecc_ctx_init(struct ecc_ctx *ctx, unsigned int curve_id)
@@ -336,8 +287,15 @@ static int __init ecdsa_init(void)
 	if (ret)
 		goto nist_p521_error;
 
+	ret = crypto_register_template(&ecdsa_x962_tmpl);
+	if (ret)
+		goto x962_tmpl_error;
+
 	return 0;
 
+x962_tmpl_error:
+	crypto_unregister_akcipher(&ecdsa_nist_p521);
+
 nist_p521_error:
 	crypto_unregister_akcipher(&ecdsa_nist_p384);
 
@@ -352,6 +310,8 @@ static int __init ecdsa_init(void)
 
 static void __exit ecdsa_exit(void)
 {
+	crypto_unregister_template(&ecdsa_x962_tmpl);
+
 	if (ecdsa_nist_p192_registered)
 		crypto_unregister_akcipher(&ecdsa_nist_p192);
 	crypto_unregister_akcipher(&ecdsa_nist_p256);
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 483f87efd4b7..5d3af7c8e723 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5658,6 +5658,33 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.suite = {
 			.hash = __VECS(wp512_tv_template)
 		}
+	}, {
+		.alg = "x962(ecdsa-nist-p192)",
+		.test = alg_test_akcipher,
+		.suite = {
+			.akcipher = __VECS(x962_ecdsa_nist_p192_tv_template)
+		}
+	}, {
+		.alg = "x962(ecdsa-nist-p256)",
+		.test = alg_test_akcipher,
+		.fips_allowed = 1,
+		.suite = {
+			.akcipher = __VECS(x962_ecdsa_nist_p256_tv_template)
+		}
+	}, {
+		.alg = "x962(ecdsa-nist-p384)",
+		.test = alg_test_akcipher,
+		.fips_allowed = 1,
+		.suite = {
+			.akcipher = __VECS(x962_ecdsa_nist_p384_tv_template)
+		}
+	}, {
+		.alg = "x962(ecdsa-nist-p521)",
+		.test = alg_test_akcipher,
+		.fips_allowed = 1,
+		.suite = {
+			.akcipher = __VECS(x962_ecdsa_nist_p521_tv_template)
+		}
 	}, {
 		.alg = "xcbc(aes)",
 		.test = alg_test_hash,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 9b38501a17b2..d052d18c8f5b 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -21,6 +21,7 @@
 #define _CRYPTO_TESTMGR_H
 
 #include <linux/oid_registry.h>
+#include <crypto/internal/ecc.h>
 
 #define MAX_IVLEN		32
 
@@ -647,10 +648,816 @@ static const struct akcipher_testvec rsa_tv_template[] = {
 	}
 };
 
+#ifdef CONFIG_CPU_BIG_ENDIAN
+#define be64_to_cpua(b1, b2, b3, b4, b5, b6, b7, b8)			\
+	0x##b1, 0x##b2, 0x##b3, 0x##b4, 0x##b5, 0x##b6, 0x##b7, 0x##b8
+#else
+#define be64_to_cpua(b1, b2, b3, b4, b5, b6, b7, b8)			\
+	0x##b8, 0x##b7, 0x##b6, 0x##b5, 0x##b4, 0x##b3, 0x##b2, 0x##b1
+#endif
+
 /*
  * ECDSA test vectors.
  */
 static const struct akcipher_testvec ecdsa_nist_p192_tv_template[] = {
+	{
+	.key =
+	"\x04\xf7\x46\xf8\x2f\x15\xf6\x22\x8e\xd7\x57\x4f\xcc\xe7\xbb\xc1"
+	"\xd4\x09\x73\xcf\xea\xd0\x15\x07\x3d\xa5\x8a\x8a\x95\x43\xe4\x68"
+	"\xea\xc6\x25\xc1\xc1\x01\x25\x4c\x7e\xc3\x3c\xa6\x04\x0a\xe7\x08"
+	"\x98",
+	.key_len = 49,
+	.params =
+	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
+	"\xce\x3d\x03\x01\x01",
+	.param_len = 21,
+	.m =
+	"\xcd\xb9\xd2\x1c\xb7\x6f\xcd\x44\xb3\xfd\x63\xea\xa3\x66\x7f\xae"
+	"\x63\x85\xe7\x82",
+	.m_size = 20,
+	.algo = OID_id_ecdsa_with_sha1,
+	.c = (const unsigned char[]){
+	be64_to_cpua(ad, 59, ad, 88, 27, d6, 92, 6b),
+	be64_to_cpua(a0, 27, 91, c6, f6, 7f, c3, 09),
+	be64_to_cpua(ba, e5, 93, 83, 6e, b6, 3b, 63),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(86, 80, 6f, a5, 79, 77, da, d0),
+	be64_to_cpua(ef, 95, 52, 7b, a0, 0f, e4, 18),
+	be64_to_cpua(10, 68, 01, 9d, ba, ce, 83, 08),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00) },
+	.c_size = ECC_MAX_BYTES * 2,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
+	.key =
+	"\x04\xb6\x4b\xb1\xd1\xac\xba\x24\x8f\x65\xb2\x60\x00\x90\xbf\xbd"
+	"\x78\x05\x73\xe9\x79\x1d\x6f\x7c\x0b\xd2\xc3\x93\xa7\x28\xe1\x75"
+	"\xf7\xd5\x95\x1d\x28\x10\xc0\x75\x50\x5c\x1a\x4f\x3f\x8f\xa5\xee"
+	"\xa3",
+	.key_len = 49,
+	.params =
+	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
+	"\xce\x3d\x03\x01\x01",
+	.param_len = 21,
+	.m =
+	"\x8d\xd6\xb8\x3e\xe5\xff\x23\xf6\x25\xa2\x43\x42\x74\x45\xa7\x40"
+	"\x3a\xff\x2f\xe1\xd3\xf6\x9f\xe8\x33\xcb\x12\x11",
+	.m_size = 28,
+	.algo = OID_id_ecdsa_with_sha224,
+	.c = (const unsigned char[]){
+	be64_to_cpua(83, 7b, 12, e6, b6, 5b, cb, d4),
+	be64_to_cpua(14, f8, 11, 2b, 55, dc, ae, 37),
+	be64_to_cpua(5a, 8b, 82, 69, 7e, 8a, 0a, 09),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(a3, e3, 5c, 99, db, 92, 5b, 36),
+	be64_to_cpua(eb, c3, 92, 0f, 1e, 72, ee, c4),
+	be64_to_cpua(6a, 14, 4f, 53, 75, c8, 02, 48),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00) },
+	.c_size = ECC_MAX_BYTES * 2,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
+	.key =
+	"\x04\xe2\x51\x24\x9b\xf7\xb6\x32\x82\x39\x66\x3d\x5b\xec\x3b\xae"
+	"\x0c\xd5\xf2\x67\xd1\xc7\xe1\x02\xe4\xbf\x90\x62\xb8\x55\x75\x56"
+	"\x69\x20\x5e\xcb\x4e\xca\x33\xd6\xcb\x62\x6b\x94\xa9\xa2\xe9\x58"
+	"\x91",
+	.key_len = 49,
+	.params =
+	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
+	"\xce\x3d\x03\x01\x01",
+	.param_len = 21,
+	.m =
+	"\x35\xec\xa1\xa0\x9e\x14\xde\x33\x03\xb6\xf6\xbd\x0c\x2f\xb2\xfd"
+	"\x1f\x27\x82\xa5\xd7\x70\x3f\xef\xa0\x82\x69\x8e\x73\x31\x8e\xd7",
+	.m_size = 32,
+	.algo = OID_id_ecdsa_with_sha256,
+	.c = (const unsigned char[]){
+	be64_to_cpua(01, 48, fb, 5f, 72, 2a, d4, 8f),
+	be64_to_cpua(6b, 1a, 58, 56, f1, 8f, f7, fd),
+	be64_to_cpua(3f, 72, 3f, 1f, 42, d2, 3f, 1d),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(7d, 3a, 97, d9, cd, 1a, 6a, 49),
+	be64_to_cpua(32, dd, 41, 74, 6a, 51, c7, d9),
+	be64_to_cpua(b3, 69, 43, fd, 48, 19, 86, cf),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00) },
+	.c_size = ECC_MAX_BYTES * 2,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
+	.key =
+	"\x04\x5a\x13\xfe\x68\x86\x4d\xf4\x17\xc7\xa4\xe5\x8c\x65\x57\xb7"
+	"\x03\x73\x26\x57\xfb\xe5\x58\x40\xd8\xfd\x49\x05\xab\xf1\x66\x1f"
+	"\xe2\x9d\x93\x9e\xc2\x22\x5a\x8b\x4f\xf3\x77\x22\x59\x7e\xa6\x4e"
+	"\x8b",
+	.key_len = 49,
+	.params =
+	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
+	"\xce\x3d\x03\x01\x01",
+	.param_len = 21,
+	.m =
+	"\x9d\x2e\x1a\x8f\xed\x6c\x4b\x61\xae\xac\xd5\x19\x79\xce\x67\xf9"
+	"\xa0\x34\xeb\xb0\x81\xf9\xd9\xdc\x6e\xb3\x5c\xa8\x69\xfc\x8a\x61"
+	"\x39\x81\xfb\xfd\x5c\x30\x6b\xa8\xee\xed\x89\xaf\xa3\x05\xe4\x78",
+	.m_size = 48,
+	.algo = OID_id_ecdsa_with_sha384,
+	.c = (const unsigned char[]){
+	be64_to_cpua(dd, 15, bb, d6, 8c, a7, 03, 78),
+	be64_to_cpua(cf, 7f, 34, b4, b4, e5, c5, 00),
+	be64_to_cpua(f0, a3, 38, ce, 2b, f8, 9d, 1a),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(93, 12, 3b, 3b, 28, fb, 6d, e1),
+	be64_to_cpua(d1, 01, 77, 44, 5d, 53, a4, 7c),
+	be64_to_cpua(64, bc, 5a, 1f, 82, 96, 61, d7),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00) },
+	.c_size = ECC_MAX_BYTES * 2,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
+	.key =
+	"\x04\xd5\xf2\x6e\xc3\x94\x5c\x52\xbc\xdf\x86\x6c\x14\xd1\xca\xea"
+	"\xcc\x72\x3a\x8a\xf6\x7a\x3a\x56\x36\x3b\xca\xc6\x94\x0e\x17\x1d"
+	"\x9e\xa0\x58\x28\xf9\x4b\xe6\xd1\xa5\x44\x91\x35\x0d\xe7\xf5\x11"
+	"\x57",
+	.key_len = 49,
+	.params =
+	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
+	"\xce\x3d\x03\x01\x01",
+	.param_len = 21,
+	.m =
+	"\xd5\x4b\xe9\x36\xda\xd8\x6e\xc0\x50\x03\xbe\x00\x43\xff\xf0\x23"
+	"\xac\xa2\x42\xe7\x37\x77\x79\x52\x8f\x3e\xc0\x16\xc1\xfc\x8c\x67"
+	"\x16\xbc\x8a\x5d\x3b\xd3\x13\xbb\xb6\xc0\x26\x1b\xeb\x33\xcc\x70"
+	"\x4a\xf2\x11\x37\xe8\x1b\xba\x55\xac\x69\xe1\x74\x62\x7c\x6e\xb5",
+	.m_size = 64,
+	.algo = OID_id_ecdsa_with_sha512,
+	.c = (const unsigned char[]){
+	be64_to_cpua(2b, 11, 2d, 1c, b6, 06, c9, 6c),
+	be64_to_cpua(dd, 3f, 07, 87, 12, a0, d4, ac),
+	be64_to_cpua(88, 5b, 8f, 59, 43, bf, cf, c6),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(28, 6a, df, 97, fd, 82, 76, 24),
+	be64_to_cpua(a9, 14, 2a, 5e, f5, e5, fb, 72),
+	be64_to_cpua(73, b4, 22, 9a, 98, 73, 3c, 83),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00) },
+	.c_size = ECC_MAX_BYTES * 2,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	},
+};
+
+static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
+	{
+	.key =
+	"\x04\xb9\x7b\xbb\xd7\x17\x64\xd2\x7e\xfc\x81\x5d\x87\x06\x83\x41"
+	"\x22\xd6\x9a\xaa\x87\x17\xec\x4f\x63\x55\x2f\x94\xba\xdd\x83\xe9"
+	"\x34\x4b\xf3\xe9\x91\x13\x50\xb6\xcb\xca\x62\x08\xe7\x3b\x09\xdc"
+	"\xc3\x63\x4b\x2d\xb9\x73\x53\xe4\x45\xe6\x7c\xad\xe7\x6b\xb0\xe8"
+	"\xaf",
+	.key_len = 65,
+	.params =
+	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
+	"\xce\x3d\x03\x01\x07",
+	.param_len = 21,
+	.m =
+	"\xc2\x2b\x5f\x91\x78\x34\x26\x09\x42\x8d\x6f\x51\xb2\xc5\xaf\x4c"
+	"\x0b\xde\x6a\x42",
+	.m_size = 20,
+	.algo = OID_id_ecdsa_with_sha1,
+	.c = (const unsigned char[]){
+	be64_to_cpua(ee, ca, 6a, 52, 0e, 48, 4d, cc),
+	be64_to_cpua(f7, d4, ad, 8d, 94, 5a, 69, 89),
+	be64_to_cpua(cf, d4, e7, b7, f0, 82, 56, 41),
+	be64_to_cpua(f9, 25, ce, 9f, 3a, a6, 35, 81),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(fb, 9d, 8b, de, d4, 8d, 6f, ad),
+	be64_to_cpua(f1, 03, 03, f3, 3b, e2, 73, f7),
+	be64_to_cpua(8a, fa, 54, 93, 29, a7, 70, 86),
+	be64_to_cpua(d7, e4, ef, 52, 66, d3, 5b, 9d),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00) },
+	.c_size = ECC_MAX_BYTES * 2,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
+	.key =
+	"\x04\x8b\x6d\xc0\x33\x8e\x2d\x8b\x67\xf5\xeb\xc4\x7f\xa0\xf5\xd9"
+	"\x7b\x03\xa5\x78\x9a\xb5\xea\x14\xe4\x23\xd0\xaf\xd7\x0e\x2e\xa0"
+	"\xc9\x8b\xdb\x95\xf8\xb3\xaf\xac\x00\x2c\x2c\x1f\x7a\xfd\x95\x88"
+	"\x43\x13\xbf\xf3\x1c\x05\x1a\x14\x18\x09\x3f\xd6\x28\x3e\xc5\xa0"
+	"\xd4",
+	.key_len = 65,
+	.params =
+	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
+	"\xce\x3d\x03\x01\x07",
+	.param_len = 21,
+	.m =
+	"\x1a\x15\xbc\xa3\xe4\xed\x3a\xb8\x23\x67\xc6\xc4\x34\xf8\x6c\x41"
+	"\x04\x0b\xda\xc5\x77\xfa\x1c\x2d\xe6\x2c\x3b\xe0",
+	.m_size = 28,
+	.algo = OID_id_ecdsa_with_sha224,
+	.c = (const unsigned char[]){
+	be64_to_cpua(7d, 25, d8, 25, f5, 81, d2, 1e),
+	be64_to_cpua(34, 62, 79, cb, 6a, 91, 67, 2e),
+	be64_to_cpua(ae, ce, 77, 59, 1a, db, 59, d5),
+	be64_to_cpua(20, 43, fa, c0, 9f, 9d, 7b, e7),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(ce, d5, 2e, 8b, de, 5a, 04, 0e),
+	be64_to_cpua(bf, 50, 05, 58, 39, 0e, 26, 92),
+	be64_to_cpua(76, 20, 4a, 77, 22, ec, c8, 66),
+	be64_to_cpua(5f, f8, 74, f8, 57, d0, 5e, 54),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00) },
+	.c_size = ECC_MAX_BYTES * 2,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
+	.key =
+	"\x04\xf1\xea\xc4\x53\xf3\xb9\x0e\x9f\x7e\xad\xe3\xea\xd7\x0e\x0f"
+	"\xd6\x98\x9a\xca\x92\x4d\x0a\x80\xdb\x2d\x45\xc7\xec\x4b\x97\x00"
+	"\x2f\xe9\x42\x6c\x29\xdc\x55\x0e\x0b\x53\x12\x9b\x2b\xad\x2c\xe9"
+	"\x80\xe6\xc5\x43\xc2\x1d\x5e\xbb\x65\x21\x50\xb6\x37\xb0\x03\x8e"
+	"\xb8",
+	.key_len = 65,
+	.params =
+	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
+	"\xce\x3d\x03\x01\x07",
+	.param_len = 21,
+	.m =
+	"\x8f\x43\x43\x46\x64\x8f\x6b\x96\xdf\x89\xdd\xa9\x01\xc5\x17\x6b"
+	"\x10\xa6\xd8\x39\x61\xdd\x3c\x1a\xc8\x8b\x59\xb2\xdc\x32\x7a\xa4",
+	.m_size = 32,
+	.algo = OID_id_ecdsa_with_sha256,
+	.c = (const unsigned char[]){
+	be64_to_cpua(91, dc, 02, 67, dc, 0c, d0, 82),
+	be64_to_cpua(ac, 44, c3, e8, 24, 11, 2d, a4),
+	be64_to_cpua(09, dc, 29, 63, a8, 1a, ad, fc),
+	be64_to_cpua(08, 31, fa, 74, 0d, 1d, 21, 5d),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(4f, 2a, 65, 35, 23, e3, 1d, fa),
+	be64_to_cpua(0a, 6e, 1b, c4, af, e1, 83, c3),
+	be64_to_cpua(f9, a9, 81, ac, 4a, 50, d0, 91),
+	be64_to_cpua(bd, ff, ce, ee, 42, c3, 97, ff),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00) },
+	.c_size = ECC_MAX_BYTES * 2,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
+	.key =
+	"\x04\xc5\xc6\xea\x60\xc9\xce\xad\x02\x8d\xf5\x3e\x24\xe3\x52\x1d"
+	"\x28\x47\x3b\xc3\x6b\xa4\x99\x35\x99\x11\x88\x88\xc8\xf4\xee\x7e"
+	"\x8c\x33\x8f\x41\x03\x24\x46\x2b\x1a\x82\xf9\x9f\xe1\x97\x1b\x00"
+	"\xda\x3b\x24\x41\xf7\x66\x33\x58\x3d\x3a\x81\xad\xcf\x16\xe9\xe2"
+	"\x7c",
+	.key_len = 65,
+	.params =
+	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
+	"\xce\x3d\x03\x01\x07",
+	.param_len = 21,
+	.m =
+	"\x3e\x78\x70\xfb\xcd\x66\xba\x91\xa1\x79\xff\x1e\x1c\x6b\x78\xe6"
+	"\xc0\x81\x3a\x65\x97\x14\x84\x36\x14\x1a\x9a\xb7\xc5\xab\x84\x94"
+	"\x5e\xbb\x1b\x34\x71\xcb\x41\xe1\xf6\xfc\x92\x7b\x34\xbb\x86\xbb",
+	.m_size = 48,
+	.algo = OID_id_ecdsa_with_sha384,
+	.c = (const unsigned char[]){
+	be64_to_cpua(f2, e4, 6c, c7, 94, b1, d5, fe),
+	be64_to_cpua(08, b2, 6b, 24, 94, 48, 46, 5e),
+	be64_to_cpua(d0, 2e, 95, 54, d1, 95, 64, 93),
+	be64_to_cpua(8e, f3, 6f, dc, f8, 69, a6, 2e),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(c0, 60, 11, 92, dc, 17, 89, 12),
+	be64_to_cpua(69, f4, 3b, 4f, 47, cf, 9b, 16),
+	be64_to_cpua(19, fb, 5f, 92, f4, c9, 23, 37),
+	be64_to_cpua(eb, a7, 80, 26, dc, f9, 3a, 44),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00) },
+	.c_size = ECC_MAX_BYTES * 2,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
+	.key =
+	"\x04\xd7\x27\x46\x49\xf6\x26\x85\x12\x40\x76\x8e\xe2\xe6\x2a\x7a"
+	"\x83\xb1\x4e\x7a\xeb\x3b\x5c\x67\x4a\xb5\xa4\x92\x8c\x69\xff\x38"
+	"\xee\xd9\x4e\x13\x29\x59\xad\xde\x6b\xbb\x45\x31\xee\xfd\xd1\x1b"
+	"\x64\xd3\xb5\xfc\xaf\x9b\x4b\x88\x3b\x0e\xb7\xd6\xdf\xf1\xd5\x92"
+	"\xbf",
+	.key_len = 65,
+	.params =
+	"\x30\x13\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x08\x2a\x86\x48"
+	"\xce\x3d\x03\x01\x07",
+	.param_len = 21,
+	.m =
+	"\x57\xb7\x9e\xe9\x05\x0a\x8c\x1b\xc9\x13\xe5\x4a\x24\xc7\xe2\xe9"
+	"\x43\xc3\xd1\x76\x62\xf4\x98\x1a\x9c\x13\xb0\x20\x1b\xe5\x39\xca"
+	"\x4f\xd9\x85\x34\x95\xa2\x31\xbc\xbb\xde\xdd\x76\xbb\x61\xe3\xcf"
+	"\x9d\xc0\x49\x7a\xf3\x7a\xc4\x7d\xa8\x04\x4b\x8d\xb4\x4d\x5b\xd6",
+	.m_size = 64,
+	.algo = OID_id_ecdsa_with_sha512,
+	.c = (const unsigned char[]){
+	be64_to_cpua(76, f6, 04, 99, 09, 37, 4d, fa),
+	be64_to_cpua(ed, 8c, 73, 30, 6c, 22, b3, 97),
+	be64_to_cpua(40, ea, 44, 81, 00, 4e, 29, 08),
+	be64_to_cpua(b8, 6d, 87, 81, 43, df, fb, 9f),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(76, 31, 79, 4a, e9, 81, 6a, ee),
+	be64_to_cpua(5c, ad, c3, 78, 1c, c2, c1, 19),
+	be64_to_cpua(f8, 00, dd, ab, d4, c0, 2b, e6),
+	be64_to_cpua(1e, b9, 75, 31, f6, 04, a5, 4d),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00) },
+	.c_size = ECC_MAX_BYTES * 2,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	},
+};
+
+static const struct akcipher_testvec ecdsa_nist_p384_tv_template[] = {
+	{
+	.key = /* secp384r1(sha1) */
+	"\x04\x89\x25\xf3\x97\x88\xcb\xb0\x78\xc5\x72\x9a\x14\x6e\x7a\xb1"
+	"\x5a\xa5\x24\xf1\x95\x06\x9e\x28\xfb\xc4\xb9\xbe\x5a\x0d\xd9\x9f"
+	"\xf3\xd1\x4d\x2d\x07\x99\xbd\xda\xa7\x66\xec\xbb\xea\xba\x79\x42"
+	"\xc9\x34\x89\x6a\xe7\x0b\xc3\xf2\xfe\x32\x30\xbe\xba\xf9\xdf\x7e"
+	"\x4b\x6a\x07\x8e\x26\x66\x3f\x1d\xec\xa2\x57\x91\x51\xdd\x17\x0e"
+	"\x0b\x25\xd6\x80\x5c\x3b\xe6\x1a\x98\x48\x91\x45\x7a\x73\xb0\xc3"
+	"\xf1",
+	.key_len = 97,
+	.params =
+	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
+	"\x00\x22",
+	.param_len = 18,
+	.m =
+	"\x12\x55\x28\xf0\x77\xd5\xb6\x21\x71\x32\x48\xcd\x28\xa8\x25\x22"
+	"\x3a\x69\xc1\x93",
+	.m_size = 20,
+	.algo = OID_id_ecdsa_with_sha1,
+	.c = (const unsigned char[]){
+	be64_to_cpua(ec, 7c, 7e, d0, 87, d7, d7, 6e),
+	be64_to_cpua(78, f1, 4c, 26, e6, 5b, 86, cf),
+	be64_to_cpua(3a, c6, f1, 32, 3c, ce, 70, 2b),
+	be64_to_cpua(8d, 26, 8e, ae, 63, 3f, bc, 20),
+	be64_to_cpua(57, 55, 07, 20, 43, 30, de, a0),
+	be64_to_cpua(f5, 0f, 24, 4c, 07, 93, 6f, 21),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(79, 12, 2a, b7, c5, 15, 92, c5),
+	be64_to_cpua(4a, a1, 59, f1, 1c, a4, 58, 26),
+	be64_to_cpua(74, a0, 0f, bf, af, c3, 36, 76),
+	be64_to_cpua(df, 28, 8c, 1b, fa, f9, 95, 88),
+	be64_to_cpua(5f, 63, b1, be, 5e, 4c, 0e, a1),
+	be64_to_cpua(cd, bb, 7e, 81, 5d, 8f, 63, c0),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00) },
+	.c_size = ECC_MAX_BYTES * 2,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
+	.key = /* secp384r1(sha224) */
+	"\x04\x69\x6c\xcf\x62\xee\xd0\x0d\xe5\xb5\x2f\x70\x54\xcf\x26\xa0"
+	"\xd9\x98\x8d\x92\x2a\xab\x9b\x11\xcb\x48\x18\xa1\xa9\x0d\xd5\x18"
+	"\x3e\xe8\x29\x6e\xf6\xe4\xb5\x8e\xc7\x4a\xc2\x5f\x37\x13\x99\x05"
+	"\xb6\xa4\x9d\xf9\xfb\x79\x41\xe7\xd7\x96\x9f\x73\x3b\x39\x43\xdc"
+	"\xda\xf4\x06\xb9\xa5\x29\x01\x9d\x3b\xe1\xd8\x68\x77\x2a\xf4\x50"
+	"\x6b\x93\x99\x6c\x66\x4c\x42\x3f\x65\x60\x6c\x1c\x0b\x93\x9b\x9d"
+	"\xe0",
+	.key_len = 97,
+	.params =
+	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
+	"\x00\x22",
+	.param_len = 18,
+	.m =
+	"\x12\x80\xb6\xeb\x25\xe2\x3d\xf0\x21\x32\x96\x17\x3a\x38\x39\xfd"
+	"\x1f\x05\x34\x7b\xb8\xf9\x71\x66\x03\x4f\xd5\xe5",
+	.m_size = 28,
+	.algo = OID_id_ecdsa_with_sha224,
+	.c = (const unsigned char[]){
+	be64_to_cpua(3f, dd, 15, 1b, 68, 2b, 9d, 8b),
+	be64_to_cpua(c9, 9c, 11, b8, 10, 01, c5, 41),
+	be64_to_cpua(c5, da, b4, e3, 93, 07, e0, 99),
+	be64_to_cpua(97, f1, c8, 72, 26, cf, 5a, 5e),
+	be64_to_cpua(ec, cb, e4, 89, 47, b2, f7, bc),
+	be64_to_cpua(8a, 51, 84, ce, 13, 1e, d2, dc),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(88, 2b, 82, 26, 5e, 1c, da, fb),
+	be64_to_cpua(9f, 19, d0, 42, 8b, 93, c2, 11),
+	be64_to_cpua(4d, d0, c6, 6e, b0, e9, fc, 14),
+	be64_to_cpua(df, d8, 68, a2, 64, 42, 65, f3),
+	be64_to_cpua(4b, 00, 08, 31, 6c, f5, d5, f6),
+	be64_to_cpua(8b, 03, 2c, fc, 1f, d1, a9, a4),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00) },
+	.c_size = ECC_MAX_BYTES * 2,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
+	.key = /* secp384r1(sha256) */
+	"\x04\xee\xd6\xda\x3e\x94\x90\x00\x27\xed\xf8\x64\x55\xd6\x51\x9a"
+	"\x1f\x52\x00\x63\x78\xf1\xa9\xfd\x75\x4c\x9e\xb2\x20\x1a\x91\x5a"
+	"\xba\x7a\xa3\xe5\x6c\xb6\x25\x68\x4b\xe8\x13\xa6\x54\x87\x2c\x0e"
+	"\xd0\x83\x95\xbc\xbf\xc5\x28\x4f\x77\x1c\x46\xa6\xf0\xbc\xd4\xa4"
+	"\x8d\xc2\x8f\xb3\x32\x37\x40\xd6\xca\xf8\xae\x07\x34\x52\x39\x52"
+	"\x17\xc3\x34\x29\xd6\x40\xea\x5c\xb9\x3f\xfb\x32\x2e\x12\x33\xbc"
+	"\xab",
+	.key_len = 97,
+	.params =
+	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
+	"\x00\x22",
+	.param_len = 18,
+	.m =
+	"\xaa\xe7\xfd\x03\x26\xcb\x94\x71\xe4\xce\x0f\xc5\xff\xa6\x29\xa3"
+	"\xe1\xcc\x4c\x35\x4e\xde\xca\x80\xab\x26\x0c\x25\xe6\x68\x11\xc2",
+	.m_size = 32,
+	.algo = OID_id_ecdsa_with_sha256,
+	.c = (const unsigned char[]){
+	be64_to_cpua(c8, 8d, 2c, 79, 3a, 8e, 32, c4),
+	be64_to_cpua(b6, c6, fc, 70, 2e, 66, 3c, 77),
+	be64_to_cpua(af, 06, 3f, 84, 04, e2, f9, 67),
+	be64_to_cpua(cc, 47, 53, 87, bc, bd, 83, 3f),
+	be64_to_cpua(8e, 3f, 7e, ce, 0a, 9b, aa, 59),
+	be64_to_cpua(08, 09, 12, 9d, 6e, 96, 64, a6),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(10, 0e, f4, 1f, 39, ca, 4d, 43),
+	be64_to_cpua(4f, 8d, de, 1e, 93, 8d, 95, bb),
+	be64_to_cpua(15, 68, c0, 75, 3e, 23, 5e, 36),
+	be64_to_cpua(dd, ce, bc, b2, 97, f4, 9c, f3),
+	be64_to_cpua(26, a2, b0, 89, 42, 0a, da, d9),
+	be64_to_cpua(40, 34, b8, 90, a9, 80, ab, 47),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00) },
+	.c_size = ECC_MAX_BYTES * 2,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
+	.key = /* secp384r1(sha384) */
+	"\x04\x3a\x2f\x62\xe7\x1a\xcf\x24\xd0\x0b\x7c\xe0\xed\x46\x0a\x4f"
+	"\x74\x16\x43\xe9\x1a\x25\x7c\x55\xff\xf0\x29\x68\x66\x20\x91\xf9"
+	"\xdb\x2b\xf6\xb3\x6c\x54\x01\xca\xc7\x6a\x5c\x0d\xeb\x68\xd9\x3c"
+	"\xf1\x01\x74\x1f\xf9\x6c\xe5\x5b\x60\xe9\x7f\x5d\xb3\x12\x80\x2a"
+	"\xd8\x67\x92\xc9\x0e\x4c\x4c\x6b\xa1\xb2\xa8\x1e\xac\x1c\x97\xd9"
+	"\x21\x67\xe5\x1b\x5a\x52\x31\x68\xd6\xee\xf0\x19\xb0\x55\xed\x89"
+	"\x9e",
+	.key_len = 97,
+	.params =
+	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
+	"\x00\x22",
+	.param_len = 18,
+	.m =
+	"\x8d\xf2\xc0\xe9\xa8\xf3\x8e\x44\xc4\x8c\x1a\xa0\xb8\xd7\x17\xdf"
+	"\xf2\x37\x1b\xc6\xe3\xf5\x62\xcc\x68\xf5\xd5\x0b\xbf\x73\x2b\xb1"
+	"\xb0\x4c\x04\x00\x31\xab\xfe\xc8\xd6\x09\xc8\xf2\xea\xd3\x28\xff",
+	.m_size = 48,
+	.algo = OID_id_ecdsa_with_sha384,
+	.c = (const unsigned char[]){
+	be64_to_cpua(a2, a4, c8, f2, ea, 9d, 11, 1f),
+	be64_to_cpua(3b, 1f, 07, 8f, 15, 02, fe, 1d),
+	be64_to_cpua(29, e6, fb, ca, 8c, d6, b6, b4),
+	be64_to_cpua(2d, 7a, 91, 5f, 49, 2d, 22, 08),
+	be64_to_cpua(ee, 2e, 62, 35, 46, fa, 00, d8),
+	be64_to_cpua(9b, 28, 68, c0, a1, ea, 8c, 50),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(ab, 8d, 4e, de, e6, 6d, 9b, 66),
+	be64_to_cpua(96, 17, 04, c9, 05, 77, f1, 8e),
+	be64_to_cpua(44, 92, 8c, 86, 99, 65, b3, 97),
+	be64_to_cpua(71, cd, 8f, 18, 99, f0, 0f, 13),
+	be64_to_cpua(bf, e3, 75, 24, 49, ac, fb, c8),
+	be64_to_cpua(fc, 50, f6, 43, bd, 50, 82, 0e),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00) },
+	.c_size = ECC_MAX_BYTES * 2,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	}, {
+	.key = /* secp384r1(sha512) */
+	"\x04\xb4\xe7\xc1\xeb\x64\x25\x22\x46\xc3\x86\x61\x80\xbe\x1e\x46"
+	"\xcb\xf6\x05\xc2\xee\x73\x83\xbc\xea\x30\x61\x4d\x40\x05\x41\xf4"
+	"\x8c\xe3\x0e\x5c\xf0\x50\xf2\x07\x19\xe8\x4f\x25\xbe\xee\x0c\x95"
+	"\x54\x36\x86\xec\xc2\x20\x75\xf3\x89\xb5\x11\xa1\xb7\xf5\xaf\xbe"
+	"\x81\xe4\xc3\x39\x06\xbd\xe4\xfe\x68\x1c\x6d\x99\x2b\x1b\x63\xfa"
+	"\xdf\x42\x5c\xc2\x5a\xc7\x0c\xf4\x15\xf7\x1b\xa3\x2e\xd7\x00\xac"
+	"\xa3",
+	.key_len = 97,
+	.params =
+	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
+	"\x00\x22",
+	.param_len = 18,
+	.m =
+	"\xe8\xb7\x52\x7d\x1a\x44\x20\x05\x53\x6b\x3a\x68\xf2\xe7\x6c\xa1"
+	"\xae\x9d\x84\xbb\xba\x52\x43\x3e\x2c\x42\x78\x49\xbf\x78\xb2\x71"
+	"\xeb\xe1\xe0\xe8\x42\x7b\x11\xad\x2b\x99\x05\x1d\x36\xe6\xac\xfc"
+	"\x55\x73\xf0\x15\x63\x39\xb8\x6a\x6a\xc5\x91\x5b\xca\x6a\xa8\x0e",
+	.m_size = 64,
+	.algo = OID_id_ecdsa_with_sha512,
+	.c = (const unsigned char[]){
+	be64_to_cpua(3e, b3, c7, a8, b3, 17, 77, d1),
+	be64_to_cpua(dc, 2b, 43, 0e, 6a, b3, 53, 6f),
+	be64_to_cpua(4c, fc, 6f, 80, e3, af, b3, d9),
+	be64_to_cpua(9a, 02, de, 93, e8, 83, e4, 84),
+	be64_to_cpua(4d, c6, ef, da, 02, e7, 0f, 52),
+	be64_to_cpua(00, 1d, 20, 94, 77, fe, 31, fa),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(4e, 45, cf, 3c, 93, ff, 50, 5d),
+	be64_to_cpua(34, e4, 8b, 80, a5, b6, da, 2c),
+	be64_to_cpua(c4, 6a, 03, 5f, 8d, 7a, f9, fb),
+	be64_to_cpua(ec, 63, e3, 0c, ec, 50, dc, cc),
+	be64_to_cpua(de, 3a, 3d, 16, af, b4, 52, 6a),
+	be64_to_cpua(63, f6, f0, 3d, 5f, 5f, 99, 3f),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 00) },
+	.c_size = ECC_MAX_BYTES * 2,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	},
+};
+
+static const struct akcipher_testvec ecdsa_nist_p521_tv_template[] = {
+	{
+	.key = /* secp521r1(sha224) */
+	"\x04\x01\x4f\x43\x18\xb6\xa9\xc9\x5d\x68\xd3\xa9\x42\xf8\x98\xc0"
+	"\xd2\xd1\xa9\x50\x3b\xe8\xc4\x40\xe6\x11\x78\x88\x4b\xbd\x76\xa7"
+	"\x9a\xe0\xdd\x31\xa4\x67\x78\x45\x33\x9e\x8c\xd1\xc7\x44\xac\x61"
+	"\x68\xc8\x04\xe7\x5c\x79\xb1\xf1\x41\x0c\x71\xc0\x53\xa8\xbc\xfb"
+	"\xf5\xca\xd4\x01\x40\xfd\xa3\x45\xda\x08\xe0\xb4\xcb\x28\x3b\x0a"
+	"\x02\x35\x5f\x02\x9f\x3f\xcd\xef\x08\x22\x40\x97\x74\x65\xb7\x76"
+	"\x85\xc7\xc0\x5c\xfb\x81\xe1\xa5\xde\x0c\x4e\x8b\x12\x31\xb6\x47"
+	"\xed\x37\x0f\x99\x3f\x26\xba\xa3\x8e\xff\x79\x34\x7c\x3a\xfe\x1f"
+	"\x3b\x83\x82\x2f\x14",
+	.key_len = 133,
+	.params =
+	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
+	"\x00\x23",
+	.param_len = 18,
+	.m =
+	"\xa2\x3a\x6a\x8c\x7b\x3c\xf2\x51\xf8\xbe\x5f\x4f\x3b\x15\x05\xc4"
+	"\xb5\xbc\x19\xe7\x21\x85\xe9\x23\x06\x33\x62\xfb",
+	.m_size = 28,
+	.algo = OID_id_ecdsa_with_sha224,
+	.c = (const unsigned char[]){
+	be64_to_cpua(46, 6b, c7, af, 7a, b9, 19, 0a),
+	be64_to_cpua(6c, a6, 9b, 89, 8b, 1e, fd, 09),
+	be64_to_cpua(98, 85, 29, 88, ff, 0b, 94, 94),
+	be64_to_cpua(18, c6, 37, 8a, cb, a7, d8, 7d),
+	be64_to_cpua(f8, 3f, 59, 0f, 74, f0, 3f, d8),
+	be64_to_cpua(e2, ef, 07, 92, ee, 60, 94, 06),
+	be64_to_cpua(35, f6, dc, 6d, 02, 7b, 22, ac),
+	be64_to_cpua(d6, 43, e7, ff, 42, b2, ba, 74),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 01),
+	be64_to_cpua(50, b1, a5, 98, 92, 2a, a5, 52),
+	be64_to_cpua(1c, ad, 22, da, 82, 00, 35, a3),
+	be64_to_cpua(0e, 64, cc, c4, e8, 43, d9, 0e),
+	be64_to_cpua(30, 90, 0f, 1c, 8f, 78, d3, 9f),
+	be64_to_cpua(26, 0b, 5f, 49, 32, 6b, 91, 99),
+	be64_to_cpua(0f, f8, 65, 97, 6b, 09, 4d, 22),
+	be64_to_cpua(5e, f9, 88, f3, d2, 32, 90, 57),
+	be64_to_cpua(26, 0d, 55, cd, 23, 1e, 7d, a0),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 3a) },
+	.c_size = ECC_MAX_BYTES * 2,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	},
+	{
+	.key = /* secp521r1(sha256) */
+	"\x04\x01\x05\x3a\x6b\x3b\x5a\x0f\xa7\xb9\xb7\x32\x53\x4e\xe2\xae"
+	"\x0a\x52\xc5\xda\xdd\x5a\x79\x1c\x30\x2d\x33\x07\x79\xd5\x70\x14"
+	"\x61\x0c\xec\x26\x4d\xd8\x35\x57\x04\x1d\x88\x33\x4d\xce\x05\x36"
+	"\xa5\xaf\x56\x84\xfa\x0b\x9e\xff\x7b\x30\x4b\x92\x1d\x06\xf8\x81"
+	"\x24\x1e\x51\x00\x09\x21\x51\xf7\x46\x0a\x77\xdb\xb5\x0c\xe7\x9c"
+	"\xff\x27\x3c\x02\x71\xd7\x85\x36\xf1\xaa\x11\x59\xd8\xb8\xdc\x09"
+	"\xdc\x6d\x5a\x6f\x63\x07\x6c\xe1\xe5\x4d\x6e\x0f\x6e\xfb\x7c\x05"
+	"\x8a\xe9\x53\xa8\xcf\xce\x43\x0e\x82\x20\x86\xbc\x88\x9c\xb7\xe3"
+	"\xe6\x77\x1e\x1f\x8a",
+	.key_len = 133,
+	.params =
+	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
+	"\x00\x23",
+	.param_len = 18,
+	.m =
+	"\xcc\x97\x73\x0c\x73\xa2\x53\x2b\xfa\xd7\x83\x1d\x0c\x72\x1b\x39"
+	"\x80\x71\x8d\xdd\xc5\x9b\xff\x55\x32\x98\x25\xa2\x58\x2e\xb7\x73",
+	.m_size = 32,
+	.algo = OID_id_ecdsa_with_sha256,
+	.c = (const unsigned char[]){
+	be64_to_cpua(de, 7e, d7, 59, 10, e9, d9, d5),
+	be64_to_cpua(38, 1f, 46, 0b, 04, 64, 34, 79),
+	be64_to_cpua(ae, ce, 54, 76, 9a, c2, 8f, b8),
+	be64_to_cpua(95, 35, 6f, 02, 0e, af, e1, 4c),
+	be64_to_cpua(56, 3c, f6, f0, d8, e1, b7, 5d),
+	be64_to_cpua(50, 9f, 7d, 1f, ca, 8b, a8, 2d),
+	be64_to_cpua(06, 0f, fd, 83, fc, 0e, d9, ce),
+	be64_to_cpua(a5, 5f, 57, 52, 27, 78, 3a, b5),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, cd),
+	be64_to_cpua(55, 38, b6, f6, 34, 65, c7, bd),
+	be64_to_cpua(1c, 57, 56, 8f, 12, b7, 1d, 91),
+	be64_to_cpua(03, 42, 02, 5f, 50, f0, a2, 0d),
+	be64_to_cpua(fa, 10, dd, 9b, fb, 36, 1a, 31),
+	be64_to_cpua(e0, 87, 2c, 44, 4b, 5a, ee, af),
+	be64_to_cpua(a9, 79, 24, b9, 37, 35, dd, a0),
+	be64_to_cpua(6b, 35, ae, 65, b5, 99, 12, 0a),
+	be64_to_cpua(50, 85, 38, f9, 15, 83, 18, 04),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 01, cf) },
+	.c_size = ECC_MAX_BYTES * 2,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	},
+	{
+	.key = /* secp521r1(sha384) */
+	"\x04\x00\x2e\xd6\x21\x04\x75\xc3\xdc\x7d\xff\x0e\xf3\x70\x25\x2b"
+	"\xad\x72\xfc\x5a\x91\xf1\xd5\x9c\x64\xf3\x1f\x47\x11\x10\x62\x33"
+	"\xfd\x2e\xe8\x32\xca\x9e\x6f\x0a\x4c\x5b\x35\x9a\x46\xc5\xe7\xd4"
+	"\x38\xda\xb2\xf0\xf4\x87\xf3\x86\xf4\xea\x70\xad\x1e\xd4\x78\x8c"
+	"\x36\x18\x17\x00\xa2\xa0\x34\x1b\x2e\x6a\xdf\x06\xd6\x99\x2d\x47"
+	"\x50\x92\x1a\x8a\x72\x9c\x23\x44\xfa\xa7\xa9\xed\xa6\xef\x26\x14"
+	"\xb3\x9d\xfe\x5e\xa3\x8c\xd8\x29\xf8\xdf\xad\xa6\xab\xfc\xdd\x46"
+	"\x22\x6e\xd7\x35\xc7\x23\xb7\x13\xae\xb6\x34\xff\xd7\x80\xe5\x39"
+	"\xb3\x3b\x5b\x1b\x94",
+	.key_len = 133,
+	.params =
+	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
+	"\x00\x23",
+	.param_len = 18,
+	.m =
+	"\x36\x98\xd6\x82\xfa\xad\xed\x3c\xb9\x40\xb6\x4d\x9e\xb7\x04\x26"
+	"\xad\x72\x34\x44\xd2\x81\xb4\x9b\xbe\x01\x04\x7a\xd8\x50\xf8\x59"
+	"\xba\xad\x23\x85\x6b\x59\xbe\xfb\xf6\x86\xd4\x67\xa8\x43\x28\x76",
+	.m_size = 48,
+	.algo = OID_id_ecdsa_with_sha384,
+	.c = (const unsigned char[]){
+	be64_to_cpua(b8, 6a, dd, fb, e6, 63, 4e, 28),
+	be64_to_cpua(84, 59, fd, 1a, c4, 40, dd, 43),
+	be64_to_cpua(32, 76, 06, d0, f9, c0, e4, e6),
+	be64_to_cpua(e4, df, 9b, 7d, 9e, 47, ca, 33),
+	be64_to_cpua(7e, 42, 71, 86, 57, 2d, f1, 7d),
+	be64_to_cpua(f2, 4b, 64, 98, f7, ec, da, c7),
+	be64_to_cpua(ec, 51, dc, e8, 35, 5e, ae, 16),
+	be64_to_cpua(96, 76, 3c, 27, ea, aa, 9c, 26),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, 93),
+	be64_to_cpua(c6, 4f, ab, 2b, 62, c1, 42, b1),
+	be64_to_cpua(e5, 5a, 94, 56, cf, 8f, b4, 22),
+	be64_to_cpua(6a, c3, f3, 7a, d1, fa, e7, a7),
+	be64_to_cpua(df, c4, c0, db, 54, db, 8a, 0d),
+	be64_to_cpua(da, a7, cd, 26, 28, 76, 3b, 52),
+	be64_to_cpua(e4, 3c, bc, 93, 65, 57, 1c, 30),
+	be64_to_cpua(55, ce, 37, 97, c9, 05, 51, e5),
+	be64_to_cpua(c3, 6a, 87, 6e, b5, 13, 1f, 20),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 00, ff) },
+	.c_size = ECC_MAX_BYTES * 2,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	},
+	{
+	.key = /* secp521r1(sha512) */
+	"\x04\x00\xc7\x65\xee\x0b\x86\x7d\x8f\x02\xf1\x74\x5b\xb0\x4c\x3f"
+	"\xa6\x35\x60\x9f\x55\x23\x11\xcc\xdf\xb8\x42\x99\xee\x6c\x96\x6a"
+	"\x27\xa2\x56\xb2\x2b\x03\xad\x0f\xe7\x97\xde\x09\x5d\xb4\xc5\x5f"
+	"\xbd\x87\x37\xbf\x5a\x16\x35\x56\x08\xfd\x6f\x06\x1a\x1c\x84\xee"
+	"\xc3\x64\xb3\x00\x9e\xbd\x6e\x60\x76\xee\x69\xfd\x3a\xb8\xcd\x7e"
+	"\x91\x68\x53\x57\x44\x13\x2e\x77\x09\x2a\xbe\x48\xbd\x91\xd8\xf6"
+	"\x21\x16\x53\x99\xd5\xf0\x40\xad\xa6\xf8\x58\x26\xb6\x9a\xf8\x77"
+	"\xfe\x3a\x05\x1a\xdb\xa9\x0f\xc0\x6c\x76\x30\x8c\xd8\xde\x44\xae"
+	"\xd0\x17\xdf\x49\x6a",
+	.key_len = 133,
+	.params =
+	"\x30\x10\x06\x07\x2a\x86\x48\xce\x3d\x02\x01\x06\x05\x2b\x81\x04"
+	"\x00\x23",
+	.param_len = 18,
+	.m =
+	"\x5c\xa6\xbc\x79\xb8\xa0\x1e\x11\x83\xf7\xe9\x05\xdf\xba\xf7\x69"
+	"\x97\x22\x32\xe4\x94\x7c\x65\xbd\x74\xc6\x9a\x8b\xbd\x0d\xdc\xed"
+	"\xf5\x9c\xeb\xe1\xc5\x68\x40\xf2\xc7\x04\xde\x9e\x0d\x76\xc5\xa3"
+	"\xf9\x3c\x6c\x98\x08\x31\xbd\x39\xe8\x42\x7f\x80\x39\x6f\xfe\x68",
+	.m_size = 64,
+	.algo = OID_id_ecdsa_with_sha512,
+	.c = (const unsigned char[]){
+	be64_to_cpua(28, b5, 04, b0, b6, 33, 1c, 7e),
+	be64_to_cpua(80, a6, 13, fc, b6, 90, f7, bb),
+	be64_to_cpua(27, 93, e8, 6c, 49, 7d, 28, fc),
+	be64_to_cpua(1f, 12, 3e, b7, 7e, 51, ff, 7f),
+	be64_to_cpua(fb, 62, 1e, 42, 03, 6c, 74, 8a),
+	be64_to_cpua(63, 0e, 02, cc, 94, a9, 05, b9),
+	be64_to_cpua(aa, 86, ec, a8, 05, 03, 52, 56),
+	be64_to_cpua(71, 86, 96, ac, 21, 33, 7e, 4e),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 01, 5c),
+	be64_to_cpua(46, 1e, 77, 44, 78, e0, d1, 04),
+	be64_to_cpua(72, 74, 13, 63, 39, a6, e5, 25),
+	be64_to_cpua(00, 55, bb, 6a, b4, 73, 00, d2),
+	be64_to_cpua(71, d0, e9, ca, a7, c0, cb, aa),
+	be64_to_cpua(7a, 76, 37, 51, 47, 49, 98, 12),
+	be64_to_cpua(88, 05, 3e, 43, 39, 01, bd, b7),
+	be64_to_cpua(95, 35, 89, 4f, 41, 5f, 9e, 19),
+	be64_to_cpua(43, 52, 1d, e3, c6, bd, 5a, 40),
+	be64_to_cpua(00, 00, 00, 00, 00, 00, 01, 70) },
+	.c_size = ECC_MAX_BYTES * 2,
+	.public_key_vec = true,
+	.siggen_sigver_test = true,
+	},
+};
+
+/*
+ * ECDSA X9.62 test vectors.
+ *
+ * Identical to ECDSA test vectors, except signature in "c" is X9.62 encoded.
+ */
+static const struct akcipher_testvec x962_ecdsa_nist_p192_tv_template[] = {
 	{
 	.key =
 	"\x04\xf7\x46\xf8\x2f\x15\xf6\x22\x8e\xd7\x57\x4f\xcc\xe7\xbb\xc1"
@@ -777,7 +1584,7 @@ static const struct akcipher_testvec ecdsa_nist_p192_tv_template[] = {
 	},
 };
 
-static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
+static const struct akcipher_testvec x962_ecdsa_nist_p256_tv_template[] = {
 	{
 	.key =
 	"\x04\xb9\x7b\xbb\xd7\x17\x64\xd2\x7e\xfc\x81\x5d\x87\x06\x83\x41"
@@ -914,7 +1721,7 @@ static const struct akcipher_testvec ecdsa_nist_p256_tv_template[] = {
 	},
 };
 
-static const struct akcipher_testvec ecdsa_nist_p384_tv_template[] = {
+static const struct akcipher_testvec x962_ecdsa_nist_p384_tv_template[] = {
 	{
 	.key = /* secp384r1(sha1) */
 	"\x04\x89\x25\xf3\x97\x88\xcb\xb0\x78\xc5\x72\x9a\x14\x6e\x7a\xb1"
@@ -1071,7 +1878,7 @@ static const struct akcipher_testvec ecdsa_nist_p384_tv_template[] = {
 	},
 };
 
-static const struct akcipher_testvec ecdsa_nist_p521_tv_template[] = {
+static const struct akcipher_testvec x962_ecdsa_nist_p521_tv_template[] = {
 	{
 	.key = /* secp521r1(sha224) */
 	"\x04\x01\x4f\x43\x18\xb6\xa9\xc9\x5d\x68\xd3\xa9\x42\xf8\x98\xc0"
diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
index 0717a53ae732..568b7c5352b9 100644
--- a/include/crypto/internal/ecc.h
+++ b/include/crypto/internal/ecc.h
@@ -293,4 +293,5 @@ void ecc_point_mult_shamir(const struct ecc_point *result,
 			   const u64 *y, const struct ecc_point *q,
 			   const struct ecc_curve *curve);
 
+extern struct crypto_template ecdsa_x962_tmpl;
 #endif
-- 
2.43.0


