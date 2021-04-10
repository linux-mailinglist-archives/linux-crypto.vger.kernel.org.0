Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 975E535AC8A
	for <lists+linux-crypto@lfdr.de>; Sat, 10 Apr 2021 11:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234507AbhDJJuz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 10 Apr 2021 05:50:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:16564 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbhDJJux (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 10 Apr 2021 05:50:53 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FHVYg1sLdz17RFS;
        Sat, 10 Apr 2021 17:48:23 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Sat, 10 Apr 2021 17:50:27 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/3] crypto: hisilicon/hpre - add debug log
Date:   Sat, 10 Apr 2021 17:46:58 +0800
Message-ID: <1618048021-50335-1-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patchset adds the debug log and cleanup code style.

Hui Tang (3):
  crypto: hisilicon/hpre - delete the rudundant space after return
  crypto: hisilicon/hpre - use the correct variable type
  crypto: hisilicon/hpre - add debug log

 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 11 +++++++++--
 drivers/crypto/hisilicon/hpre/hpre_main.c   |  4 ++--
 2 files changed, 11 insertions(+), 4 deletions(-)

--
2.8.1

