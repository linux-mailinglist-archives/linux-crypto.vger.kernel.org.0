Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2419D5678D1
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Jul 2022 22:52:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231624AbiGEUwP (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 5 Jul 2022 16:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231266AbiGEUwH (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 5 Jul 2022 16:52:07 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B10C48
        for <linux-crypto@vger.kernel.org>; Tue,  5 Jul 2022 13:52:06 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o8pWW-0000tV-F5; Tue, 05 Jul 2022 22:51:56 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o8pWR-004dB6-KV; Tue, 05 Jul 2022 22:51:55 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o8pWU-003Drt-DI; Tue, 05 Jul 2022 22:51:54 +0200
From:   =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@pengutronix.de
Subject: [PATCH 3/7] crypto: atmel-tdes: Drop if with an always false condition
Date:   Tue,  5 Jul 2022 22:51:40 +0200
Message-Id: <20220705205144.131702-3-u.kleine-koenig@pengutronix.de>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705205144.131702-1-u.kleine-koenig@pengutronix.de>
References: <20220705205144.131702-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=906; h=from:subject; bh=hb+vAIzIxMcYrdRF7gpCmqvcWbWsIAkNG+jTD0UJXVs=; b=owEBbQGS/pANAwAKAcH8FHityuwJAcsmYgBixKRN5JJGdPjBP8TuRen+HhTmrn9xCuY1S8xLEObq HOLW8/SJATMEAAEKAB0WIQR+cioWkBis/z50pAvB/BR4rcrsCQUCYsSkTQAKCRDB/BR4rcrsCRBqB/ 9ncIDc0egXxTGDBZHtalYESqaEd4KhLB9dUOivnXe/jE8kEXgXFi5NCZUPYzZtwhb+ojJwltto5Jo0 C70G43+c/jBXo4UMnYIQs2XHFu/aaqsdDgkL+T/4j4qP5itPDd7VQP+EvJYGzQUrmmUQeNZSIdtB0y F1OwI3j1hxCtOO+4VycfLm1PtN7jc0XOWj6+o3wwWMLonOcBepD1wB29DhWZYYajJEKCATh7XUI8f6 C1DjwiG4ji1G7EPxm55+SFYxM3mmGAxFnc8muZhY45xWCPNYTrH85r7ubDziuyqEu1n5Hz3C89sEhY XDn11+bUFC/dRMK29+zWU8av9xkZpw
X-Developer-Key: i=u.kleine-koenig@pengutronix.de; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-crypto@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The remove callback is only called after probe completed successfully.
In this case platform_set_drvdata() was called with a non-NULL argument
and so tdes_dd is never NULL.

This is a preparation for making platform remove callbacks return void.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
---
 drivers/crypto/atmel-tdes.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/atmel-tdes.c b/drivers/crypto/atmel-tdes.c
index 9fd7b8e439d2..a5e78aa08bf0 100644
--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -1266,8 +1266,7 @@ static int atmel_tdes_remove(struct platform_device *pdev)
 	struct atmel_tdes_dev *tdes_dd;
 
 	tdes_dd = platform_get_drvdata(pdev);
-	if (!tdes_dd)
-		return -ENODEV;
+
 	spin_lock(&atmel_tdes.lock);
 	list_del(&tdes_dd->list);
 	spin_unlock(&atmel_tdes.lock);
-- 
2.36.1

