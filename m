Return-Path: <linux-crypto+bounces-2102-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E8F0857161
	for <lists+linux-crypto@lfdr.de>; Fri, 16 Feb 2024 00:17:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DB3DB24C8C
	for <lists+linux-crypto@lfdr.de>; Thu, 15 Feb 2024 23:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75D114A09C;
	Thu, 15 Feb 2024 23:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mZaJsbaS"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1CE1487EC;
	Thu, 15 Feb 2024 23:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708038882; cv=none; b=dg253uG5McEZPGPJlXaO+iUDCognse3ck2PED45ueuVSAVSxM9qPvpjw010vyFRp1XOpLabwJc5G3oSUMYEG9b+fS5WzEWPFVYUZDalERxD22kjCPh9cY3f8vVBJFnunY4TcnNM6pYEsccnXuYxUGhvBtRQ6+9TvD+liIHqt9oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708038882; c=relaxed/simple;
	bh=mhU0bmPHBeF08SYolZF/y+HVVTOZOcSu5BU7EGiPuBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sm00lbOGSpPp6azJU9hevJx5eViFBZTqh9L+zpOYPk7jLAMlSzOnB4GPzaB2Gf+xbGrA2hjAUSsd9EJwWJM2g/oEsEJdy6bWto1jRe3ScXdJDj8JnNvJC6Qr/gzAJGrHn9t9SC3CpjZV+FMrmTBU9pRXvbIcef2c1NobaVog7CA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mZaJsbaS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FMW496027152;
	Thu, 15 Feb 2024 23:14:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=TgFtvWyefJsqJg/5/Y/sVXi8wg7VifvdDt4fnDvR9gU=;
 b=mZaJsbaS9hvzuKtfWE9zWQBVAtc9VmD4X2oQplx4OXRRfa3pQyKabytpypYdaadfAMAp
 OhV0o5Fex8m+VXkCMMwaydG6nF8ti8iit00aMNA3OW91HB26lk1yRXNh8xQC0gYcUL0z
 YZq1FZK1UEu9CNJS92lJjq5QBFlVzOQ2KvfUgRM9/JSTnRR6Y6WBKhO56YErQOnYxdM3
 u/fLA1dJ6zb4cYAxAmYGDPtYL47XSHOBrKJfKSuIyewB5mxI4+ttquIe6HYRiDjbiZC0
 3dwVWpvdf1h2d6F9MtO6Kb/67kbBvZfPccw+5GMWrwIpZFO2pxrkenwBzRrRTYWHS+vZ fg== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9ug4h7j1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 23:14:35 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41FLuPM5004258;
	Thu, 15 Feb 2024 23:14:34 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6kv0r3ps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 23:14:34 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FNEW2h22086358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 23:14:34 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0469F58054;
	Thu, 15 Feb 2024 23:14:32 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5423558050;
	Thu, 15 Feb 2024 23:14:31 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Feb 2024 23:14:31 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        herbert@gondor.apana.org.au, davem@davemloft.net
Cc: linux-kernel@vger.kernel.org, saulo.alessandre@tse.jus.br,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 14/14] crypto: ecdh - Add support for NIST P521 and add test case
Date: Thu, 15 Feb 2024 18:14:13 -0500
Message-ID: <20240215231414.3857320-15-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240215231414.3857320-1-stefanb@linux.ibm.com>
References: <20240215231414.3857320-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: m5dwGDNmozOUT__2uOtN-Myn6G0HnLIU
X-Proofpoint-ORIG-GUID: m5dwGDNmozOUT__2uOtN-Myn6G0HnLIU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_22,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 bulkscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150181

Implement ecdh support with NIST P521 and add a test case from RFC5903.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 crypto/ecdh.c                 | 34 +++++++++++++++
 crypto/testmgr.c              |  7 ++++
 crypto/testmgr.h              | 79 +++++++++++++++++++++++++++++++++++
 include/crypto/internal/ecc.h |  1 +
 4 files changed, 121 insertions(+)

diff --git a/crypto/ecdh.c b/crypto/ecdh.c
index e64133428552..be87832e172e 100644
--- a/crypto/ecdh.c
+++ b/crypto/ecdh.c
@@ -207,6 +207,32 @@ static struct kpp_alg ecdh_nist_p384 = {
 	},
 };
 
