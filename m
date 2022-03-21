Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576A94E3161
	for <lists+linux-crypto@lfdr.de>; Mon, 21 Mar 2022 21:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350340AbiCUULE (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 21 Mar 2022 16:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347295AbiCUUJ5 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 21 Mar 2022 16:09:57 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E1310504A
        for <linux-crypto@vger.kernel.org>; Mon, 21 Mar 2022 13:08:08 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id r13so7179101wrr.9
        for <linux-crypto@vger.kernel.org>; Mon, 21 Mar 2022 13:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KKQIZ8jXpBKaieCflF0TRZBAI0CizxmrIeEedyXM13o=;
        b=xwGWaPIxsJtw1F30UvWCKmUgnDyZOwOcJWbagXXvLSDhkHTI0ZRhzVADNnTlEyOoB0
         lwAXUoXQuz9yAaR/zpIVOVLLjkk+Zh/JkM85bx86GufMvQxoRpLXWMzCisU5ssO/i0El
         n0t2KyNfF91/u3jTzbfGpjjsAdtoN8eqvIL/YQNlQhfQ+SBU+g+GQBkMs6JdKcWXzsAX
         zXh+wqDoB+BV8aySN6zfDLPdnI/O/UA9Mu+AtefcqeIrbBRATcaQdZ1GvhCgYBV4vZ57
         pF2RezgivY0en7SmC6nV6Cy5xvXn63ExrUPdada1ZbiyeFgAvkQhuCuU8G9AhIziGYB7
         yZ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KKQIZ8jXpBKaieCflF0TRZBAI0CizxmrIeEedyXM13o=;
        b=vNqrYDO8/tNWaimEVOUqZVLDnURLA/SnqV45wCPh5k/xxlG4aFvnqkKJFZQe6rYt4+
         wlCJVr/BPRe4Xor3VDiB545ymn+i0zqowZHzMuqwowq+MasXJI8vZN8QNhvWbc6rd0xS
         YsGntRFuctT65JdiyEcNFcSRuVJntkNt/AW721Ni1g/rwx1tI4cYnX26hsDdmy8LRkBu
         f63cK8BzopXmo2g8i0eEJBQdwf7Cih+quRpKI3b5dhyIqkL7qoW5AZHTFqur0LoRwO2Q
         137Ky8BA4qqH5D0WgpNxul84yVsu6BAYFazZkQFgWPrereiYqaIuLUcJJ54mo3Y9JoW8
         Ns3w==
X-Gm-Message-State: AOAM531WQ15Ub+zOplNNxeXie0vCX40sEC/RE5gBUPtnzdz2/2SB+0fK
        epREHKz2WyAypteMF0SOylbyjA==
X-Google-Smtp-Source: ABdhPJwZkUNjMvKbTUN2HxHXxoH9tJ6RsaGOP6up/Huupq5DDHCueRCHLJ4pVYum6Blg/i5/uq9qXA==
X-Received: by 2002:a5d:47cc:0:b0:204:1c9d:2157 with SMTP id o12-20020a5d47cc000000b002041c9d2157mr2642754wrc.294.1647893286777;
        Mon, 21 Mar 2022 13:08:06 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i14-20020a0560001ace00b00203da1fa749sm24426988wry.72.2022.03.21.13.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 13:08:06 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     heiko@sntech.de, herbert@gondor.apana.org.au, krzk+dt@kernel.org,
        mturquette@baylibre.com, robh+dt@kernel.org, sboyd@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH v3 22/26] crypto: rockchip: add support for rk3328
Date:   Mon, 21 Mar 2022 20:07:35 +0000
Message-Id: <20220321200739.3572792-23-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220321200739.3572792-1-clabbe@baylibre.com>
References: <20220321200739.3572792-1-clabbe@baylibre.com>
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

Add compatible and variant for rk3328.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/crypto/rockchip/rk3288_crypto.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/crypto/rockchip/rk3288_crypto.c b/drivers/crypto/rockchip/rk3288_crypto.c
index 5f1422094a7f..bb1adbe947f9 100644
--- a/drivers/crypto/rockchip/rk3288_crypto.c
+++ b/drivers/crypto/rockchip/rk3288_crypto.c
@@ -19,6 +19,10 @@
 #include <linux/crypto.h>
 #include <linux/reset.h>
 
+static const struct rk_variant rk3328_variant = {
+	.num_instance = 1,
+};
+
 static const struct rk_variant rk3288_variant = {
 	.num_instance = 1
 };
@@ -215,6 +219,9 @@ static const struct of_device_id crypto_of_id_table[] = {
 	{ .compatible = "rockchip,rk3288-crypto",
 	  .data = &rk3288_variant,
 	},
+	{ .compatible = "rockchip,rk3328-crypto",
+	  .data = &rk3328_variant,
+	},
 	{ .compatible = "rockchip,rk3399-crypto",
 	  .data = &rk3399_variant,
 	},
-- 
2.34.1

