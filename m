Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3CF649D40D
	for <lists+linux-crypto@lfdr.de>; Wed, 26 Jan 2022 22:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbiAZVFD (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 26 Jan 2022 16:05:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbiAZVE6 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 26 Jan 2022 16:04:58 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B3B4C061747
        for <linux-crypto@vger.kernel.org>; Wed, 26 Jan 2022 13:04:58 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id j5-20020a05600c1c0500b0034d2e956aadso607198wms.4
        for <linux-crypto@vger.kernel.org>; Wed, 26 Jan 2022 13:04:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XtAZUKhGKHjYfajUS2uXJzGri3eZZgxbF/8hYjHFYEk=;
        b=OIn3/Ia6hAwycSnr3NZlODzPFqa/EJCMMeZcyRybAseGvz3913KKcmA/H91rkKTGRy
         PtQfeueRPyx6t8K6t93wVx+PCjkVS9zctVwzIZmUKYQxBwON5aRL824DYiXQ+itVlz2K
         Sw1cAgV59OhCPBW3P0QBhzyqft1TJ97SB8cwTqkSuNcoznMxv/t6isSSSbHhLDSJR5db
         d/iXOWT2ggnOB45ZQaTbXpOnPVIJiaeYwWznJHT1C0017g0wS3XHhlGOhyldhd0HhRd+
         d01sgB7zQa3DNZMZp279y8Z+JC9O45fW0AYRLyQmW5sgpTSuKCIBqVj5mDDougmxO2K6
         P9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XtAZUKhGKHjYfajUS2uXJzGri3eZZgxbF/8hYjHFYEk=;
        b=RirqOe5WAwgZZDLRDu2VgQWWXAVLuKdKLPRkxfQ0MoSi6DSHaldBZb9W03zDs3IXKK
         iSrMUChUlAXFVxAgLmQa2jnanpHOE8KXRU7c4jZYM8Af/Kk/OSqJAGihI79vMF1WRRPp
         q8Lof+qvCh9hIf5/rbavRmOzSu/S7FzcyTGJNqH4ZctIwELiu/lpqKWCKL8L0eI2tF6J
         JtDKrHiSnC1/sB8A5uWG7NYSYYRPopZCN2lBOtWpt5bS9GVc9ZD9YjbOWxMPhW9UFZe0
         2RweAHx/J/S0m9dIzOzOEly7HRkXzh2Lt8ZYXZRNdT09jxvab1oNrUBqMY7af7gnbCns
         pKdw==
X-Gm-Message-State: AOAM533HJlvo+rVje/zQwg1y5i26HDIHV8xrXcLUOH4yrT1vqUqtNoz6
        1WjZX/ZajSBU3tprcgDGqVgcnw==
X-Google-Smtp-Source: ABdhPJwtxqNJuhVN5WLIINA4xCkD2h+AHjTXiZNUQMpu9OEiqy41TS1maJtKxXblKqGCfpR2TpM3KA==
X-Received: by 2002:a05:600c:281:: with SMTP id 1mr462008wmk.134.1643231096680;
        Wed, 26 Jan 2022 13:04:56 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id j19sm4948611wmq.17.2022.01.26.13.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 13:04:56 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     davem@davemloft.net, herbert@gondor.apana.org.au,
        jernej.skrabec@gmail.com, mripard@kernel.org, wens@csie.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        linux-sunxi@googlegroups.com, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 7/8] crypto: sun8i-ss: test error before assigning
Date:   Wed, 26 Jan 2022 21:04:40 +0000
Message-Id: <20220126210441.3661782-8-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220126210441.3661782-1-clabbe@baylibre.com>
References: <20220126210441.3661782-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The first thing we should do after dma_map_single() is to test the
result.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
index 7ebd11d3ff7d..1aae36d541d8 100644
--- a/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
+++ b/drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c
@@ -414,15 +414,15 @@ int sun8i_ss_hash_run(struct crypto_engine *engine, void *breq)
 	}
 
 	addr_pad = dma_map_single(ss->dev, pad, j * 4, DMA_TO_DEVICE);
-	rctx->t_src[i].addr = addr_pad;
-	rctx->t_src[i].len = j;
-	rctx->t_dst[i].addr = addr_res;
-	rctx->t_dst[i].len = digestsize / 4;
 	if (dma_mapping_error(ss->dev, addr_pad)) {
 		dev_err(ss->dev, "DMA error on padding SG\n");
 		err = -EINVAL;
 		goto theend;
 	}
+	rctx->t_src[i].addr = addr_pad;
+	rctx->t_src[i].len = j;
+	rctx->t_dst[i].addr = addr_res;
+	rctx->t_dst[i].len = digestsize / 4;
 
 	err = sun8i_ss_run_hash_task(ss, rctx, crypto_tfm_alg_name(areq->base.tfm));
 
-- 
2.34.1

