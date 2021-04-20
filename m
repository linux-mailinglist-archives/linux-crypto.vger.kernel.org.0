Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D79D3650F1
	for <lists+linux-crypto@lfdr.de>; Tue, 20 Apr 2021 05:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbhDTDgl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 19 Apr 2021 23:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233670AbhDTDgj (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 19 Apr 2021 23:36:39 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65727C06138C
        for <linux-crypto@vger.kernel.org>; Mon, 19 Apr 2021 20:36:08 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id m16so27147181qtx.9
        for <linux-crypto@vger.kernel.org>; Mon, 19 Apr 2021 20:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wHIdoU8gmuAA7x+QZ3612OOOxooCO7GWN9KlzMj4N6o=;
        b=IhrO2aJBlITMhY8cVJ0gGR8dlXvqCEaRhu5oNiPgdGOlOWtayYiECRFTRIrKndPSPP
         GvMB9geb0KN9wINff8o50/X1xerTXW4TzP2B7zPQxRttYlVlJOpxNfVyGFJ+RQOJn4aE
         YABTR4OOBl6FBBjIOXNoz1E22iMwAsS/hBvCwZdpEHz4Qh/ufpy3hJdOthWKZzO7Y5qc
         jKGecRbXr00YQUWdsI2GJzu1jjC1gWN7vl29dd41UmTUcoOQogQNeeedlvACsZtAnhq+
         m4Pbs3zGIVk6EaEOjQaf6Oi47KIK/MoZXQm1vyfIfLpiIYS1QIVmMaWzmCbvklIupdUY
         jp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wHIdoU8gmuAA7x+QZ3612OOOxooCO7GWN9KlzMj4N6o=;
        b=mhAzRBwW3FKQWwpyDStLZQxUkNjhJlVS5zOx80hX4mlgSQ3DLcHJ6JR+qIunISM8LZ
         5/nIzhoF43MdoBji/yJ/RABxhWduJ2i5x6jDwQvQxERRTWFqbSvpYnvT1Na3FMu6K4nj
         6YWFwgv+x8gVx75oWxOah5COkchukUdccSBFwVTZ9q8xeWsqlPQaAZqidIWS5ZhGxvcv
         b2ST3jIxuezlwZWaobv0wjUA7Iuq9gyijY4jBPUWBh1Tq+Z8cVqH0dQLgua7gyKMVhWQ
         HIlmVZC4I7brWMQ8exGAYNQFh50FyRBbqHNbcnhLiIGyCXWDqENI9HlJL8o44kvo2WgI
         DBkQ==
X-Gm-Message-State: AOAM532H6aSk2EekDWShdBxOvcl9GOVKo+ycUFtii770cVPxHZtWBEdX
        YhaXN/xx5wE+POqheV7e52ij9Q==
X-Google-Smtp-Source: ABdhPJyA4UpPZ72M/OtTdHw/yGFNLrKP8nCVXpuPaPmQ6CntuCKDNyMChlttRBW5ILBpC74NORksPQ==
X-Received: by 2002:ac8:60c8:: with SMTP id i8mr7663086qtm.63.1618889767683;
        Mon, 19 Apr 2021 20:36:07 -0700 (PDT)
Received: from pop-os.fios-router.home (pool-71-163-245-5.washdc.fios.verizon.net. [71.163.245.5])
        by smtp.googlemail.com with ESMTPSA id b8sm3562643qka.117.2021.04.19.20.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 20:36:07 -0700 (PDT)
From:   Thara Gopinath <thara.gopinath@linaro.org>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        bjorn.andersson@linaro.org
Cc:     ebiggers@google.com, ardb@kernel.org, sivaprak@codeaurora.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [Patch v3 5/7] crypto: qce: common: Clean up qce_auth_cfg
Date:   Mon, 19 Apr 2021 23:36:00 -0400
Message-Id: <20210420033602.1729947-6-thara.gopinath@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210420033602.1729947-1-thara.gopinath@linaro.org>
References: <20210420033602.1729947-1-thara.gopinath@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Remove various redundant checks in qce_auth_cfg. Also allow qce_auth_cfg
to take auth_size as a parameter which is a required setting for ccm(aes)
algorithms

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/crypto/qce/common.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/drivers/crypto/qce/common.c b/drivers/crypto/qce/common.c
index 7b5bc5a6ae81..7b3d6caec1b2 100644
--- a/drivers/crypto/qce/common.c
+++ b/drivers/crypto/qce/common.c
@@ -97,11 +97,11 @@ static inline void qce_crypto_go(struct qce_device *qce, bool result_dump)
 }
 
 #ifdef CONFIG_CRYPTO_DEV_QCE_SHA
