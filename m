Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18DC38D2FF
	for <lists+linux-crypto@lfdr.de>; Sat, 22 May 2021 04:24:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhEVCZ4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 21 May 2021 22:25:56 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5723 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhEVCZy (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 21 May 2021 22:25:54 -0400
Received: from dggems701-chm.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fn6dy5K3FzpfHZ;
        Sat, 22 May 2021 10:20:54 +0800 (CST)
Received: from dggemi760-chm.china.huawei.com (10.1.198.146) by
 dggems701-chm.china.huawei.com (10.3.19.178) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Sat, 22 May 2021 10:24:27 +0800
Received: from localhost.localdomain (10.67.165.24) by
 dggemi760-chm.china.huawei.com (10.1.198.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 22 May 2021 10:24:26 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] crypto: ecdh: fix ecdh-nist-p192's entry in testmgr
Date:   Sat, 22 May 2021 10:21:21 +0800
Message-ID: <1621650084-25505-2-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1621650084-25505-1-git-send-email-tanghui20@huawei.com>
References: <1621650084-25505-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggemi760-chm.china.huawei.com (10.1.198.146)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add a comment that p192 will fail to register in FIPS mode.

Fix ecdh-nist-p192's entry in testmgr by removing the ifdefs
and not setting fips_allowed.

Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 crypto/ecdh.c    | 1 +
 crypto/testmgr.c | 3 ---
 crypto/testmgr.h | 2 --
 3 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/crypto/ecdh.c b/crypto/ecdh.c
index 04a427b..4227d35 100644
--- a/crypto/ecdh.c
+++ b/crypto/ecdh.c
@@ -179,6 +179,7 @@ static int ecdh_init(void)
 {
 	int ret;
 
+	/* NIST p192 will fail to register in FIPS mode */
 	ret = crypto_register_kpp(&ecdh_nist_p192);
 	ecdh_nist_p192_registered = ret == 0;
 
diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 10c5b3b..26e40db 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -4899,15 +4899,12 @@ static const struct alg_test_desc alg_test_descs[] = {
 		}
 	}, {
 #endif
-#ifndef CONFIG_CRYPTO_FIPS
 		.alg = "ecdh-nist-p192",
 		.test = alg_test_kpp,
-		.fips_allowed = 1,
 		.suite = {
 			.kpp = __VECS(ecdh_p192_tv_template)
 		}
 	}, {
-#endif
 		.alg = "ecdh-nist-p256",
 		.test = alg_test_kpp,
 		.fips_allowed = 1,
diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index 34e4a3d..fe1e59d 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -2685,7 +2685,6 @@ static const struct kpp_testvec curve25519_tv_template[] = {
 }
 };
 
-#ifndef CONFIG_CRYPTO_FIPS
 static const struct kpp_testvec ecdh_p192_tv_template[] = {
 	{
 	.secret =
@@ -2725,7 +2724,6 @@ static const struct kpp_testvec ecdh_p192_tv_template[] = {
 	.expected_ss_size = 24
 	}
 };
-#endif
 
 static const struct kpp_testvec ecdh_p256_tv_template[] = {
 	{
-- 
2.8.1

