Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24401137C7A
	for <lists+linux-crypto@lfdr.de>; Sat, 11 Jan 2020 10:02:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbgAKJCN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 11 Jan 2020 04:02:13 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8698 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728275AbgAKJCN (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 11 Jan 2020 04:02:13 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id EBAB2BDEA4569FCB8CAC;
        Sat, 11 Jan 2020 17:02:11 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Sat, 11 Jan 2020 17:02:03 +0800
From:   Zaibo Xu <xuzaibo@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linuxarm@huawei.com>,
        <jonathan.cameron@huawei.com>, <wangzhou1@hisilicon.com>,
        <tanghui20@huawei.com>, <yekai13@huawei.com>,
        <liulongfang@huawei.com>, <qianweili@huawei.com>,
        <fanghao11@huawei.com>, <forest.zhouchang@huawei.com>
Subject: [PATCH 0/4] crypto: hisilicon - Misc fixed on HPRE
Date:   Sat, 11 Jan 2020 16:58:14 +0800
Message-ID: <1578733098-13863-1-git-send-email-xuzaibo@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

1.Bugfixed tfm leak with some other tiny bugfixed.
2.Fixed some tiny bugs and update some code style.
3.Adjust input parameter order of hpre_crt_para_get.
4.Add branch prediction macro on hot path with small performance gain(~1%).

This series is based on:
git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git

Zaibo Xu (4):
  crypto: hisilicon - Bugfixed tfm leak
  crypto: hisilicon - Fixed some tiny bugs of HPRE
  crypto: hisilicon - adjust hpre_crt_para_get
  crypto: hisilicon - add branch prediction macro

 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 141 ++++++++++++++--------------
 drivers/crypto/hisilicon/hpre/hpre_main.c   |  32 ++++---
 2 files changed, 86 insertions(+), 87 deletions(-)

-- 
2.8.1

