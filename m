Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA7A558061
	for <lists+linux-crypto@lfdr.de>; Thu, 27 Jun 2019 12:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfF0K21 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 27 Jun 2019 06:28:27 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:36610 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726678AbfF0K20 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 27 Jun 2019 06:28:26 -0400
Received: by mail-wr1-f42.google.com with SMTP id n4so1935754wrs.3
        for <linux-crypto@vger.kernel.org>; Thu, 27 Jun 2019 03:28:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LgOxz3M+88gVu7JIGRNWNEXUFNxqJnrZXlO07MCiXP4=;
        b=ffLR9+B7GcB8IqxtWJlDizIKlinnoboJrNnyqRd1IMlSqNUg5dBUrDR2j51obEqx+P
         idgeEGkeN8ZtAIhat3fhEB03qmD2i/0ziqm14X1FFTB7EerGh5VDPMnT9iIvkrxtYqEd
         oXS3LcUthszwe1PC1s4VALHoWHHM6fXYdL8Zc4w7aFzNcUD/5vdVKEB64BFOhkl7RNcp
         DbmV7k8RPLWvDJQfzdlQLVIQuFY5ls2x+02nPo4oXPCe7X+nzyyQ04vhYOjuV9v0FdD/
         4NImUWNnhLUpLG2q2fyO9FkenF6OaZolSSIxPnH3L4bGpRYmhCEWo1TbgL4oAw/+gHx8
         EzAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LgOxz3M+88gVu7JIGRNWNEXUFNxqJnrZXlO07MCiXP4=;
        b=Y+s30LpkPQcOMN11lcHVIfOrzd70BSyHM0N46uRpmaOcqN77EXudoqkVGtHo6xFwmW
         A5gx/8dBC3v8mUqdC8GdXGEvgVtvVmNnbpAB1P+pn7PZvQZZYwbKDqPBf8wc/3J35yHG
         u5kyXsEtZr7dgRDoOSmI578ZmOh3Qcw5NTTfoCI/WcsgHnd9HHNLM4ggGjucXdlxF508
         y74ijOIuSP1soHqmwmoZh0d2z1KRR2tvNo9V2ZzhVLJwMA88TiKqVdlH38muattLiM8d
         zI/fSwGrYCYNrz8FzujxZ/tJDNf/LLSB3hYo5fMrzZPtzk25Xu/UXsjfCnu3/KEiS2Ek
         6PaQ==
X-Gm-Message-State: APjAAAX6xDWooGgho2jyb9vMe+A3eL9b5CE5MTO2dn+Ft9WUWHUU7Uqn
        hauIFxitpNR8EVSbu1lg7C+wwlAW0Kg=
X-Google-Smtp-Source: APXvYqy6BKK2hfKOvX5CpP3t3wZvWwqW6FTqAXfHvPDWOwrvKG17Cw+YgNRLle2yolDHihhTK02SLg==
X-Received: by 2002:adf:e806:: with SMTP id o6mr485789wrm.269.1561631303799;
        Thu, 27 Jun 2019 03:28:23 -0700 (PDT)
Received: from localhost.localdomain (aaubervilliers-681-1-8-173.w90-88.abo.wanadoo.fr. [90.88.13.173])
        by smtp.gmail.com with ESMTPSA id g2sm5584533wmh.0.2019.06.27.03.28.22
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 27 Jun 2019 03:28:23 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v3 31/32] crypto: arm64/aes-cipher - switch to shared AES inverse Sbox
Date:   Thu, 27 Jun 2019 12:26:46 +0200
Message-Id: <20190627102647.2992-32-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190627102647.2992-1-ard.biesheuvel@linaro.org>
References: <20190627102647.2992-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/crypto/aes-cipher-core.S | 40 +-------------------
 1 file changed, 1 insertion(+), 39 deletions(-)

diff --git a/arch/arm64/crypto/aes-cipher-core.S b/arch/arm64/crypto/aes-cipher-core.S
index 3a44eada2347..27dac259b359 100644
--- a/arch/arm64/crypto/aes-cipher-core.S
+++ b/arch/arm64/crypto/aes-cipher-core.S
@@ -131,43 +131,5 @@ ENDPROC(__aes_arm64_encrypt)
 
 	.align		5
 ENTRY(__aes_arm64_decrypt)
-	do_crypt	iround, crypto_it_tab, __aes_arm64_inverse_sbox, 0
+	do_crypt	iround, crypto_it_tab, crypto_aes_inv_sbox, 0
 ENDPROC(__aes_arm64_decrypt)
