Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB963EB1D3
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Aug 2021 09:44:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239673AbhHMHmu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 13 Aug 2021 03:42:50 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:17014 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239628AbhHMHmg (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 13 Aug 2021 03:42:36 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GmFlz4FfDzb1RZ;
        Fri, 13 Aug 2021 15:38:23 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 13 Aug 2021 15:42:04 +0800
Received: from huawei.com (10.69.192.56) by dggpeml500012.china.huawei.com
 (7.185.36.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 13 Aug
 2021 15:42:03 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH v4 0/2] crypto: hisilicon - some misc bugfix for SEC engine
Date:   Fri, 13 Aug 2021 15:41:00 +0800
Message-ID: <1628840462-25437-1-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

some misc bugfix for SEC engine.

changes v1->v2:
	delete the "ifdefs", use the IS_ENABLED.
changes v2->v3:
	fix merge conflict
changes v3->v4:
	fix build error.

Kai Ye (2):
  crypto: hisilicon/sec - fix the abnormal exiting process
  crypto: hisilicon/sec - modify the hardware endian configuration

 drivers/crypto/hisilicon/sec2/sec.h      |  5 -----
 drivers/crypto/hisilicon/sec2/sec_main.c | 34 +++++++++++---------------------
 2 files changed, 11 insertions(+), 28 deletions(-)

-- 
2.7.4

