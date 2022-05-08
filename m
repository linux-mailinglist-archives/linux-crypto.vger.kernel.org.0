Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6594551F079
	for <lists+linux-crypto@lfdr.de>; Sun,  8 May 2022 21:42:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbiEHTV6 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 8 May 2022 15:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237620AbiEHTEf (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 8 May 2022 15:04:35 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC4ADF82
        for <linux-crypto@vger.kernel.org>; Sun,  8 May 2022 12:00:29 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id q20so7290445wmq.1
        for <linux-crypto@vger.kernel.org>; Sun, 08 May 2022 12:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i2uYJa2gxIdaD8fQBCxMjwb6E0s7Z3esdAlzwfZv714=;
        b=7DJ1zP2YxdU6IX/RUiFnD+Y6o4wHYt/GovZV9GZnYlY3QDAv0vvypAxxGE12USg+cx
         aAFr+EuwuJ1tN/NAAQgAqmqgNH4cOsptYE+9jbkZY6UqIAl5lbP0hcoXihysDb5Zj92D
         EZcObpoSsBa+1xuPpuWrjQ2hDfJvXxMc/KFrrDEyuwcJItv97HsMNhUjGBsUFwJF/747
         AKKqvr+6EuKGNfTSz268XknKW5b8s/UMiedi90182ccGPjS/6c4n5h+0NUFMPxTcCjwH
         esSSDYC2GO7LNsXmpdcxIAX09xJgmXTZcQ3wyygYe2SFW06Nq9nyQhkeKFWeBNwH6d2z
         9UaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i2uYJa2gxIdaD8fQBCxMjwb6E0s7Z3esdAlzwfZv714=;
        b=EnBeDRLGm8NTPZKo1nGSnA3zhyEl+fFvH0Rnxs8+baftfdobjqBDoSdWt0vb26LRHc
         +gq3qsFV3xr1pH25XeioZM+Wqe1otXqMzeceMnCkuH32+Xy6HObVR5bEsGp2o9pBfVSS
         gZMStPieyPn//WjnCu4ERwbwdw450MG1E0gV6BxZwtLzg1krDtBgik8GQex9ML6DY0mT
         YIKLu0592vm5OfD9oO/9ZyEljqei9lnTy/r+LNHyjsUdpXkASqkbQsQPIHcdZPKtPyzg
         87oKfUKyRptSQJo4Zbx0yn3VT5PRDAYPjiD4/5ClUylU97CzoMdvvVwVqxwh4C58tzHP
         528g==
X-Gm-Message-State: AOAM532gwoDbMqet992zRZBfwR+HckdzYBSPUwIqDsGWjyMzey92Wbag
        KQU8Wu4PGoIUcQ5kZm+tfhhC+w==
X-Google-Smtp-Source: ABdhPJz1Bn96NkNlpBwW7gmLnC4gKO6YIqTcEyHARlQXxpdCcK/f3iY8GvjvU8XDHYLiJF5twUOWSg==
X-Received: by 2002:a05:600c:35cc:b0:394:7e9e:bd1f with SMTP id r12-20020a05600c35cc00b003947e9ebd1fmr10934528wmq.95.1652036429227;
        Sun, 08 May 2022 12:00:29 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id n16-20020a05600c3b9000b00394699f803dsm10552348wms.46.2022.05.08.12.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 May 2022 12:00:28 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, ardb@kernel.org, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v7 23/33] crypto: rockchip: use the rk_crypto_info given as parameter
Date:   Sun,  8 May 2022 18:59:47 +0000
Message-Id: <20220508185957.3629088-24-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220508185957.3629088-1-clabbe@baylibre.com>
References: <20220508185957.3629088-1-clabbe@baylibre.com>
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

Instead of using the crypto_info from TFM ctx, use the one given as parameter.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto_skcipher.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
index 6a1bea98fded..cf0dfb6029d8 100644
--- a/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_skcipher.c
@@ -254,7 +254,7 @@ static void rk_cipher_hw_init(struct rk_crypto_info *dev, struct skcipher_reques
 			     RK_CRYPTO_TDES_BYTESWAP_KEY |
 			     RK_CRYPTO_TDES_BYTESWAP_IV;
 		CRYPTO_WRITE(dev, RK_CRYPTO_TDES_CTRL, rctx->mode);
-		memcpy_toio(ctx->dev->reg + RK_CRYPTO_TDES_KEY1_0, ctx->key, ctx->keylen);
+		memcpy_toio(dev->reg + RK_CRYPTO_TDES_KEY1_0, ctx->key, ctx->keylen);
 		conf_reg = RK_CRYPTO_DESSEL;
 	} else {
 		rctx->mode |= RK_CRYPTO_AES_FIFO_MODE |
@@ -266,7 +266,7 @@ static void rk_cipher_hw_init(struct rk_crypto_info *dev, struct skcipher_reques
 		else if (ctx->keylen == AES_KEYSIZE_256)
 			rctx->mode |= RK_CRYPTO_AES_256BIT_key;
 		CRYPTO_WRITE(dev, RK_CRYPTO_AES_CTRL, rctx->mode);
-		memcpy_toio(ctx->dev->reg + RK_CRYPTO_AES_KEY_0, ctx->key, ctx->keylen);
+		memcpy_toio(dev->reg + RK_CRYPTO_AES_KEY_0, ctx->key, ctx->keylen);
 	}
 	conf_reg |= RK_CRYPTO_BYTESWAP_BTFIFO |
 		    RK_CRYPTO_BYTESWAP_BRFIFO;
-- 
2.35.1

