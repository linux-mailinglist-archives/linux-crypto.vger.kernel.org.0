Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9F1D20E37B
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Jun 2020 00:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390107AbgF2VOh (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 29 Jun 2020 17:14:37 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:59618 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729918AbgF2S5H (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:07 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 477AA4F36D5F161AAF4E;
        Mon, 29 Jun 2020 19:10:58 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Mon, 29 Jun 2020 19:10:44 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>
Subject: [PATCH 0/9] crypto: hisilicon/qm - misc fixes
Date:   Mon, 29 Jun 2020 19:08:59 +0800
Message-ID: <1593428948-64634-1-git-send-email-shenyang39@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patchset fix some qm bugs:
patch 1: store the string address before pass to 'strsep'
patch 2: clear 'qp_status->used' when init the qp
patch 3: use 'dev_info_ratelimited' to avoid printk flooding.
patch 4: fix the judgement of queue is full
patch 7: save the vf configuration space to make sure it is available
 after the PF FLR
patch 8: move the process of register alg to crypto in driver 'hisi_zip'
patch 9: register callback to 'pci_driver.shutdown'

This patchset depends on:
https://patchwork.kernel.org/cover/1162709/

Hui Tang (1):
  crypto: hisilicon/qm - fix judgement of queue is full

Shukun Tan (3):
  crypto: hisilicon/qm - clear used reference count when start qp
  crypto: hisilicon/qm - fix event queue depth to 2048
  crypto: hisilicon/qm - fix VF not available after PF FLR

Sihang Chen (1):
  crypto: hisilicon/qm - fix wrong release after using strsep

Yang Shen (4):
  crypto: hisilicon/qm - fix print frequence in hisi_qp_send
  crypto: hisilicon/qm - fix no stop reason when use hisi_qm_stop
  crypto: hisilicon/qm - fix the process of register algorithms to
    crypto
  crypto: hisilicon/qm - register callback function to
    'pci_driver.shutdown'

 drivers/crypto/hisilicon/hpre/hpre_crypto.c |  36 +++-----
 drivers/crypto/hisilicon/hpre/hpre_main.c   |  27 +++---
 drivers/crypto/hisilicon/qm.c               | 126 +++++++++++++++++++++++-----
 drivers/crypto/hisilicon/qm.h               |  23 ++---
 drivers/crypto/hisilicon/sec2/sec_crypto.c  |  35 +++-----
 drivers/crypto/hisilicon/sec2/sec_main.c    |  30 +++----
 drivers/crypto/hisilicon/zip/zip_crypto.c   |   2 +-
 drivers/crypto/hisilicon/zip/zip_main.c     |  44 +++++-----
 8 files changed, 190 insertions(+), 133 deletions(-)

--
2.7.4

