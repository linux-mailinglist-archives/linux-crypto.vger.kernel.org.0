Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 989E418BC12
	for <lists+linux-crypto@lfdr.de>; Thu, 19 Mar 2020 17:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbgCSQM5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 19 Mar 2020 12:12:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45972 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgCSQM4 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 19 Mar 2020 12:12:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id j10so1658135pfi.12;
        Thu, 19 Mar 2020 09:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IyNaexVGAFPuYa1/21/8hAP4p1WeyICJrEGxBbYyNDc=;
        b=dMFJIcOwrvBMz9CuzcOCecXrkf2l05YwXoYZdxWd6zBtQNgIu3JlDLG7oIb47Gdu3+
         TRlOf6AZXTqlel+ur7Tx2eiZ0KR/ysvucY18CvjiWPl6IZgb8h82YOcnjVGY4PKE/t63
         RtHVOaJiDaFzhkIVgY1cFea7beyGgBncU8P1BEHNFp0yX0yzUnq90Vt5lyZtQU3+mP3P
         svCnEOFbKY+TUai9Ak89CXjDy6vC6oVc75ORhmBBUImfnnxKFB3RUkL2Jwyn+/gE22jw
         ztLaEu8EKWvy8JRX6ZeyVe28XQljUSL24tlH8eQZ4lKmQhzZCTPzMNGZpIY52kGiiNQ9
         8Eiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IyNaexVGAFPuYa1/21/8hAP4p1WeyICJrEGxBbYyNDc=;
        b=U/nDI1qp604r++GQFHBRrpHB9uoohEQdKd2HZZSLyM3BVGLjhY0qUhztOJHsaQOusA
         V3bK2xjrPHzCr2r8Lt+p7IltD2TLcjumoD5FEJvjC+Hfplb2SK/QptVhjBPhDbdvr774
         j0iCUAUnhfG/NUiqJuqE00PgWylNQ7JSP9x9bUZh5XmUY3FRslTHky859tw4PnNMlbX8
         z1PkMNS9akp6S1T3KW2vmf5hdTbcOpj/LpLC+zeicxuFVgw5nL2weU5ufJ4hPb/SA+wU
         9LSTlmNQKWR0p/0FpaMy4YeO8DQifRZb3a7b5r337RozvKbqYOTp67J0n6lYaeLLFS/+
         CQwA==
X-Gm-Message-State: ANhLgQ3jbChAecSj5HtyydEbKOxPfEwSwavgcgHCQifLL2y/fOkn0Jk+
        ZcbifXkON8wSSBWveI4Av7qVFAYQ
X-Google-Smtp-Source: ADFU+vvPUJEKADAsesBf+ZtaXjG5o82wlqCNpt9aXNF47rlFJ+RQuEDaCu6+7qYhC8+pN2W10Xs7Ng==
X-Received: by 2002:a62:76c3:: with SMTP id r186mr4788303pfc.303.1584634373793;
        Thu, 19 Mar 2020 09:12:53 -0700 (PDT)
Received: from localhost.localdomain (c-67-165-113-11.hsd1.wa.comcast.net. [67.165.113.11])
        by smtp.gmail.com with ESMTPSA id x189sm3000078pfb.1.2020.03.19.09.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2020 09:12:51 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-crypto@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
        Chris Healy <cphealy@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Iuliana Prodan <iuliana.prodan@nxp.com>, linux-imx@nxp.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 1/9] crypto: caam - allocate RNG instantiation descriptor with GFP_DMA
Date:   Thu, 19 Mar 2020 09:12:25 -0700
Message-Id: <20200319161233.8134-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200319161233.8134-1-andrew.smirnov@gmail.com>
References: <20200319161233.8134-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Be consistent with the rest of the codebase and use GFP_DMA when
allocating memory for a CAAM JR descriptor.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Reviewed-by: Horia Geantă <horia.geanta@nxp.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Horia Geantă <horia.geanta@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Iuliana Prodan <iuliana.prodan@nxp.com>
Cc: linux-imx@nxp.com
Cc: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/crypto/caam/ctrl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/caam/ctrl.c b/drivers/crypto/caam/ctrl.c
index 7139366da016..7f7f2960b0cc 100644
--- a/drivers/crypto/caam/ctrl.c
+++ b/drivers/crypto/caam/ctrl.c
@@ -196,7 +196,7 @@ static int deinstantiate_rng(struct device *ctrldev, int state_handle_mask)
 	u32 *desc, status;
 	int sh_idx, ret = 0;
 
-	desc = kmalloc(CAAM_CMD_SZ * 3, GFP_KERNEL);
+	desc = kmalloc(CAAM_CMD_SZ * 3, GFP_KERNEL | GFP_DMA);
 	if (!desc)
 		return -ENOMEM;
 
@@ -273,7 +273,7 @@ static int instantiate_rng(struct device *ctrldev, int state_handle_mask,
 	int ret = 0, sh_idx;
 
 	ctrl = (struct caam_ctrl __iomem *)ctrlpriv->ctrl;
-	desc = kmalloc(CAAM_CMD_SZ * 7, GFP_KERNEL);
+	desc = kmalloc(CAAM_CMD_SZ * 7, GFP_KERNEL | GFP_DMA);
 	if (!desc)
 		return -ENOMEM;
 
-- 
2.21.0

