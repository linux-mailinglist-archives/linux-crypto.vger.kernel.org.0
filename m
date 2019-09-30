Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46243C1DDD
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Sep 2019 11:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730393AbfI3JX4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 30 Sep 2019 05:23:56 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:37958 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726008AbfI3JX4 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 30 Sep 2019 05:23:56 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 66995D6A81E2A7737D46;
        Mon, 30 Sep 2019 17:23:53 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Mon, 30 Sep 2019 17:23:45 +0800
From:   Zaibo Xu <xuzaibo@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <linuxarm@huawei.com>, <forest.zhouchang@huawei.com>,
        Zaibo Xu <xuzaibo@huawei.com>
Subject: [PATCH 0/5] crypto: hisilicon - add HPRE support
Date:   Mon, 30 Sep 2019 17:20:04 +0800
Message-ID: <1569835209-44326-1-git-send-email-xuzaibo@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This series adds HiSilicon high performance RSA engine(HPRE) driver
in crypto subsystem. HPRE driver provides PCIe hardware device initiation
with RSA and DH algorithms registered to Crypto. Meanwhile, some debug
supporting of DebugFS is given.

Zaibo Xu (5):
  crypto: hisilicon - add HiSilicon HPRE accelerator
  crypto: hisilicon - add SRIOV support for HPRE
  Documentation: Add debugfs doc for hisi_hpre
  crypto: hisilicon: Add debugfs for HPRE
  MAINTAINERS: Add maintainer for HiSilicon HPRE driver

 Documentation/ABI/testing/debugfs-hisi-hpre |   57 ++
 MAINTAINERS                                 |    9 +
 drivers/crypto/hisilicon/Kconfig            |   11 +
 drivers/crypto/hisilicon/Makefile           |    1 +
 drivers/crypto/hisilicon/hpre/Makefile      |    2 +
 drivers/crypto/hisilicon/hpre/hpre.h        |   83 ++
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 1137 +++++++++++++++++++++++++++
 drivers/crypto/hisilicon/hpre/hpre_main.c   | 1052 +++++++++++++++++++++++++
 8 files changed, 2352 insertions(+)
 create mode 100644 Documentation/ABI/testing/debugfs-hisi-hpre
 create mode 100644 drivers/crypto/hisilicon/hpre/Makefile
 create mode 100644 drivers/crypto/hisilicon/hpre/hpre.h
 create mode 100644 drivers/crypto/hisilicon/hpre/hpre_crypto.c
 create mode 100644 drivers/crypto/hisilicon/hpre/hpre_main.c

-- 
2.8.1