-
-	.section	".rodata", "a"
-	.align		L1_CACHE_SHIFT
-	.type		__aes_arm64_inverse_sbox, %object
-__aes_arm64_inverse_sbox:
-	.byte		0x52, 0x09, 0x6a, 0xd5, 0x30, 0x36, 0xa5, 0x38
-	.byte		0xbf, 0x40, 0xa3, 0x9e, 0x81, 0xf3, 0xd7, 0xfb
-	.byte		0x7c, 0xe3, 0x39, 0x82, 0x9b, 0x2f, 0xff, 0x87
-	.byte		0x34, 0x8e, 0x43, 0x44, 0xc4, 0xde, 0xe9, 0xcb
-	.byte		0x54, 0x7b, 0x94, 0x32, 0xa6, 0xc2, 0x23, 0x3d
-	.byte		0xee, 0x4c, 0x95, 0x0b, 0x42, 0xfa, 0xc3, 0x4e
-	.byte		0x08, 0x2e, 0xa1, 0x66, 0x28, 0xd9, 0x24, 0xb2
-	.byte		0x76, 0x5b, 0xa2, 0x49, 0x6d, 0x8b, 0xd1, 0x25
-	.byte		0x72, 0xf8, 0xf6, 0x64, 0x86, 0x68, 0x98, 0x16
-	.byte		0xd4, 0xa4, 0x5c, 0xcc, 0x5d, 0x65, 0xb6, 0x92
-	.byte		0x6c, 0x70, 0x48, 0x50, 0xfd, 0xed, 0xb9, 0xda
-	.byte		0x5e, 0x15, 0x46, 0x57, 0xa7, 0x8d, 0x9d, 0x84
-	.byte		0x90, 0xd8, 0xab, 0x00, 0x8c, 0xbc, 0xd3, 0x0a
-	.byte		0xf7, 0xe4, 0x58, 0x05, 0xb8, 0xb3, 0x45, 0x06
-	.byte		0xd0, 0x2c, 0x1e, 0x8f, 0xca, 0x3f, 0x0f, 0x02
-	.byte		0xc1, 0xaf, 0xbd, 0x03, 0x01, 0x13, 0x8a, 0x6b
-	.byte		0x3a, 0x91, 0x11, 0x41, 0x4f, 0x67, 0xdc, 0xea
-	.byte		0x97, 0xf2, 0xcf, 0xce, 0xf0, 0xb4, 0xe6, 0x73
-	.byte		0x96, 0xac, 0x74, 0x22, 0xe7, 0xad, 0x35, 0x85
-	.byte		0xe2, 0xf9, 0x37, 0xe8, 0x1c, 0x75, 0xdf, 0x6e
-	.byte		0x47, 0xf1, 0x1a, 0x71, 0x1d, 0x29, 0xc5, 0x89
-	.byte		0x6f, 0xb7, 0x62, 0x0e, 0xaa, 0x18, 0xbe, 0x1b
-	.byte		0xfc, 0x56, 0x3e, 0x4b, 0xc6, 0xd2, 0x79, 0x20
-	.byte		0x9a, 0xdb, 0xc0, 0xfe, 0x78, 0xcd, 0x5a, 0xf4
-	.byte		0x1f, 0xdd, 0xa8, 0x33, 0x88, 0x07, 0xc7, 0x31
-	.byte		0xb1, 0x12, 0x10, 0x59, 0x27, 0x80, 0xec, 0x5f
-	.byte		0x60, 0x51, 0x7f, 0xa9, 0x19, 0xb5, 0x4a, 0x0d
-	.byte		0x2d, 0xe5, 0x7a, 0x9f, 0x93, 0xc9, 0x9c, 0xef
-	.byte		0xa0, 0xe0, 0x3b, 0x4d, 0xae, 0x2a, 0xf5, 0xb0
-	.byte		0xc8, 0xeb, 0xbb, 0x3c, 0x83, 0x53, 0x99, 0x61
-	.byte		0x17, 0x2b, 0x04, 0x7e, 0xba, 0x77, 0xd6, 0x26
-	.byte		0xe1, 0x69, 0x14, 0x63, 0x55, 0x21, 0x0c, 0x7d
-	.size		__aes_arm64_inverse_sbox, . - __aes_arm64_inverse_sbox
-- 
2.20.1

