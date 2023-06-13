Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F70772DDED
	for <lists+linux-crypto@lfdr.de>; Tue, 13 Jun 2023 11:38:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239355AbjFMJij (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 13 Jun 2023 05:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239967AbjFMJig (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 13 Jun 2023 05:38:36 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF1DE3;
        Tue, 13 Jun 2023 02:38:34 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1q90Tf-002LR5-F7; Tue, 13 Jun 2023 17:38:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 13 Jun 2023 17:38:15 +0800
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Tue, 13 Jun 2023 17:38:15 +0800
Subject: [PATCH 4/5] KEYS: asymmetric: Move sm2 code into x509_public_key
References: <ZIg4b8kAeW7x/oM1@gondor.apana.org.au>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        David Howells <dhowells@redhat.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>, keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Message-Id: <E1q90Tf-002LR5-F7@formenos.hmeau.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The sm2 certificate requires a modified digest.  Move the code
for the hashing from the signature verification path into the
code where we generate the digest.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 crypto/asymmetric_keys/public_key.c      |   67 -------------------
 crypto/asymmetric_keys/x509_public_key.c |   28 +++++---
 crypto/sm2.c                             |  106 ++++++++++++++++++++-----------
 include/crypto/public_key.h              |    2 
 include/crypto/sm2.h                     |   12 ---
 5 files changed, 93 insertions(+), 122 deletions(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index eca5671ad3f2..c795a12a3599 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -18,8 +18,6 @@
 #include <keys/asymmetric-subtype.h>
 #include <crypto/public_key.h>
 #include <crypto/akcipher.h>
-#include <crypto/sm2.h>
-#include <crypto/sm3_base.h>
 
 MODULE_DESCRIPTION("In-software asymmetric public-key subtype");
 MODULE_AUTHOR("Red Hat, Inc.");
@@ -312,65 +310,6 @@ static int software_key_eds_op(struct kernel_pkey_params *params,
 	return ret;
 }
 
-#if IS_REACHABLE(CONFIG_CRYPTO_SM2)
-static int cert_sig_digest_update(const struct public_key_signature *sig,
-				  struct crypto_akcipher *tfm_pkey)
-{
-	struct crypto_shash *tfm;
-	struct shash_desc *desc;
-	size_t desc_size;
-	unsigned char dgst[SM3_DIGEST_SIZE];
-	int ret;
-
-	BUG_ON(!sig->data);
-
-	/* SM2 signatures always use the SM3 hash algorithm */
-	if (!sig->hash_algo || strcmp(sig->hash_algo, "sm3") != 0)
-		return -EINVAL;
-
-	ret = sm2_compute_z_digest(tfm_pkey, SM2_DEFAULT_USERID,
-					SM2_DEFAULT_USERID_LEN, dgst);
-	if (ret)
-		return ret;
-
-	tfm = crypto_alloc_shash(sig->hash_algo, 0, 0);
-	if (IS_ERR(tfm))
-		return PTR_ERR(tfm);
-
-	desc_size = crypto_shash_descsize(tfm) + sizeof(*desc);
-	desc = kzalloc(desc_size, GFP_KERNEL);
-	if (!desc) {
-		ret = -ENOMEM;
-		goto error_free_tfm;
-	}
-
-	desc->tfm = tfm;
-
-	ret = crypto_shash_init(desc);
-	if (ret < 0)
-		goto error_free_desc;
-
-	ret = crypto_shash_update(desc, dgst, SM3_DIGEST_SIZE);
-	if (ret < 0)
-		goto error_free_desc;
-
-	ret = crypto_shash_finup(desc, sig->data, sig->data_size, sig->digest);
-
-error_free_desc:
-	kfree(desc);
-error_free_tfm:
-	crypto_free_shash(tfm);
-	return ret;
-}
-#else
-static inline int cert_sig_digest_update(
-	const struct public_key_signature *sig,
-	struct crypto_akcipher *tfm_pkey)
-{
-	return -ENOTSUPP;
-}
-#endif /* ! IS_REACHABLE(CONFIG_CRYPTO_SM2) */
-
 /*
  * Verify a signature using a public key.
  */
@@ -438,12 +377,6 @@ int public_key_verify_signature(const struct public_key *pkey,
 	if (ret)
 		goto error_free_key;
 
-	if (strcmp(pkey->pkey_algo, "sm2") == 0 && sig->data_size) {
-		ret = cert_sig_digest_update(sig, tfm);
-		if (ret)
-			goto error_free_key;
-	}
-
 	sg_init_table(src_sg, 2);
 	sg_set_buf(&src_sg[0], sig->s, sig->s_size);
 	sg_set_buf(&src_sg[1], sig->digest, sig->digest_size);
diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index 0b4943a4592b..2fca030a6290 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -6,13 +6,15 @@
  */
 
 #define pr_fmt(fmt) "X.509: "fmt
+#include <crypto/hash.h>
+#include <crypto/sm2.h>
+#include <keys/asymmetric-parser.h>
+#include <keys/asymmetric-subtype.h>
+#include <keys/system_keyring.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
-#include <keys/asymmetric-subtype.h>
-#include <keys/asymmetric-parser.h>
-#include <keys/system_keyring.h>
-#include <crypto/hash.h>
+#include <linux/string.h>
 #include "asymmetric_keys.h"
 #include "x509_parser.h"
 
@@ -30,9 +32,6 @@ int x509_get_sig_params(struct x509_certificate *cert)
 
 	pr_devel("==>%s()\n", __func__);
 
-	sig->data = cert->tbs;
-	sig->data_size = cert->tbs_size;
-
 	sig->s = kmemdup(cert->raw_sig, cert->raw_sig_size, GFP_KERNEL);
 	if (!sig->s)
 		return -ENOMEM;
@@ -65,7 +64,20 @@ int x509_get_sig_params(struct x509_certificate *cert)
 
 	desc->tfm = tfm;
 
-	ret = crypto_shash_digest(desc, cert->tbs, cert->tbs_size, sig->digest);
+	if (strcmp(cert->pub->pkey_algo, "sm2") == 0) {
+		ret = strcmp(sig->hash_algo, "sm3") != 0 ? -EINVAL :
+		      crypto_shash_init(desc) ?:
+		      sm2_compute_z_digest(desc, cert->pub->key,
+					   cert->pub->keylen, sig->digest) ?:
+		      crypto_shash_init(desc) ?:
+		      crypto_shash_update(desc, sig->digest,
+					  sig->digest_size) ?:
+		      crypto_shash_finup(desc, cert->tbs, cert->tbs_size,
+					 sig->digest);
+	} else
+		ret = crypto_shash_digest(desc, cert->tbs, cert->tbs_size,
+					  sig->digest);
+
 	if (ret < 0)
 		goto error_2;
 
diff --git a/crypto/sm2.c b/crypto/sm2.c
index ed9307dac3d1..285b3cb7c0bc 100644
--- a/crypto/sm2.c
+++ b/crypto/sm2.c
@@ -13,11 +13,14 @@
 #include <crypto/internal/akcipher.h>
 #include <crypto/akcipher.h>
 #include <crypto/hash.h>
-#include <crypto/sm3.h>
 #include <crypto/rng.h>
 #include <crypto/sm2.h>
 #include "sm2signature.asn1.h"
 
+/* The default user id as specified in GM/T 0009-2012 */
+#define SM2_DEFAULT_USERID "1234567812345678"
+#define SM2_DEFAULT_USERID_LEN 16
+
 #define MPI_NBYTES(m)   ((mpi_get_nbits(m) + 7) / 8)
 
 struct ecc_domain_parms {
@@ -60,6 +63,9 @@ static const struct ecc_domain_parms sm2_ecp = {
 	.h = 1
 };
 
+static int __sm2_set_pub_key(struct mpi_ec_ctx *ec,
+			     const void *key, unsigned int keylen);
+
 static int sm2_ec_ctx_init(struct mpi_ec_ctx *ec)
 {
 	const struct ecc_domain_parms *ecp = &sm2_ecp;
@@ -213,12 +219,13 @@ int sm2_get_signature_s(void *context, size_t hdrlen, unsigned char tag,
 	return 0;
 }
 
-static int sm2_z_digest_update(struct sm3_state *sctx,
-			MPI m, unsigned int pbytes)
+static int sm2_z_digest_update(struct shash_desc *desc,
+			       MPI m, unsigned int pbytes)
 {
 	static const unsigned char zero[32];
 	unsigned char *in;
 	unsigned int inlen;
+	int err;
 
 	in = mpi_get_buffer(m, &inlen, NULL);
 	if (!in)
@@ -226,21 +233,22 @@ static int sm2_z_digest_update(struct sm3_state *sctx,
 
 	if (inlen < pbytes) {
 		/* padding with zero */
-		sm3_update(sctx, zero, pbytes - inlen);
-		sm3_update(sctx, in, inlen);
+		err = crypto_shash_update(desc, zero, pbytes - inlen) ?:
+		      crypto_shash_update(desc, in, inlen);
 	} else if (inlen > pbytes) {
 		/* skip the starting zero */
-		sm3_update(sctx, in + inlen - pbytes, pbytes);
+		err = crypto_shash_update(desc, in + inlen - pbytes, pbytes);
 	} else {
-		sm3_update(sctx, in, inlen);
+		err = crypto_shash_update(desc, in, inlen);
 	}
 
 	kfree(in);
-	return 0;
+	return err;
 }
 
-static int sm2_z_digest_update_point(struct sm3_state *sctx,
-		MPI_POINT point, struct mpi_ec_ctx *ec, unsigned int pbytes)
+static int sm2_z_digest_update_point(struct shash_desc *desc,
+				     MPI_POINT point, struct mpi_ec_ctx *ec,
+				     unsigned int pbytes)
 {
 	MPI x, y;
 	int ret = -EINVAL;
@@ -248,50 +256,68 @@ static int sm2_z_digest_update_point(struct sm3_state *sctx,
 	x = mpi_new(0);
 	y = mpi_new(0);
 
-	if (!mpi_ec_get_affine(x, y, point, ec) &&
-	    !sm2_z_digest_update(sctx, x, pbytes) &&
-	    !sm2_z_digest_update(sctx, y, pbytes))
-		ret = 0;
+	ret = mpi_ec_get_affine(x, y, point, ec) ? -EINVAL :
+	      sm2_z_digest_update(desc, x, pbytes) ?:
+	      sm2_z_digest_update(desc, y, pbytes);
 
 	mpi_free(x);
 	mpi_free(y);
 	return ret;
 }
 
-int sm2_compute_z_digest(struct crypto_akcipher *tfm,
-			const unsigned char *id, size_t id_len,
-			unsigned char dgst[SM3_DIGEST_SIZE])
+int sm2_compute_z_digest(struct shash_desc *desc,
+			 const void *key, unsigned int keylen, void *dgst)
 {
-	struct mpi_ec_ctx *ec = akcipher_tfm_ctx(tfm);
-	uint16_t bits_len;
-	unsigned char entl[2];
-	struct sm3_state sctx;
+	struct mpi_ec_ctx *ec;
+	unsigned int bits_len;
 	unsigned int pbytes;
+	u8 entl[2];
+	int err;
 
-	if (id_len > (USHRT_MAX / 8) || !ec->Q)
-		return -EINVAL;
+	ec = kmalloc(sizeof(*ec), GFP_KERNEL);
+	if (!ec)
+		return -ENOMEM;
+
+	err = __sm2_set_pub_key(ec, key, keylen);
+	if (err)
+		goto out_free_ec;
 
-	bits_len = (uint16_t)(id_len * 8);
+	bits_len = SM2_DEFAULT_USERID_LEN * 8;
 	entl[0] = bits_len >> 8;
 	entl[1] = bits_len & 0xff;
 
 	pbytes = MPI_NBYTES(ec->p);
 
 	/* ZA = H256(ENTLA | IDA | a | b | xG | yG | xA | yA) */
-	sm3_init(&sctx);
-	sm3_update(&sctx, entl, 2);
-	sm3_update(&sctx, id, id_len);
-
-	if (sm2_z_digest_update(&sctx, ec->a, pbytes) ||
-	    sm2_z_digest_update(&sctx, ec->b, pbytes) ||
-	    sm2_z_digest_update_point(&sctx, ec->G, ec, pbytes) ||
-	    sm2_z_digest_update_point(&sctx, ec->Q, ec, pbytes))
-		return -EINVAL;
+	err = crypto_shash_init(desc);
+	if (err)
+		goto out_deinit_ec;
 
-	sm3_final(&sctx, dgst);
-	return 0;
+	err = crypto_shash_update(desc, entl, 2);
+	if (err)
+		goto out_deinit_ec;
+
+	err = crypto_shash_update(desc, SM2_DEFAULT_USERID,
+				  SM2_DEFAULT_USERID_LEN);
+	if (err)
+		goto out_deinit_ec;
+
+	err = sm2_z_digest_update(desc, ec->a, pbytes) ?:
+	      sm2_z_digest_update(desc, ec->b, pbytes) ?:
+	      sm2_z_digest_update_point(desc, ec->G, ec, pbytes) ?:
+	      sm2_z_digest_update_point(desc, ec->Q, ec, pbytes);
+	if (err)
+		goto out_deinit_ec;
+
+	err = crypto_shash_final(desc, dgst);
+
+out_deinit_ec:
+	sm2_ec_ctx_deinit(ec);
+out_free_ec:
+	kfree(ec);
+	return err;
 }
-EXPORT_SYMBOL(sm2_compute_z_digest);
+EXPORT_SYMBOL_GPL(sm2_compute_z_digest);
 
 static int _sm2_verify(struct mpi_ec_ctx *ec, MPI hash, MPI sig_r, MPI sig_s)
 {
@@ -391,6 +417,14 @@ static int sm2_set_pub_key(struct crypto_akcipher *tfm,
 			const void *key, unsigned int keylen)
 {
 	struct mpi_ec_ctx *ec = akcipher_tfm_ctx(tfm);
+
+	return __sm2_set_pub_key(ec, key, keylen);
+
+}
+
+static int __sm2_set_pub_key(struct mpi_ec_ctx *ec,
+			     const void *key, unsigned int keylen)
+{
 	MPI a;
 	int rc;
 
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 653992a6e941..8fadd561c50e 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -48,8 +48,6 @@ struct public_key_signature {
 	const char *pkey_algo;
 	const char *hash_algo;
 	const char *encoding;
-	const void *data;
-	unsigned int data_size;
 };
 
 extern void public_key_signature_free(struct public_key_signature *sig);
diff --git a/include/crypto/sm2.h b/include/crypto/sm2.h
index af452556dcd4..7094d75ed54c 100644
--- a/include/crypto/sm2.h
+++ b/include/crypto/sm2.h
@@ -11,15 +11,9 @@
 #ifndef _CRYPTO_SM2_H
 #define _CRYPTO_SM2_H
 
-#include <crypto/sm3.h>
-#include <crypto/akcipher.h>
+struct shash_desc;
 
-/* The default user id as specified in GM/T 0009-2012 */
-#define SM2_DEFAULT_USERID "1234567812345678"
-#define SM2_DEFAULT_USERID_LEN 16
-
-extern int sm2_compute_z_digest(struct crypto_akcipher *tfm,
-			const unsigned char *id, size_t id_len,
-			unsigned char dgst[SM3_DIGEST_SIZE]);
+int sm2_compute_z_digest(struct shash_desc *desc,
+			 const void *key, unsigned int keylen, void *dgst);
 
 #endif /* _CRYPTO_SM2_H */
