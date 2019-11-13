Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4A88FAF6C
	for <lists+linux-crypto@lfdr.de>; Wed, 13 Nov 2019 12:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbfKMLOk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 13 Nov 2019 06:14:40 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6218 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727476AbfKMLOk (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 13 Nov 2019 06:14:40 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0CE781C769F221A5B2FD;
        Wed, 13 Nov 2019 19:14:39 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.439.0; Wed, 13 Nov 2019 19:14:28 +0800
From:   Zaibo Xu <xuzaibo@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <jonathan.cameron@huawei.com>,
        <wangzhou1@hisilicon.com>, <linuxarm@huawei.com>,
        <fanghao11@huawei.com>, <yekai13@huawei.com>,
        <zhangwei375@huawei.com>, <forest.zhouchang@huawei.com>
Subject: [PATCH v3 5/5] MAINTAINERS: Add maintainer for HiSilicon SEC V2 driver
Date:   Wed, 13 Nov 2019 19:11:08 +0800
Message-ID: <1573643468-1812-6-git-send-email-xuzaibo@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1573643468-1812-1-git-send-email-xuzaibo@huawei.com>
References: <1573643468-1812-1-git-send-email-xuzaibo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Here adds maintainer information for security engine driver.

Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 536998f..bbf8985 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7372,6 +7372,16 @@ F:	include/uapi/linux/if_hippi.h
 F:	net/802/hippi.c
 F:	drivers/net/hippi/
 
+HISILICON SECURITY ENGINE V2 DRIVER (SEC2)
+M:	Zaibo Xu <xuzaibo@huawei.com>
+L:	linux-crypto@vger.kernel.org
+S:	Maintained
+F:	drivers/crypto/hisilicon/sec2/sec_crypto.c
+F:	drivers/crypto/hisilicon/sec2/sec_main.c
+F:	drivers/crypto/hisilicon/sec2/sec_crypto.h
+F:	drivers/crypto/hisilicon/sec2/sec.h
+F:	Documentation/ABI/testing/debugfs-hisi-sec
+
 HISILICON HIGH PERFORMANCE RSA ENGINE DRIVER (HPRE)
 M:	Zaibo Xu <xuzaibo@huawei.com>
 L:	linux-crypto@vger.kernel.org
-- 
2.8.1

