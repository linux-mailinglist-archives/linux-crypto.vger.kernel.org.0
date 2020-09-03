Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22FDE25C31B
	for <lists+linux-crypto@lfdr.de>; Thu,  3 Sep 2020 16:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbgICOoC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 3 Sep 2020 10:44:02 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:38754 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729007AbgICOgU (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 3 Sep 2020 10:36:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07488;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=31;SR=0;TI=SMTPD_---0U7pNn5X_1599138766;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0U7pNn5X_1599138766)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 03 Sep 2020 21:12:46 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        David Howells <dhowells@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Stephan Mueller <smueller@chronox.de>,
        Marcelo Henrique Cerri <marcelo.cerri@canonical.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Colin Ian King <colin.king@canonical.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        "Gilad Ben-Yossef" <gilad@benyossef.com>,
        Pascal van Leeuwen <pvanleeuwen@rambus.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-security-module@vger.kernel.org
Cc:     Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Subject: [PATCH v6 6/8] X.509: support OSCCA certificate parse
Date:   Thu,  3 Sep 2020 21:12:40 +0800
Message-Id: <20200903131242.128665-7-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.19.1.3.ge56e4f7
In-Reply-To: <20200903131242.128665-1-tianjia.zhang@linux.alibaba.com>
References: <20200903131242.128665-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The digital certificate format based on SM2 crypto algorithm as
specified in GM/T 0015-2012. It was published by State Encryption
Management Bureau, China.

This patch adds the OID object identifier defined by OSCCA. The
x509 certificate supports sm2-with-sm3 type certificate parsing.
It uses the standard elliptic curve public key, and the sm2
algorithm signs the hash generated by sm3.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Tested-by: Xufeng Zhang <yunbo.xufeng@linux.alibaba.com>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 14 +++++++++++++-
 include/linux/oid_registry.h              |  6 ++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index 26ec20ef4899..6a8aee22bfd4 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -234,6 +234,10 @@ int x509_note_pkey_algo(void *context, size_t hdrlen,
 	case OID_gost2012Signature512:
 		ctx->cert->sig->hash_algo = "streebog512";
 		goto ecrdsa;
+
+	case OID_sm2_with_sm3:
+		ctx->cert->sig->hash_algo = "sm3";
+		goto sm2;
 	}
 
 rsa_pkcs1:
@@ -246,6 +250,11 @@ int x509_note_pkey_algo(void *context, size_t hdrlen,
 	ctx->cert->sig->encoding = "raw";
 	ctx->algo_oid = ctx->last_oid;
 	return 0;
+sm2:
+	ctx->cert->sig->pkey_algo = "sm2";
+	ctx->cert->sig->encoding = "raw";
+	ctx->algo_oid = ctx->last_oid;
+	return 0;
 }
 
 /*
@@ -266,7 +275,8 @@ int x509_note_signature(void *context, size_t hdrlen,
 	}
 
 	if (strcmp(ctx->cert->sig->pkey_algo, "rsa") == 0 ||
-	    strcmp(ctx->cert->sig->pkey_algo, "ecrdsa") == 0) {
+	    strcmp(ctx->cert->sig->pkey_algo, "ecrdsa") == 0 ||
+	    strcmp(ctx->cert->sig->pkey_algo, "sm2") == 0) {
 		/* Discard the BIT STRING metadata */
 		if (vlen < 1 || *(const u8 *)value != 0)
 			return -EBADMSG;
@@ -456,6 +466,8 @@ int x509_extract_key_data(void *context, size_t hdrlen,
 	else if (ctx->last_oid == OID_gost2012PKey256 ||
 		 ctx->last_oid == OID_gost2012PKey512)
 		ctx->cert->pub->pkey_algo = "ecrdsa";
+	else if (ctx->last_oid == OID_id_ecPublicKey)
+		ctx->cert->pub->pkey_algo = "sm2";
 	else
 		return -ENOPKG;
 
diff --git a/include/linux/oid_registry.h b/include/linux/oid_registry.h
index 657d6bf2c064..48fe3133ff39 100644
--- a/include/linux/oid_registry.h
+++ b/include/linux/oid_registry.h
@@ -107,6 +107,12 @@ enum OID {
 	OID_gostTC26Sign512B,		/* 1.2.643.7.1.2.1.2.2 */
 	OID_gostTC26Sign512C,		/* 1.2.643.7.1.2.1.2.3 */
 
+	/* OSCCA */
+	OID_sm2,			/* 1.2.156.10197.1.301 */
+	OID_sm3,			/* 1.2.156.10197.1.401 */
+	OID_sm2_with_sm3,		/* 1.2.156.10197.1.501 */
+	OID_sm3WithRSAEncryption,	/* 1.2.156.10197.1.504 */
+
 	OID__NR
 };
 
-- 
2.19.1.3.ge56e4f7