-static u32 qce_auth_cfg(unsigned long flags, u32 key_size)
+static u32 qce_auth_cfg(unsigned long flags, u32 key_size, u32 auth_size)
 {
 	u32 cfg = 0;
 
-	if (IS_AES(flags) && (IS_CCM(flags) || IS_CMAC(flags)))
+	if (IS_CCM(flags) || IS_CMAC(flags))
 		cfg |= AUTH_ALG_AES << AUTH_ALG_SHIFT;
 	else
 		cfg |= AUTH_ALG_SHA << AUTH_ALG_SHIFT;
@@ -119,15 +119,16 @@ static u32 qce_auth_cfg(unsigned long flags, u32 key_size)
 		cfg |= AUTH_SIZE_SHA256 << AUTH_SIZE_SHIFT;
 	else if (IS_CMAC(flags))
 		cfg |= AUTH_SIZE_ENUM_16_BYTES << AUTH_SIZE_SHIFT;
+	else if (IS_CCM(flags))
+		cfg |= (auth_size - 1) << AUTH_SIZE_SHIFT;
 
 	if (IS_SHA1(flags) || IS_SHA256(flags))
 		cfg |= AUTH_MODE_HASH << AUTH_MODE_SHIFT;
-	else if (IS_SHA1_HMAC(flags) || IS_SHA256_HMAC(flags) ||
-		 IS_CBC(flags) || IS_CTR(flags))
+	else if (IS_SHA1_HMAC(flags) || IS_SHA256_HMAC(flags))
 		cfg |= AUTH_MODE_HMAC << AUTH_MODE_SHIFT;
-	else if (IS_AES(flags) && IS_CCM(flags))
+	else if (IS_CCM(flags))
 		cfg |= AUTH_MODE_CCM << AUTH_MODE_SHIFT;
-	else if (IS_AES(flags) && IS_CMAC(flags))
+	else if (IS_CMAC(flags))
 		cfg |= AUTH_MODE_CMAC << AUTH_MODE_SHIFT;
 
 	if (IS_SHA(flags) || IS_SHA_HMAC(flags))
@@ -136,10 +137,6 @@ static u32 qce_auth_cfg(unsigned long flags, u32 key_size)
 	if (IS_CCM(flags))
 		cfg |= QCE_MAX_NONCE_WORDS << AUTH_NONCE_NUM_WORDS_SHIFT;
 
-	if (IS_CBC(flags) || IS_CTR(flags) || IS_CCM(flags) ||
-	    IS_CMAC(flags))
-		cfg |= BIT(AUTH_LAST_SHIFT) | BIT(AUTH_FIRST_SHIFT);
-
 	return cfg;
 }
 
@@ -171,7 +168,7 @@ static int qce_setup_regs_ahash(struct crypto_async_request *async_req)
 		qce_clear_array(qce, REG_AUTH_KEY0, 16);
 		qce_clear_array(qce, REG_AUTH_BYTECNT0, 4);
 
-		auth_cfg = qce_auth_cfg(rctx->flags, rctx->authklen);
+		auth_cfg = qce_auth_cfg(rctx->flags, rctx->authklen, digestsize);
 	}
 
 	if (IS_SHA_HMAC(rctx->flags) || IS_CMAC(rctx->flags)) {
@@ -199,7 +196,7 @@ static int qce_setup_regs_ahash(struct crypto_async_request *async_req)
 		qce_write_array(qce, REG_AUTH_BYTECNT0,
 				(u32 *)rctx->byte_count, 2);
 
-	auth_cfg = qce_auth_cfg(rctx->flags, 0);
+	auth_cfg = qce_auth_cfg(rctx->flags, 0, digestsize);
 
 	if (rctx->last_blk)
 		auth_cfg |= BIT(AUTH_LAST_SHIFT);
-- 
2.25.1

