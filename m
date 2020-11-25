Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9192C3A16
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Nov 2020 08:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727342AbgKYH1S (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 25 Nov 2020 02:27:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725308AbgKYH1S (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 25 Nov 2020 02:27:18 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1506BC0613D4;
        Tue, 24 Nov 2020 23:27:18 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id l17so1652448pgk.1;
        Tue, 24 Nov 2020 23:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rEVQORojpxPILZoW25n2HNyuoMNfuJyQRA19mYILOf8=;
        b=o5yR1QncWtHI7laziJnIVWi41OACz/GkEpSxGJOmf5GD+LJomt+70NTmT95cO/Xyba
         OybniIp3Pj/jxXZXmkxxd7S0Bu+zyo6YYBvMAeMn3B4XM9i9fhvnGLhRFlfGWK+jpiFU
         zt4YC4jUBqzFwvspqVwBTTgK6my6adGAvENBOCv/ehpWc3K3XcIcuKDg7Zdxeg4kcTSH
         T5eekai1hme6HRsNQwDnvv4cXLmeviSo+NyUQGKdHz+LiBWwBuH10GE4FcWhoF3LFsCY
         NWiHS70IdxUkdMWbVBJceId1hiXOr0LKFrqAdi1rlMNsqhQzwDlkdy8MyAW7shLQJqgc
         81/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rEVQORojpxPILZoW25n2HNyuoMNfuJyQRA19mYILOf8=;
        b=UQ5GutJuHmb0TH6klo3HlfKuOOcvCMyLDxLigJhI5eMTR1Z+ViFS5NvUdsdou+bUFO
         eBDmonc+4HeAOJcPjGFQE8CoQiZdywjkJoHkRqhn3xcmkbjceNtdzoE3r0KId5jWQhQR
         rovFeG28cVuMq5ablg4MXnShHUJYOMl2pTidSeh7xQ2WFExfLqZ5v7X/bN7zlEKzK7FG
         IqJiKXOsYN85ht00mdqgTE1r6wQwWrzzJp92DnIoF4YDPODBROmOu0a/Cuhh76nX4QdV
         3y5hB7dqUsDuxo28fPVvE7TI8wSv/SvNSM7yQ6Yudp7f7X818TWY6IhzL6tpTbkJ8cB8
         JQGQ==
X-Gm-Message-State: AOAM531H4qJoac/rFcGFh4ISihV3aWKHtAACa3e83TkwB5EER2TAkPqL
        qDNtTBfkxlXHu+/DPbGmJ0A=
X-Google-Smtp-Source: ABdhPJw6C3b7fcys7nNw/xkapoD+30YZQvOvYZUOXMpRHBAetMf1GJScjGsyE1i8tc6u8NF0vwiFVw==
X-Received: by 2002:a65:518a:: with SMTP id h10mr2077147pgq.340.1606289237684;
        Tue, 24 Nov 2020 23:27:17 -0800 (PST)
Received: from linux-l9pv.suse ([124.11.22.254])
        by smtp.gmail.com with ESMTPSA id q7sm1006055pfh.91.2020.11.24.23.27.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Nov 2020 23:27:17 -0800 (PST)
From:   "Lee, Chun-Yi" <joeyli.kernel@gmail.com>
X-Google-Original-From: "Lee, Chun-Yi" <jlee@suse.com>
To:     David Howells <dhowells@redhat.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Ben Boeckel <me@benboeckel.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Malte Gell <malte.gell@gmx.de>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Lee, Chun-Yi" <jlee@suse.com>
Subject: [PATCH v2 2/4] PKCS#7: Check codeSigning EKU for kernel module and kexec pe verification
Date:   Wed, 25 Nov 2020 15:26:51 +0800
Message-Id: <20201125072653.15657-3-jlee@suse.com>
X-Mailer: git-send-email 2.12.3
In-Reply-To: <20201125072653.15657-1-jlee@suse.com>
References: <20201125072653.15657-1-jlee@suse.com>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch adds the logic for checking the CodeSigning extended
key usage when verifying signature of kernel module or
kexec PE binary in PKCS#7.

Signed-off-by: "Lee, Chun-Yi" <jlee@suse.com>
---
 certs/system_keyring.c               |  2 +-
 crypto/asymmetric_keys/Kconfig       |  9 +++++++++
 crypto/asymmetric_keys/pkcs7_trust.c | 37 +++++++++++++++++++++++++++++++++---
 include/crypto/pkcs7.h               |  3 ++-
 4 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/certs/system_keyring.c b/certs/system_keyring.c
index 798291177186..4104f5465d8a 100644
--- a/certs/system_keyring.c
+++ b/certs/system_keyring.c
@@ -242,7 +242,7 @@ int verify_pkcs7_message_sig(const void *data, size_t len,
 			goto error;
 		}
 	}
-	ret = pkcs7_validate_trust(pkcs7, trusted_keys);
+	ret = pkcs7_validate_trust(pkcs7, trusted_keys, usage);
 	if (ret < 0) {
 		if (ret == -ENOKEY)
 			pr_devel("PKCS#7 signature not signed with a trusted key\n");
diff --git a/crypto/asymmetric_keys/Kconfig b/crypto/asymmetric_keys/Kconfig
index 1f1f004dc757..1754812df989 100644
--- a/crypto/asymmetric_keys/Kconfig
+++ b/crypto/asymmetric_keys/Kconfig
@@ -96,4 +96,13 @@ config SIGNED_PE_FILE_VERIFICATION
 	  This option provides support for verifying the signature(s) on a
 	  signed PE binary.
 
+config CHECK_CODESIGN_EKU
+	bool "Check codeSigning extended key usage"
+	depends on PKCS7_MESSAGE_PARSER=y
+	depends on SYSTEM_DATA_VERIFICATION
+	help
+	  This option provides support for checking the codeSigning extended
+	  key usage when verifying the signature in PKCS#7. It affects kernel
+	  module verification and kexec PE binary verification.
+
 endif # ASYMMETRIC_KEY_TYPE
diff --git a/crypto/asymmetric_keys/pkcs7_trust.c b/crypto/asymmetric_keys/pkcs7_trust.c
index 61af3c4d82cc..1d2318ff63db 100644
--- a/crypto/asymmetric_keys/pkcs7_trust.c
+++ b/crypto/asymmetric_keys/pkcs7_trust.c
@@ -16,12 +16,36 @@
 #include <crypto/public_key.h>
 #include "pkcs7_parser.h"
 
+#ifdef CONFIG_CHECK_CODESIGN_EKU
+static bool check_codesign_eku(struct key *key,
+			     enum key_being_used_for usage)
+{
+	struct public_key *public_key = key->payload.data[asym_crypto];
+
+	switch (usage) {
+	case VERIFYING_MODULE_SIGNATURE:
+	case VERIFYING_KEXEC_PE_SIGNATURE:
+		return !!(public_key->eku & EKU_codeSigning);
+	default:
+		break;
+	}
+	return true;
+}
+#else
+static bool check_codesign_eku(struct key *key,
+			     enum key_being_used_for usage)
+{
+	return true;
+}
+#endif
+
 /**
  * Check the trust on one PKCS#7 SignedInfo block.
  */
 static int pkcs7_validate_trust_one(struct pkcs7_message *pkcs7,
 				    struct pkcs7_signed_info *sinfo,
-				    struct key *trust_keyring)
+				    struct key *trust_keyring,
+				    enum key_being_used_for usage)
 {
 	struct public_key_signature *sig = sinfo->sig;
 	struct x509_certificate *x509, *last = NULL, *p;
@@ -112,6 +136,12 @@ static int pkcs7_validate_trust_one(struct pkcs7_message *pkcs7,
 	return -ENOKEY;
 
 matched:
+	if (!check_codesign_eku(key, usage)) {
+		pr_warn("sinfo %u: The signer %x key is not CodeSigning\n",
+			sinfo->index, key_serial(key));
+		key_put(key);
+		return -ENOKEY;
+	}
 	ret = verify_signature(key, sig);
 	key_put(key);
 	if (ret < 0) {
@@ -156,7 +186,8 @@ static int pkcs7_validate_trust_one(struct pkcs7_message *pkcs7,
  * May also return -ENOMEM.
  */
 int pkcs7_validate_trust(struct pkcs7_message *pkcs7,
-			 struct key *trust_keyring)
+			 struct key *trust_keyring,
+			 enum key_being_used_for usage)
 {
 	struct pkcs7_signed_info *sinfo;
 	struct x509_certificate *p;
@@ -167,7 +198,7 @@ int pkcs7_validate_trust(struct pkcs7_message *pkcs7,
 		p->seen = false;
 
 	for (sinfo = pkcs7->signed_infos; sinfo; sinfo = sinfo->next) {
-		ret = pkcs7_validate_trust_one(pkcs7, sinfo, trust_keyring);
+		ret = pkcs7_validate_trust_one(pkcs7, sinfo, trust_keyring, usage);
 		switch (ret) {
 		case -ENOKEY:
 			continue;
diff --git a/include/crypto/pkcs7.h b/include/crypto/pkcs7.h
index 38ec7f5f9041..b3b48240ba73 100644
--- a/include/crypto/pkcs7.h
+++ b/include/crypto/pkcs7.h
@@ -30,7 +30,8 @@ extern int pkcs7_get_content_data(const struct pkcs7_message *pkcs7,
  * pkcs7_trust.c
  */
 extern int pkcs7_validate_trust(struct pkcs7_message *pkcs7,
-				struct key *trust_keyring);
+				struct key *trust_keyring,
+				enum key_being_used_for usage);
 
 /*
  * pkcs7_verify.c
-- 
2.16.4

