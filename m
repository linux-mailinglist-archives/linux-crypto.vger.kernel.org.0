Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13D6C270A54
	for <lists+linux-crypto@lfdr.de>; Sat, 19 Sep 2020 05:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgISDP0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 18 Sep 2020 23:15:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13323 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726054AbgISDP0 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 18 Sep 2020 23:15:26 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3A9DD8003434FBABB5A8;
        Sat, 19 Sep 2020 11:15:24 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.487.0; Sat, 19 Sep 2020 11:15:17 +0800
From:   yumeng 00484669 <yumeng18@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <yumeng18@huawei.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 0/3] crypto: hisilicon/hpre - misc clean up and fixes
Date:   Sat, 19 Sep 2020 11:13:49 +0800
Message-ID: <1600485232-39831-1-git-send-email-yumeng18@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Adjust some tiny coding problems and fix a bug of DH algorithm.

Changes since v1:
Remove 'u64' cast in 'cpu_to_le64';

Meng Yu (3):
  crypto: hisilicon/hpre - remove useless code
  crypto: hisilicon/hpre - adjust some coding style
  crypto: hisilicon/hpre - fix a bug in dh algorithm

 drivers/crypto/hisilicon/hpre/hpre.h        |  1 -
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 23 +++++++++++------------
 2 files changed, 11 insertions(+), 13 deletions(-)

-- 
2.8.1