+static int ecdh_nist_p521_init_tfm(struct crypto_kpp *tfm)
+{
+	struct ecdh_ctx *ctx = ecdh_get_ctx(tfm);
+
+	ctx->curve_id = ECC_CURVE_NIST_P521;
+	ctx->ndigits = ECC_CURVE_NIST_P521_DIGITS;
+	ctx->nbytes = DIV_ROUND_UP(521, 8);
+	ctx->msd_mask = 0x1ff;
+
+	return 0;
+}
+static struct kpp_alg ecdh_nist_p521 = {
+	.set_secret = ecdh_set_secret,
+	.generate_public_key = ecdh_compute_value,
+	.compute_shared_secret = ecdh_compute_value,
+	.max_size = ecdh_max_size,
+	.init = ecdh_nist_p521_init_tfm,
+	.base = {
+		.cra_name = "ecdh-nist-p521",
+		.cra_driver_name = "ecdh-nist-p521-generic",
+		.cra_priority = 100,
+		.cra_module = THIS_MODULE,
+		.cra_ctxsize = sizeof(struct ecdh_ctx),
+	},
+};
+
 static bool ecdh_nist_p192_registered;
 
 static int __init ecdh_init(void)
@@ -225,8 +251,15 @@ static int __init ecdh_init(void)
 	if (ret)
 		goto nist_p384_error;
 
+	ret = crypto_register_kpp(&ecdh_nist_p521);
+	if (ret)
+		goto nist_p521_error;
+
 	return 0;
 
+nist_p521_error:
+	crypto_unregister_kpp(&ecdh_nist_p384);
+
 nist_p384_error:
 	crypto_unregister_kpp(&ecdh_nist_p256);
 
@@ -242,6 +275,7 @@ static void __exit ecdh_exit(void)
 		crypto_unregister_kpp(&ecdh_nist_p192);
 	crypto_unregister_kpp(&ecdh_nist_p256);
 	crypto_unregister_kpp(&ecdh_nist_p384);
+	crypto_unregister_kpp(&ecdh_nist_p521);
 }
 
 subsys_initcall(ecdh_init);
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 00f5a6cf341a..91f39f5a438b 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5077,6 +5077,13 @@ static const struct alg_test_desc alg_test_descs[] = {
 		.suite = {
 			.kpp = __VECS(ecdh_p384_tv_template)
 		}
+	}, {
+		.alg = "ecdh-nist-p521",
+		.test = alg_test_kpp,
+		.fips_allowed = 1,
+		.suite = {
+			.kpp = __VECS(ecdh_p521_tv_template)
+		}
 	}, {
 		.alg = "ecdsa-nist-p192",
 		.test = alg_test_akcipher,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 9bde04be8df9..dc9a2b30b5fd 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -4468,6 +4468,85 @@ static const struct kpp_testvec ecdh_p384_tv_template[] = {
 	}
 };
 
