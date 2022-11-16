Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C83662B21F
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Nov 2022 05:14:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbiKPEOc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 15 Nov 2022 23:14:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbiKPEOY (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 15 Nov 2022 23:14:24 -0500
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F2F31F84;
        Tue, 15 Nov 2022 20:14:19 -0800 (PST)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AG3MWSf016081;
        Wed, 16 Nov 2022 04:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=8ESuWlIrale+sXyV4fNctyjVH7uHSmRimCDCqLPwhog=;
 b=RBF1t4oGDoPGC+0xeLQ1EWG+ZHfJKiSOxXAophg7F+UmWGEzThZ7WftkUbuFNvyeoNr1
 vB7AWaFoO+SdHX7c3pQ6vmRi87PPNYxwVzMC62JTidoa/IilwzZCgwuNMMlslroN3POR
 jzK+SVaksSzCTfgnJ5oMViD8BwHp8NudD9zVuis4r4g7Gy/vzcaWV3Mc4K7p+XhT7znx
 Jeq0V/djvbuDpSU0AxX9yLKj5oSi0nA3kXJNXcA7K879XrDG0J7Bc2WQ5vaxRJgnMzMO
 LChW/PmGJWwJv5pz9zJOmuEWxwHPrb+/k9UNCwueJNNMH5mzhdw/1AZRp8AcJbzDroXJ Cg== 
Received: from p1lg14878.it.hpe.com (p1lg14878.it.hpe.com [16.230.97.204])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3kvqwa0ajs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Nov 2022 04:14:10 +0000
Received: from p1lg14885.dc01.its.hpecorp.net (unknown [10.119.18.236])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by p1lg14878.it.hpe.com (Postfix) with ESMTPS id 908C32EEF6;
        Wed, 16 Nov 2022 04:14:09 +0000 (UTC)
Received: from adevxp033-sys.us.rdlabs.hpecorp.net (unknown [16.231.227.36])
        by p1lg14885.dc01.its.hpecorp.net (Postfix) with ESMTP id 1E29880FE88;
        Wed, 16 Nov 2022 04:14:09 +0000 (UTC)
From:   Robert Elliott <elliott@hpe.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        tim.c.chen@linux.intel.com, ap420073@gmail.com, ardb@kernel.org,
        Jason@zx2c4.com, David.Laight@ACULAB.COM, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Robert Elliott <elliott@hpe.com>
Subject: [PATCH v4 14/24] crypto: x86/sha - load based on CPU features
Date:   Tue, 15 Nov 2022 22:13:32 -0600
Message-Id: <20221116041342.3841-15-elliott@hpe.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116041342.3841-1-elliott@hpe.com>
References: <20221103042740.6556-1-elliott@hpe.com>
 <20221116041342.3841-1-elliott@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 54hW-XXOxZ2aQxfGxRBb41DPGlIROLF3
X-Proofpoint-ORIG-GUID: 54hW-XXOxZ2aQxfGxRBb41DPGlIROLF3
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-15_08,2022-11-15_03,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 mlxlogscore=999 spamscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2211160029
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Like commit aa031b8f702e ("crypto: x86/sha512 - load based on CPU
features"), add module aliases for x86-optimized crypto modules:
        sha1, sha256
based on CPU feature bits so udev gets a chance to load them later in
the boot process when the filesystems are all running.

Signed-off-by: Robert Elliott <elliott@hpe.com>

---
v3 put device table SHA_NI entries inside CONFIG_SHAn_NI ifdefs,
ensure builds properly with arch/x86/Kconfig.assembler changed
to not set CONFIG_AS_SHA*_NI
---
 arch/x86/crypto/sha1_ssse3_glue.c   | 15 +++++++++++++++
 arch/x86/crypto/sha256_ssse3_glue.c | 15 +++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/x86/crypto/sha1_ssse3_glue.c b/arch/x86/crypto/sha1_ssse3_glue.c
index 32f3310e19e2..806463f57b6d 100644
--- a/arch/x86/crypto/sha1_ssse3_glue.c
+++ b/arch/x86/crypto/sha1_ssse3_glue.c
@@ -24,6 +24,7 @@
 #include <linux/types.h>
 #include <crypto/sha1.h>
 #include <crypto/sha1_base.h>
+#include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
 /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
@@ -328,11 +329,25 @@ static void unregister_sha1_ni(void)
 static inline void unregister_sha1_ni(void) { }
 #endif
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+#ifdef CONFIG_AS_SHA1_NI
+	X86_MATCH_FEATURE(X86_FEATURE_SHA_NI, NULL),
+#endif
+	X86_MATCH_FEATURE(X86_FEATURE_AVX2, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_SSSE3, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static int __init sha1_ssse3_mod_init(void)
 {
 	const char *feature_name;
 	int ret;
 
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 #ifdef CONFIG_AS_SHA1_NI
 	/* SHA-NI */
 	if (boot_cpu_has(X86_FEATURE_SHA_NI)) {
diff --git a/arch/x86/crypto/sha256_ssse3_glue.c b/arch/x86/crypto/sha256_ssse3_glue.c
index 839da1b36273..30c8c50c1123 100644
--- a/arch/x86/crypto/sha256_ssse3_glue.c
+++ b/arch/x86/crypto/sha256_ssse3_glue.c
@@ -38,6 +38,7 @@
 #include <crypto/sha2.h>
 #include <crypto/sha256_base.h>
 #include <linux/string.h>
+#include <asm/cpu_device_id.h>
 #include <asm/simd.h>
 
 /* avoid kernel_fpu_begin/end scheduler/rcu stalls */
@@ -399,11 +400,25 @@ static void unregister_sha256_ni(void)
 static inline void unregister_sha256_ni(void) { }
 #endif
 
+static const struct x86_cpu_id module_cpu_ids[] = {
+#ifdef CONFIG_AS_SHA256_NI
+	X86_MATCH_FEATURE(X86_FEATURE_SHA_NI, NULL),
+#endif
+	X86_MATCH_FEATURE(X86_FEATURE_AVX2, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_AVX, NULL),
+	X86_MATCH_FEATURE(X86_FEATURE_SSSE3, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, module_cpu_ids);
+
 static int __init sha256_ssse3_mod_init(void)
 {
 	const char *feature_name;
 	int ret;
 
+	if (!x86_match_cpu(module_cpu_ids))
+		return -ENODEV;
+
 #ifdef CONFIG_AS_SHA256_NI
 	/* SHA-NI */
 	if (boot_cpu_has(X86_FEATURE_SHA_NI)) {
-- 
2.38.1

