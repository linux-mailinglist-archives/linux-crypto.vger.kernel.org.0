Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC2C1659E0
	for <lists+linux-crypto@lfdr.de>; Thu, 20 Feb 2020 10:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgBTJJJ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 20 Feb 2020 04:09:09 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:56060 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726940AbgBTJJJ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 20 Feb 2020 04:09:09 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3C194F099F1E60AC4B51;
        Thu, 20 Feb 2020 17:09:06 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Thu, 20 Feb 2020 17:08:56 +0800
From:   Zaibo Xu <xuzaibo@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <wangzhou1@hisilicon.com>,
        <linuxarm@huawei.com>, <fanghao11@huawei.com>,
        <yekai13@huawei.com>, <tanshukun1@huawei.com>,
        <qianweili@huawei.com>, <shenyang39@huawei.com>,
        <zhangwei375@huawei.com>, <tanghui20@huawei.com>,
        <liulongfang@huawei.com>, <forest.zhouchang@huawei.com>
Subject: [PATCH 0/4] crypto: hisilicon - Improve SEC performance
Date:   Thu, 20 Feb 2020 17:04:51 +0800
Message-ID: <1582189495-38051-1-git-send-email-xuzaibo@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: liulongfang <liulongfang@huawei.com>

Improve SEC throughput by allocating a workqueue for each device
instead of one workqueue for all SEC devices. What's more,
when IOMMU translation is turned on, the plat buffer (pbuffer)
will be reserved for small packets (<512Bytes) to
which small packets are copied. This can avoid DMA mapping on
user small packets and improve performance.

This series is based on:
git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git

Shukun Tan (1):
  crypto: hisilicon - Use one workqueue per qm instead of per qp

liulongfang (2):
  crypto: hisilicon/sec2 - Add iommu status check
  crypto: hisilicon/sec2 - Add pbuffer mode for SEC driver

yekai13 (1):
  crypto: hisilicon/sec2 - Add workqueue for SEC driver.

 drivers/crypto/hisilicon/qm.c              |  38 ++---
 drivers/crypto/hisilicon/qm.h              |   4 +-
 drivers/crypto/hisilicon/sec2/sec.h        |   7 +
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 244 ++++++++++++++++++++++++-----
 drivers/crypto/hisilicon/sec2/sec_main.c   |  45 +++++-
 5 files changed, 273 insertions(+), 65 deletions(-)

-- 
2.8.1

