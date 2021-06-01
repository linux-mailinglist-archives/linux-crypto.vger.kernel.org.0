Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9591F39758E
	for <lists+linux-crypto@lfdr.de>; Tue,  1 Jun 2021 16:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbhFAOjG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 1 Jun 2021 10:39:06 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2832 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234038AbhFAOjF (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 1 Jun 2021 10:39:05 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4FvZPf2j5MzWlbj;
        Tue,  1 Jun 2021 22:32:38 +0800 (CST)
Received: from dggema755-chm.china.huawei.com (10.1.198.197) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 1 Jun 2021 22:37:20 +0800
Received: from huawei.com (10.90.53.225) by dggema755-chm.china.huawei.com
 (10.1.198.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Tue, 1 Jun
 2021 22:37:19 +0800
From:   Zhang Qilong <zhangqilong3@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <pali@kernel.org>, <pavel@ucw.cz>, <linux-crypto@vger.kernel.org>
Subject: [PATCH -next 0/2] Fix error handling in omap sham ops
Date:   Tue, 1 Jun 2021 22:51:16 +0800
Message-ID: <20210601145118.126169-1-zhangqilong3@huawei.com>
X-Mailer: git-send-email 2.26.0.106.g9fadedd
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.90.53.225]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema755-chm.china.huawei.com (10.1.198.197)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

First patch clear pm_runtime_get_sync calls. The other
fix PM disable depth imbalance.

Zhang Qilong (2):
  crypto: omap-des - using pm_runtime_resume_and_get instead of
    pm_runtime_get_sync
  crypto: omap-sham - Fix PM reference leak in omap sham ops

 drivers/crypto/omap-des.c  | 9 +++------
 drivers/crypto/omap-sham.c | 4 ++--
 2 files changed, 5 insertions(+), 8 deletions(-)

-- 
2.17.1

