Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 603743116E1
	for <lists+linux-crypto@lfdr.de>; Sat,  6 Feb 2021 00:22:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhBEXTZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 5 Feb 2021 18:19:25 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:12853 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbhBEKOX (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 5 Feb 2021 05:14:23 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4DXB6V5Rdmz7h2g;
        Fri,  5 Feb 2021 18:12:02 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.498.0; Fri, 5 Feb 2021
 18:13:11 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <herbert@gondor.apana.org.au>, <wangzhou1@hisilicon.com>,
        <xuzaibo@huawei.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] crypto: hisilicon/sec - fixes shash test error
Date:   Fri, 5 Feb 2021 18:10:57 +0800
Message-ID: <1612519857-30714-4-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1612519857-30714-1-git-send-email-liulongfang@huawei.com>
References: <1612519857-30714-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

If this configuration item is not turned on,
the allocation of crypto_tfm will fail when
the shash algorithm calculates the hash
through the software.

Signed-off-by: Longfang Liu <liulongfang@huawei.com>
---
 arch/arm64/configs/defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 8383016..7cfc9b6 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -117,7 +117,7 @@ CONFIG_KVM=y
 CONFIG_ARM64_CRYPTO=y
 CONFIG_CRYPTO_SHA1_ARM64_CE=y
 CONFIG_CRYPTO_SHA2_ARM64_CE=y
-CONFIG_CRYPTO_SHA512_ARM64_CE=m
+CONFIG_CRYPTO_SHA512_ARM64_CE=y
 CONFIG_CRYPTO_SHA3_ARM64=m
 CONFIG_CRYPTO_SM3_ARM64_CE=m
 CONFIG_CRYPTO_GHASH_ARM64_CE=y
-- 
2.8.1

