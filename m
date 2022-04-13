Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD87E4FFEAB
	for <lists+linux-crypto@lfdr.de>; Wed, 13 Apr 2022 21:09:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236470AbiDMTLX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 13 Apr 2022 15:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238080AbiDMTLJ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 13 Apr 2022 15:11:09 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D536FF60
        for <linux-crypto@vger.kernel.org>; Wed, 13 Apr 2022 12:07:43 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r64so1683798wmr.4
        for <linux-crypto@vger.kernel.org>; Wed, 13 Apr 2022 12:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ww46m6LdM7MaV4jgNKlRbRSwspMAPKBncRJe9WsCVsI=;
        b=n4GxM+7nsuxsI+1bGcB5rLwa+X6GSggqVjENOqQyONbq7w/m8M5vULAHabZHUaOfI0
         yrGXFlSZ6/xTW4bEIDG74iTDKKtkFl5IouRROOgn+l7gyc1H+SRRImGzZHyrLUg1bR2g
         D5itmvThqm5esfDcz+3UULE7zNmNWRa/gxb4oVPhjDJZIiAUySCYh5+jzyk/hMTdqP4N
         mSYFtR+OODyxrWgjVMDeaKECZH1M+ZKiqFcWtMZMZVALTWSPe2NgG7NL06hU29c93Kli
         CbmCLaHHyqPdNkawQoM8UfbBDQrTDhPNqov2IYHyMHvnTcr6sEHfp1lRrVtqet85eAmI
         hXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ww46m6LdM7MaV4jgNKlRbRSwspMAPKBncRJe9WsCVsI=;
        b=pz+Jd5jd/Fv4rSB2ma0WyEHHgu43xbNRcERgrsT0HYUxuwnY+Yhm7EEM+HddqGmUYv
         LeazlrtcXeneBcXD900+XakrZUu3kDMdE974llzPuLBLVHzkI2vMs8oZBS+282+fjYWU
         f/UEzKuMpH3J59DO+p2NmBLpQ8P5MY7sedtmBNQfT4EI3ZHZrrvl1s1DI8U45QcmFLyP
         0JE7BryTmmQveWjYYDn3vD7uLouD5X5OuBO9xdDpliqRqCkcw5+47bk9ZD2TZKmSEnow
         9cr7Y4iQNwT2j4ihAICV960K5uZD91WTrBhFPwjT6/60If63aC6yGgTyYgiSVkJULKoC
         4BxA==
X-Gm-Message-State: AOAM5337P1KCmRt6UwL4k3iaIO1ALKk/p0udElS682A8SlQ+X7Lw8R2x
        T9Rv/hGhLCEgDKHTF5pm4iCzNA==
X-Google-Smtp-Source: ABdhPJy6gHqrDJOTPbB96a63VKnYt0J7Z0B01+Lngql6b4+Dh4LGSSPlMrcvgax9jGWuIz5xph+3Ww==
X-Received: by 2002:a1c:7518:0:b0:381:c77:ceec with SMTP id o24-20020a1c7518000000b003810c77ceecmr146115wmc.57.1649876862022;
        Wed, 13 Apr 2022 12:07:42 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o29-20020a05600c511d00b0038e3532b23csm3551852wms.15.2022.04.13.12.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:07:41 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 19/33] crypto: rockchip: add support for rk3328
Date:   Wed, 13 Apr 2022 19:06:59 +0000
Message-Id: <20220413190713.1427956-20-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413190713.1427956-1-clabbe@baylibre.com>
References: <20220413190713.1427956-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The rk3328 could be used as-is by the rockchip driver.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index 97ef59a36be6..6147ce44f757 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -197,6 +197,7 @@ static void rk_crypto_unregister(void)
 
 static const struct of_device_id crypto_of_id_table[] = {
 	{ .compatible = "rockchip,rk3288-crypto" },
+	{ .compatible = "rockchip,rk3328-crypto" },
 	{}
 };
 MODULE_DEVICE_TABLE(of, crypto_of_id_table);
-- 
2.35.1

