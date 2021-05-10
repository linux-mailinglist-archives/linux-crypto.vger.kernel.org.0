Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA83377F06
	for <lists+linux-crypto@lfdr.de>; Mon, 10 May 2021 11:09:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhEJJLC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 10 May 2021 05:11:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2741 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhEJJLA (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 10 May 2021 05:11:00 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FdwCZ4bg5zqV1L;
        Mon, 10 May 2021 17:06:34 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Mon, 10 May 2021 17:09:46 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/8] crypto: hisilicon/hpre - fix coding style
Date:   Mon, 10 May 2021 17:06:43 +0800
Message-ID: <1620637611-41643-1-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patchset fix coding style, as follows:

Hui Tang (8):
  crypto: hisilicon/hpre - the macro 'HPRE_ADDR' expands
  crypto: hisilicon/hpre - init a structure member each line
  crypto: hisilicon/hpre - replace macro with inline function
  crypto: hisilicon/hpre - remove the macro of 'HPRE_DEV'
  crypto: hisilicon/hpre - delete rudundant initialization
  crypto: hisilicon/hpre - use 'GENMASK' to generate mask value
  crypto: hisilicon/hpre - delete rudundant macro definition
  crypto: hisilicon/hpre - add 'default' for switch statement

 drivers/crypto/hisilicon/hpre/hpre_crypto.c |  67 ++++++------
 drivers/crypto/hisilicon/hpre/hpre_main.c   | 151 +++++++++++++++++-----------
 2 files changed, 128 insertions(+), 90 deletions(-)

--
2.8.1

