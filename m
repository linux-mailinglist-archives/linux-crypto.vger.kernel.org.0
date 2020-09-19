Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D304270D66
	for <lists+linux-crypto@lfdr.de>; Sat, 19 Sep 2020 13:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726455AbgISLDP (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 19 Sep 2020 07:03:15 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13771 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726159AbgISLDP (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 19 Sep 2020 07:03:15 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7CBAAC2D6ACBF852BCB1;
        Sat, 19 Sep 2020 19:02:54 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 19:02:47 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>
Subject: [PATCH 0/2] crypto: hisilicon/qm - misc fixes
Date:   Sat, 19 Sep 2020 19:01:34 +0800
Message-ID: <1600513296-29287-1-git-send-email-qianweili@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patchset fix some driver bugs

Resend this patch series because it depends on
https://patchwork.kernel.org/cover/11760159/
(crypto: hisilicon/zip - misc clean up).
Now the patch series has been applied.

Weili Qian (1):
  crypto: hisilicon/qm - remove the update of flags

Yang Shen (1):
  crypto: hisilicon/qm - fix wrong return type of 'pci_get_drvdata'

 drivers/crypto/hisilicon/hpre/hpre_main.c | 3 +--
 drivers/crypto/hisilicon/qm.c             | 1 -
 drivers/crypto/hisilicon/sec2/sec_main.c  | 3 +--
 drivers/crypto/hisilicon/zip/zip_main.c   | 3 +--
 4 files changed, 3 insertions(+), 7 deletions(-)

-- 
2.8.1

