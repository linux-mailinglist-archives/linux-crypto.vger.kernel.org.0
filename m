Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A4821B061
	for <lists+linux-crypto@lfdr.de>; Fri, 10 Jul 2020 09:42:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgGJHmL (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 10 Jul 2020 03:42:11 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54796 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726496AbgGJHln (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 10 Jul 2020 03:41:43 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8F794F6A111D71882E73;
        Fri, 10 Jul 2020 15:41:32 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Fri, 10 Jul 2020 15:41:22 +0800
From:   Meng Yu <yumeng18@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/6] crypto: hisilicon/hpre bugfix - misc fixes
Date:   Fri, 10 Jul 2020 15:40:40 +0800
Message-ID: <1594366846-1313-1-git-send-email-yumeng18@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Bugfix: crypto: hisilicon/hpre - modify the macros, add a switch in
    sriov_configure, unified debugfs interface, and disable
    hardware FLR.

Hui Tang (2):
  crypto: hisilicon/hpre - HPRE_OVERTIME_THRHLD can be written by
    debugfs
  crypto: hisilicon/hpre - disable FLR triggered by hardware

Meng Yu (4):
  crypto: hisilicon/hpre - Init the value of current_q of debugfs
  crypto: hisilicon/hpre - Modify the Macro definition and format
  crypto: hisilicon/hpre - Add a switch in sriov_configure
  crypto: hisilicon/hpre - update debugfs interface parameters

 drivers/crypto/hisilicon/hpre/hpre_main.c | 111 +++++++++++++++++-------------
 1 file changed, 62 insertions(+), 49 deletions(-)

-- 
2.8.1

