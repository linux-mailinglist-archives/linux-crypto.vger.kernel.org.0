Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D27B1F3D25
	for <lists+linux-crypto@lfdr.de>; Tue,  9 Jun 2020 15:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730263AbgFINtN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 9 Jun 2020 09:49:13 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:46093 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729535AbgFINtI (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 9 Jun 2020 09:49:08 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=20;SR=0;TI=SMTPD_---0U.6GXuU_1591710541;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U.6GXuU_1591710541)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 09 Jun 2020 21:49:02 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dhowells@redhat.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@st.com, jmorris@namei.org, serge@hallyn.com,
        nramas@linux.microsoft.com, tusharsu@linux.microsoft.com,
        zohar@linux.ibm.com, gilad@benyossef.com, pvanleeuwen@rambus.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-security-module@vger.kernel.org, zhang.jia@linux.alibaba.com,
        tianjia.zhang@linux.alibaba.com
Subject: [PATCH v3 7/8] X.509: support OSCCA sm2-with-sm3 certificate verification
Date:   Tue,  9 Jun 2020 21:48:54 +0800
Message-Id: <20200609134855.21431-8-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200609134855.21431-1-tianjia.zhang@linux.alibaba.com>
References: <20200609134855.21431-1-tianjia.zhang@linux.alibaba.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The digital certificate format based on SM2 crypto algorithm as
specified in GM/T 0015-2012. It was published by State Encryption
Management Bureau, China.

The method of generating Other User Information is defined as
ZA=H256(ENTLA || IDA || a || b || xG || yG || xA || yA), it also
specified in https://tools.ietf.org/html/draft-shen-sm2-ecdsa-02.

The x509 certificate supports sm2-with-sm3 type certificate
verification.  Because certificate verification requires ZA
in addition to tbs data, ZA also depends on elliptic curve
parameters and public key data, so you need to access tbs in sig
and calculate ZA. Finally calculate the digest of the
signature and complete the verification work. The calculation
process of ZA is declared in specifications GM/T 0009-2012
and GM/T 0003.2-2012.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/asymmetric_keys/Makefile          |  1 +
 crypto/asymmetric_keys/public_key.c      |  6 +++
 crypto/asymmetric_keys/public_key_sm2.c  | 59 ++++++++++++++++++++++++
 crypto/asymmetric_keys/x509_public_key.c |  2 +
 include/crypto/public_key.h              | 14 ++++++
 5 files changed, 82 insertions(+)
 create mode 100644 crypto/asymmetric_keys/public_key_sm2.c

diff --git a/crypto/asymmetric_keys/Makefile b/crypto/asymmetric_keys/Makefile
index 28b91adba2ae..d499367dd253 100644
--- a/crypto/asymmetric_keys/Makefile
+++ b/crypto/asymmetric_keys/Makefile
@@ -11,6 +11,7 @@ asymmetric_keys-y := \
 	signature.o
 
 obj-$(CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE) += public_key.o
+obj-$(CONFIG_CRYPTO_SM2) += public_key_sm2.o
 obj-$(CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE) += asym_tpm.o
 
 #
diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index d7f43d4ea925..7283ddb7c5e2 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -298,6 +298,12 @@ int public_key_verify_signature(const struct public_key *pkey,
 	if (ret)
 		goto error_free_key;
 
+	if (strcmp(sig->pkey_algo, "sm2") == 0) {
+		ret = cert_sig_digest_update(sig, tfm);
+		if (ret)
+			goto error_free_key;
+	}
+
 	sg_init_table(src_sg, 2);
 	sg_set_buf(&src_sg[0], sig->s, sig->s_size);
 	sg_set_buf(&src_sg[1], sig->digest, sig->digest_size);
diff --git a/crypto/asymmetric_keys/public_key_sm2.c b/crypto/asymmetric_keys/public_key_sm2.c
new file mode 100644
index 000000000000..d7f144e53f41
--- /dev/null
+++ b/crypto/asymmetric_keys/public_key_sm2.c
@@ -0,0 +1,59 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * asymmetric public-key algorithm for SM2-with-SM3 certificate
+ * as specified by OSCCA GM/T 0003.1-2012 -- 0003.5-2012 SM2 and
+ * described at https://tools.ietf.org/html/draft-shen-sm2-ecdsa-02
+ *
+ * Copyright (c) 2020, Alibaba Group.
+ * Authors: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
+ */
+
+#include <crypto/sm3_base.h>
+#include <crypto/sm2.h>
+#include "x509_parser.h"
+
+int cert_sig_digest_update(const struct public_key_signature *sig,
+				struct crypto_akcipher *tfm_pkey)
+{
+	struct x509_certificate *cert = sig->cert;
+	struct crypto_shash *tfm;
+	struct shash_desc *desc;
+	size_t desc_size;
+	unsigned char dgst[SM3_DIGEST_SIZE];
+	int ret;
+
+	if (!cert)
+		return -EINVAL;
+
+	ret = sm2_compute_z_digest(tfm_pkey, SM2_DEFAULT_USERID,
+					SM2_DEFAULT_USERID_LEN, dgst);
+	if (ret)
+		return ret;
+
+	tfm = crypto_alloc_shash(sig->hash_algo, 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	desc_size = crypto_shash_descsize(tfm) + sizeof(*desc);
+	desc = kzalloc(desc_size, GFP_KERNEL);
+	if (!desc)
+		goto error_free_tfm;
+
+	desc->tfm = tfm;
+
+	ret = crypto_shash_init(desc);
+	if (ret < 0)
+		goto error_free_desc;
+
+	ret = crypto_shash_update(desc, dgst, SM3_DIGEST_SIZE);
+	if (ret < 0)
+		goto error_free_desc;
+
+	ret = crypto_shash_finup(desc, cert->tbs, cert->tbs_size, sig->digest);
+
+error_free_desc:
+	kfree(desc);
+error_free_tfm:
+	crypto_free_shash(tfm);
+	return ret;
+}
diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index d964cc82b69c..feccec08b244 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -30,6 +30,8 @@ int x509_get_sig_params(struct x509_certificate *cert)
 
 	pr_devel("==>%s()\n", __func__);
 
+	sig->cert = cert;
+
 	if (!cert->pub->pkey_algo)
 		cert->unsupported_key = true;
 
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index 0588ef3bc6ff..4bf007424f56 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -12,6 +12,7 @@
 
 #include <linux/keyctl.h>
 #include <linux/oid_registry.h>
+#include <crypto/akcipher.h>
 
 /*
  * Cryptographic data for the public-key subtype of the asymmetric key type.
@@ -44,6 +45,7 @@ struct public_key_signature {
 	const char *pkey_algo;
 	const char *hash_algo;
 	const char *encoding;
+	void *cert;		/* For certificate */
 };
 
 extern void public_key_signature_free(struct public_key_signature *sig);
@@ -81,4 +83,16 @@ extern int verify_signature(const struct key *,
 int public_key_verify_signature(const struct public_key *pkey,
 				const struct public_key_signature *sig);
 
+#ifdef CONFIG_CRYPTO_SM2
+int cert_sig_digest_update(const struct public_key_signature *sig,
+				struct crypto_akcipher *tfm_pkey);
+#else
+static inline
+int cert_sig_digest_update(const struct public_key_signature *sig,
+				struct crypto_akcipher *tfm_pkey)
+{
+	return -ENOTSUPP;
+}
+#endif
+
 #endif /* _LINUX_PUBLIC_KEY_H */
-- 
2.17.1

