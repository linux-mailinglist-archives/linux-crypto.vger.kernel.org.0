Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29E8D8235A
	for <lists+linux-crypto@lfdr.de>; Mon,  5 Aug 2019 19:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728935AbfHERBa (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 5 Aug 2019 13:01:30 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39434 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728871AbfHERBa (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 5 Aug 2019 13:01:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id x4so31968925wrt.6
        for <linux-crypto@vger.kernel.org>; Mon, 05 Aug 2019 10:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6M1f+n+9jHNDiBKrjrAwxjEkDG8P40fV2Q/ea83mMEM=;
        b=St6WmCG8nefGsebP0J3JjPh6ZBzWEmpmsFI+67FPfEnJ+5CfilnvMYeZ2UmDjAF95N
         O+iubhzS8tRaqeo2qtMiYaZLAal4NsZwS3PoDmCtXZQHZ+gvZqwy8bzI0q0tNt7eUuEw
         wvsZqMbpoQX4DNJau1vWoHI3kwbyELbUQFq2cG1LUzeUzo0KY4BbMAeKW2dk9/RLzQHv
         f5VoQw++HjJ7zzY+WuX6r+d67wmyyrkFEb2dN5EOv1T4Ixy+l1AjOH94T3BzMbTn5OGx
         sYddTvDGJbA8lu8L2OIutNT0Np9mhTE8HZQrHNHTL4Se5d51Thi0K/csyOv8rKAeRD3D
         KvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6M1f+n+9jHNDiBKrjrAwxjEkDG8P40fV2Q/ea83mMEM=;
        b=SpNr4xsEviGn71V7ZXEX5khkR84BCJif5Fzd7ADb2hjt5wagGw9VqUrPZ0DpoPYrT5
         VBiOquHWLKIETCZjLbQUm6bopLdh5O/xwQoTN6EgLdbMKz42WecEc/NtnR+UhrHiw+81
         jFqExHVE/H39RmSwryFnywavpG7n/G/cN1OLctToWMljKkeyquL9X2lodc/IPZzVUmwB
         oXBkGmn5RB3aSqico/FF8XNXyfp5uyJmoPUO75/RDtXYhL886iPo4Yz7PheqfPC3aQHs
         fd1ghceB/6osqm46WQ2B/rHRygC1xXJm0m+JtoD/++Kfqr/roJa2teFrDx8om36NOHPX
         3T1w==
X-Gm-Message-State: APjAAAUp0EblvEu0Qoi3MiGiq6NOZgwWst/kvYciqUpxc2KbF+yon6Ve
        w2v7okBBTmnPJmbyaZkfgaVM10tzEYqFWA==
X-Google-Smtp-Source: APXvYqw9UCCW6JzhfzPRES57+6bnSsVInUeZpxqR+2cEl3FxLYRpMj06xKuQxFl2i04ofsHGsoDydA==
X-Received: by 2002:adf:e883:: with SMTP id d3mr78057279wrm.330.1565024487991;
        Mon, 05 Aug 2019 10:01:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:587:a407:da00:582f:8334:9cd9:7241])
        by smtp.gmail.com with ESMTPSA id j9sm95669383wrn.81.2019.08.05.10.01.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Aug 2019 10:01:27 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org,
        horia.geanta@nxp.com, Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v4 08/30] crypto: nitrox/des - switch to new verification routines
Date:   Mon,  5 Aug 2019 20:00:15 +0300
Message-Id: <20190805170037.31330-9-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190805170037.31330-1-ard.biesheuvel@linaro.org>
References: <20190805170037.31330-1-ard.biesheuvel@linaro.org>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/crypto/cavium/nitrox/nitrox_skcipher.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/cavium/nitrox/nitrox_skcipher.c b/drivers/crypto/cavium/nitrox/nitrox_skcipher.c
index 7e4a5e69085e..9d3bd1b589e0 100644
--- a/drivers/crypto/cavium/nitrox/nitrox_skcipher.c
+++ b/drivers/crypto/cavium/nitrox/nitrox_skcipher.c
@@ -7,7 +7,7 @@
 #include <crypto/aes.h>
 #include <crypto/skcipher.h>
 #include <crypto/ctr.h>
-#include <crypto/des.h>
+#include <crypto/internal/des.h>
 #include <crypto/xts.h>
 
 #include "nitrox_dev.h"
@@ -257,7 +257,7 @@ static int nitrox_aes_decrypt(struct skcipher_request *skreq)
 static int nitrox_3des_setkey(struct crypto_skcipher *cipher,
 			      const u8 *key, unsigned int keylen)
 {
-	return unlikely(des3_verify_key(cipher, key)) ?:
+	return crypto_des3_ede_verify_key(crypto_skcipher_tfm(cipher), key) ?:
 	       nitrox_skcipher_setkey(cipher, 0, key, keylen);
 }
 
-- 
2.17.1

