Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A5D5AC919
	for <lists+linux-crypto@lfdr.de>; Mon,  5 Sep 2022 05:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234357AbiIED3C (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 4 Sep 2022 23:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiIED3A (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 4 Sep 2022 23:29:00 -0400
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F19242CDD5
        for <linux-crypto@vger.kernel.org>; Sun,  4 Sep 2022 20:28:52 -0700 (PDT)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 28538mwx049169;
        Mon, 5 Sep 2022 11:08:48 +0800 (GMT-8)
        (envelope-from neal_liu@aspeedtech.com)
Received: from localhost.localdomain (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 5 Sep
 2022 11:28:42 +0800
From:   Neal Liu <neal_liu@aspeedtech.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>
CC:     <linux-aspeed@lists.ozlabs.org>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <BMC-SW@aspeedtech.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] crypto: aspeed: fix format unexpected build warning
Date:   Mon, 5 Sep 2022 11:28:38 +0800
Message-ID: <20220905032838.1663510-1-neal_liu@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.10.10]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 28538mwx049169
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This fixes the following similar build warning when
enabling compile test:

aspeed-hace-hash.c:188:9: warning: format '%x' expects argument of type
'unsigned int', but argument 7 has type 'size_t' {aka 'long unsigned int'}
[-Wformat=]

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Neal Liu <neal_liu@aspeedtech.com>
---
 drivers/crypto/aspeed/aspeed-hace-hash.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/aspeed/aspeed-hace-hash.c b/drivers/crypto/aspeed/aspeed-hace-hash.c
index 0a44ffc0e13b..d0f61149fe24 100644
--- a/drivers/crypto/aspeed/aspeed-hace-hash.c
+++ b/drivers/crypto/aspeed/aspeed-hace-hash.c
@@ -186,7 +186,7 @@ static int aspeed_ahash_dma_prepare_sg(struct aspeed_hace_dev *hace_dev)
 	length = rctx->total + rctx->bufcnt - remain;
 
 	AHASH_DBG(hace_dev, "%s:0x%x, %s:0x%x, %s:0x%x, %s:0x%x\n",
-		  "rctx total", rctx->total, "bufcnt", rctx->bufcnt,
+		  "rctx total", rctx->total, "bufcnt", (u32)rctx->bufcnt,
 		  "length", length, "remain", remain);
 
 	sg_len = dma_map_sg(hace_dev->dev, rctx->src_sg, rctx->src_nents,
@@ -325,8 +325,8 @@ static int aspeed_hace_ahash_trigger(struct aspeed_hace_dev *hace_dev,
 	struct aspeed_sham_reqctx *rctx = ahash_request_ctx(req);
 
 	AHASH_DBG(hace_dev, "src_dma:0x%x, digest_dma:0x%x, length:0x%x\n",
-		  hash_engine->src_dma, hash_engine->digest_dma,
-		  hash_engine->src_length);
+		  (u32)hash_engine->src_dma, (u32)hash_engine->digest_dma,
+		  (u32)hash_engine->src_length);
 
 	rctx->cmd |= HASH_CMD_INT_ENABLE;
 	hash_engine->resume = resume;
-- 
2.25.1

