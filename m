Return-Path: <linux-crypto+bounces-3631-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 751428A88BC
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Apr 2024 18:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97E111C22805
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Apr 2024 16:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF51C1494B8;
	Wed, 17 Apr 2024 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="X13wy9SK"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7580148849;
	Wed, 17 Apr 2024 16:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713370898; cv=none; b=G3wPpwuEq7TNhGXcChPuRtOM0EVfewl/rZRHjQ91TMKZeIfL0ao+DBudlUHAJdJ9HITcBbSa+QBEwLaLo70hxhMifY2kEjPdxhW6kh8VxYlmpP79WmXWNIcj+n3n4B4EHTHai2TJMObawjddkORp6p+uJdWDfYMwZROXsKuqVWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713370898; c=relaxed/simple;
	bh=FZNNZzQDGvE0/zYCuy8u6/O1zoxgSlPDmN9D8f4IprM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Riep4trZBOoc/Yrm9F7I6dFZyAjG1KUq22ca4WUaIOjJleq7ue4gMiCJGOjF9mE5v94TKYhmK8sX7IM2R7OmPd5hIUEUmi7/7GalpPfU8gtWWHFG4d7wG3ZT12t5ip5K33KhkYcFo1/5gTSR0XN6e07iljIMb2hcIFLf9f00ijI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=X13wy9SK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43HFtWKb018816;
	Wed, 17 Apr 2024 16:21:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=IIrko1/T7CTt8L5i4sdyJ3PNU7RcmoZo6FeX9Iv00+g=;
 b=X13wy9SKvN1G9c3AH3QS9JrXgCztZbNRHQCuOwDEJLpsFLPNIhHjVI+FvgLO1Dz/tvN+
 +VdvnnCzdJtW0awgYKNY3tFth3KMQIsO+/kWOSOXrcF6pVVdHRwVoVaNjfr4P96/oehU
 FpH3W3ehWusCFvLCRTx+wNUqnf8NaAhPJeTwbqAfRo1vWbU99Zvt3bA4o2Ext+rnRU3W
 g+sVtF7HwJ39/J+DThsdITTr2kjdpK7lu06FO7ki3Aa9wRIF0FX4eIhXqN9ONH61JEVS
 1ylIeG7qOU8FYUW+pQdaB00hSjrw3Oh4y8MdYWF/63/c8Stne0lTKkbnyfMzKOsjNQJR Tg== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xjhg3g2d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 16:21:25 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43HEbm5o018288;
	Wed, 17 Apr 2024 16:21:25 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xg4ctdq4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Apr 2024 16:21:25 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43HGLMju16057076
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 16:21:24 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 84D2358055;
	Wed, 17 Apr 2024 16:21:22 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8E365804E;
	Wed, 17 Apr 2024 16:21:21 +0000 (GMT)
Received: from sbct-3.bos2.lab (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Apr 2024 16:21:21 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, jarkko@kernel.org, ardb@kernel.org,
        salvatore.benedetto@intel.com, git@jvdsn.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 2/2] crypto: ecdh & ecc - Initialize ctx->private_key in proper byte order
Date: Wed, 17 Apr 2024 12:21:17 -0400
Message-ID: <20240417162117.2752326-3-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240417162117.2752326-1-stefanb@linux.ibm.com>
References: <20240417162117.2752326-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hK9yyOq5i4OaG3fooP_pccMGZLQhUy9e
X-Proofpoint-ORIG-GUID: hK9yyOq5i4OaG3fooP_pccMGZLQhUy9e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-17_13,2024-04-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 mlxscore=0 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxlogscore=999 phishscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404170113

The private key in ctx->private_key is currently initialized in reverse
byte order in ecdh_set_secret and whenever the key is needed in proper
byte order the variable priv is introduced and the bytes from
ctx->private_key are copied into priv while being byte-swapped
(ecc_swap_digits). To get rid of the unnecessary byte swapping initialize
ctx->private_key in proper byte order and clean up all functions that were
previously using priv or were called with ctx->private_key:

