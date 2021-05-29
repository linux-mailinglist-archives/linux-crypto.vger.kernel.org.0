Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF901394C6C
	for <lists+linux-crypto@lfdr.de>; Sat, 29 May 2021 16:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbhE2OUU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 29 May 2021 10:20:20 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2103 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbhE2OUU (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 29 May 2021 10:20:20 -0400
Received: from dggeme768-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Fsk7b660rzWlXW;
        Sat, 29 May 2021 22:14:03 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 dggeme768-chm.china.huawei.com (10.3.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Sat, 29 May 2021 22:18:41 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <liulongfang@huawei.com>,
        Weili Qian <qianweili@huawei.com>
Subject: [PATCH 0/4] crypto: hisilicon/qm - support the communication between PF and VF
Date:   Sat, 29 May 2021 22:15:33 +0800
Message-ID: <1622297737-46604-1-git-send-email-qianweili@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme768-chm.china.huawei.com (10.3.19.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch adds support for PF and VF communications in accelerator driver,
and updates the reset flow based on VF/PF communications.

Weili Qian (4):
  crypto: hisilicon/qm - adjust reset interface
  crypto: hisilicon/qm - enable PF and VFs communication
  crypto: hisilicon/qm - add callback to support communication
  crypto: hisilicon/qm - update reset flow

 drivers/crypto/hisilicon/qm.c | 713 +++++++++++++++++++++++++++++++++++++-----
 drivers/crypto/hisilicon/qm.h |   1 +
 2 files changed, 629 insertions(+), 85 deletions(-)

-- 
2.8.1

