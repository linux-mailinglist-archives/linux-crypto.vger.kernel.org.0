Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E09C33EAE85
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Aug 2021 04:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237946AbhHMCXC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 12 Aug 2021 22:23:02 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:13269 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237914AbhHMCXB (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 12 Aug 2021 22:23:01 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Gm6lF21LJz1CWHp;
        Fri, 13 Aug 2021 10:22:17 +0800 (CST)
Received: from dggpeml500012.china.huawei.com (7.185.36.15) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 13 Aug 2021 10:22:29 +0800
Received: from huawei.com (10.69.192.56) by dggpeml500012.china.huawei.com
 (7.185.36.15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 13 Aug
 2021 10:22:29 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH v3 0/2] crypto: hisilicon - some misc bugfix for SEC engine
Date:   Fri, 13 Aug 2021 10:21:25 +0800
Message-ID: <1628821287-49924-1-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

Kai Ye (2):
  crypto: hisilicon/sec - fix the abnormal exiting process
  crypto: hisilicon/sec - modify the hardware endian configuration

 drivers/crypto/hisilicon/sec2/sec.h      |  5 -----
 drivers/crypto/hisilicon/sec2/sec_main.c | 34 +++++++++++---------------------
 2 files changed, 11 insertions(+), 28 deletions(-)

-- 
2.7.4

