Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 175A222D557
	for <lists+linux-crypto@lfdr.de>; Sat, 25 Jul 2020 08:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726782AbgGYGJc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 25 Jul 2020 02:09:32 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:33158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726572AbgGYGJc (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 25 Jul 2020 02:09:32 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 87CEE19433806C00652C;
        Sat, 25 Jul 2020 14:09:28 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 25 Jul 2020 14:09:20 +0800
From:   Yang Shen <shenyang39@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH 0/4] crypto: hisilicon/zip - misc bugfix
Date:   Sat, 25 Jul 2020 14:06:46 +0800
Message-ID: <1595657210-3964-1-git-send-email-shenyang39@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patchset fix some bug:
patch 1:clear the debug registers when remove driver
patch 2:intercept invalid input when using decompress
patch 3:replace the return value '-EBUSY' with '-EAGAIN' when
    device is busy
patch 4:initialize the 'curr_qm_qp_num' when probe device

This patchset depends on:
https://patchwork.kernel.org/cover/11684785/

Hao Fang (1):
  crypto: hisilicon/zip - fix the uncleared debug registers

Sihang Chen (1):
  crypto: hisilicon/zip - fix the uninitalized 'curr_qm_qp_num'

Yang Shen (1):
  crypto: hisilicon/zip - fix the return value when device is busy

Zhou Wang (1):
  crypto: hisilicon/zip - fix zero length input in GZIP decompress

 drivers/crypto/hisilicon/zip/zip_crypto.c | 25 +++++++++++++++++++------
 drivers/crypto/hisilicon/zip/zip_main.c   | 19 +++++++++++++++++++
 2 files changed, 38 insertions(+), 6 deletions(-)

--
2.7.4

