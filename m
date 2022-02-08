Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1E384AD108
	for <lists+linux-crypto@lfdr.de>; Tue,  8 Feb 2022 06:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347431AbiBHFdQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 8 Feb 2022 00:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiBHF1d (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 8 Feb 2022 00:27:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD7FC0401DC;
        Mon,  7 Feb 2022 21:27:31 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFAE861586;
        Tue,  8 Feb 2022 05:27:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107C1C340F3;
        Tue,  8 Feb 2022 05:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644298050;
        bh=/+K9xJqNUbZi+7N8cFg9gue80UqlTLBuUSdgObEXWFM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z7rRp2j1ZqpV2TpYaXY7gJ1fGd3/rz8go1vNnL7LLhFajnASfbccwm7ghLhfiuPo8
         cspY+XndgYuFiHwUis9KwIApnSJ7WL6WC8o+CYE9fJ7SVTU4OHUKn5sCkGYAU2KFTN
         qeLv63wFZi5nMV4c8OBifjSJUd4MM4odt4R2FAIWD/80IerMETe2YIi6qK97MGDo4+
         JdrJW6rxjVVBAINnsdihCisrPF5e1iKj4oQr/UzP4eKeDtmD4PnGDd47wY4EAVbc2O
         JkRn+Qt9Q/eAZ8h5x1OdjWhIhXnRTuu4dHQIW2s6YVvnpi4xFRb9vEA0QFvyrHwzSP
         0/51eoviLja8A==
From:   Eric Biggers <ebiggers@kernel.org>
To:     keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>
Cc:     linux-crypto@vger.kernel.org, linux-integrity@vger.kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Mimi Zohar <zohar@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v2 2/2] KEYS: asymmetric: properly validate hash_algo and encoding
Date:   Mon,  7 Feb 2022 21:24:48 -0800
Message-Id: <20220208052448.409152-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220208052448.409152-1-ebiggers@kernel.org>
References: <20220208052448.409152-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

It is insecure to allow arbitrary hash algorithms and signature
encodings to be used with arbitrary signature algorithms.  Notably,
ECDSA, ECRDSA, and SM2 all sign/verify raw hash values and don't
disambiguate between different hash algorithms like RSA PKCS#1 v1.5
padding does.  Therefore, they need to be restricted to certain sets of
hash algorithms (ideally just one, but in practice small sets are used).
Additionally, the encoding is an integral part of modern signature
algorithms, and is not supposed to vary.

Therefore, tighten the checks of hash_algo and encoding done by
software_key_determine_akcipher().

Also rearrange the parameters to software_key_determine_akcipher() to
put the public_key first, as this is the most important parameter and it
often determines everything else.

Fixes: 299f561a6693 ("x509: Add support for parsing x509 certs with ECDSA keys")
Fixes: 215525639631 ("X.509: support OSCCA SM2-with-SM3 certificate verification")
Fixes: 0d7a78643f69 ("crypto: ecrdsa - add EC-RDSA (GOST 34.10) algorithm")
Cc: stable@vger.kernel.org
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
Tested-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/asymmetric_keys/public_key.c | 111 +++++++++++++++++++---------
 1 file changed, 76 insertions(+), 35 deletions(-)

diff --git a/crypto/asymmetric_keys/public_key.c b/crypto/asymmetric_keys/public_key.c
index e36213945686..7c9e6be35c30 100644
--- a/crypto/asymmetric_keys/public_key.c
+++ b/crypto/asymmetric_keys/public_key.c
@@ -60,39 +60,83 @@ static void public_key_destroy(void *payload0, void *payload3)
 }
 
 /*
- * Determine the crypto algorithm name.
+ * Given a public_key, and an encoding and hash_algo to be used for signing
+ * and/or verification with that key, determine the name of the corresponding
+ * akcipher algorithm.  Also check that encoding and hash_algo are allowed.
  */
