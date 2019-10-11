Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 214FBD3E3E
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Oct 2019 13:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfJKLVZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Oct 2019 07:21:25 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3736 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727198AbfJKLVZ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Oct 2019 07:21:25 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5229058A0503F8BAB2B9;
        Fri, 11 Oct 2019 19:21:20 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 11 Oct 2019 19:21:11 +0800
From:   Zhou Wang <wangzhou1@hisilicon.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, Zhou Wang <wangzhou1@hisilicon.com>
Subject: [PATCH 1/2] crypto: hisilicon - select NEED_SG_DMA_LENGTH in qm Kconfig
Date:   Fri, 11 Oct 2019 19:18:10 +0800
Message-ID: <1570792690-74597-1-git-send-email-wangzhou1@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

To avoid compile error in some platforms, select NEED_SG_DMA_LENGTH in
qm Kconfig.

Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
Reported-by: kbuild test robot <lkp@intel.com>
---
 drivers/crypto/hisilicon/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/hisilicon/Kconfig b/drivers/crypto/hisilicon/Kconfig
index 82fb810d..a71f2bf 100644
--- a/drivers/crypto/hisilicon/Kconfig
+++ b/drivers/crypto/hisilicon/Kconfig
@@ -18,6 +18,7 @@ config CRYPTO_DEV_HISI_QM
 	tristate
 	depends on ARM64 || COMPILE_TEST
 	depends on PCI && PCI_MSI
+	select NEED_SG_DMA_LENGTH
 	help
 	  HiSilicon accelerator engines use a common queue management
 	  interface. Specific engine driver may use this module.
-- 
2.8.1

