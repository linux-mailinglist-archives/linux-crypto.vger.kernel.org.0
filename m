Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5892E342C31
	for <lists+linux-crypto@lfdr.de>; Sat, 20 Mar 2021 12:31:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhCTLaz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 20 Mar 2021 07:30:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14107 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhCTLaY (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 20 Mar 2021 07:30:24 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F2dmm3lytz17NQ2;
        Sat, 20 Mar 2021 19:28:24 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Sat, 20 Mar 2021 19:30:11 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 0/4] crypto: hisilicon/qm - support doorbell isolation and queue number configuration
Date:   Sat, 20 Mar 2021 19:27:42 +0800
Message-ID: <1616239666-43572-1-git-send-email-qianweili@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Kunpeng930 supports getting the number of queues from hardware registers
and queue doorbell isolation.

This patchset configures the total number of hardware queues and the
maximum number of function queues, and supports queue doorbell isolation.

Weili Qian (4):
  crypto: hisilicon/qm - set the total number of queues
  crypto: hisilicon/qm - move 'CURRENT_QM' code to qm.c
  crypto: hisilicon/qm - set the number of queues for function
  crypto: hisilicon/qm - add queue isolation support for Kunpeng 930

 drivers/crypto/hisilicon/hpre/hpre.h      |   1 -
 drivers/crypto/hisilicon/hpre/hpre_main.c |  64 ------
 drivers/crypto/hisilicon/qm.c             | 332 +++++++++++++++++++++++-------
 drivers/crypto/hisilicon/qm.h             |  17 +-
 drivers/crypto/hisilicon/sec2/sec.h       |   1 -
 drivers/crypto/hisilicon/sec2/sec_main.c  |  65 +-----
 drivers/crypto/hisilicon/zip/zip_main.c   |  65 +-----
 include/uapi/misc/uacce/hisi_qm.h         |   1 +
 8 files changed, 272 insertions(+), 274 deletions(-)

-- 
2.8.1