-static
-int software_key_determine_akcipher(const char *encoding,
-				    const char *hash_algo,
-				    const struct public_key *pkey,
-				    char alg_name[CRYPTO_MAX_ALG_NAME])
+static int
+software_key_determine_akcipher(const struct public_key *pkey,
+				const char *encoding, const char *hash_algo,
+				char alg_name[CRYPTO_MAX_ALG_NAME])
 {
 	int n;
 
-	if (strcmp(encoding, "pkcs1") == 0) {
-		/* The data wangled by the RSA algorithm is typically padded
-		 * and encoded in some manner, such as EMSA-PKCS1-1_5 [RFC3447
-		 * sec 8.2].
+	if (!encoding)
+		return -EINVAL;
+
+	if (strcmp(pkey->pkey_algo, "rsa") == 0) {
+		/*
+		 * RSA signatures usually use EMSA-PKCS1-1_5 [RFC3447 sec 8.2].
+		 */
+		if (strcmp(encoding, "pkcs1") == 0) {
+			if (!hash_algo)
+				n = snprintf(alg_name, CRYPTO_MAX_ALG_NAME,
+					     "pkcs1pad(%s)",
+					     pkey->pkey_algo);
+			else
+				n = snprintf(alg_name, CRYPTO_MAX_ALG_NAME,
+					     "pkcs1pad(%s,%s)",
+					     pkey->pkey_algo, hash_algo);
+			return n >= CRYPTO_MAX_ALG_NAME ? -EINVAL : 0;
+		}
+		if (strcmp(encoding, "raw") != 0)
+			return -EINVAL;
+		/*
+		 * Raw RSA cannot differentiate between different hash
+		 * algorithms.
+		 */
+		if (hash_algo)
+			return -EINVAL;
+	} else if (strncmp(pkey->pkey_algo, "ecdsa", 5) == 0) {
+		if (strcmp(encoding, "x962") != 0)
+			return -EINVAL;
+		/*
+		 * ECDSA signatures are taken over a raw hash, so they don't
+		 * differentiate between different hash algorithms.  That means
+		 * that the verifier should hard-code a specific hash algorithm.
+		 * Unfortunately, in practice ECDSA is used with multiple SHAs,
+		 * so we have to allow all of them and not just one.
 		 */
 		if (!hash_algo)
-			n = snprintf(alg_name, CRYPTO_MAX_ALG_NAME,
-				     "pkcs1pad(%s)",
-				     pkey->pkey_algo);
-		else
-			n = snprintf(alg_name, CRYPTO_MAX_ALG_NAME,
-				     "pkcs1pad(%s,%s)",
-				     pkey->pkey_algo, hash_algo);
-		return n >= CRYPTO_MAX_ALG_NAME ? -EINVAL : 0;
-	}
-
-	if (strcmp(encoding, "raw") == 0 ||
-	    strcmp(encoding, "x962") == 0) {
-		strcpy(alg_name, pkey->pkey_algo);
-		return 0;
+			return -EINVAL;
+		if (strcmp(hash_algo, "sha1") != 0 &&
+		    strcmp(hash_algo, "sha224") != 0 &&
+		    strcmp(hash_algo, "sha256") != 0 &&
+		    strcmp(hash_algo, "sha384") != 0 &&
+		    strcmp(hash_algo, "sha512") != 0)
+			return -EINVAL;
+	} else if (strcmp(pkey->pkey_algo, "sm2") == 0) {
+		if (strcmp(encoding, "raw") != 0)
+			return -EINVAL;
+		if (!hash_algo)
+			return -EINVAL;
+		if (strcmp(hash_algo, "sm3") != 0)
+			return -EINVAL;
+	} else if (strcmp(pkey->pkey_algo, "ecrdsa") == 0) {
+		if (strcmp(encoding, "raw") != 0)
+			return -EINVAL;
+		if (!hash_algo)
+			return -EINVAL;
+		if (strcmp(hash_algo, "streebog256") != 0 &&
+		    strcmp(hash_algo, "streebog512") != 0)
+			return -EINVAL;
+	} else {
+		/* Unknown public key algorithm */
+		return -ENOPKG;
 	}
-
-	return -ENOPKG;
+	if (strscpy(alg_name, pkey->pkey_algo, CRYPTO_MAX_ALG_NAME) < 0)
+		return -EINVAL;
+	return 0;
 }
 
 static u8 *pkey_pack_u32(u8 *dst, u32 val)
@@ -113,9 +157,8 @@ static int software_key_query(const struct kernel_pkey_params *params,
 	u8 *key, *ptr;
 	int ret, len;
 
-	ret = software_key_determine_akcipher(params->encoding,
-					      params->hash_algo,
-					      pkey, alg_name);
+	ret = software_key_determine_akcipher(pkey, params->encoding,
+					      params->hash_algo, alg_name);
 	if (ret < 0)
 		return ret;
 
@@ -179,9 +222,8 @@ static int software_key_eds_op(struct kernel_pkey_params *params,
 
 	pr_devel("==>%s()\n", __func__);
 
-	ret = software_key_determine_akcipher(params->encoding,
-					      params->hash_algo,
-					      pkey, alg_name);
+	ret = software_key_determine_akcipher(pkey, params->encoding,
+					      params->hash_algo, alg_name);
 	if (ret < 0)
 		return ret;
 
@@ -340,9 +382,8 @@ int public_key_verify_signature(const struct public_key *pkey,
 			return -EKEYREJECTED;
 	}
 
-	ret = software_key_determine_akcipher(sig->encoding,
-					      sig->hash_algo,
-					      pkey, alg_name);
+	ret = software_key_determine_akcipher(pkey, sig->encoding,
+					      sig->hash_algo, alg_name);
 	if (ret < 0)
 		return ret;
 
-- 
2.35.1

