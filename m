Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470854BE618
	for <lists+linux-crypto@lfdr.de>; Mon, 21 Feb 2022 19:01:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357332AbiBUMJf (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 21 Feb 2022 07:09:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357358AbiBUMJI (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 21 Feb 2022 07:09:08 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BA2201AC
        for <linux-crypto@vger.kernel.org>; Mon, 21 Feb 2022 04:08:44 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k127-20020a1ca185000000b0037bc4be8713so13388212wme.3
        for <linux-crypto@vger.kernel.org>; Mon, 21 Feb 2022 04:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wZFWsyzx/jHMsWPxyPrQm5lf1ZD0aMT85ez0uftjp7E=;
        b=1PGtPPDp+XFtVSREdW90iUbBSR6N4gGIyYK9a0b8MHbK/Qkq1UH2wOhpNzD7hyTVtA
         6B0QWQnBoukyAnTHYkmmddBYf0sa26knc7O5Kx9X6uxs/H7QHr7zPA2/BzmboSv2pTh/
         GhZ8Q5dfBViX2AvCAPLUNbiRQuPHwq5tS0CrZwqj5Z8gpiSVq/rYF2MMveY7EIGO+JSz
         vEePq/DY+or1APvewtFco3JsmXAZbCmvzQHZ8hetzHBpaTvjqTXZrZc9Vy2gOlSElOq/
         9be2oV+LKSHqtwqJXl/m9+UIKdFVb44sEBA0HKyq+KNsl427a4yhdZEtb4/8jwnNkMsz
         9tmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wZFWsyzx/jHMsWPxyPrQm5lf1ZD0aMT85ez0uftjp7E=;
        b=6ZetXdunALW13lioxFSw5vM6Sad3yQSdkWfMmvtqWB3nJwya+VGCNeIZi4KPB03e9l
         K8JGETMsdFt+en4fhduDpTviHNk1hUrGVoBXStZSOdpDX2xJ2olphvrwycEgQf8QMTx+
         UuYyYbxPv3Ln6655ZPiYk/yjEiKm0iE8aoZEkJXIx3jN6+qYhfuZo7wifynLh9zCFD83
         MCWNdy8aY5WJ+xzyNv5Hx5u9GirmGATOK/j9iLiBqdRo4WGkEy9Rgx+Y12keLk30/RbQ
         h9x62QueReNkgQiRIpIvm048I4UkqFBCKJOf/3VFHgn9vyc11ZytITHtfq+6X7ZSckh/
         CRIQ==
X-Gm-Message-State: AOAM531Syboc4SK98lNjWs7X4fDCeGUAkeu3Pnjq4zX4vT8Wu5TpE5EN
        imutrk3GhU92M97YS51YlhXoeg==
X-Google-Smtp-Source: ABdhPJyFGzoL8/nsVuES11PLDKB1Nir+e3TPvcagEp/HBZSmVCZxbZuibRi7efMk2RlWfpuAwsMcxw==
X-Received: by 2002:a05:600c:2b94:b0:355:1695:e8c5 with SMTP id j20-20020a05600c2b9400b003551695e8c5mr17921665wmc.142.1645445323024;
        Mon, 21 Feb 2022 04:08:43 -0800 (PST)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id a8sm11821546wra.0.2022.02.21.04.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 04:08:42 -0800 (PST)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     herbert@gondor.apana.org.au, jernej.skrabec@gmail.com,
        linus.walleij@linaro.org, narmstrong@baylibre.com,
        ulli.kroll@googlemail.com, wens@csie.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@lists.linux.dev,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 3/5] crypto: amlogic: call finalize with bh disabled
Date:   Mon, 21 Feb 2022 12:08:31 +0000
Message-Id: <20220221120833.2618733-4-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220221120833.2618733-1-clabbe@baylibre.com>
References: <20220221120833.2618733-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Doing ipsec produces a spinlock recursion warning.
This is due to not disabling BH during crypto completion function.

Fixes: 48fe583fe541 ("crypto: amlogic - Add crypto accelerator for amlogic GXL")
Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/amlogic/amlogic-gxl-cipher.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
index c6865cbd334b..e79514fce731 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
@@ -265,7 +265,9 @@ static int meson_handle_cipher_request(struct crypto_engine *engine,
 	struct skcipher_request *breq = container_of(areq, struct skcipher_request, base);
 
 	err = meson_cipher(breq);
+	local_bh_disable();
 	crypto_finalize_skcipher_request(engine, breq, err);
+	local_bh_enable();
 
 	return 0;
 }
-- 
2.34.1

