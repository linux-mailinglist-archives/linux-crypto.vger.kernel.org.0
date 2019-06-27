Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA64A5805E
	for <lists+linux-crypto@lfdr.de>; Thu, 27 Jun 2019 12:28:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbfF0K2X (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 27 Jun 2019 06:28:23 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33600 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfF0K2W (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 27 Jun 2019 06:28:22 -0400
Received: by mail-wr1-f65.google.com with SMTP id n9so1950786wru.0
        for <linux-crypto@vger.kernel.org>; Thu, 27 Jun 2019 03:28:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MjklBC4QXLLYOVvVYsNk23Xh/eNadKBF3H0s2LOsbpU=;
        b=Za/MTEXKeBIrGQve8XmJXITdWVnr5g9xRMV7x2h+pxLHKCenXG82yFlL+Qv+YPEd5G
         tbYH8cVKuLDtrbVr1dpGMy7R5taeoGMxUG+jM6kH27v0yLUj8V1pX32ICu6KYu8qNHES
         Xn5OO5Y0zyy6SJ6IZZvWK14sjV6iDaL/gKhCbuNtJxb4h71FyPfMYbX8Yd6tanXijzT8
         3Awfk6nMnXwjfZgrR1VwDEVlRtWrfY8azFwoWm0Bg8KxXpdAEp/nslRrNFGPneh3q/Qd
         9pvs48TDIvgbtAnVAoTIL9I/ofMY6DjDCFf6VhhBmCaRL+UYlIy/smOFq4R0B3EQNXFF
         LZaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MjklBC4QXLLYOVvVYsNk23Xh/eNadKBF3H0s2LOsbpU=;
        b=Cffn1P8YYsy72Z8b1fYOjpKsmNxrh1G37zK9au6gcaCTXqkYoSH2DEl/IhyDDojZFE
         S/Dyq5n/G8dbKTzuIOSUi3ZM+oFWgaSX2pe9+5YICknW0tUjYPT5Pi9nzUW3reHjl7tQ
         gsuIYAGu98TU/slpwfqFdMc9AGiRaBpWDfTs2VtDez9/8om7qiftuWKuaE3sAI+urdUX
         R+WEqPH0T+3GPvWZC5UirbEmc6LrAWwP5yqYfzeiu5bShl6My8qtR4zAD+ee9wvLN1Mt
         3qFhe4vN4+AokxCKWUI3ROZfuqsPYcC0/wFMCLxQ9M+bhdXUQWPUfirTP+clm0fQo4oi
         1sdw==
X-Gm-Message-State: APjAAAXSWv17mFHMoox3VjvDEeAOgZa8LPUvd4PLjUFL273KNY/hUJsz
        etfvjiQUeYPrtfmcSvvBbBiIvD2Wxt0=
X-Google-Smtp-Source: APXvYqzlCxptc8S22IztX7AOuPdcXX6/c3ZGSw+AQeay8uARf18y3rp9CZ+5we+d0cppTP/RFPvwsw==
X-Received: by 2002:adf:fb84:: with SMTP id a4mr2816484wrr.41.1561631300630;
        Thu, 27 Jun 2019 03:28:20 -0700 (PDT)
Received: from localhost.localdomain (aaubervilliers-681-1-8-173.w90-88.abo.wanadoo.fr. [90.88.13.173])
        by smtp.gmail.com with ESMTPSA id g2sm5584533wmh.0.2019.06.27.03.28.19
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 03:28:20 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v3 28/32] crypto: lib/aes - export sbox and inverse sbox
Date:   Thu, 27 Jun 2019 12:26:43 +0200
Message-Id: <20190627102647.2992-29-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627102647.2992-1-ard.biesheuvel@linaro.org>
References: <20190627102647.2992-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

There are a few copies of the AES S-boxes floating around, so export
the ones from the AES library so that we can reuse them in other
modules.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/crypto/aes.h | 3 +++
 lib/crypto/aes.c     | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/include/crypto/aes.h b/include/crypto/aes.h
index df8426fd8051..8e0f4cf948e5 100644
--- a/include/crypto/aes.h
+++ b/include/crypto/aes.h
@@ -67,4 +67,7 @@ void aes_encrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in);
  */
 void aes_decrypt(const struct crypto_aes_ctx *ctx, u8 *out, const u8 *in);
 
+extern const u8 crypto_aes_sbox[];
+extern const u8 crypto_aes_inv_sbox[];
+
 #endif
diff --git a/lib/crypto/aes.c b/lib/crypto/aes.c
index 9928b23e0a8a..467f0c35a0e0 100644
--- a/lib/crypto/aes.c
+++ b/lib/crypto/aes.c
@@ -82,6 +82,12 @@ static volatile const u8 __cacheline_aligned aes_inv_sbox[] = {
 	0xe1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0c, 0x7d,
 };
 
+extern const u8 crypto_aes_sbox[] __alias(aes_sbox);
+extern const u8 crypto_aes_inv_sbox[] __alias(aes_inv_sbox);
+
+EXPORT_SYMBOL(crypto_aes_sbox);
+EXPORT_SYMBOL(crypto_aes_inv_sbox);
+
 static u32 mul_by_x(u32 w)
 {
 	u32 x = w & 0x7f7f7f7f;
-- 
2.20.1

