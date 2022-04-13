Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBA44FFE7B
	for <lists+linux-crypto@lfdr.de>; Wed, 13 Apr 2022 21:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236600AbiDMTJv (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 13 Apr 2022 15:09:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237928AbiDMTJt (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 13 Apr 2022 15:09:49 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 162356E4F5
        for <linux-crypto@vger.kernel.org>; Wed, 13 Apr 2022 12:07:27 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id q20so1693795wmq.1
        for <linux-crypto@vger.kernel.org>; Wed, 13 Apr 2022 12:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w4B/nkw6c+X0giFcf3xLDnzS4+ocxAJWfds+bZ7Txos=;
        b=jiOAFhLbEKc14FWm3yMjT0bbvtxTYPXvNGpo+AFvfuJMT54/wy7BFm8+ddRTVgIJkS
         bP21FD4FlJSXKgBkPKqs91MHbXwtEVI/j9/xgJTecf2hKmBhnO1Z9oW7T8fV/VZNFtPo
         KkQV2bwW0T8bM2pAmsbWUuLOa0z4L9uQy04o8otA1LzQzQ1cahmcy9WiQurPoWUMEoQA
         y9O/SldCp/jxVeMjtB6zjQs9fmWyDjnoVfHCXOBCDNlEK5kgpD17IoAI0i4Wyr5en5cu
         +tK5nMzd1NdMmQj1yKvF54iy37rUdBE6lFjm1DuZtweRiGGN/a8s+4PdW4zHfhY9jAgM
         axIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w4B/nkw6c+X0giFcf3xLDnzS4+ocxAJWfds+bZ7Txos=;
        b=4/qMTIocFVMcKaA7lWv/7qhUOZVqd5RwSpqC4QASJlYmpJJ41KQsovJU+FdQDFd2+0
         QEv2pvim1ug05KS6OpC7Nh8EtZI1AuAt1ASm/f2gUkjozYv2ENJGP1uHhu9C7wgOe4zQ
         zRx0gJN9tdM69JIa6saqsYcNruvCIhLnE+jXgX6UUE6Aq8OdU5z+YwMn1s1p76s3/7Ge
         AwrhnaG1h5tFq71GdUX5bTknRk84QZAuhiWBw0LSs6jPXBxA1jWfRCApo6Jc6C/hlV3u
         T7udvcwQISCHX0d088JktwBxrimnFK0ulOvhK8C5AYe9ZQe4Uu+1p0EIIy6SRjasVu1O
         6wSw==
X-Gm-Message-State: AOAM531vgn8BC+T3zgiNmNW11+M4pFCfqoG20d9bB0QvJx1A8hwtgmUZ
        xfdvNE4SYqKlkdzTbSpikxvaZA==
X-Google-Smtp-Source: ABdhPJytnnB0BQUt30BsR2iqSqrcF6jboGMeaUhvOLB3fVaJplpL6qaHJ7dSaTQ8mUaTMLCR7e8oPg==
X-Received: by 2002:a05:600c:6d3:b0:38e:c692:d50a with SMTP id b19-20020a05600c06d300b0038ec692d50amr180063wmn.30.1649876845729;
        Wed, 13 Apr 2022 12:07:25 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id o29-20020a05600c511d00b0038e3532b23csm3551852wms.15.2022.04.13.12.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:07:25 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v5 04/33] crypto: rockchip: fix privete/private typo
Date:   Wed, 13 Apr 2022 19:06:44 +0000
Message-Id: <20220413190713.1427956-5-clabbe@baylibre.com>
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

This fix a simple typo on private word.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.h b/drivers/crypto/rockchip/rk3288_crypto.h
index 2fa7131e4060..656d6795d400 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.h
+++ b/drivers/crypto/rockchip/rk3288_crypto.h
@@ -235,7 +235,7 @@ struct rk_ahash_ctx {
 	struct crypto_ahash		*fallback_tfm;
 };
 
-/* the privete variable of hash for fallback */
+/* the private variable of hash for fallback */
 struct rk_ahash_rctx {
 	struct ahash_request		fallback_req;
 	u32				mode;
-- 
2.35.1