+/*
+ * NIST P521 test vectors from RFC5903
+ */
+static const struct kpp_testvec ecdh_p521_tv_template[] = {
+	{
+	.secret =
+#ifdef __LITTLE_ENDIAN
+	"\x02\x00" /* type */
+	"\x48\x00" /* len */
+	"\x42\x00" /* key_size */
+#else
+	"\x00\x02" /* type */
+	"\x00\x48" /* len */
+	"\x00\x42" /* key_size */
+#endif
+	"\x00\x37\xAD\xE9\x31\x9A\x89\xF4"
+	"\xDA\xBD\xB3\xEF\x41\x1A\xAC\xCC"
+	"\xA5\x12\x3C\x61\xAC\xAB\x57\xB5"
+	"\x39\x3D\xCE\x47\x60\x81\x72\xA0"
+	"\x95\xAA\x85\xA3\x0F\xE1\xC2\x95"
+	"\x2C\x67\x71\xD9\x37\xBA\x97\x77"
+	"\xF5\x95\x7B\x26\x39\xBA\xB0\x72"
+	"\x46\x2F\x68\xC2\x7A\x57\x38\x2D"
+	"\x4A\x52",
+	.b_public =
+	"\x00\xD0\xB3\x97\x5A\xC4\xB7\x99"
+	"\xF5\xBE\xA1\x6D\x5E\x13\xE9\xAF"
+	"\x97\x1D\x5E\x9B\x98\x4C\x9F\x39"
+	"\x72\x8B\x5E\x57\x39\x73\x5A\x21"
+	"\x9B\x97\xC3\x56\x43\x6A\xDC\x6E"
+	"\x95\xBB\x03\x52\xF6\xBE\x64\xA6"
+	"\xC2\x91\x2D\x4E\xF2\xD0\x43\x3C"
+	"\xED\x2B\x61\x71\x64\x00\x12\xD9"
+	"\x46\x0F"
+	"\x01\x5C\x68\x22\x63\x83\x95\x6E"
+	"\x3B\xD0\x66\xE7\x97\xB6\x23\xC2"
+	"\x7C\xE0\xEA\xC2\xF5\x51\xA1\x0C"
+	"\x2C\x72\x4D\x98\x52\x07\x7B\x87"
+	"\x22\x0B\x65\x36\xC5\xC4\x08\xA1"
+	"\xD2\xAE\xBB\x8E\x86\xD6\x78\xAE"
+	"\x49\xCB\x57\x09\x1F\x47\x32\x29"
+	"\x65\x79\xAB\x44\xFC\xD1\x7F\x0F"
+	"\xC5\x6A",
+	.expected_a_public =
+	"\x00\x15\x41\x7E\x84\xDB\xF2\x8C"
+	"\x0A\xD3\xC2\x78\x71\x33\x49\xDC"
+	"\x7D\xF1\x53\xC8\x97\xA1\x89\x1B"
+	"\xD9\x8B\xAB\x43\x57\xC9\xEC\xBE"
+	"\xE1\xE3\xBF\x42\xE0\x0B\x8E\x38"
+	"\x0A\xEA\xE5\x7C\x2D\x10\x75\x64"
+	"\x94\x18\x85\x94\x2A\xF5\xA7\xF4"
+	"\x60\x17\x23\xC4\x19\x5D\x17\x6C"
+	"\xED\x3E"
+	"\x01\x7C\xAE\x20\xB6\x64\x1D\x2E"
+	"\xEB\x69\x57\x86\xD8\xC9\x46\x14"
+	"\x62\x39\xD0\x99\xE1\x8E\x1D\x5A"
+	"\x51\x4C\x73\x9D\x7C\xB4\xA1\x0A"
+	"\xD8\xA7\x88\x01\x5A\xC4\x05\xD7"
+	"\x79\x9D\xC7\x5E\x7B\x7D\x5B\x6C"
+	"\xF2\x26\x1A\x6A\x7F\x15\x07\x43"
+	"\x8B\xF0\x1B\xEB\x6C\xA3\x92\x6F"
+	"\x95\x82",
+	.expected_ss =
+	"\x01\x14\x4C\x7D\x79\xAE\x69\x56"
+	"\xBC\x8E\xDB\x8E\x7C\x78\x7C\x45"
+	"\x21\xCB\x08\x6F\xA6\x44\x07\xF9"
+	"\x78\x94\xE5\xE6\xB2\xD7\x9B\x04"
+	"\xD1\x42\x7E\x73\xCA\x4B\xAA\x24"
+	"\x0A\x34\x78\x68\x59\x81\x0C\x06"
+	"\xB3\xC7\x15\xA3\xA8\xCC\x31\x51"
+	"\xF2\xBE\xE4\x17\x99\x6D\x19\xF3"
+	"\xDD\xEA",
+	.secret_size = 72,
+	.b_public_size = 132,
+	.expected_a_public_size = 132,
+	.expected_ss_size = 66
+	}
+};
+
 /*
  * MD4 test vectors from RFC1320
  */
diff --git a/include/crypto/internal/ecc.h b/include/crypto/internal/ecc.h
index 328a82bd35c8..a04b313f2871 100644
--- a/include/crypto/internal/ecc.h
+++ b/include/crypto/internal/ecc.h
@@ -33,6 +33,7 @@
 #define ECC_CURVE_NIST_P192_DIGITS  3
 #define ECC_CURVE_NIST_P256_DIGITS  4
 #define ECC_CURVE_NIST_P384_DIGITS  6
+#define ECC_CURVE_NIST_P521_DIGITS  9
 #define ECC_MAX_DIGITS              (576 / 64) /* due to NIST P521 */
 
 #define ECC_DIGITS_TO_BYTES_SHIFT 3
-- 
2.43.0


