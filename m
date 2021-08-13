Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A27ED3EB38C
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Aug 2021 11:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239913AbhHMJyV (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 13 Aug 2021 05:54:21 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:14202 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239318AbhHMJyV (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 13 Aug 2021 05:54:21 -0400
Received: from dggeme768-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4GmJlz3bkwz1CW0m;
        Fri, 13 Aug 2021 17:53:35 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 dggeme768-chm.china.huawei.com (10.3.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 13 Aug 2021 17:53:52 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>
Subject: [PATCH v2 0/5] crypto: hisilicon - support runtime PM for accelerator devices
Date:   Fri, 13 Aug 2021 17:50:04 +0800
Message-ID: <1628848209-26398-1-git-send-email-qianweili@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme768-chm.china.huawei.com (10.3.19.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Kunpeng930 accelerator devices support runtime power management, this
patchset enables runtime PM for accelerator devices.

---
v1->v2: fix warning
---

Weili Qian (5):
  crypto: hisilicon - using 'debugfs_create_file' instead of
    'debugfs_create_regset32'
  crypto: hisilicon - add runtime PM ops
  crypto: hisilicon - support runtime PM for accelerator device
  crypto: hisilicon - change parameter passing of debugfs function
  crypto: hisilicon - check _PS0 and _PR0 method

 drivers/crypto/hisilicon/hpre/hpre_main.c |  60 ++++-
 drivers/crypto/hisilicon/qm.c             | 430 +++++++++++++++++++++++++-----
 drivers/crypto/hisilicon/qm.h             |   8 +
 drivers/crypto/hisilicon/sec2/sec_main.c  |  58 +++-
 drivers/crypto/hisilicon/zip/zip_main.c   |  57 +++-
 5 files changed, 521 insertions(+), 92 deletions(-)

-- 
2.8.1

