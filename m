Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF05B20AFC0
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2020 12:32:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgFZKcr (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 26 Jun 2020 06:32:47 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6318 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727899AbgFZKcq (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 26 Jun 2020 06:32:46 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id B4928AA2F1376BAD268F
        for <linux-crypto@vger.kernel.org>; Fri, 26 Jun 2020 18:32:43 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Fri, 26 Jun 2020
 18:32:38 +0800
From:   Longfang Liu <liulongfang@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>
Subject: [PATCH 0/5] crypto: hisilicon/sec2 - fix SEC bugs and coding styles
Date:   Fri, 26 Jun 2020 18:32:04 +0800
Message-ID: <1593167529-22463-1-git-send-email-liulongfang@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Fix some SEC driver bugs and modify some coding styles

Kai Ye (2):
  crypto: hisilicon/sec2 - clear SEC debug regs
  crypto:hisilicon/sec2 - update busy processing logic

Longfang Liu (3):
  crypto: hisilicon/sec2 - update SEC initialization and reset
  crypto: hisilicon/sec2 - update debugfs interface parameters
  crypto: hisilicon/sec2 - fix some coding styles

 drivers/crypto/hisilicon/qm.h              |   1 +
 drivers/crypto/hisilicon/sec2/sec.h        |   3 +
 drivers/crypto/hisilicon/sec2/sec_crypto.c |  81 +++++++++++++------
 drivers/crypto/hisilicon/sec2/sec_main.c   | 126 +++++++++++++++--------------
 4 files changed, 128 insertions(+), 83 deletions(-)

-- 
2.8.1

