Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF10AEABA2
	for <lists+linux-crypto@lfdr.de>; Thu, 31 Oct 2019 09:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfJaIiR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 31 Oct 2019 04:38:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:41400 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726774AbfJaIiR (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 31 Oct 2019 04:38:17 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id EBBB53FA92232A055EA8;
        Thu, 31 Oct 2019 16:38:14 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Thu, 31 Oct 2019 16:38:04 +0800
From:   Zaibo Xu <xuzaibo@huawei.com>
To:     <herbert@gondor.apana.org.au>, <mpm@selenic.com>
CC:     <linux-crypto@vger.kernel.org>, <jonathan.cameron@huawei.com>,
        <wangzhou1@hisilicon.com>, <linuxarm@huawei.com>,
        <wangkefeng.wang@huawei.com>, <qianweili@huawei.com>,
        <forest.zhouchang@huawei.com>
Subject: [PATCH 2/2] MAINTAINERS: Add maintainer for HiSilicon TRNG V2 driver
Date:   Thu, 31 Oct 2019 16:34:30 +0800
Message-ID: <1572510870-40390-3-git-send-email-xuzaibo@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1572510870-40390-1-git-send-email-xuzaibo@huawei.com>
References: <1572510870-40390-1-git-send-email-xuzaibo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Here adds maintainer information for HiSilicon TRNG V2 driver.

Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
---
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bbf8985..342345d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7399,6 +7399,11 @@ W:	http://www.hisilicon.com
 S:	Maintained
 F:	drivers/net/ethernet/hisilicon/hns3/
 
+HISILICON TRUE RANDOM NUMBER GENERATOR V2 SUPPORT
+M:	Zaibo Xu <xuzaibo@huawei.com>
+S:	Maintained
+F:	drivers/char/hw_random/hisi-trng-v2.c
+
 HISILICON LPC BUS DRIVER
 M:	john.garry@huawei.com
 W:	http://www.hisilicon.com
-- 
2.8.1

