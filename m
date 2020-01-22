Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B58F6144E7F
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Jan 2020 10:17:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728931AbgAVJRl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 22 Jan 2020 04:17:41 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:60720 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726049AbgAVJRl (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 22 Jan 2020 04:17:41 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id AEB42BAE94895711F33B;
        Wed, 22 Jan 2020 17:17:39 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.439.0; Wed, 22 Jan 2020 17:17:32 +0800
From:   Hongbo Yao <yaohongbo@huawei.com>
To:     <jens.wiklander@linaro.org>, <Rijo-john.Thomas@amd.com>
CC:     <yaohongbo@huawei.com>, <chenzhou10@huawei.com>,
        <tee-dev@lists.linaro.org>, <linux-kernel@vger.kernel.org>,
        <Devaraj.Rangasamy@amd.com>, <herbert@gondor.apana.org.au>,
        <linux-crypto@vger.kernel.org>
Subject: [PATCH RESEND -next] tee: amdtee: amdtee depends on CRYPTO_DEV_CCP_DD
Date:   Wed, 22 Jan 2020 17:12:38 +0800
Message-ID: <20200122091238.65484-1-yaohongbo@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

If CRYPTO_DEV_CCP_DD=m and AMDTEE=y, the following error is seen
while building call.c or core.c

drivers/tee/amdtee/call.o: In function `handle_unload_ta':
call.c:(.text+0x35f): undefined reference to `psp_tee_process_cmd'
drivers/tee/amdtee/core.o: In function `amdtee_driver_init':
core.c:(.init.text+0xf): undefined reference to `psp_check_tee_status

Fix the config dependency for AMDTEE here.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 757cc3e9ff ("tee: add AMD-TEE driver")
Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
Reviewed-by: Rijo Thomas <Rijo-john.Thomas@amd.com>
---
 drivers/tee/amdtee/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tee/amdtee/Kconfig b/drivers/tee/amdtee/Kconfig
index 4e32b6413b41..191f9715fa9a 100644
--- a/drivers/tee/amdtee/Kconfig
+++ b/drivers/tee/amdtee/Kconfig
@@ -3,6 +3,6 @@
 config AMDTEE
 	tristate "AMD-TEE"
 	default m
-	depends on CRYPTO_DEV_SP_PSP
+	depends on CRYPTO_DEV_SP_PSP && CRYPTO_DEV_CCP_DD
 	help
 	  This implements AMD's Trusted Execution Environment (TEE) driver.
-- 
2.20.1