- ecc_gen_privkey: Directly initialize the passed ctx->private_key with
  random bytes and get rid of the priv variable. This function only has
  ecdh_set_secret as a caller.

- crypto_ecdh_shared_secret: Called only from ecdh_compute_value with
  ctx->private_key. Get rid of the priv variable and work with the passed
  private_key directly.

- ecc_make_pub_key: Called only from ecdh_compute_value with
  ctx->private_key. Get rid of the priv variable and work with the passed
  private_key directly.

Cc: Salvatore Benedetto <salvatore.benedetto@intel.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecc.c                  | 29 ++++++++++-------------------
 crypto/ecdh.c                 |  8 +++-----
 include/crypto/internal/ecc.h |  3 ++-
 3 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/crypto/ecc.c b/crypto/ecc.c
index 2e05387b9499..c1d2e884be1e 100644
--- a/crypto/ecc.c
+++ b/crypto/ecc.c
@@ -1497,10 +1497,10 @@ EXPORT_SYMBOL(ecc_is_key_valid);
  * This method generates a private key uniformly distributed in the range
  * [2, n-3].
  */
-int ecc_gen_privkey(unsigned int curve_id, unsigned int ndigits, u64 *privkey)
+int ecc_gen_privkey(unsigned int curve_id, unsigned int ndigits,
+		    u64 *private_key)
 {
 	const struct ecc_curve *curve = ecc_get_curve(curve_id);
-	u64 priv[ECC_MAX_DIGITS];
 	unsigned int nbytes = ndigits << ECC_DIGITS_TO_BYTES_SHIFT;
 	unsigned int nbits = vli_num_bits(curve->n, ndigits);
 	int err;
@@ -1509,7 +1509,7 @@ int ecc_gen_privkey(unsigned int curve_id, unsigned int ndigits, u64 *privkey)
 	 * Step 1 & 2: check that N is included in Table 1 of FIPS 186-5,
 	 * section 6.1.1.
 	 */
-	if (nbits < 224 || ndigits > ARRAY_SIZE(priv))
+	if (nbits < 224)
 		return -EINVAL;
 
 	/*
@@ -1527,17 +1527,16 @@ int ecc_gen_privkey(unsigned int curve_id, unsigned int ndigits, u64 *privkey)
 		return -EFAULT;
 
 	/* Step 3: obtain N returned_bits from the DRBG. */
-	err = crypto_rng_get_bytes(crypto_default_rng, (u8 *)priv, nbytes);
+	err = crypto_rng_get_bytes(crypto_default_rng,
+				   (u8 *)private_key, nbytes);
 	crypto_put_default_rng();
 	if (err)
 		return err;
 
 	/* Step 4: make sure the private key is in the valid range. */
-	if (__ecc_is_key_valid(curve, priv, ndigits))
+	if (__ecc_is_key_valid(curve, private_key, ndigits))
 		return -EINVAL;
 
-	ecc_swap_digits(priv, privkey, ndigits);
-
 	return 0;
 }
 EXPORT_SYMBOL(ecc_gen_privkey);
