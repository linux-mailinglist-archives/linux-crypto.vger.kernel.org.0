Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D751A137B29
	for <lists+linux-crypto@lfdr.de>; Sat, 11 Jan 2020 03:45:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728204AbgAKCpy (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 10 Jan 2020 21:45:54 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:45370 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728199AbgAKCpw (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 10 Jan 2020 21:45:52 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4B0BFD1295358EBBB4F0;
        Sat, 11 Jan 2020 10:45:49 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Sat, 11 Jan 2020 10:45:40 +0800
From:   Zaibo Xu <xuzaibo@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>,
        <tanghui20@huawei.com>, <yekai13@huawei.com>,
        <liulongfang@huawei.com>, <qianweili@huawei.com>,
        <zhangwei375@huawei.com>, <fanghao11@huawei.com>,
        <forest.zhouchang@huawei.com>
Subject: [PATCH v2 0/9] crypto: hisilicon-SEC V2 AEAD added with some bugfixed
Date:   Sat, 11 Jan 2020 10:41:47 +0800
Message-ID: <1578710516-40535-1-git-send-email-xuzaibo@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add AEAD algorithms supporting, and some bugfixed with
some updating on internal funcions to support more algorithms.

This series is based on:
git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git

Change log:
  V2: Rebased on Arnd Bergmann's fixing patch on DebugFS usage.

Zaibo Xu (9):
  crypto: hisilicon - Update debugfs usage of SEC V2
  crypto: hisilicon - fix print/comment of SEC V2
  crypto: hisilicon - Update some names on SEC V2
  crypto: hisilicon - Update QP resources of SEC V2
  crypto: hisilicon - Adjust some inner logic
  crypto: hisilicon - Add callback error check
  crypto: hisilicon - Add branch prediction macro
  crypto: hisilicon - redefine skcipher initiation
  crypto: hisilicon - Add aead support on SEC2

 drivers/crypto/hisilicon/Kconfig           |   8 +-
 drivers/crypto/hisilicon/sec2/sec.h        |  49 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.c | 963 +++++++++++++++++++++++------
 drivers/crypto/hisilicon/sec2/sec_crypto.h |  22 +-
 drivers/crypto/hisilicon/sec2/sec_main.c   |  23 +-
 5 files changed, 833 insertions(+), 232 deletions(-)

-- 
2.8.1

