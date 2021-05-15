Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBA53817BD
	for <lists+linux-crypto@lfdr.de>; Sat, 15 May 2021 12:48:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhEOKtU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 15 May 2021 06:49:20 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3693 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232003AbhEOKtR (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 15 May 2021 06:49:17 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fj28p1zVmz16QD8;
        Sat, 15 May 2021 18:44:58 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Sat, 15 May 2021 18:47:34 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>,
        <liulongfang@huawei.com>
Subject: [PATCH 0/4] crypto: hisilicon/qm - modify reset process
Date:   Sat, 15 May 2021 18:44:36 +0800
Message-ID: <1621075480-52869-1-git-send-email-qianweili@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This series of patches modify the process of error initialization and
recovery and enable the master ooo to be closed when nfe occurs to avoid
error spread.

Weili Qian (4):
  crypto: hisilicon/qm - initialize the device before doing tasks
  crypto: hisilicon/qm - modify 'QM_RESETTING' clearing error
  crypto: hisilicon/qm - adjust order of device error configuration
  crypto: hisilicon/qm - enable to close master ooo when NFE occurs

 drivers/crypto/hisilicon/hpre/hpre_main.c |  42 ++++++---
 drivers/crypto/hisilicon/qm.c             | 136 +++++++++++++++++++-----------
 drivers/crypto/hisilicon/sec2/sec_main.c  |  48 ++++++-----
 drivers/crypto/hisilicon/zip/zip_main.c   |  38 ++++++---
 4 files changed, 169 insertions(+), 95 deletions(-)

-- 
2.8.1

