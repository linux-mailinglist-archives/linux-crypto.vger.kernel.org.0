Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEA630EF2F
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Feb 2021 10:06:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234195AbhBDJDI (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 4 Feb 2021 04:03:08 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12023 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233876AbhBDJCp (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 4 Feb 2021 04:02:45 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DWXZc3Xk8zjJnP;
        Thu,  4 Feb 2021 17:00:40 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Thu, 4 Feb 2021 17:01:49 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <tanghui20@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/4] crypto: hisilicon - some updates to adapt Kunpeng930
Date:   Thu, 4 Feb 2021 16:59:32 +0800
Message-ID: <1612429176-28084-1-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

1.Update clusters number for both Kunpeng920 and Kunpeng930.
2.Some bugfixs only on Kunpeng920, so added hardware version wrap.
3.Fix use of 'dma_map_single'.
4.Fix PASID on Kunpeng930.

Hui Tang (2):
  crypto: hisilicon/hpre - adapt the number of clusters
  crypto: hisilicon/hpre - tiny fix

Weili Qian (2):
  crypto:hisilicon/qm - fix use of "dma_map_single"
  crypto:hisilicon - PASID fixed on Kupeng 930

 drivers/crypto/hisilicon/hpre/hpre.h      |   8 ++-
 drivers/crypto/hisilicon/hpre/hpre_main.c | 100 +++++++++++++++++++-----------
 drivers/crypto/hisilicon/qm.c             |  61 +++++++++++-------
 drivers/crypto/hisilicon/qm.h             |   1 +
 drivers/crypto/hisilicon/sec2/sec_main.c  |   2 +-
 drivers/crypto/hisilicon/zip/zip_main.c   |   2 +-
 6 files changed, 110 insertions(+), 64 deletions(-)

--
2.8.1

