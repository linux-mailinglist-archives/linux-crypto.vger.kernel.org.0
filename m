Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DF51178BEA
	for <lists+linux-crypto@lfdr.de>; Wed,  4 Mar 2020 08:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728472AbgCDHuB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 4 Mar 2020 02:50:01 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11142 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728458AbgCDHuB (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 4 Mar 2020 02:50:01 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 4EEC6421EEFCC8CCC427;
        Wed,  4 Mar 2020 15:49:57 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Wed, 4 Mar 2020 15:49:51 +0800
From:   Shukun Tan <tanshukun1@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <jonathan.cameron@huawei.com>
Subject: [PATCH 0/4] crypto: hisilicon - Refactor find device related code
Date:   Wed, 4 Mar 2020 15:49:21 +0800
Message-ID: <1583308165-16800-1-git-send-email-tanshukun1@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

By binding device finding with create QP logic to fix the bug of creating
QP failure occasionally. Then, merge the find device related code into
qm.c to reduce redundancy.

Hui Tang (1):
  crypto: hisilicon/hpre - Optimize finding hpre device process

Kai Ye (1):
  crypto: hisilicon/sec2 - Add new create qp process

Shukun Tan (1):
  crypto: hisilicon/zip - Use hisi_qm_alloc_qps_node() when init ctx

Weili Qian (1):
  crypto: hisilicon/qm - Put device finding logic into QM

 drivers/crypto/hisilicon/hpre/hpre.h        |   3 +-
 drivers/crypto/hisilicon/hpre/hpre_crypto.c |  20 ++---
 drivers/crypto/hisilicon/hpre/hpre_main.c   |  52 +++---------
 drivers/crypto/hisilicon/qm.c               | 125 ++++++++++++++++++++++++++++
 drivers/crypto/hisilicon/qm.h               |  31 +++++++
 drivers/crypto/hisilicon/sec2/sec.h         |   5 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.c  |  17 ++--
 drivers/crypto/hisilicon/sec2/sec_main.c    |  81 +++++++-----------
 drivers/crypto/hisilicon/zip/zip.h          |   2 +-
 drivers/crypto/hisilicon/zip/zip_crypto.c   |  54 ++++++------
 drivers/crypto/hisilicon/zip/zip_main.c     |  92 ++------------------
 11 files changed, 252 insertions(+), 230 deletions(-)

-- 
2.7.4

