Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45B5158062
	for <lists+linux-crypto@lfdr.de>; Thu, 27 Jun 2019 12:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfF0K21 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 27 Jun 2019 06:28:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43811 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726508AbfF0K21 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 27 Jun 2019 06:28:27 -0400
Received: by mail-wr1-f65.google.com with SMTP id p13so1901945wru.10
        for <linux-crypto@vger.kernel.org>; Thu, 27 Jun 2019 03:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4lc0G+siZ09AfrMnEtgKbgVUS7Kj+FyziWNUdbDRXLk=;
        b=fc+jtIn6IYU6NPWid6bB6S68xSHoEFE3Gh4BV2VII3662RVCVZy0onW6zfxIbjm23w
         Ud2+yAEIDk5130j2ucMOkQJaKqIp4LQwMQJf+MNbAxQLvVZFFCJdCk3ZqtDu1S27qcLo
         Locc1F4T2UNlXjuftpHv9w2ltSkZtjNLSGBZmHAaETg8AE8PP1y0CiTj4SQ0CjCVpL/b
         POQZ6fEPC/+INGNa1DNl/ApI+aHvA5bkXQpTQhXRnPc0EdBr934MhhW4BEm5+doYD/3K
         1MEn02e7WOZsjg+yfMZWdLRuCtUghw5QLhOkZO4yTbwp5J99wJ6l4RTOHmj+JCx14+/Q
         uxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4lc0G+siZ09AfrMnEtgKbgVUS7Kj+FyziWNUdbDRXLk=;
        b=IkQ93EscIBHyFBf4uSpJMPltV3UN3lzHUo8WGobmQkgyN8+DsjUDmE1SlUxynDAkk5
         SR5AycK5jXlZbPo94LgPuAjNOyQgeL9OhS7NxW9Q5QSX9kM1BO0h3EOIJdmog0bdW+46
         DL8JHXgoxbB0Zq26xXe4wlKaz9vo6SXyA51Gnt2hGMyC4JZqj4h1tqKpsqxvd468KDvv
         //X6GEw/PqMTOdmT0VvZCvVHc7BlP0DUbShb4kQo06ZpBZwLRbMCD8+SnBX/ZP5NmmPc
         OT2HkXNFP8lHkjBupg2K8ds3Zis7Q7vQRtLrBYYPC6LovIKMPERg8VzbH2Xa/KlM7oV2
         JjAA==
X-Gm-Message-State: APjAAAWbZEd132xLzxmkheW6bxqu6ZbFjone80lHK8FIKN3IX7ZkQI5L
        lTuRiJxTDiHU9qjkkiKvByCeq1XGPlo=
X-Google-Smtp-Source: APXvYqwtePYNJx+WqgiXVvkdnREurs6iXZi3g9bCNf9arZGQ264zgI3LVrULpcSsJvsodpOLhHjyHw==
X-Received: by 2002:a05:6000:112:: with SMTP id o18mr2793380wrx.153.1561631304993;
        Thu, 27 Jun 2019 03:28:24 -0700 (PDT)
Received: from localhost.localdomain (aaubervilliers-681-1-8-173.w90-88.abo.wanadoo.fr. [90.88.13.173])
        by smtp.gmail.com with ESMTPSA id g2sm5584533wmh.0.2019.06.27.03.28.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 03:28:24 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v3 32/32] crypto: arm/aes-scalar - unexport en/decryption routines
Date:   Thu, 27 Jun 2019 12:26:47 +0200
Message-Id: <20190627102647.2992-33-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627102647.2992-1-ard.biesheuvel@linaro.org>
References: <20190627102647.2992-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The scalar table based AES routines are not used by other drivers, so
let's keep it that way and unexport the symbols.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/crypto/aes-cipher-glue.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/crypto/aes-cipher-glue.c b/arch/arm/crypto/aes-cipher-glue.c
index f6c07867b8ff..26a2b81c2c12 100644
--- a/arch/arm/crypto/aes-cipher-glue.c
+++ b/arch/arm/crypto/aes-cipher-glue.c
@@ -14,10 +14,7 @@
 #include <linux/module.h>
 
 asmlinkage void __aes_arm_encrypt(u32 *rk, int rounds, const u8 *in, u8 *out);
-EXPORT_SYMBOL(__aes_arm_encrypt);
-
 asmlinkage void __aes_arm_decrypt(u32 *rk, int rounds, const u8 *in, u8 *out);
-EXPORT_SYMBOL(__aes_arm_decrypt);
 
 static void aes_arm_encrypt(struct crypto_tfm *tfm, u8 *out, const u8 *in)
 {
-- 
2.20.1

