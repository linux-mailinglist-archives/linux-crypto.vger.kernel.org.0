Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6802D5917
	for <lists+linux-crypto@lfdr.de>; Thu, 10 Dec 2020 12:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389423AbgLJLPl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 10 Dec 2020 06:15:41 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9577 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389124AbgLJLMh (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 10 Dec 2020 06:12:37 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4CsB7430qgzM2tm;
        Thu, 10 Dec 2020 19:11:12 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Thu, 10 Dec 2020
 19:11:52 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/6] crypto: hisilicon - enable new algorithms of SEC 
Date:   Thu, 10 Dec 2020 19:10:01 +0800
Message-ID: <1607598607-8728-1-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add support for new algorithms of SEC accelerator on Kunpeng930,
the driver and test case needs to be updated

Longfang Liu (5):
  crypto: hisilicon/sec - add new type of sqe for Kunpeng930
  crypto: hisilicon/sec - add new skcipher mode for SEC
  crypto: hisilicon/sec - add new AEAD mode for SEC
  crypto: hisilicon/sec - fixes some coding style
  crypto: hisilicon/sec - add new algorithm test case

Meng Yu (1):
  crypto: hisilicon/hpre - add version adapt to new algorithms

 arch/arm64/configs/defconfig                |   2 +-
 crypto/testmgr.c                            |  26 +
 crypto/testmgr.h                            |  72 +++
 drivers/crypto/hisilicon/hpre/hpre.h        |   5 +-
 drivers/crypto/hisilicon/hpre/hpre_crypto.c |   4 +-
 drivers/crypto/hisilicon/qm.c               |   4 +-
 drivers/crypto/hisilicon/qm.h               |   4 +-
 drivers/crypto/hisilicon/sec2/sec.h         |  19 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.c  | 861 ++++++++++++++++++++++------
 drivers/crypto/hisilicon/sec2/sec_crypto.h  | 180 +++++-
 drivers/crypto/hisilicon/zip/zip.h          |   4 +-
 drivers/crypto/hisilicon/zip/zip_crypto.c   |   4 +-
 12 files changed, 988 insertions(+), 197 deletions(-)

-- 
2.8.1

