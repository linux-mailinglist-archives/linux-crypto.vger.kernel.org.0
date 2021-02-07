Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4AB231235B
	for <lists+linux-crypto@lfdr.de>; Sun,  7 Feb 2021 11:09:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbhBGKHr (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 7 Feb 2021 05:07:47 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12475 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhBGKHo (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 7 Feb 2021 05:07:44 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DYPtC5N9kzjKgd;
        Sun,  7 Feb 2021 18:05:39 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.498.0; Sun, 7 Feb 2021
 18:06:55 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <herbert@gondor.apana.org.au>, <wangzhou1@hisilicon.com>,
        <xuzaibo@huawei.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] crypto:hisilicon/sec - fixes some coding style
Date:   Sun, 7 Feb 2021 18:04:37 +0800
Message-ID: <1612692280-11386-1-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

1. Fix two problems.
2. Fix some coding style.

Changes v1 -> v2:
  - Modify the way to fix shash test error.

Longfang Liu (3):
  crypto: hisilicon/sec - fixes some log printing style
  crypto: hisilicon/sec - fixes some driver coding style
  crypto: hisilicon/sec - fixes shash test error

 drivers/crypto/hisilicon/sec2/sec.h        |   5 +-
 drivers/crypto/hisilicon/sec2/sec_crypto.c |  83 +++++++++---------
 drivers/crypto/hisilicon/sec2/sec_crypto.h |   2 -
 drivers/crypto/hisilicon/sec2/sec_main.c   | 131 +++++++++++++++++------------
 4 files changed, 119 insertions(+), 102 deletions(-)

-- 
2.8.1

