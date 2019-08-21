Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89B6197D0E
	for <lists+linux-crypto@lfdr.de>; Wed, 21 Aug 2019 16:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfHUOdR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 21 Aug 2019 10:33:17 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35667 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728964AbfHUOdQ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 21 Aug 2019 10:33:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so2394581wmg.0
        for <linux-crypto@vger.kernel.org>; Wed, 21 Aug 2019 07:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gkbLgubyXxiJMMRMzAmpKCmMYVcmKbpOZX5ob6E8mqs=;
        b=szJfzLYALpagYlStlGrcldxHDC71KgrrVq/2Lvma8CKThhHW29eHiIOAyilSpqSYI1
         lpVUdhvz3EyHWhXAgAM0gShZ06fTET0OCdcEqmt1X8vrfmJRns9YcuTk4YgZGRIRn7Ph
         Z+Wmg4XzICMidAwoPKXCfJZYOuNRQBjb7+L5vmYDhkc2Rjh/NyrBl+ivQ5LY3gxMBO2m
         ItYZWOuim7xv1hpPmiV5F+61E5t4gld4t0Y+72TH4NoQfz/mWVerUSEW7I6NY/EzvWSn
         3qstcIz3JOFBYZJXko3tGp94lnDWN8ETVy0MW6IHerNDjvEw9i6t/JsVh7Mf+qZMylV1
         H3Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gkbLgubyXxiJMMRMzAmpKCmMYVcmKbpOZX5ob6E8mqs=;
        b=SIiK7GJ0KZtGhHkLCF7iKtqtAHDEczloer8DI3jovsrwZ7oPJK7+OZLlWmTU5bqVgw
         Lrylpw4bADflSCIeUlUTiZfl9a87XW+B6A86Gi9YPzHGFwMM00rG+qMrcApjcLYVGEfL
         cHpgPMd6QI8PwZLTAWYLm1G/sCgKQc1a6w+fBgtq1xeSpna2vQuBoR3AEY0pU97xMhzx
         72QkySh2qPC56utLH/PwJM0ZLtpLVpMk2/HDGdbhhYhtL7POYBsubtqK5jD56jkQO+P4
         xvzLI8HJ0Rw7BIqGNXS9zWb/Tp+7S0kMeAhzWCuVSJfZWWqrphQhH1ZFm30qwI6622Np
         wBug==
X-Gm-Message-State: APjAAAVj1pAStI+6u28rexbBcI//A5XWMiex1C2FGOg2DwHRxq6uQu5c
        oV2u3zWCM73WMsoY457SLEWeGjkqNWnZfw==
X-Google-Smtp-Source: APXvYqw61OlW7GEMQHKOrev6MN9CxVLvahtdbFcssZpLVX3eYdfWV/4Bu4ug/8k5PLACVWGyP3i4FQ==
X-Received: by 2002:a1c:20c3:: with SMTP id g186mr364851wmg.15.1566397994370;
        Wed, 21 Aug 2019 07:33:14 -0700 (PDT)
Received: from mba13.lan (adsl-103.109.242.1.tellas.gr. [109.242.1.103])
        by smtp.gmail.com with ESMTPSA id 16sm181427wmx.45.2019.08.21.07.33.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 07:33:13 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 09/17] crypto: arm64/aes-cts-cbc-ce - performance tweak
Date:   Wed, 21 Aug 2019 17:32:45 +0300
Message-Id: <20190821143253.30209-10-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190821143253.30209-1-ard.biesheuvel@linaro.org>
References: <20190821143253.30209-1-ard.biesheuvel@linaro.org>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Optimize away one of the tbl instructions in the decryption path,
which turns out to be unnecessary.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/aes-modes.S | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/crypto/aes-modes.S b/arch/arm64/crypto/aes-modes.S
index 2879f030a749..38cd5a2091a8 100644
--- a/arch/arm64/crypto/aes-modes.S
+++ b/arch/arm64/crypto/aes-modes.S
@@ -293,12 +293,11 @@ AES_ENTRY(aes_cbc_cts_decrypt)
 	ld1		{v5.16b}, [x5]			/* get iv */
 	dec_prepare	w3, x2, x6
 
-	tbl		v2.16b, {v1.16b}, v4.16b
 	decrypt_block	v0, w3, x2, x6, w7
-	eor		v2.16b, v2.16b, v0.16b
+	tbl		v2.16b, {v0.16b}, v3.16b
+	eor		v2.16b, v2.16b, v1.16b
 
 	tbx		v0.16b, {v1.16b}, v4.16b
-	tbl		v2.16b, {v2.16b}, v3.16b
 	decrypt_block	v0, w3, x2, x6, w7
 	eor		v0.16b, v0.16b, v5.16b		/* xor with iv */
 
-- 
2.17.1

