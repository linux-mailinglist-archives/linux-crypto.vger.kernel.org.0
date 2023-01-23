Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B7C677F9C
	for <lists+linux-crypto@lfdr.de>; Mon, 23 Jan 2023 16:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232084AbjAWPZR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 23 Jan 2023 10:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbjAWPYs (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 23 Jan 2023 10:24:48 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 71EEA2A990;
        Mon, 23 Jan 2023 07:24:26 -0800 (PST)
Received: from vm02.corp.microsoft.com (unknown [167.220.196.155])
        by linux.microsoft.com (Postfix) with ESMTPSA id 45FBE20E2D1C;
        Mon, 23 Jan 2023 07:23:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 45FBE20E2D1C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1674487421;
        bh=f6pZHu6WA/l0Wr6r6xjwOggDdU/mGOH5y0VgIu48aRI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CTpL+hP1jfHwJgIWyL5E02ar+Ivbg7F3vb3yLQyVIcOQ1EDXh1m4ST7PyAUL2S7Eo
         Ke9aI0JmACwIMQToFpulqUUS+D2RpYR/H7yKH4hwSNaPWlXbaDcYA+YFz8omtw+XMd
         3mPd6S6VqHES18GPFY8B/pjM2NqtWQoY77jGuvlw=
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Brijesh Singh" <brijesh.singh@amd.com>,
        "Tom Lendacky" <thomas.lendacky@amd.com>,
        "Kalra, Ashish" <ashish.kalra@amd.com>,
        linux-crypto@vger.kernel.org,
        Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Subject: [PATCH v1 7/8] crypto: ccp - Skip DMA coherency check for platform psp
Date:   Mon, 23 Jan 2023 15:22:49 +0000
Message-Id: <20230123152250.26413-8-jpiotrowski@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
References: <20230123152250.26413-1-jpiotrowski@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The value of device_get_dma_attr() is only relevenat for ARM64 and CCP
devices to configure the value of the axcache attribute used to access
memory by the coprocessor. None of this applies to the platform psp so
skip it.

Signed-off-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
---
 drivers/crypto/ccp/sp-platform.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ccp/sp-platform.c b/drivers/crypto/ccp/sp-platform.c
index 281dbf6b150c..b74f16e0e963 100644
--- a/drivers/crypto/ccp/sp-platform.c
+++ b/drivers/crypto/ccp/sp-platform.c
@@ -29,6 +29,7 @@
 struct sp_platform {
 	int coherent;
 	unsigned int irq_count;
+	bool is_platform;
 };
 
 #ifdef CONFIG_CRYPTO_DEV_SP_PSP
@@ -190,8 +191,10 @@ static int sp_platform_probe(struct platform_device *pdev)
 	sp->dev_specific = sp_platform;
 	sp->dev_vdata = pdev->dev.of_node ? sp_get_of_version(pdev)
 					 : sp_get_acpi_version(pdev);
-	if (!sp->dev_vdata && pdev->id_entry)
+	if (!sp->dev_vdata && pdev->id_entry) {
+		sp_platform->is_platform = true;
 		sp->dev_vdata = sp_get_plat_version(pdev);
+	}
 	if (!sp->dev_vdata) {
 		ret = -ENODEV;
 		dev_err(dev, "missing driver data\n");
@@ -205,7 +208,7 @@ static int sp_platform_probe(struct platform_device *pdev)
 	}
 
 	attr = device_get_dma_attr(dev);
-	if (attr == DEV_DMA_NOT_SUPPORTED) {
+	if (!sp_platform->is_platform && attr == DEV_DMA_NOT_SUPPORTED) {
 		dev_err(dev, "DMA is not supported");
 		goto e_err;
 	}
-- 
2.25.1

