Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50C9114243D
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Jan 2020 08:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726148AbgATHaU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 20 Jan 2020 02:30:20 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:42992 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726089AbgATHaU (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 20 Jan 2020 02:30:20 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C9CDE9BFEA9824FD5ADD;
        Mon, 20 Jan 2020 15:30:17 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.439.0; Mon, 20 Jan 2020 15:30:11 +0800
From:   Shukun Tan <tanshukun1@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH 0/4] crypto: hisilicon: Unify hardware error handle process
Date:   Mon, 20 Jan 2020 15:30:05 +0800
Message-ID: <1579505409-3776-1-git-send-email-tanshukun1@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

ZIP/HPRE/SEC hardware error handle process has great similarities, unify
the essential error handle process looks necessary. We mainly unify error
init/uninit and error detect process in this patch set.

We also add the configure of ZIP RAS error and fix qm log error bug.

Shukun Tan (4):
  crypto: hisilicon: Unify hardware error init/uninit into QM
  crypto: hisilicon: Configure zip RAS error type
  crypto: hisilicon: Unify error detect process into qm
  crypto: hisilicon: Fix duplicate print when qm occur multiple errors

 drivers/crypto/hisilicon/hpre/hpre_main.c | 108 +++++----------
 drivers/crypto/hisilicon/qm.c             | 216 +++++++++++++++++++++---------
 drivers/crypto/hisilicon/qm.h             |  25 +++-
 drivers/crypto/hisilicon/sec2/sec_main.c  | 162 ++++++++--------------
 drivers/crypto/hisilicon/zip/zip_main.c   | 183 +++++++++++--------------
 5 files changed, 346 insertions(+), 348 deletions(-)

-- 
2.7.4

