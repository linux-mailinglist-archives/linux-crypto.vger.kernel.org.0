Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0271037B625
	for <lists+linux-crypto@lfdr.de>; Wed, 12 May 2021 08:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbhELGbk (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 12 May 2021 02:31:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3724 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbhELGbc (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 12 May 2021 02:31:32 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fg4ZS4KvqzmgKw;
        Wed, 12 May 2021 14:26:56 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS403-HUB.china.huawei.com (10.3.19.203) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 14:30:10 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 5/8] crypto: hisilicon/hpre - delete rudundant initialization
Date:   Wed, 12 May 2021 14:27:08 +0800
Message-ID: <1620800831-53346-6-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1620800831-53346-1-git-send-email-tanghui20@huawei.com>
References: <1620800831-53346-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Delete rudundant variable initialization.

Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/hisilicon/hpre/hpre_crypto.c b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
index b9197e9..3a3af82 100644
--- a/drivers/crypto/hisilicon/hpre/hpre_crypto.c
+++ b/drivers/crypto/hisilicon/hpre/hpre_crypto.c
@@ -1480,7 +1480,7 @@ static int hpre_ecdh_dst_data_init(struct hpre_asym_request *hpre_req,
 	struct hpre_sqe *msg = &hpre_req->req;
 	struct hpre_ctx *ctx = hpre_req->ctx;
 	struct device *dev = ctx->dev;
-	dma_addr_t dma = 0;
+	dma_addr_t dma;
 
 	if (unlikely(!data || !sg_is_last(data) || len != ctx->key_sz << 1)) {
 		dev_err(dev, "data or data length is illegal!\n");
@@ -1807,7 +1807,7 @@ static int hpre_curve25519_dst_init(struct hpre_asym_request *hpre_req,
 	struct hpre_sqe *msg = &hpre_req->req;
 	struct hpre_ctx *ctx = hpre_req->ctx;
 	struct device *dev = ctx->dev;
-	dma_addr_t dma = 0;
+	dma_addr_t dma;
 
 	if (!data || !sg_is_last(data) || len != ctx->key_sz) {
 		dev_err(dev, "data or data length is illegal!\n");
-- 
2.8.1