@@ -1547,23 +1546,20 @@ int ecc_make_pub_key(unsigned int curve_id, unsigned int ndigits,
 {
 	int ret = 0;
 	struct ecc_point *pk;
-	u64 priv[ECC_MAX_DIGITS];
 	const struct ecc_curve *curve = ecc_get_curve(curve_id);
 
-	if (!private_key || ndigits > ARRAY_SIZE(priv)) {
+	if (!private_key) {
 		ret = -EINVAL;
 		goto out;
 	}
 
-	ecc_swap_digits(private_key, priv, ndigits);
-
 	pk = ecc_alloc_point(ndigits);
 	if (!pk) {
 		ret = -ENOMEM;
 		goto out;
 	}
 
-	ecc_point_mult(pk, &curve->g, priv, NULL, curve, ndigits);
+	ecc_point_mult(pk, &curve->g, private_key, NULL, curve, ndigits);
 
 	/* SP800-56A rev 3 5.6.2.1.3 key check */
 	if (ecc_is_pubkey_valid_full(curve, pk)) {
@@ -1647,13 +1643,11 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
 {
 	int ret = 0;
 	struct ecc_point *product, *pk;
-	u64 priv[ECC_MAX_DIGITS];
 	u64 rand_z[ECC_MAX_DIGITS];
 	unsigned int nbytes;
 	const struct ecc_curve *curve = ecc_get_curve(curve_id);
 
-	if (!private_key || !public_key ||
-	    ndigits > ARRAY_SIZE(priv) || ndigits > ARRAY_SIZE(rand_z)) {
+	if (!private_key || !public_key || ndigits > ARRAY_SIZE(rand_z)) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -1674,15 +1668,13 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
 	if (ret)
 		goto err_alloc_product;
 
-	ecc_swap_digits(private_key, priv, ndigits);
-
 	product = ecc_alloc_point(ndigits);
 	if (!product) {
 		ret = -ENOMEM;
 		goto err_alloc_product;
 	}
 
-	ecc_point_mult(product, pk, priv, rand_z, curve, ndigits);
+	ecc_point_mult(product, pk, private_key, rand_z, curve, ndigits);
 
 	if (ecc_point_is_zero(product)) {
 		ret = -EFAULT;
@@ -1692,7 +1684,6 @@ int crypto_ecdh_shared_secret(unsigned int curve_id, unsigned int ndigits,
 	ecc_swap_digits(product->x, secret, ndigits);
 
 err_validity:
-	memzero_explicit(priv, sizeof(priv));
 	memzero_explicit(rand_z, sizeof(rand_z));
 	ecc_free_point(product);
 err_alloc_product:
diff --git a/crypto/ecdh.c b/crypto/ecdh.c
index c02c9a2b9682..72cfd1590156 100644
--- a/crypto/ecdh.c
+++ b/crypto/ecdh.c
@@ -27,7 +27,6 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 			   unsigned int len)
 {
 	struct ecdh_ctx *ctx = ecdh_get_ctx(tfm);
-	u64 priv[ECC_MAX_DIGITS];
 	struct ecdh params;
 	int ret = 0;
 
@@ -41,15 +40,14 @@ static int ecdh_set_secret(struct crypto_kpp *tfm, const void *buf,
 		return ecc_gen_privkey(ctx->curve_id, ctx->ndigits,
 				       ctx->private_key);
 
-	memcpy(ctx->private_key, params.key, params.key_size);
-	ecc_swap_digits(ctx->private_key, priv, ctx->ndigits);
+	ecc_digits_from_bytes(params.key, params.key_size,
+			      ctx->private_key, ctx->ndigits);
 
 	if (ecc_is_key_valid(ctx->curve_id, ctx->ndigits,
-			     priv, params.key_size) < 0) {
+			     ctx->private_key, params.key_size) < 0) {
 		memzero_explicit(ctx->private_key, params.key_size);
 		ret = -EINVAL;
 	}
-	memzero_explicit(priv, sizeof(priv));
 
 	return ret;
 }
diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
index 4e2f5f938e91..7ca1f463d1ec 100644
--- a/include/crypto/internal/ecc.h
+++ b/include/crypto/internal/ecc.h
@@ -103,7 +103,8 @@ int ecc_is_key_valid(unsigned int curve_id, unsigned int ndigits,
  * Returns 0 if the private key was generated successfully, a negative value
  * if an error occurred.
  */
-int ecc_gen_privkey(unsigned int curve_id, unsigned int ndigits, u64 *privkey);
+int ecc_gen_privkey(unsigned int curve_id, unsigned int ndigits,
+		    u64 *private_key);
 
 /**
  * ecc_make_pub_key() - Compute an ECC public key
-- 
2.43.0


