Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 863A8A78CD
	for <lists+linux-crypto@lfdr.de>; Wed,  4 Sep 2019 04:35:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfIDCfo (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 3 Sep 2019 22:35:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35250 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728132AbfIDCfo (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 3 Sep 2019 22:35:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id gn20so8847652plb.2;
        Tue, 03 Sep 2019 19:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BhpxphdWBSz1L2B9ZesztRoMGvUE4getK82ZLPQsGtU=;
        b=uA7W+0QuGo4CfSUGJFtcIxVBeJHAXQr7NMTxwWhTSHPmEft7Y50uESN5XZhyYSvskD
         oLnz4yfwXPto9dDkaWqTVvzzJUy3Kmmw3se8i7TQvlkspqQMwoWaFXCVmf29+AEV8xg/
         7jQip18Y1VLk4UJ6QKxt1zcNzeCTkJ0acHsZzy2Sdlk6/RYB759lxDFLga4VVeRfJ0pr
         CQ+ARLxflLHfqZ0/nCXGxuG2cv31mKP7PCAU4q6tJEazGiWpapEklyNL4WYWqPxNx/kw
         /puwtHk/f+Dv4VCACQ84nCZ/avvUws7kWue0JTFoC9PKONA25/8abUOnG7gpJnp3JVa6
         JYYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BhpxphdWBSz1L2B9ZesztRoMGvUE4getK82ZLPQsGtU=;
        b=OvrqDSUcdcLz9yen0WoVAHFVpZubaktRSqfDychewGORT4GkPmf+i5RwIjJHoF6ShD
         9YBcJQCUQ8YdkEvqQXI3nmpJwuXkSVrgFD+R1u3CLbUzpzmk/XYGndBKbRNMOVQNPwzk
         OHMjAHuGQYm7Iz1BKnqPs5c5Zau3MWdvT3S/Roz+IMnR1wn4uQyogrgi55ADonQ/0V/s
         I/Y9wh/77B3RaWx7qeTRa5qj5mbWy6tZFuHOqZMfpq6GrDqctAtnE+fH9YCI/F0ZUvi8
         0EqAsWQlZ629QOOXbCevfcmFCBsvWHHGywpcGFTGogpKf2Y5fKgnLIAz2kSWaF2XJ5xp
         hTDg==
X-Gm-Message-State: APjAAAUHZxRwcrmPe/6VR+FQGfUogAZlT8WcpEo6c2IAqnhrDa/JkGV3
        ZBTU93CMSI1d1vLnw05MnKMM6XoYck8=
X-Google-Smtp-Source: APXvYqw6FnMQh0U7BoqICAUQEf+gIXACPri+NLjJWx1LxnWK07lqcBLU657h8PWLnw8GSL5FgkQMPg==
X-Received: by 2002:a17:902:758a:: with SMTP id j10mr31127712pll.233.1567564543249;
        Tue, 03 Sep 2019 19:35:43 -0700 (PDT)
Received: from localhost.lan (c-67-185-54-80.hsd1.wa.comcast.net. [67.185.54.80])
        by smtp.gmail.com with ESMTPSA id i74sm7480250pfe.28.2019.09.03.19.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 19:35:42 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/12] crypto: caam - user devres to populate platform devices
Date:   Tue,  3 Sep 2019 19:35:12 -0700
Message-Id: <20190904023515.7107-10-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190904023515.7107-1-andrew.smirnov@gmail.com>
References: <20190904023515.7107-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Use devres to de-initialize the RNG and drop explicit de-initialization
code in caam_remove().

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Horia Geantă <horia.geanta@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/caam/ctrl.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 37cd04f8ddb1..4a84c2701311 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -322,20 +322,6 @@ static int instantiate_rng(struct device *ctrldev, int state_handle_mask,
 	return ret;
 }
 
-static int caam_remove(struct platform_device *pdev)
-{
-	struct device *ctrldev;
-	struct caam_drv_private *ctrlpriv;
-
-	ctrldev = &pdev->dev;
-	ctrlpriv = dev_get_drvdata(ctrldev);
-
-	/* Remove platform devices under the crypto node */
-	of_platform_depopulate(ctrldev);
-
-	return 0;
-}
-
 /*
  * kick_trng - sets the various parameters for enabling the initialization
  *	       of the RNG4 block in CAAM
@@ -762,7 +748,7 @@ static int caam_probe(struct platform_device *pdev)
 #endif
 	}
 
-	ret = of_platform_populate(nprop, caam_match, NULL, dev);
+	ret = devm_of_platform_populate(dev);
 	if (ret) {
 		dev_err(dev, "JR platform devices creation error\n");
 		return ret;
@@ -784,8 +770,7 @@ static int caam_probe(struct platform_device *pdev)
 	/* If no QI and no rings specified, quit and go home */
 	if ((!ctrlpriv->qi_present) && (!ctrlpriv->total_jobrs)) {
 		dev_err(dev, "no queues configured, terminating\n");
-		ret = -ENOMEM;
-		goto caam_remove;
+		return -ENOMEM;
 	}
 
 	if (ctrlpriv->era < 10)
@@ -848,7 +833,7 @@ static int caam_probe(struct platform_device *pdev)
 		} while ((ret == -EAGAIN) && (ent_delay < RTSDCTL_ENT_DLY_MAX));
 		if (ret) {
 			dev_err(dev, "failed to instantiate RNG");
-			goto caam_remove;
+			return ret;
 		}
 		/*
 		 * Set handles init'ed by this module as the complement of the
@@ -922,10 +907,6 @@ static int caam_probe(struct platform_device *pdev)
 			    &ctrlpriv->ctl_tdsk_wrap);
 #endif
 	return 0;
-
-caam_remove:
-	caam_remove(pdev);
-	return ret;
 }
 
 static struct platform_driver caam_driver = {
@@ -934,7 +915,6 @@ static struct platform_driver caam_driver = {
 		.of_match_table = caam_match,
 	},
 	.probe       = caam_probe,
-	.remove      = caam_remove,
 };
 
 module_platform_driver(caam_driver);
-- 
2.21.0

