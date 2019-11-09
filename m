Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F74FF5CE5
	for <lists+linux-crypto@lfdr.de>; Sat,  9 Nov 2019 03:05:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbfKICFq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 Nov 2019 21:05:46 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:55342 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726112AbfKICFq (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 8 Nov 2019 21:05:46 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 12950D3826BCC61C5ADF;
        Sat,  9 Nov 2019 10:05:44 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Sat, 9 Nov 2019 10:05:34 +0800
From:   Zaibo Xu <xuzaibo@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <jonathan.cameron@huawei.com>,
        <wangzhou1@hisilicon.com>, <linuxarm@huawei.com>,
        <fanghao11@huawei.com>, <yekai13@huawei.com>,
        <zhangwei375@huawei.com>, <forest.zhouchang@huawei.com>
Subject: [PATCH v2 5/5] MAINTAINERS: Add maintainer for HiSilicon SEC V2 driver
Date:   Sat, 9 Nov 2019 10:01:57 +0800
Message-ID: <1573264917-14588-6-git-send-email-xuzaibo@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1573264917-14588-1-git-send-email-xuzaibo@huawei.com>
References: <1573264917-14588-1-git-send-email-xuzaibo@huawei.com>
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

