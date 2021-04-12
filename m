Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5B4735C654
	for <lists+linux-crypto@lfdr.de>; Mon, 12 Apr 2021 14:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbhDLMen (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 12 Apr 2021 08:34:43 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16902 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239097AbhDLMem (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 12 Apr 2021 08:34:42 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FJp665gQHzlXPd;
        Mon, 12 Apr 2021 20:32:30 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Mon, 12 Apr 2021 20:34:14 +0800
From:   Weili Qian <qianweili@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <xuzaibo@huawei.com>, <wangzhou1@hisilicon.com>,
        <liulongfang@huawei.com>, Weili Qian <qianweili@huawei.com>
Subject: [PATCH 0/4] crypto: hisilicon - adapt hardware error type
Date:   Mon, 12 Apr 2021 20:31:31 +0800
Message-ID: <1618230695-22775-1-git-send-email-qianweili@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patchset changes 'err_info' to dynamic configuration and enables
new hardware error types for Kunpeng930.

Weili Qian (4):
  crypto: hisilicon - dynamic configuration 'err_info'
  crypto: hisilicon - support new error types for ZIP
  crypto: hisilicon - add new error type for SEC
  crypto: hisilicon - enable new error types for QM

 drivers/crypto/hisilicon/hpre/hpre_main.c | 26 ++++++++++------
 drivers/crypto/hisilicon/qm.c             | 28 ++++++++---------
 drivers/crypto/hisilicon/qm.h             |  8 +++--
 drivers/crypto/hisilicon/sec2/sec_main.c  | 52 +++++++++++++++++++++++--------
 drivers/crypto/hisilicon/zip/zip_main.c   | 34 +++++++++++++-------
 5 files changed, 97 insertions(+), 51 deletions(-)

-- 
2.8.1

