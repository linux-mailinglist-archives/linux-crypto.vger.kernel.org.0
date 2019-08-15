Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 167BB8E7B4
	for <lists+linux-crypto@lfdr.de>; Thu, 15 Aug 2019 11:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730559AbfHOJCW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 15 Aug 2019 05:02:22 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40106 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730822AbfHOJCV (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 15 Aug 2019 05:02:21 -0400
Received: by mail-wr1-f65.google.com with SMTP id c3so1586715wrd.7
        for <linux-crypto@vger.kernel.org>; Thu, 15 Aug 2019 02:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=EQD3Yz4/E/hQa6m3ot8YrbybVAaA2KIMFOZXweyBf7Q=;
        b=moGsEtFEoDDfDOOAyEnKBXMBanpzvbN+N89CCLBz56SCnHsgDlQh3sSgW5dOuvc2Pn
         /URF3Pa5Bv3pLYXYQ9Rq5bdbf15WNi/zkB2D/b+nLMjKw+TjIbJSgAuF0nt5HUsGNnGG
         O2tG8ostalyEiEztNjbSWBWyZ4cqpY2X30JwwL2GXzhJItsIXiNT8Kzw4+UVcT1cCRkH
         28Ygs2RGs9J1kyrq4Sm9LBcRbu2fM6v3opS+rhiYZAHbCE4AycjdY04FRRw3vLDwWUWP
         BCrG5HjnyMDM/ekUpN8iXNfOGe6yd1S4QKv6a8S7iYWkttTLSuizDn/pMCX2Mll/zxEo
         AOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EQD3Yz4/E/hQa6m3ot8YrbybVAaA2KIMFOZXweyBf7Q=;
        b=atmgxYrBLCSu8H7NmNCoX3eJYKj+OLWjB3S6pAP71s9pxxCIQh/PrO1B4QnLzbapFx
         FdpLRgHlCYFGK9/jG66NRHUpXYw5MYlpD3hT1Q0SOYltq72RGiBQXoF2FtgY7l08nbLb
         8Ya5a010vJ1cjNL2hWyHd8sBRvIhvp7621pHIWXdTR0/nk2Ezzl/Imf7jIgJdqXbFkEj
         mT1nQOQBwOwSNDhUjlQ6VBlx00+QwnApK65qwnxjxlxcf3ztMkJww3t2bDritp41JbJ3
         Qw6n5N0fP3XEy1yY7vFl3Zz9GuBteQV4r/o6jOSy2LX8Z1lZb3DYTYwHzT93mdh0Y1aN
         AXCQ==
X-Gm-Message-State: APjAAAWZfZxZDDFwsDCES2Tgrz4PO/2BZJ3lLaB0/gwR4PWb9CQvQInm
        eTkdY8Hj7Bn6uk8YH6TY1jsQLvhuzGWds0Je
X-Google-Smtp-Source: APXvYqzTbPlHx9RBMZ9D8UoGi3Kezmsf0VdSIuNki76q/Ne2QzJmes7QYwtLAmCgU2s8a+0luj5bfA==
X-Received: by 2002:a5d:4108:: with SMTP id l8mr4201135wrp.113.1565859734018;
        Thu, 15 Aug 2019 02:02:14 -0700 (PDT)
Received: from localhost.localdomain ([2a02:587:a407:da00:f1b5:e68c:5f7f:79e7])
        by smtp.gmail.com with ESMTPSA id x20sm3857533wrg.10.2019.08.15.02.02.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Aug 2019 02:02:13 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v5 27/30] crypto: des - split off DES library from generic DES cipher driver
Date:   Thu, 15 Aug 2019 12:01:09 +0300
Message-Id: <20190815090112.9377-28-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190815090112.9377-1-ard.biesheuvel@linaro.org>
References: <20190815090112.9377-1-ard.biesheuvel@linaro.org>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Another one for the cipher museum: split off DES core processing into
a separate module so other drivers (mostly for crypto accelerators)
can reuse the code without pulling in the generic DES cipher itself.
This will also permit the cipher interface to be made private to the
crypto API itself once we move the only user in the kernel (CIFS) to
this library interface.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/crypto/des3_ede_glue.c                |   2 +-
 crypto/Kconfig                                 |   8 +-
 crypto/des_generic.c                           | 917 +-------------------
 drivers/crypto/Kconfig                         |  28 +-
 drivers/crypto/caam/Kconfig                    |   2 +-
 drivers/crypto/cavium/nitrox/Kconfig           |   2 +-
 drivers/crypto/inside-secure/safexcel_cipher.c |   2 +-
 drivers/crypto/stm32/Kconfig                   |   2 +-
 drivers/crypto/ux500/Kconfig                   |   2 +-
 include/crypto/des.h                           |  43 +-
 include/crypto/internal/des.h                  |  69 +-
 lib/crypto/Makefile                            |   3 +
 lib/crypto/des.c                               | 902 +++++++++++++++++++
 13 files changed, 1053 insertions(+), 929 deletions(-)

diff --git a/arch/x86/crypto/des3_ede_glue.c b/arch/x86/crypto/des3_ede_glue.c
index ec608babc22b..f730a312ce35 100644
--- a/arch/x86/crypto/des3_ede_glue.c
+++ b/arch/x86/crypto/des3_ede_glue.c
@@ -11,7 +11,7 @@
  */
 
 #include <crypto/algapi.h>
-#include <crypto/des.h>
+#include <crypto/internal/des.h>
 #include <crypto/internal/skcipher.h>
 #include <linux/crypto.h>
 #include <linux/init.h>
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 8880c1fc51d8..6e01525edad3 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1301,9 +1301,13 @@ config CRYPTO_CAST6_AVX_X86_64
 	  This module provides the Cast6 cipher algorithm that processes
 	  eight blocks parallel using the AVX instruction set.
 
+config CRYPTO_LIB_DES
+	tristate
+
 config CRYPTO_DES
 	tristate "DES and Triple DES EDE cipher algorithms"
 	select CRYPTO_ALGAPI
+	select CRYPTO_LIB_DES
 	help
 	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3).
 
@@ -1311,7 +1315,7 @@ config CRYPTO_DES_SPARC64
 	tristate "DES and Triple DES EDE cipher algorithms (SPARC64)"
 	depends on SPARC64
 	select CRYPTO_ALGAPI
-	select CRYPTO_DES
+	select CRYPTO_LIB_DES
 	help
 	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3),
 	  optimized using SPARC64 crypto opcodes.
@@ -1320,7 +1324,7 @@ config CRYPTO_DES3_EDE_X86_64
 	tristate "Triple DES EDE cipher algorithm (x86-64)"
 	depends on X86 && 64BIT
 	select CRYPTO_BLKCIPHER
-	select CRYPTO_DES
+	select CRYPTO_LIB_DES
 	help
 	  Triple DES EDE (FIPS 46-3) algorithm.
 
diff --git a/crypto/des_generic.c b/crypto/des_generic.c
index f15ae7660f1b..e021a321f584 100644
--- a/crypto/des_generic.c
+++ b/crypto/des_generic.c
@@ -13,832 +13,42 @@
 #include <linux/module.h>
 #include <linux/errno.h>
 #include <linux/crypto.h>
-#include <linux/types.h>
 
-#include <crypto/des.h>
-
-#define ROL(x, r) ((x) = rol32((x), (r)))
-#define ROR(x, r) ((x) = ror32((x), (r)))
-
-struct des_ctx {
-	u32 expkey[DES_EXPKEY_WORDS];
-};
-
-struct des3_ede_ctx {
-	u32 expkey[DES3_EDE_EXPKEY_WORDS];
-};
-
-/* Lookup tables for key expansion */
-
-static const u8 pc1[256] = {
-	0x00, 0x00, 0x40, 0x04, 0x10, 0x10, 0x50, 0x14,
-	0x04, 0x40, 0x44, 0x44, 0x14, 0x50, 0x54, 0x54,
-	0x02, 0x02, 0x42, 0x06, 0x12, 0x12, 0x52, 0x16,
-	0x06, 0x42, 0x46, 0x46, 0x16, 0x52, 0x56, 0x56,
-	0x80, 0x08, 0xc0, 0x0c, 0x90, 0x18, 0xd0, 0x1c,
-	0x84, 0x48, 0xc4, 0x4c, 0x94, 0x58, 0xd4, 0x5c,
-	0x82, 0x0a, 0xc2, 0x0e, 0x92, 0x1a, 0xd2, 0x1e,
-	0x86, 0x4a, 0xc6, 0x4e, 0x96, 0x5a, 0xd6, 0x5e,
-	0x20, 0x20, 0x60, 0x24, 0x30, 0x30, 0x70, 0x34,
-	0x24, 0x60, 0x64, 0x64, 0x34, 0x70, 0x74, 0x74,
-	0x22, 0x22, 0x62, 0x26, 0x32, 0x32, 0x72, 0x36,
-	0x26, 0x62, 0x66, 0x66, 0x36, 0x72, 0x76, 0x76,
-	0xa0, 0x28, 0xe0, 0x2c, 0xb0, 0x38, 0xf0, 0x3c,
-	0xa4, 0x68, 0xe4, 0x6c, 0xb4, 0x78, 0xf4, 0x7c,
-	0xa2, 0x2a, 0xe2, 0x2e, 0xb2, 0x3a, 0xf2, 0x3e,
-	0xa6, 0x6a, 0xe6, 0x6e, 0xb6, 0x7a, 0xf6, 0x7e,
-	0x08, 0x80, 0x48, 0x84, 0x18, 0x90, 0x58, 0x94,
-	0x0c, 0xc0, 0x4c, 0xc4, 0x1c, 0xd0, 0x5c, 0xd4,
-	0x0a, 0x82, 0x4a, 0x86, 0x1a, 0x92, 0x5a, 0x96,
-	0x0e, 0xc2, 0x4e, 0xc6, 0x1e, 0xd2, 0x5e, 0xd6,
-	0x88, 0x88, 0xc8, 0x8c, 0x98, 0x98, 0xd8, 0x9c,
-	0x8c, 0xc8, 0xcc, 0xcc, 0x9c, 0xd8, 0xdc, 0xdc,
-	0x8a, 0x8a, 0xca, 0x8e, 0x9a, 0x9a, 0xda, 0x9e,
-	0x8e, 0xca, 0xce, 0xce, 0x9e, 0xda, 0xde, 0xde,
-	0x28, 0xa0, 0x68, 0xa4, 0x38, 0xb0, 0x78, 0xb4,
-	0x2c, 0xe0, 0x6c, 0xe4, 0x3c, 0xf0, 0x7c, 0xf4,
-	0x2a, 0xa2, 0x6a, 0xa6, 0x3a, 0xb2, 0x7a, 0xb6,
-	0x2e, 0xe2, 0x6e, 0xe6, 0x3e, 0xf2, 0x7e, 0xf6,
-	0xa8, 0xa8, 0xe8, 0xac, 0xb8, 0xb8, 0xf8, 0xbc,
-	0xac, 0xe8, 0xec, 0xec, 0xbc, 0xf8, 0xfc, 0xfc,
-	0xaa, 0xaa, 0xea, 0xae, 0xba, 0xba, 0xfa, 0xbe,
-	0xae, 0xea, 0xee, 0xee, 0xbe, 0xfa, 0xfe, 0xfe
-};
-
-static const u8 rs[256] = {
-	0x00, 0x00, 0x80, 0x80, 0x02, 0x02, 0x82, 0x82,
-	0x04, 0x04, 0x84, 0x84, 0x06, 0x06, 0x86, 0x86,
-	0x08, 0x08, 0x88, 0x88, 0x0a, 0x0a, 0x8a, 0x8a,
-	0x0c, 0x0c, 0x8c, 0x8c, 0x0e, 0x0e, 0x8e, 0x8e,
-	0x10, 0x10, 0x90, 0x90, 0x12, 0x12, 0x92, 0x92,
-	0x14, 0x14, 0x94, 0x94, 0x16, 0x16, 0x96, 0x96,
-	0x18, 0x18, 0x98, 0x98, 0x1a, 0x1a, 0x9a, 0x9a,
-	0x1c, 0x1c, 0x9c, 0x9c, 0x1e, 0x1e, 0x9e, 0x9e,
-	0x20, 0x20, 0xa0, 0xa0, 0x22, 0x22, 0xa2, 0xa2,
-	0x24, 0x24, 0xa4, 0xa4, 0x26, 0x26, 0xa6, 0xa6,
-	0x28, 0x28, 0xa8, 0xa8, 0x2a, 0x2a, 0xaa, 0xaa,
-	0x2c, 0x2c, 0xac, 0xac, 0x2e, 0x2e, 0xae, 0xae,
-	0x30, 0x30, 0xb0, 0xb0, 0x32, 0x32, 0xb2, 0xb2,
-	0x34, 0x34, 0xb4, 0xb4, 0x36, 0x36, 0xb6, 0xb6,
-	0x38, 0x38, 0xb8, 0xb8, 0x3a, 0x3a, 0xba, 0xba,
-	0x3c, 0x3c, 0xbc, 0xbc, 0x3e, 0x3e, 0xbe, 0xbe,
-	0x40, 0x40, 0xc0, 0xc0, 0x42, 0x42, 0xc2, 0xc2,
-	0x44, 0x44, 0xc4, 0xc4, 0x46, 0x46, 0xc6, 0xc6,
-	0x48, 0x48, 0xc8, 0xc8, 0x4a, 0x4a, 0xca, 0xca,
-	0x4c, 0x4c, 0xcc, 0xcc, 0x4e, 0x4e, 0xce, 0xce,
-	0x50, 0x50, 0xd0, 0xd0, 0x52, 0x52, 0xd2, 0xd2,
-	0x54, 0x54, 0xd4, 0xd4, 0x56, 0x56, 0xd6, 0xd6,
-	0x58, 0x58, 0xd8, 0xd8, 0x5a, 0x5a, 0xda, 0xda,
-	0x5c, 0x5c, 0xdc, 0xdc, 0x5e, 0x5e, 0xde, 0xde,
-	0x60, 0x60, 0xe0, 0xe0, 0x62, 0x62, 0xe2, 0xe2,
-	0x64, 0x64, 0xe4, 0xe4, 0x66, 0x66, 0xe6, 0xe6,
-	0x68, 0x68, 0xe8, 0xe8, 0x6a, 0x6a, 0xea, 0xea,
-	0x6c, 0x6c, 0xec, 0xec, 0x6e, 0x6e, 0xee, 0xee,
-	0x70, 0x70, 0xf0, 0xf0, 0x72, 0x72, 0xf2, 0xf2,
-	0x74, 0x74, 0xf4, 0xf4, 0x76, 0x76, 0xf6, 0xf6,
-	0x78, 0x78, 0xf8, 0xf8, 0x7a, 0x7a, 0xfa, 0xfa,
-	0x7c, 0x7c, 0xfc, 0xfc, 0x7e, 0x7e, 0xfe, 0xfe
-};
-
-static const u32 pc2[1024] = {
-	0x00000000, 0x00000000, 0x00000000, 0x00000000,
-	0x00040000, 0x00000000, 0x04000000, 0x00100000,
-	0x00400000, 0x00000008, 0x00000800, 0x40000000,
-	0x00440000, 0x00000008, 0x04000800, 0x40100000,
-	0x00000400, 0x00000020, 0x08000000, 0x00000100,
-	0x00040400, 0x00000020, 0x0c000000, 0x00100100,
-	0x00400400, 0x00000028, 0x08000800, 0x40000100,
-	0x00440400, 0x00000028, 0x0c000800, 0x40100100,
-	0x80000000, 0x00000010, 0x00000000, 0x00800000,
-	0x80040000, 0x00000010, 0x04000000, 0x00900000,
-	0x80400000, 0x00000018, 0x00000800, 0x40800000,
-	0x80440000, 0x00000018, 0x04000800, 0x40900000,
-	0x80000400, 0x00000030, 0x08000000, 0x00800100,
-	0x80040400, 0x00000030, 0x0c000000, 0x00900100,
-	0x80400400, 0x00000038, 0x08000800, 0x40800100,
-	0x80440400, 0x00000038, 0x0c000800, 0x40900100,
-	0x10000000, 0x00000000, 0x00200000, 0x00001000,
-	0x10040000, 0x00000000, 0x04200000, 0x00101000,
-	0x10400000, 0x00000008, 0x00200800, 0x40001000,
-	0x10440000, 0x00000008, 0x04200800, 0x40101000,
-	0x10000400, 0x00000020, 0x08200000, 0x00001100,
-	0x10040400, 0x00000020, 0x0c200000, 0x00101100,
-	0x10400400, 0x00000028, 0x08200800, 0x40001100,
-	0x10440400, 0x00000028, 0x0c200800, 0x40101100,
-	0x90000000, 0x00000010, 0x00200000, 0x00801000,
-	0x90040000, 0x00000010, 0x04200000, 0x00901000,
-	0x90400000, 0x00000018, 0x00200800, 0x40801000,
-	0x90440000, 0x00000018, 0x04200800, 0x40901000,
-	0x90000400, 0x00000030, 0x08200000, 0x00801100,
-	0x90040400, 0x00000030, 0x0c200000, 0x00901100,
-	0x90400400, 0x00000038, 0x08200800, 0x40801100,
-	0x90440400, 0x00000038, 0x0c200800, 0x40901100,
-	0x00000200, 0x00080000, 0x00000000, 0x00000004,
-	0x00040200, 0x00080000, 0x04000000, 0x00100004,
-	0x00400200, 0x00080008, 0x00000800, 0x40000004,
-	0x00440200, 0x00080008, 0x04000800, 0x40100004,
-	0x00000600, 0x00080020, 0x08000000, 0x00000104,
-	0x00040600, 0x00080020, 0x0c000000, 0x00100104,
-	0x00400600, 0x00080028, 0x08000800, 0x40000104,
-	0x00440600, 0x00080028, 0x0c000800, 0x40100104,
-	0x80000200, 0x00080010, 0x00000000, 0x00800004,
-	0x80040200, 0x00080010, 0x04000000, 0x00900004,
-	0x80400200, 0x00080018, 0x00000800, 0x40800004,
-	0x80440200, 0x00080018, 0x04000800, 0x40900004,
-	0x80000600, 0x00080030, 0x08000000, 0x00800104,
-	0x80040600, 0x00080030, 0x0c000000, 0x00900104,
-	0x80400600, 0x00080038, 0x08000800, 0x40800104,
-	0x80440600, 0x00080038, 0x0c000800, 0x40900104,
-	0x10000200, 0x00080000, 0x00200000, 0x00001004,
-	0x10040200, 0x00080000, 0x04200000, 0x00101004,
-	0x10400200, 0x00080008, 0x00200800, 0x40001004,
-	0x10440200, 0x00080008, 0x04200800, 0x40101004,
-	0x10000600, 0x00080020, 0x08200000, 0x00001104,
-	0x10040600, 0x00080020, 0x0c200000, 0x00101104,
-	0x10400600, 0x00080028, 0x08200800, 0x40001104,
-	0x10440600, 0x00080028, 0x0c200800, 0x40101104,
-	0x90000200, 0x00080010, 0x00200000, 0x00801004,
-	0x90040200, 0x00080010, 0x04200000, 0x00901004,
-	0x90400200, 0x00080018, 0x00200800, 0x40801004,
-	0x90440200, 0x00080018, 0x04200800, 0x40901004,
-	0x90000600, 0x00080030, 0x08200000, 0x00801104,
-	0x90040600, 0x00080030, 0x0c200000, 0x00901104,
-	0x90400600, 0x00080038, 0x08200800, 0x40801104,
-	0x90440600, 0x00080038, 0x0c200800, 0x40901104,
-	0x00000002, 0x00002000, 0x20000000, 0x00000001,
-	0x00040002, 0x00002000, 0x24000000, 0x00100001,
-	0x00400002, 0x00002008, 0x20000800, 0x40000001,
-	0x00440002, 0x00002008, 0x24000800, 0x40100001,
-	0x00000402, 0x00002020, 0x28000000, 0x00000101,
-	0x00040402, 0x00002020, 0x2c000000, 0x00100101,
-	0x00400402, 0x00002028, 0x28000800, 0x40000101,
-	0x00440402, 0x00002028, 0x2c000800, 0x40100101,
-	0x80000002, 0x00002010, 0x20000000, 0x00800001,
-	0x80040002, 0x00002010, 0x24000000, 0x00900001,
-	0x80400002, 0x00002018, 0x20000800, 0x40800001,
-	0x80440002, 0x00002018, 0x24000800, 0x40900001,
-	0x80000402, 0x00002030, 0x28000000, 0x00800101,
-	0x80040402, 0x00002030, 0x2c000000, 0x00900101,
-	0x80400402, 0x00002038, 0x28000800, 0x40800101,
-	0x80440402, 0x00002038, 0x2c000800, 0x40900101,
-	0x10000002, 0x00002000, 0x20200000, 0x00001001,
-	0x10040002, 0x00002000, 0x24200000, 0x00101001,
-	0x10400002, 0x00002008, 0x20200800, 0x40001001,
-	0x10440002, 0x00002008, 0x24200800, 0x40101001,
-	0x10000402, 0x00002020, 0x28200000, 0x00001101,
-	0x10040402, 0x00002020, 0x2c200000, 0x00101101,
-	0x10400402, 0x00002028, 0x28200800, 0x40001101,
-	0x10440402, 0x00002028, 0x2c200800, 0x40101101,
-	0x90000002, 0x00002010, 0x20200000, 0x00801001,
-	0x90040002, 0x00002010, 0x24200000, 0x00901001,
-	0x90400002, 0x00002018, 0x20200800, 0x40801001,
-	0x90440002, 0x00002018, 0x24200800, 0x40901001,
-	0x90000402, 0x00002030, 0x28200000, 0x00801101,
-	0x90040402, 0x00002030, 0x2c200000, 0x00901101,
-	0x90400402, 0x00002038, 0x28200800, 0x40801101,
-	0x90440402, 0x00002038, 0x2c200800, 0x40901101,
-	0x00000202, 0x00082000, 0x20000000, 0x00000005,
-	0x00040202, 0x00082000, 0x24000000, 0x00100005,
-	0x00400202, 0x00082008, 0x20000800, 0x40000005,
-	0x00440202, 0x00082008, 0x24000800, 0x40100005,
-	0x00000602, 0x00082020, 0x28000000, 0x00000105,
-	0x00040602, 0x00082020, 0x2c000000, 0x00100105,
-	0x00400602, 0x00082028, 0x28000800, 0x40000105,
-	0x00440602, 0x00082028, 0x2c000800, 0x40100105,
-	0x80000202, 0x00082010, 0x20000000, 0x00800005,
-	0x80040202, 0x00082010, 0x24000000, 0x00900005,
-	0x80400202, 0x00082018, 0x20000800, 0x40800005,
-	0x80440202, 0x00082018, 0x24000800, 0x40900005,
-	0x80000602, 0x00082030, 0x28000000, 0x00800105,
-	0x80040602, 0x00082030, 0x2c000000, 0x00900105,
-	0x80400602, 0x00082038, 0x28000800, 0x40800105,
-	0x80440602, 0x00082038, 0x2c000800, 0x40900105,
-	0x10000202, 0x00082000, 0x20200000, 0x00001005,
-	0x10040202, 0x00082000, 0x24200000, 0x00101005,
-	0x10400202, 0x00082008, 0x20200800, 0x40001005,
-	0x10440202, 0x00082008, 0x24200800, 0x40101005,
-	0x10000602, 0x00082020, 0x28200000, 0x00001105,
-	0x10040602, 0x00082020, 0x2c200000, 0x00101105,
-	0x10400602, 0x00082028, 0x28200800, 0x40001105,
-	0x10440602, 0x00082028, 0x2c200800, 0x40101105,
-	0x90000202, 0x00082010, 0x20200000, 0x00801005,
-	0x90040202, 0x00082010, 0x24200000, 0x00901005,
-	0x90400202, 0x00082018, 0x20200800, 0x40801005,
-	0x90440202, 0x00082018, 0x24200800, 0x40901005,
-	0x90000602, 0x00082030, 0x28200000, 0x00801105,
-	0x90040602, 0x00082030, 0x2c200000, 0x00901105,
-	0x90400602, 0x00082038, 0x28200800, 0x40801105,
-	0x90440602, 0x00082038, 0x2c200800, 0x40901105,
-
-	0x00000000, 0x00000000, 0x00000000, 0x00000000,
-	0x00000000, 0x00000008, 0x00080000, 0x10000000,
-	0x02000000, 0x00000000, 0x00000080, 0x00001000,
-	0x02000000, 0x00000008, 0x00080080, 0x10001000,
-	0x00004000, 0x00000000, 0x00000040, 0x00040000,
-	0x00004000, 0x00000008, 0x00080040, 0x10040000,
-	0x02004000, 0x00000000, 0x000000c0, 0x00041000,
-	0x02004000, 0x00000008, 0x000800c0, 0x10041000,
-	0x00020000, 0x00008000, 0x08000000, 0x00200000,
-	0x00020000, 0x00008008, 0x08080000, 0x10200000,
-	0x02020000, 0x00008000, 0x08000080, 0x00201000,
-	0x02020000, 0x00008008, 0x08080080, 0x10201000,
-	0x00024000, 0x00008000, 0x08000040, 0x00240000,
-	0x00024000, 0x00008008, 0x08080040, 0x10240000,
-	0x02024000, 0x00008000, 0x080000c0, 0x00241000,
-	0x02024000, 0x00008008, 0x080800c0, 0x10241000,
-	0x00000000, 0x01000000, 0x00002000, 0x00000020,
-	0x00000000, 0x01000008, 0x00082000, 0x10000020,
-	0x02000000, 0x01000000, 0x00002080, 0x00001020,
-	0x02000000, 0x01000008, 0x00082080, 0x10001020,
-	0x00004000, 0x01000000, 0x00002040, 0x00040020,
-	0x00004000, 0x01000008, 0x00082040, 0x10040020,
-	0x02004000, 0x01000000, 0x000020c0, 0x00041020,
-	0x02004000, 0x01000008, 0x000820c0, 0x10041020,
-	0x00020000, 0x01008000, 0x08002000, 0x00200020,
-	0x00020000, 0x01008008, 0x08082000, 0x10200020,
-	0x02020000, 0x01008000, 0x08002080, 0x00201020,
-	0x02020000, 0x01008008, 0x08082080, 0x10201020,
-	0x00024000, 0x01008000, 0x08002040, 0x00240020,
-	0x00024000, 0x01008008, 0x08082040, 0x10240020,
-	0x02024000, 0x01008000, 0x080020c0, 0x00241020,
-	0x02024000, 0x01008008, 0x080820c0, 0x10241020,
-	0x00000400, 0x04000000, 0x00100000, 0x00000004,
-	0x00000400, 0x04000008, 0x00180000, 0x10000004,
-	0x02000400, 0x04000000, 0x00100080, 0x00001004,
-	0x02000400, 0x04000008, 0x00180080, 0x10001004,
-	0x00004400, 0x04000000, 0x00100040, 0x00040004,
-	0x00004400, 0x04000008, 0x00180040, 0x10040004,
-	0x02004400, 0x04000000, 0x001000c0, 0x00041004,
-	0x02004400, 0x04000008, 0x001800c0, 0x10041004,
-	0x00020400, 0x04008000, 0x08100000, 0x00200004,
-	0x00020400, 0x04008008, 0x08180000, 0x10200004,
-	0x02020400, 0x04008000, 0x08100080, 0x00201004,
-	0x02020400, 0x04008008, 0x08180080, 0x10201004,
-	0x00024400, 0x04008000, 0x08100040, 0x00240004,
-	0x00024400, 0x04008008, 0x08180040, 0x10240004,
-	0x02024400, 0x04008000, 0x081000c0, 0x00241004,
-	0x02024400, 0x04008008, 0x081800c0, 0x10241004,
-	0x00000400, 0x05000000, 0x00102000, 0x00000024,
-	0x00000400, 0x05000008, 0x00182000, 0x10000024,
-	0x02000400, 0x05000000, 0x00102080, 0x00001024,
-	0x02000400, 0x05000008, 0x00182080, 0x10001024,
-	0x00004400, 0x05000000, 0x00102040, 0x00040024,
-	0x00004400, 0x05000008, 0x00182040, 0x10040024,
-	0x02004400, 0x05000000, 0x001020c0, 0x00041024,
-	0x02004400, 0x05000008, 0x001820c0, 0x10041024,
-	0x00020400, 0x05008000, 0x08102000, 0x00200024,
-	0x00020400, 0x05008008, 0x08182000, 0x10200024,
-	0x02020400, 0x05008000, 0x08102080, 0x00201024,
-	0x02020400, 0x05008008, 0x08182080, 0x10201024,
-	0x00024400, 0x05008000, 0x08102040, 0x00240024,
-	0x00024400, 0x05008008, 0x08182040, 0x10240024,
-	0x02024400, 0x05008000, 0x081020c0, 0x00241024,
-	0x02024400, 0x05008008, 0x081820c0, 0x10241024,
-	0x00000800, 0x00010000, 0x20000000, 0x00000010,
-	0x00000800, 0x00010008, 0x20080000, 0x10000010,
-	0x02000800, 0x00010000, 0x20000080, 0x00001010,
-	0x02000800, 0x00010008, 0x20080080, 0x10001010,
-	0x00004800, 0x00010000, 0x20000040, 0x00040010,
-	0x00004800, 0x00010008, 0x20080040, 0x10040010,
-	0x02004800, 0x00010000, 0x200000c0, 0x00041010,
-	0x02004800, 0x00010008, 0x200800c0, 0x10041010,
-	0x00020800, 0x00018000, 0x28000000, 0x00200010,
-	0x00020800, 0x00018008, 0x28080000, 0x10200010,
-	0x02020800, 0x00018000, 0x28000080, 0x00201010,
-	0x02020800, 0x00018008, 0x28080080, 0x10201010,
-	0x00024800, 0x00018000, 0x28000040, 0x00240010,
-	0x00024800, 0x00018008, 0x28080040, 0x10240010,
-	0x02024800, 0x00018000, 0x280000c0, 0x00241010,
-	0x02024800, 0x00018008, 0x280800c0, 0x10241010,
-	0x00000800, 0x01010000, 0x20002000, 0x00000030,
-	0x00000800, 0x01010008, 0x20082000, 0x10000030,
-	0x02000800, 0x01010000, 0x20002080, 0x00001030,
-	0x02000800, 0x01010008, 0x20082080, 0x10001030,
-	0x00004800, 0x01010000, 0x20002040, 0x00040030,
-	0x00004800, 0x01010008, 0x20082040, 0x10040030,
-	0x02004800, 0x01010000, 0x200020c0, 0x00041030,
-	0x02004800, 0x01010008, 0x200820c0, 0x10041030,
-	0x00020800, 0x01018000, 0x28002000, 0x00200030,
-	0x00020800, 0x01018008, 0x28082000, 0x10200030,
-	0x02020800, 0x01018000, 0x28002080, 0x00201030,
-	0x02020800, 0x01018008, 0x28082080, 0x10201030,
-	0x00024800, 0x01018000, 0x28002040, 0x00240030,
-	0x00024800, 0x01018008, 0x28082040, 0x10240030,
-	0x02024800, 0x01018000, 0x280020c0, 0x00241030,
-	0x02024800, 0x01018008, 0x280820c0, 0x10241030,
-	0x00000c00, 0x04010000, 0x20100000, 0x00000014,
-	0x00000c00, 0x04010008, 0x20180000, 0x10000014,
-	0x02000c00, 0x04010000, 0x20100080, 0x00001014,
-	0x02000c00, 0x04010008, 0x20180080, 0x10001014,
-	0x00004c00, 0x04010000, 0x20100040, 0x00040014,
-	0x00004c00, 0x04010008, 0x20180040, 0x10040014,
-	0x02004c00, 0x04010000, 0x201000c0, 0x00041014,
-	0x02004c00, 0x04010008, 0x201800c0, 0x10041014,
-	0x00020c00, 0x04018000, 0x28100000, 0x00200014,
-	0x00020c00, 0x04018008, 0x28180000, 0x10200014,
-	0x02020c00, 0x04018000, 0x28100080, 0x00201014,
-	0x02020c00, 0x04018008, 0x28180080, 0x10201014,
-	0x00024c00, 0x04018000, 0x28100040, 0x00240014,
-	0x00024c00, 0x04018008, 0x28180040, 0x10240014,
-	0x02024c00, 0x04018000, 0x281000c0, 0x00241014,
-	0x02024c00, 0x04018008, 0x281800c0, 0x10241014,
-	0x00000c00, 0x05010000, 0x20102000, 0x00000034,
-	0x00000c00, 0x05010008, 0x20182000, 0x10000034,
-	0x02000c00, 0x05010000, 0x20102080, 0x00001034,
-	0x02000c00, 0x05010008, 0x20182080, 0x10001034,
-	0x00004c00, 0x05010000, 0x20102040, 0x00040034,
-	0x00004c00, 0x05010008, 0x20182040, 0x10040034,
-	0x02004c00, 0x05010000, 0x201020c0, 0x00041034,
-	0x02004c00, 0x05010008, 0x201820c0, 0x10041034,
-	0x00020c00, 0x05018000, 0x28102000, 0x00200034,
-	0x00020c00, 0x05018008, 0x28182000, 0x10200034,
-	0x02020c00, 0x05018000, 0x28102080, 0x00201034,
-	0x02020c00, 0x05018008, 0x28182080, 0x10201034,
-	0x00024c00, 0x05018000, 0x28102040, 0x00240034,
-	0x00024c00, 0x05018008, 0x28182040, 0x10240034,
-	0x02024c00, 0x05018000, 0x281020c0, 0x00241034,
-	0x02024c00, 0x05018008, 0x281820c0, 0x10241034
-};
-
-/* S-box lookup tables */
-
-static const u32 S1[64] = {
-	0x01010400, 0x00000000, 0x00010000, 0x01010404,
-	0x01010004, 0x00010404, 0x00000004, 0x00010000,
-	0x00000400, 0x01010400, 0x01010404, 0x00000400,
-	0x01000404, 0x01010004, 0x01000000, 0x00000004,
-	0x00000404, 0x01000400, 0x01000400, 0x00010400,
-	0x00010400, 0x01010000, 0x01010000, 0x01000404,
-	0x00010004, 0x01000004, 0x01000004, 0x00010004,
-	0x00000000, 0x00000404, 0x00010404, 0x01000000,
-	0x00010000, 0x01010404, 0x00000004, 0x01010000,
-	0x01010400, 0x01000000, 0x01000000, 0x00000400,
-	0x01010004, 0x00010000, 0x00010400, 0x01000004,
-	0x00000400, 0x00000004, 0x01000404, 0x00010404,
-	0x01010404, 0x00010004, 0x01010000, 0x01000404,
-	0x01000004, 0x00000404, 0x00010404, 0x01010400,
-	0x00000404, 0x01000400, 0x01000400, 0x00000000,
-	0x00010004, 0x00010400, 0x00000000, 0x01010004
-};
-
-static const u32 S2[64] = {
-	0x80108020, 0x80008000, 0x00008000, 0x00108020,
-	0x00100000, 0x00000020, 0x80100020, 0x80008020,
-	0x80000020, 0x80108020, 0x80108000, 0x80000000,
-	0x80008000, 0x00100000, 0x00000020, 0x80100020,
-	0x00108000, 0x00100020, 0x80008020, 0x00000000,
-	0x80000000, 0x00008000, 0x00108020, 0x80100000,
-	0x00100020, 0x80000020, 0x00000000, 0x00108000,
-	0x00008020, 0x80108000, 0x80100000, 0x00008020,
-	0x00000000, 0x00108020, 0x80100020, 0x00100000,
-	0x80008020, 0x80100000, 0x80108000, 0x00008000,
-	0x80100000, 0x80008000, 0x00000020, 0x80108020,
-	0x00108020, 0x00000020, 0x00008000, 0x80000000,
-	0x00008020, 0x80108000, 0x00100000, 0x80000020,
-	0x00100020, 0x80008020, 0x80000020, 0x00100020,
-	0x00108000, 0x00000000, 0x80008000, 0x00008020,
-	0x80000000, 0x80100020, 0x80108020, 0x00108000
-};
-
-static const u32 S3[64] = {
-	0x00000208, 0x08020200, 0x00000000, 0x08020008,
-	0x08000200, 0x00000000, 0x00020208, 0x08000200,
-	0x00020008, 0x08000008, 0x08000008, 0x00020000,
-	0x08020208, 0x00020008, 0x08020000, 0x00000208,
-	0x08000000, 0x00000008, 0x08020200, 0x00000200,
-	0x00020200, 0x08020000, 0x08020008, 0x00020208,
-	0x08000208, 0x00020200, 0x00020000, 0x08000208,
-	0x00000008, 0x08020208, 0x00000200, 0x08000000,
-	0x08020200, 0x08000000, 0x00020008, 0x00000208,
-	0x00020000, 0x08020200, 0x08000200, 0x00000000,
-	0x00000200, 0x00020008, 0x08020208, 0x08000200,
-	0x08000008, 0x00000200, 0x00000000, 0x08020008,
-	0x08000208, 0x00020000, 0x08000000, 0x08020208,
-	0x00000008, 0x00020208, 0x00020200, 0x08000008,
-	0x08020000, 0x08000208, 0x00000208, 0x08020000,
-	0x00020208, 0x00000008, 0x08020008, 0x00020200
-};
-
-static const u32 S4[64] = {
-	0x00802001, 0x00002081, 0x00002081, 0x00000080,
-	0x00802080, 0x00800081, 0x00800001, 0x00002001,
-	0x00000000, 0x00802000, 0x00802000, 0x00802081,
-	0x00000081, 0x00000000, 0x00800080, 0x00800001,
-	0x00000001, 0x00002000, 0x00800000, 0x00802001,
-	0x00000080, 0x00800000, 0x00002001, 0x00002080,
-	0x00800081, 0x00000001, 0x00002080, 0x00800080,
-	0x00002000, 0x00802080, 0x00802081, 0x00000081,
-	0x00800080, 0x00800001, 0x00802000, 0x00802081,
-	0x00000081, 0x00000000, 0x00000000, 0x00802000,
-	0x00002080, 0x00800080, 0x00800081, 0x00000001,
-	0x00802001, 0x00002081, 0x00002081, 0x00000080,
-	0x00802081, 0x00000081, 0x00000001, 0x00002000,
-	0x00800001, 0x00002001, 0x00802080, 0x00800081,
-	0x00002001, 0x00002080, 0x00800000, 0x00802001,
-	0x00000080, 0x00800000, 0x00002000, 0x00802080
-};
-
-static const u32 S5[64] = {
-	0x00000100, 0x02080100, 0x02080000, 0x42000100,
-	0x00080000, 0x00000100, 0x40000000, 0x02080000,
-	0x40080100, 0x00080000, 0x02000100, 0x40080100,
-	0x42000100, 0x42080000, 0x00080100, 0x40000000,
-	0x02000000, 0x40080000, 0x40080000, 0x00000000,
-	0x40000100, 0x42080100, 0x42080100, 0x02000100,
-	0x42080000, 0x40000100, 0x00000000, 0x42000000,
-	0x02080100, 0x02000000, 0x42000000, 0x00080100,
-	0x00080000, 0x42000100, 0x00000100, 0x02000000,
-	0x40000000, 0x02080000, 0x42000100, 0x40080100,
-	0x02000100, 0x40000000, 0x42080000, 0x02080100,
-	0x40080100, 0x00000100, 0x02000000, 0x42080000,
-	0x42080100, 0x00080100, 0x42000000, 0x42080100,
-	0x02080000, 0x00000000, 0x40080000, 0x42000000,
-	0x00080100, 0x02000100, 0x40000100, 0x00080000,
-	0x00000000, 0x40080000, 0x02080100, 0x40000100
-};
-
-static const u32 S6[64] = {
-	0x20000010, 0x20400000, 0x00004000, 0x20404010,
-	0x20400000, 0x00000010, 0x20404010, 0x00400000,
-	0x20004000, 0x00404010, 0x00400000, 0x20000010,
-	0x00400010, 0x20004000, 0x20000000, 0x00004010,
-	0x00000000, 0x00400010, 0x20004010, 0x00004000,
-	0x00404000, 0x20004010, 0x00000010, 0x20400010,
-	0x20400010, 0x00000000, 0x00404010, 0x20404000,
-	0x00004010, 0x00404000, 0x20404000, 0x20000000,
-	0x20004000, 0x00000010, 0x20400010, 0x00404000,
-	0x20404010, 0x00400000, 0x00004010, 0x20000010,
-	0x00400000, 0x20004000, 0x20000000, 0x00004010,
-	0x20000010, 0x20404010, 0x00404000, 0x20400000,
-	0x00404010, 0x20404000, 0x00000000, 0x20400010,
-	0x00000010, 0x00004000, 0x20400000, 0x00404010,
-	0x00004000, 0x00400010, 0x20004010, 0x00000000,
-	0x20404000, 0x20000000, 0x00400010, 0x20004010
-};
-
-static const u32 S7[64] = {
-	0x00200000, 0x04200002, 0x04000802, 0x00000000,
-	0x00000800, 0x04000802, 0x00200802, 0x04200800,
-	0x04200802, 0x00200000, 0x00000000, 0x04000002,
-	0x00000002, 0x04000000, 0x04200002, 0x00000802,
-	0x04000800, 0x00200802, 0x00200002, 0x04000800,
-	0x04000002, 0x04200000, 0x04200800, 0x00200002,
-	0x04200000, 0x00000800, 0x00000802, 0x04200802,
-	0x00200800, 0x00000002, 0x04000000, 0x00200800,
-	0x04000000, 0x00200800, 0x00200000, 0x04000802,
-	0x04000802, 0x04200002, 0x04200002, 0x00000002,
-	0x00200002, 0x04000000, 0x04000800, 0x00200000,
-	0x04200800, 0x00000802, 0x00200802, 0x04200800,
-	0x00000802, 0x04000002, 0x04200802, 0x04200000,
-	0x00200800, 0x00000000, 0x00000002, 0x04200802,
-	0x00000000, 0x00200802, 0x04200000, 0x00000800,
-	0x04000002, 0x04000800, 0x00000800, 0x00200002
-};
-
-static const u32 S8[64] = {
-	0x10001040, 0x00001000, 0x00040000, 0x10041040,
-	0x10000000, 0x10001040, 0x00000040, 0x10000000,
-	0x00040040, 0x10040000, 0x10041040, 0x00041000,
-	0x10041000, 0x00041040, 0x00001000, 0x00000040,
-	0x10040000, 0x10000040, 0x10001000, 0x00001040,
-	0x00041000, 0x00040040, 0x10040040, 0x10041000,
-	0x00001040, 0x00000000, 0x00000000, 0x10040040,
-	0x10000040, 0x10001000, 0x00041040, 0x00040000,
-	0x00041040, 0x00040000, 0x10041000, 0x00001000,
-	0x00000040, 0x10040040, 0x00001000, 0x00041040,
-	0x10001000, 0x00000040, 0x10000040, 0x10040000,
-	0x10040040, 0x10000000, 0x00040000, 0x10001040,
-	0x00000000, 0x10041040, 0x00040040, 0x10000040,
-	0x10040000, 0x10001000, 0x10001040, 0x00000000,
-	0x10041040, 0x00041000, 0x00041000, 0x00001040,
-	0x00001040, 0x00040040, 0x10000000, 0x10041000
-};
-
-/* Encryption components: IP, FP, and round function */
-
-#define IP(L, R, T)		\
-	ROL(R, 4);		\
-	T  = L;			\
-	L ^= R;			\
-	L &= 0xf0f0f0f0;	\
-	R ^= L;			\
-	L ^= T;			\
-	ROL(R, 12);		\
-	T  = L;			\
-	L ^= R;			\
-	L &= 0xffff0000;	\
-	R ^= L;			\
-	L ^= T;			\
-	ROR(R, 14);		\
-	T  = L;			\
-	L ^= R;			\
-	L &= 0xcccccccc;	\
-	R ^= L;			\
-	L ^= T;			\
-	ROL(R, 6);		\
-	T  = L;			\
-	L ^= R;			\
-	L &= 0xff00ff00;	\
-	R ^= L;			\
-	L ^= T;			\
-	ROR(R, 7);		\
-	T  = L;			\
-	L ^= R;			\
-	L &= 0xaaaaaaaa;	\
-	R ^= L;			\
-	L ^= T;			\
-	ROL(L, 1);
-
-#define FP(L, R, T)		\
-	ROR(L, 1);		\
-	T  = L;			\
-	L ^= R;			\
-	L &= 0xaaaaaaaa;	\
-	R ^= L;			\
-	L ^= T;			\
-	ROL(R, 7);		\
-	T  = L;			\
-	L ^= R;			\
-	L &= 0xff00ff00;	\
-	R ^= L;			\
-	L ^= T;			\
-	ROR(R, 6);		\
-	T  = L;			\
-	L ^= R;			\
-	L &= 0xcccccccc;	\
-	R ^= L;			\
-	L ^= T;			\
-	ROL(R, 14);		\
-	T  = L;			\
-	L ^= R;			\
-	L &= 0xffff0000;	\
-	R ^= L;			\
-	L ^= T;			\
-	ROR(R, 12);		\
-	T  = L;			\
-	L ^= R;			\
-	L &= 0xf0f0f0f0;	\
-	R ^= L;			\
-	L ^= T;			\
-	ROR(R, 4);
-
-#define ROUND(L, R, A, B, K, d)					\
-	B = K[0];			A = K[1];	K += d;	\
-	B ^= R;				A ^= R;			\
-	B &= 0x3f3f3f3f;		ROR(A, 4);		\
-	L ^= S8[0xff & B];		A &= 0x3f3f3f3f;	\
-	L ^= S6[0xff & (B >> 8)];	B >>= 16;		\
-	L ^= S7[0xff & A];					\
-	L ^= S5[0xff & (A >> 8)];	A >>= 16;		\
-	L ^= S4[0xff & B];					\
-	L ^= S2[0xff & (B >> 8)];				\
-	L ^= S3[0xff & A];					\
-	L ^= S1[0xff & (A >> 8)];
-
-/*
- * PC2 lookup tables are organized as 2 consecutive sets of 4 interleaved
- * tables of 128 elements.  One set is for C_i and the other for D_i, while
- * the 4 interleaved tables correspond to four 7-bit subsets of C_i or D_i.
- *
- * After PC1 each of the variables a,b,c,d contains a 7 bit subset of C_i
- * or D_i in bits 7-1 (bit 0 being the least significant).
- */
-
-#define T1(x) pt[2 * (x) + 0]
-#define T2(x) pt[2 * (x) + 1]
-#define T3(x) pt[2 * (x) + 2]
-#define T4(x) pt[2 * (x) + 3]
-
-#define DES_PC2(a, b, c, d) (T4(d) | T3(c) | T2(b) | T1(a))
-
-/*
- * Encryption key expansion
- *
- * RFC2451: Weak key checks SHOULD be performed.
- *
- * FIPS 74:
- *
- *   Keys having duals are keys which produce all zeros, all ones, or
- *   alternating zero-one patterns in the C and D registers after Permuted
- *   Choice 1 has operated on the key.
- *
- */
-unsigned long des_ekey(u32 *pe, const u8 *k)
-{
-	/* K&R: long is at least 32 bits */
-	unsigned long a, b, c, d, w;
-	const u32 *pt = pc2;
-
-	d = k[4]; d &= 0x0e; d <<= 4; d |= k[0] & 0x1e; d = pc1[d];
-	c = k[5]; c &= 0x0e; c <<= 4; c |= k[1] & 0x1e; c = pc1[c];
-	b = k[6]; b &= 0x0e; b <<= 4; b |= k[2] & 0x1e; b = pc1[b];
-	a = k[7]; a &= 0x0e; a <<= 4; a |= k[3] & 0x1e; a = pc1[a];
-
-	pe[15 * 2 + 0] = DES_PC2(a, b, c, d); d = rs[d];
-	pe[14 * 2 + 0] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
-	pe[13 * 2 + 0] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
-	pe[12 * 2 + 0] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
-	pe[11 * 2 + 0] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
-	pe[10 * 2 + 0] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
-	pe[ 9 * 2 + 0] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
-	pe[ 8 * 2 + 0] = DES_PC2(d, a, b, c); c = rs[c];
-	pe[ 7 * 2 + 0] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
-	pe[ 6 * 2 + 0] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
-	pe[ 5 * 2 + 0] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
-	pe[ 4 * 2 + 0] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
-	pe[ 3 * 2 + 0] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
-	pe[ 2 * 2 + 0] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
-	pe[ 1 * 2 + 0] = DES_PC2(c, d, a, b); b = rs[b];
-	pe[ 0 * 2 + 0] = DES_PC2(b, c, d, a);
-
-	/* Check if first half is weak */
-	w  = (a ^ c) | (b ^ d) | (rs[a] ^ c) | (b ^ rs[d]);
-
-	/* Skip to next table set */
-	pt += 512;
-
-	d = k[0]; d &= 0xe0; d >>= 4; d |= k[4] & 0xf0; d = pc1[d + 1];
-	c = k[1]; c &= 0xe0; c >>= 4; c |= k[5] & 0xf0; c = pc1[c + 1];
-	b = k[2]; b &= 0xe0; b >>= 4; b |= k[6] & 0xf0; b = pc1[b + 1];
-	a = k[3]; a &= 0xe0; a >>= 4; a |= k[7] & 0xf0; a = pc1[a + 1];
-
-	/* Check if second half is weak */
-	w |= (a ^ c) | (b ^ d) | (rs[a] ^ c) | (b ^ rs[d]);
-
-	pe[15 * 2 + 1] = DES_PC2(a, b, c, d); d = rs[d];
-	pe[14 * 2 + 1] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
-	pe[13 * 2 + 1] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
-	pe[12 * 2 + 1] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
-	pe[11 * 2 + 1] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
-	pe[10 * 2 + 1] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
-	pe[ 9 * 2 + 1] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
-	pe[ 8 * 2 + 1] = DES_PC2(d, a, b, c); c = rs[c];
-	pe[ 7 * 2 + 1] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
-	pe[ 6 * 2 + 1] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
-	pe[ 5 * 2 + 1] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
-	pe[ 4 * 2 + 1] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
-	pe[ 3 * 2 + 1] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
-	pe[ 2 * 2 + 1] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
-	pe[ 1 * 2 + 1] = DES_PC2(c, d, a, b); b = rs[b];
-	pe[ 0 * 2 + 1] = DES_PC2(b, c, d, a);
-
-	/* Fixup: 2413 5768 -> 1357 2468 */
-	for (d = 0; d < 16; ++d) {
-		a = pe[2 * d];
-		b = pe[2 * d + 1];
-		c = a ^ b;
-		c &= 0xffff0000;
-		a ^= c;
-		b ^= c;
-		ROL(b, 18);
-		pe[2 * d] = a;
-		pe[2 * d + 1] = b;
-	}
-
-	/* Zero if weak key */
-	return w;
-}
-EXPORT_SYMBOL_GPL(des_ekey);
-
-/*
- * Decryption key expansion
- *
- * No weak key checking is performed, as this is only used by triple DES
- *
- */
-static void dkey(u32 *pe, const u8 *k)
-{
-	/* K&R: long is at least 32 bits */
-	unsigned long a, b, c, d;
-	const u32 *pt = pc2;
-
-	d = k[4]; d &= 0x0e; d <<= 4; d |= k[0] & 0x1e; d = pc1[d];
-	c = k[5]; c &= 0x0e; c <<= 4; c |= k[1] & 0x1e; c = pc1[c];
-	b = k[6]; b &= 0x0e; b <<= 4; b |= k[2] & 0x1e; b = pc1[b];
-	a = k[7]; a &= 0x0e; a <<= 4; a |= k[3] & 0x1e; a = pc1[a];
-
-	pe[ 0 * 2] = DES_PC2(a, b, c, d); d = rs[d];
-	pe[ 1 * 2] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
-	pe[ 2 * 2] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
-	pe[ 3 * 2] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
-	pe[ 4 * 2] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
-	pe[ 5 * 2] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
-	pe[ 6 * 2] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
-	pe[ 7 * 2] = DES_PC2(d, a, b, c); c = rs[c];
-	pe[ 8 * 2] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
-	pe[ 9 * 2] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
-	pe[10 * 2] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
-	pe[11 * 2] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
-	pe[12 * 2] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
-	pe[13 * 2] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
-	pe[14 * 2] = DES_PC2(c, d, a, b); b = rs[b];
-	pe[15 * 2] = DES_PC2(b, c, d, a);
-
-	/* Skip to next table set */
-	pt += 512;
-
-	d = k[0]; d &= 0xe0; d >>= 4; d |= k[4] & 0xf0; d = pc1[d + 1];
-	c = k[1]; c &= 0xe0; c >>= 4; c |= k[5] & 0xf0; c = pc1[c + 1];
-	b = k[2]; b &= 0xe0; b >>= 4; b |= k[6] & 0xf0; b = pc1[b + 1];
-	a = k[3]; a &= 0xe0; a >>= 4; a |= k[7] & 0xf0; a = pc1[a + 1];
-
-	pe[ 0 * 2 + 1] = DES_PC2(a, b, c, d); d = rs[d];
-	pe[ 1 * 2 + 1] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
-	pe[ 2 * 2 + 1] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
-	pe[ 3 * 2 + 1] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
-	pe[ 4 * 2 + 1] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
-	pe[ 5 * 2 + 1] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
-	pe[ 6 * 2 + 1] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
-	pe[ 7 * 2 + 1] = DES_PC2(d, a, b, c); c = rs[c];
-	pe[ 8 * 2 + 1] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
-	pe[ 9 * 2 + 1] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
-	pe[10 * 2 + 1] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
-	pe[11 * 2 + 1] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
-	pe[12 * 2 + 1] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
-	pe[13 * 2 + 1] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
-	pe[14 * 2 + 1] = DES_PC2(c, d, a, b); b = rs[b];
-	pe[15 * 2 + 1] = DES_PC2(b, c, d, a);
-
-	/* Fixup: 2413 5768 -> 1357 2468 */
-	for (d = 0; d < 16; ++d) {
-		a = pe[2 * d];
-		b = pe[2 * d + 1];
-		c = a ^ b;
-		c &= 0xffff0000;
-		a ^= c;
-		b ^= c;
-		ROL(b, 18);
-		pe[2 * d] = a;
-		pe[2 * d + 1] = b;
-	}
-}
+#include <crypto/internal/des.h>
 
 static int des_setkey(struct crypto_tfm *tfm, const u8 *key,
 		      unsigned int keylen)
 {
 	struct des_ctx *dctx = crypto_tfm_ctx(tfm);
-	u32 *flags = &tfm->crt_flags;
-	u32 tmp[DES_EXPKEY_WORDS];
-	int ret;
-
-	/* Expand to tmp */
-	ret = des_ekey(tmp, key);
+	int err;
 
-	if (unlikely(ret == 0) && (*flags & CRYPTO_TFM_REQ_FORBID_WEAK_KEYS)) {
-		*flags |= CRYPTO_TFM_RES_WEAK_KEY;
-		return -EINVAL;
+	err = des_expand_key(dctx, key, keylen);
+	if (err == -ENOKEY) {
+		if (crypto_tfm_get_flags(tfm) & CRYPTO_TFM_REQ_FORBID_WEAK_KEYS)
+			err = -EINVAL;
+		else
+			err = 0;
 	}
 
-	/* Copy to output */
-	memcpy(dctx->expkey, tmp, sizeof(dctx->expkey));
-
-	return 0;
+	if (err) {
+		memset(dctx, 0, sizeof(*dctx));
+		crypto_tfm_set_flags(tfm, CRYPTO_TFM_RES_WEAK_KEY);
+	}
+	return err;
 }
 
-static void des_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+static void crypto_des_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 {
-	struct des_ctx *ctx = crypto_tfm_ctx(tfm);
-	const u32 *K = ctx->expkey;
-	const __le32 *s = (const __le32 *)src;
-	__le32 *d = (__le32 *)dst;
-	u32 L, R, A, B;
-	int i;
-
-	L = le32_to_cpu(s[0]);
-	R = le32_to_cpu(s[1]);
-
-	IP(L, R, A);
-	for (i = 0; i < 8; i++) {
-		ROUND(L, R, A, B, K, 2);
-		ROUND(R, L, A, B, K, 2);
-	}
-	FP(R, L, A);
+	const struct des_ctx *dctx = crypto_tfm_ctx(tfm);
 
-	d[0] = cpu_to_le32(R);
-	d[1] = cpu_to_le32(L);
+	des_encrypt(dctx, dst, src);
 }
 
-static void des_decrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+static void crypto_des_decrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
 {
-	struct des_ctx *ctx = crypto_tfm_ctx(tfm);
-	const u32 *K = ctx->expkey + DES_EXPKEY_WORDS - 2;
-	const __le32 *s = (const __le32 *)src;
-	__le32 *d = (__le32 *)dst;
-	u32 L, R, A, B;
-	int i;
-
-	L = le32_to_cpu(s[0]);
-	R = le32_to_cpu(s[1]);
+	const struct des_ctx *dctx = crypto_tfm_ctx(tfm);
 
-	IP(L, R, A);
-	for (i = 0; i < 8; i++) {
-		ROUND(L, R, A, B, K, -2);
-		ROUND(R, L, A, B, K, -2);
-	}
-	FP(R, L, A);
-
-	d[0] = cpu_to_le32(R);
-	d[1] = cpu_to_le32(L);
+	des_decrypt(dctx, dst, src);
 }
 
 int __des3_ede_setkey(u32 *expkey, u32 *flags, const u8 *key,
@@ -858,76 +68,37 @@ static int des3_ede_setkey(struct crypto_tfm *tfm, const u8 *key,
 			   unsigned int keylen)
 {
 	struct des3_ede_ctx *dctx = crypto_tfm_ctx(tfm);
-	u32 *expkey = dctx->expkey;
 	int err;
 
-	err = crypto_des3_ede_verify_key(tfm, key);
-	if (err)
-		return err;
+	err = des3_ede_expand_key(dctx, key, keylen);
+	if (err == -ENOKEY) {
+		if (crypto_tfm_get_flags(tfm) & CRYPTO_TFM_REQ_FORBID_WEAK_KEYS)
+			err = -EINVAL;
+		else
+			err = 0;
+	}
 
-	return __des3_ede_setkey(expkey, flags, key, keylen);
+	if (err) {
+		memset(dctx, 0, sizeof(*dctx));
+		crypto_tfm_set_flags(tfm, CRYPTO_TFM_RES_WEAK_KEY);
+	}
+	return err;
 }
 
-static void des3_ede_encrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+static void crypto_des3_ede_encrypt(struct crypto_tfm *tfm, u8 *dst,
+				    const u8 *src)
 {
-	struct des3_ede_ctx *dctx = crypto_tfm_ctx(tfm);
-	const u32 *K = dctx->expkey;
-	const __le32 *s = (const __le32 *)src;
-	__le32 *d = (__le32 *)dst;
-	u32 L, R, A, B;
-	int i;
-
-	L = le32_to_cpu(s[0]);
-	R = le32_to_cpu(s[1]);
+	const struct des3_ede_ctx *dctx = crypto_tfm_ctx(tfm);
 
-	IP(L, R, A);
-	for (i = 0; i < 8; i++) {
-		ROUND(L, R, A, B, K, 2);
-		ROUND(R, L, A, B, K, 2);
-	}
-	for (i = 0; i < 8; i++) {
-		ROUND(R, L, A, B, K, 2);
-		ROUND(L, R, A, B, K, 2);
-	}
-	for (i = 0; i < 8; i++) {
-		ROUND(L, R, A, B, K, 2);
-		ROUND(R, L, A, B, K, 2);
-	}
-	FP(R, L, A);
-
-	d[0] = cpu_to_le32(R);
-	d[1] = cpu_to_le32(L);
+	des3_ede_encrypt(dctx, dst, src);
 }
 
-static void des3_ede_decrypt(struct crypto_tfm *tfm, u8 *dst, const u8 *src)
+static void crypto_des3_ede_decrypt(struct crypto_tfm *tfm, u8 *dst,
+				    const u8 *src)
 {
-	struct des3_ede_ctx *dctx = crypto_tfm_ctx(tfm);
-	const u32 *K = dctx->expkey + DES3_EDE_EXPKEY_WORDS - 2;
-	const __le32 *s = (const __le32 *)src;
-	__le32 *d = (__le32 *)dst;
-	u32 L, R, A, B;
-	int i;
-
-	L = le32_to_cpu(s[0]);
-	R = le32_to_cpu(s[1]);
-
-	IP(L, R, A);
-	for (i = 0; i < 8; i++) {
-		ROUND(L, R, A, B, K, -2);
-		ROUND(R, L, A, B, K, -2);
-	}
-	for (i = 0; i < 8; i++) {
-		ROUND(R, L, A, B, K, -2);
-		ROUND(L, R, A, B, K, -2);
-	}
-	for (i = 0; i < 8; i++) {
-		ROUND(L, R, A, B, K, -2);
-		ROUND(R, L, A, B, K, -2);
-	}
-	FP(R, L, A);
+	const struct des3_ede_ctx *dctx = crypto_tfm_ctx(tfm);
 
-	d[0] = cpu_to_le32(R);
-	d[1] = cpu_to_le32(L);
+	des3_ede_decrypt(dctx, dst, src);
 }
 
 static struct crypto_alg des_algs[2] = { {
@@ -938,13 +109,12 @@ static struct crypto_alg des_algs[2] = { {
 	.cra_blocksize		=	DES_BLOCK_SIZE,
 	.cra_ctxsize		=	sizeof(struct des_ctx),
 	.cra_module		=	THIS_MODULE,
-	.cra_alignmask		=	3,
 	.cra_u			=	{ .cipher = {
 	.cia_min_keysize	=	DES_KEY_SIZE,
 	.cia_max_keysize	=	DES_KEY_SIZE,
 	.cia_setkey		=	des_setkey,
-	.cia_encrypt		=	des_encrypt,
-	.cia_decrypt		=	des_decrypt } }
+	.cia_encrypt		=	crypto_des_encrypt,
+	.cia_decrypt		=	crypto_des_decrypt } }
 }, {
 	.cra_name		=	"des3_ede",
 	.cra_driver_name	=	"des3_ede-generic",
@@ -953,13 +123,12 @@ static struct crypto_alg des_algs[2] = { {
 	.cra_blocksize		=	DES3_EDE_BLOCK_SIZE,
 	.cra_ctxsize		=	sizeof(struct des3_ede_ctx),
 	.cra_module		=	THIS_MODULE,
-	.cra_alignmask		=	3,
 	.cra_u			=	{ .cipher = {
 	.cia_min_keysize	=	DES3_EDE_KEY_SIZE,
 	.cia_max_keysize	=	DES3_EDE_KEY_SIZE,
 	.cia_setkey		=	des3_ede_setkey,
-	.cia_encrypt		=	des3_ede_encrypt,
-	.cia_decrypt		=	des3_ede_decrypt } }
+	.cia_encrypt		=	crypto_des3_ede_encrypt,
+	.cia_decrypt		=	crypto_des3_ede_decrypt } }
 } };
 
 static int __init des_generic_mod_init(void)
diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index b8c50871f11b..5cd6e3d12bac 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -150,7 +150,7 @@ config CRYPTO_DES_S390
 	depends on S390
 	select CRYPTO_ALGAPI
 	select CRYPTO_BLKCIPHER
-	select CRYPTO_DES
+	select CRYPTO_LIB_DES
 	help
 	  This is the s390 hardware accelerated implementation of the
 	  DES cipher algorithm (FIPS 46-2), and Triple DES EDE (FIPS 46-3).
@@ -215,7 +215,7 @@ config CRYPTO_DEV_MARVELL_CESA
 	tristate "Marvell's Cryptographic Engine driver"
 	depends on PLAT_ORION || ARCH_MVEBU
 	select CRYPTO_LIB_AES
-	select CRYPTO_DES
+	select CRYPTO_LIB_DES
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_HASH
 	select SRAM
@@ -227,7 +227,7 @@ config CRYPTO_DEV_MARVELL_CESA
 
 config CRYPTO_DEV_NIAGARA2
        tristate "Niagara2 Stream Processing Unit driver"
-       select CRYPTO_DES
+       select CRYPTO_LIB_DES
        select CRYPTO_BLKCIPHER
        select CRYPTO_HASH
        select CRYPTO_MD5
@@ -244,7 +244,7 @@ config CRYPTO_DEV_NIAGARA2
 
 config CRYPTO_DEV_HIFN_795X
 	tristate "Driver HIFN 795x crypto accelerator chips"
-	select CRYPTO_DES
+	select CRYPTO_LIB_DES
 	select CRYPTO_BLKCIPHER
 	select HW_RANDOM if CRYPTO_DEV_HIFN_795X_RNG
 	depends on PCI
@@ -300,7 +300,7 @@ config CRYPTO_DEV_TALITOS2
 config CRYPTO_DEV_IXP4XX
 	tristate "Driver for IXP4xx crypto hardware acceleration"
 	depends on ARCH_IXP4XX && IXP4XX_QMGR && IXP4XX_NPE
-	select CRYPTO_DES
+	select CRYPTO_LIB_DES
 	select CRYPTO_AEAD
 	select CRYPTO_AUTHENC
 	select CRYPTO_BLKCIPHER
@@ -366,7 +366,7 @@ config CRYPTO_DEV_OMAP_AES
 config CRYPTO_DEV_OMAP_DES
 	tristate "Support for OMAP DES/3DES hw engine"
 	depends on ARCH_OMAP2PLUS
-	select CRYPTO_DES
+	select CRYPTO_LIB_DES
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_ENGINE
 	help
@@ -384,7 +384,7 @@ config CRYPTO_DEV_PICOXCELL
 	select CRYPTO_AES
 	select CRYPTO_AUTHENC
 	select CRYPTO_BLKCIPHER
-	select CRYPTO_DES
+	select CRYPTO_LIB_DES
 	select CRYPTO_CBC
 	select CRYPTO_ECB
 	select CRYPTO_SEQIV
@@ -497,7 +497,7 @@ config CRYPTO_DEV_ATMEL_AES
 config CRYPTO_DEV_ATMEL_TDES
 	tristate "Support for Atmel DES/TDES hw accelerator"
 	depends on ARCH_AT91 || COMPILE_TEST
-	select CRYPTO_DES
+	select CRYPTO_LIB_DES
 	select CRYPTO_BLKCIPHER
 	help
 	  Some Atmel processors have DES/TDES hw accelerator.
@@ -595,7 +595,7 @@ config CRYPTO_DEV_QCE
 	depends on ARCH_QCOM || COMPILE_TEST
 	depends on HAS_IOMEM
 	select CRYPTO_AES
-	select CRYPTO_DES
+	select CRYPTO_LIB_DES
 	select CRYPTO_ECB
 	select CRYPTO_CBC
 	select CRYPTO_XTS
@@ -643,7 +643,7 @@ config CRYPTO_DEV_SUN4I_SS
 	select CRYPTO_MD5
 	select CRYPTO_SHA1
 	select CRYPTO_AES
-	select CRYPTO_DES
+	select CRYPTO_LIB_DES
 	select CRYPTO_BLKCIPHER
 	help
 	  Some Allwinner SoC have a crypto accelerator named
@@ -666,7 +666,7 @@ config CRYPTO_DEV_ROCKCHIP
 	tristate "Rockchip's Cryptographic Engine driver"
 	depends on OF && ARCH_ROCKCHIP
 	select CRYPTO_AES
-	select CRYPTO_DES
+	select CRYPTO_LIB_DES
 	select CRYPTO_MD5
 	select CRYPTO_SHA1
 	select CRYPTO_SHA256
@@ -703,7 +703,7 @@ config CRYPTO_DEV_BCM_SPU
 	depends on MAILBOX
 	default m
 	select CRYPTO_AUTHENC
-	select CRYPTO_DES
+	select CRYPTO_LIB_DES
 	select CRYPTO_MD5
 	select CRYPTO_SHA1
 	select CRYPTO_SHA256
@@ -722,7 +722,7 @@ config CRYPTO_DEV_SAFEXCEL
 	select CRYPTO_LIB_AES
 	select CRYPTO_AUTHENC
 	select CRYPTO_BLKCIPHER
-	select CRYPTO_DES
+	select CRYPTO_LIB_DES
 	select CRYPTO_HASH
 	select CRYPTO_HMAC
 	select CRYPTO_MD5
@@ -760,7 +760,7 @@ config CRYPTO_DEV_CCREE
 	default n
 	select CRYPTO_HASH
 	select CRYPTO_BLKCIPHER
-	select CRYPTO_DES
+	select CRYPTO_LIB_DES
 	select CRYPTO_AEAD
 	select CRYPTO_AUTHENC
 	select CRYPTO_SHA1
diff --git a/drivers/crypto/caam/Kconfig b/drivers/crypto/caam/Kconfig
index e4fdf545ac90..137ed3df0c74 100644
--- a/drivers/crypto/caam/Kconfig
+++ b/drivers/crypto/caam/Kconfig
@@ -98,7 +98,7 @@ config CRYPTO_DEV_FSL_CAAM_CRYPTO_API
 	select CRYPTO_AEAD
 	select CRYPTO_AUTHENC
 	select CRYPTO_BLKCIPHER
-	select CRYPTO_DES
+	select CRYPTO_LIB_DES
 	help
 	  Selecting this will offload crypto for users of the
 	  scatterlist crypto API (such as the linux native IPSec
diff --git a/drivers/crypto/cavium/nitrox/Kconfig b/drivers/crypto/cavium/nitrox/Kconfig
index dab162af41b8..7b1e751bb9cd 100644
--- a/drivers/crypto/cavium/nitrox/Kconfig
+++ b/drivers/crypto/cavium/nitrox/Kconfig
@@ -6,7 +6,7 @@ config CRYPTO_DEV_NITROX
 	tristate
 	select CRYPTO_BLKCIPHER
 	select CRYPTO_AES
-	select CRYPTO_DES
+	select CRYPTO_LIB_DES
 	select FW_LOADER
 
 config CRYPTO_DEV_NITROX_CNN55XX
diff --git a/drivers/crypto/inside-secure/safexcel_cipher.c b/drivers/crypto/inside-secure/safexcel_cipher.c
index 16c4d5460334..b68b6a7c0a32 100644
--- a/drivers/crypto/inside-secure/safexcel_cipher.c
+++ b/drivers/crypto/inside-secure/safexcel_cipher.c
@@ -13,7 +13,7 @@
 #include <crypto/aes.h>
 #include <crypto/authenc.h>
 #include <crypto/ctr.h>
-#include <crypto/des.h>
+#include <crypto/internal/des.h>
 #include <crypto/sha.h>
 #include <crypto/skcipher.h>
 #include <crypto/internal/aead.h>
diff --git a/drivers/crypto/stm32/Kconfig b/drivers/crypto/stm32/Kconfig
index d6576280fc9b..1aba9372cd23 100644
--- a/drivers/crypto/stm32/Kconfig
+++ b/drivers/crypto/stm32/Kconfig
@@ -25,7 +25,7 @@ config CRYPTO_DEV_STM32_CRYP
 	depends on ARCH_STM32
 	select CRYPTO_HASH
 	select CRYPTO_ENGINE
-	select CRYPTO_DES
+	select CRYPTO_LIB_DES
 	help
           This enables support for the CRYP (AES/DES/TDES) hw accelerator which
 	  can be found on STMicroelectronics STM32 SOC.
diff --git a/drivers/crypto/ux500/Kconfig b/drivers/crypto/ux500/Kconfig
index 349d34eaac13..b1c6f739f77b 100644
--- a/drivers/crypto/ux500/Kconfig
+++ b/drivers/crypto/ux500/Kconfig
@@ -9,7 +9,7 @@ config CRYPTO_DEV_UX500_CRYP
 	depends on CRYPTO_DEV_UX500
 	select CRYPTO_ALGAPI
 	select CRYPTO_BLKCIPHER
-	select CRYPTO_DES
+	select CRYPTO_LIB_DES
 	help
         This selects the crypto driver for the UX500_CRYP hardware. It supports
         AES-ECB, CBC and CTR with keys sizes of 128, 192 and 256 bit sizes.
diff --git a/include/crypto/des.h b/include/crypto/des.h
index 31b04ba835b1..2c864a4e6707 100644
--- a/include/crypto/des.h
+++ b/include/crypto/des.h
@@ -6,10 +6,7 @@
 #ifndef __CRYPTO_DES_H
 #define __CRYPTO_DES_H
 
-#include <crypto/skcipher.h>
-#include <linux/compiler.h>
-#include <linux/fips.h>
-#include <linux/string.h>
+#include <linux/types.h>
 
 #define DES_KEY_SIZE		8
 #define DES_EXPKEY_WORDS	32
@@ -19,6 +16,44 @@
 #define DES3_EDE_EXPKEY_WORDS	(3 * DES_EXPKEY_WORDS)
 #define DES3_EDE_BLOCK_SIZE	DES_BLOCK_SIZE
 
+struct des_ctx {
+	u32 expkey[DES_EXPKEY_WORDS];
+};
+
+struct des3_ede_ctx {
+	u32 expkey[DES3_EDE_EXPKEY_WORDS];
+};
+
+void des_encrypt(const struct des_ctx *ctx, u8 *dst, const u8 *src);
+void des_decrypt(const struct des_ctx *ctx, u8 *dst, const u8 *src);
+
+void des3_ede_encrypt(const struct des3_ede_ctx *dctx, u8 *dst, const u8 *src);
+void des3_ede_decrypt(const struct des3_ede_ctx *dctx, u8 *dst, const u8 *src);
+
+/**
+ * des_expand_key - Expand a DES input key into a key schedule
+ * @ctx: the key schedule
+ * @key: buffer containing the input key
+ * @len: size of the buffer contents
+ *
+ * Returns 0 on success, -EINVAL if the input key is rejected and -ENOKEY if
+ * the key is accepted but has been found to be weak.
+ */
+int des_expand_key(struct des_ctx *ctx, const u8 *key, unsigned int keylen);
+
+/**
+ * des3_ede_expand_key - Expand a triple DES input key into a key schedule
+ * @ctx: the key schedule
+ * @key: buffer containing the input key
+ * @len: size of the buffer contents
+ *
+ * Returns 0 on success, -EINVAL if the input key is rejected and -ENOKEY if
+ * the key is accepted but has been found to be weak. Note that weak keys will
+ * be rejected (and -EINVAL will be returned) when running in FIPS mode.
+ */
+int des3_ede_expand_key(struct des3_ede_ctx *ctx, const u8 *key,
+			unsigned int keylen);
+
 extern int __des3_ede_setkey(u32 *expkey, u32 *flags, const u8 *key,
 			     unsigned int keylen);
 
diff --git a/include/crypto/internal/des.h b/include/crypto/internal/des.h
index f5d2e696522e..81ea1a425e9c 100644
--- a/include/crypto/internal/des.h
+++ b/include/crypto/internal/des.h
@@ -25,18 +25,21 @@
  */
 static inline int crypto_des_verify_key(struct crypto_tfm *tfm, const u8 *key)
 {
-	u32 tmp[DES_EXPKEY_WORDS];
-	int err = 0;
-
-	if (!(crypto_tfm_get_flags(tfm) & CRYPTO_TFM_REQ_FORBID_WEAK_KEYS))
-		return 0;
+	struct des_ctx tmp;
+	int err;
+
+	err = des_expand_key(&tmp, key, DES_KEY_SIZE);
+	if (err == -ENOKEY) {
+		if (crypto_tfm_get_flags(tfm) & CRYPTO_TFM_REQ_FORBID_WEAK_KEYS)
+			err = -EINVAL;
+		else
+			err = 0;
+	}
 
-	if (!des_ekey(tmp, key)) {
+	if (err)
 		crypto_tfm_set_flags(tfm, CRYPTO_TFM_RES_WEAK_KEY);
-		err = -EINVAL;
-	}
 
-	memzero_explicit(tmp, sizeof(tmp));
+	memzero_explicit(&tmp, sizeof(tmp));
 	return err;
 }
 
@@ -53,6 +56,28 @@ static inline int crypto_des_verify_key(struct crypto_tfm *tfm, const u8 *key)
  *   property.
  *
  */
+static inline int des3_ede_verify_key(const u8 *key, unsigned int key_len,
+				      bool check_weak)
+{
+	int ret = fips_enabled ? -EINVAL : -ENOKEY;
+	u32 K[6];
+
+	memcpy(K, key, DES3_EDE_KEY_SIZE);
+
+	if ((!((K[0] ^ K[2]) | (K[1] ^ K[3])) ||
+	     !((K[2] ^ K[4]) | (K[3] ^ K[5]))) &&
+	    (fips_enabled || check_weak))
+		goto bad;
+
+	if ((!((K[0] ^ K[4]) | (K[1] ^ K[5]))) && fips_enabled)
+		goto bad;
+
+	ret = 0;
+bad:
+	memzero_explicit(K, DES3_EDE_KEY_SIZE);
+
+	return ret;
+}
 
 /**
  * crypto_des3_ede_verify_key - Check whether a DES3-EDE key is weak
@@ -70,28 +95,14 @@ static inline int crypto_des_verify_key(struct crypto_tfm *tfm, const u8 *key)
 static inline int crypto_des3_ede_verify_key(struct crypto_tfm *tfm,
 					     const u8 *key)
 {
-	int err = -EINVAL;
-	u32 K[6];
-
-	memcpy(K, key, DES3_EDE_KEY_SIZE);
-
-	if ((!((K[0] ^ K[2]) | (K[1] ^ K[3])) ||
-	     !((K[2] ^ K[4]) | (K[3] ^ K[5]))) &&
-	    (fips_enabled || (crypto_tfm_get_flags(tfm) &
-		              CRYPTO_TFM_REQ_FORBID_WEAK_KEYS)))
-		goto bad;
-
-	if ((!((K[0] ^ K[4]) | (K[1] ^ K[5]))) && fips_enabled)
-		goto bad;
+	int err;
 
-	err = 0;
-out:
-	memzero_explicit(K, DES3_EDE_KEY_SIZE);
+	err = des3_ede_verify_key(key, DES3_EDE_KEY_SIZE,
+				  crypto_tfm_get_flags(tfm) &
+				  CRYPTO_TFM_REQ_FORBID_WEAK_KEYS);
+	if (err)
+		crypto_tfm_set_flags(tfm, CRYPTO_TFM_RES_WEAK_KEY);
 	return err;
-
-bad:
-	crypto_tfm_set_flags(tfm, CRYPTO_TFM_RES_WEAK_KEY);
-	goto out;
 }
 
 static inline int verify_skcipher_des_key(struct crypto_skcipher *tfm,
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 42a91c62d96d..101a321b8a99 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -5,3 +5,6 @@ libaes-y := aes.o
 
 obj-$(CONFIG_CRYPTO_LIB_ARC4) += libarc4.o
 libarc4-y := arc4.o
+
+obj-$(CONFIG_CRYPTO_LIB_DES) += libdes.o
+libdes-y := des.o
diff --git a/lib/crypto/des.c b/lib/crypto/des.c
new file mode 100644
index 000000000000..ef5bb8822aba
--- /dev/null
+++ b/lib/crypto/des.c
@@ -0,0 +1,902 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Cryptographic API.
+ *
+ * DES & Triple DES EDE Cipher Algorithms.
+ *
+ * Copyright (c) 2005 Dag Arne Osvik <da@osvik.no>
+ */
+
+#include <linux/bitops.h>
+#include <linux/compiler.h>
+#include <linux/crypto.h>
+#include <linux/errno.h>
+#include <linux/fips.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/types.h>
+
+#include <asm/unaligned.h>
+
+#include <crypto/des.h>
+#include <crypto/internal/des.h>
+
+#define ROL(x, r) ((x) = rol32((x), (r)))
+#define ROR(x, r) ((x) = ror32((x), (r)))
+
+/* Lookup tables for key expansion */
+
+static const u8 pc1[256] = {
+	0x00, 0x00, 0x40, 0x04, 0x10, 0x10, 0x50, 0x14,
+	0x04, 0x40, 0x44, 0x44, 0x14, 0x50, 0x54, 0x54,
+	0x02, 0x02, 0x42, 0x06, 0x12, 0x12, 0x52, 0x16,
+	0x06, 0x42, 0x46, 0x46, 0x16, 0x52, 0x56, 0x56,
+	0x80, 0x08, 0xc0, 0x0c, 0x90, 0x18, 0xd0, 0x1c,
+	0x84, 0x48, 0xc4, 0x4c, 0x94, 0x58, 0xd4, 0x5c,
+	0x82, 0x0a, 0xc2, 0x0e, 0x92, 0x1a, 0xd2, 0x1e,
+	0x86, 0x4a, 0xc6, 0x4e, 0x96, 0x5a, 0xd6, 0x5e,
+	0x20, 0x20, 0x60, 0x24, 0x30, 0x30, 0x70, 0x34,
+	0x24, 0x60, 0x64, 0x64, 0x34, 0x70, 0x74, 0x74,
+	0x22, 0x22, 0x62, 0x26, 0x32, 0x32, 0x72, 0x36,
+	0x26, 0x62, 0x66, 0x66, 0x36, 0x72, 0x76, 0x76,
+	0xa0, 0x28, 0xe0, 0x2c, 0xb0, 0x38, 0xf0, 0x3c,
+	0xa4, 0x68, 0xe4, 0x6c, 0xb4, 0x78, 0xf4, 0x7c,
+	0xa2, 0x2a, 0xe2, 0x2e, 0xb2, 0x3a, 0xf2, 0x3e,
+	0xa6, 0x6a, 0xe6, 0x6e, 0xb6, 0x7a, 0xf6, 0x7e,
+	0x08, 0x80, 0x48, 0x84, 0x18, 0x90, 0x58, 0x94,
+	0x0c, 0xc0, 0x4c, 0xc4, 0x1c, 0xd0, 0x5c, 0xd4,
+	0x0a, 0x82, 0x4a, 0x86, 0x1a, 0x92, 0x5a, 0x96,
+	0x0e, 0xc2, 0x4e, 0xc6, 0x1e, 0xd2, 0x5e, 0xd6,
+	0x88, 0x88, 0xc8, 0x8c, 0x98, 0x98, 0xd8, 0x9c,
+	0x8c, 0xc8, 0xcc, 0xcc, 0x9c, 0xd8, 0xdc, 0xdc,
+	0x8a, 0x8a, 0xca, 0x8e, 0x9a, 0x9a, 0xda, 0x9e,
+	0x8e, 0xca, 0xce, 0xce, 0x9e, 0xda, 0xde, 0xde,
+	0x28, 0xa0, 0x68, 0xa4, 0x38, 0xb0, 0x78, 0xb4,
+	0x2c, 0xe0, 0x6c, 0xe4, 0x3c, 0xf0, 0x7c, 0xf4,
+	0x2a, 0xa2, 0x6a, 0xa6, 0x3a, 0xb2, 0x7a, 0xb6,
+	0x2e, 0xe2, 0x6e, 0xe6, 0x3e, 0xf2, 0x7e, 0xf6,
+	0xa8, 0xa8, 0xe8, 0xac, 0xb8, 0xb8, 0xf8, 0xbc,
+	0xac, 0xe8, 0xec, 0xec, 0xbc, 0xf8, 0xfc, 0xfc,
+	0xaa, 0xaa, 0xea, 0xae, 0xba, 0xba, 0xfa, 0xbe,
+	0xae, 0xea, 0xee, 0xee, 0xbe, 0xfa, 0xfe, 0xfe
+};
+
+static const u8 rs[256] = {
+	0x00, 0x00, 0x80, 0x80, 0x02, 0x02, 0x82, 0x82,
+	0x04, 0x04, 0x84, 0x84, 0x06, 0x06, 0x86, 0x86,
+	0x08, 0x08, 0x88, 0x88, 0x0a, 0x0a, 0x8a, 0x8a,
+	0x0c, 0x0c, 0x8c, 0x8c, 0x0e, 0x0e, 0x8e, 0x8e,
+	0x10, 0x10, 0x90, 0x90, 0x12, 0x12, 0x92, 0x92,
+	0x14, 0x14, 0x94, 0x94, 0x16, 0x16, 0x96, 0x96,
+	0x18, 0x18, 0x98, 0x98, 0x1a, 0x1a, 0x9a, 0x9a,
+	0x1c, 0x1c, 0x9c, 0x9c, 0x1e, 0x1e, 0x9e, 0x9e,
+	0x20, 0x20, 0xa0, 0xa0, 0x22, 0x22, 0xa2, 0xa2,
+	0x24, 0x24, 0xa4, 0xa4, 0x26, 0x26, 0xa6, 0xa6,
+	0x28, 0x28, 0xa8, 0xa8, 0x2a, 0x2a, 0xaa, 0xaa,
+	0x2c, 0x2c, 0xac, 0xac, 0x2e, 0x2e, 0xae, 0xae,
+	0x30, 0x30, 0xb0, 0xb0, 0x32, 0x32, 0xb2, 0xb2,
+	0x34, 0x34, 0xb4, 0xb4, 0x36, 0x36, 0xb6, 0xb6,
+	0x38, 0x38, 0xb8, 0xb8, 0x3a, 0x3a, 0xba, 0xba,
+	0x3c, 0x3c, 0xbc, 0xbc, 0x3e, 0x3e, 0xbe, 0xbe,
+	0x40, 0x40, 0xc0, 0xc0, 0x42, 0x42, 0xc2, 0xc2,
+	0x44, 0x44, 0xc4, 0xc4, 0x46, 0x46, 0xc6, 0xc6,
+	0x48, 0x48, 0xc8, 0xc8, 0x4a, 0x4a, 0xca, 0xca,
+	0x4c, 0x4c, 0xcc, 0xcc, 0x4e, 0x4e, 0xce, 0xce,
+	0x50, 0x50, 0xd0, 0xd0, 0x52, 0x52, 0xd2, 0xd2,
+	0x54, 0x54, 0xd4, 0xd4, 0x56, 0x56, 0xd6, 0xd6,
+	0x58, 0x58, 0xd8, 0xd8, 0x5a, 0x5a, 0xda, 0xda,
+	0x5c, 0x5c, 0xdc, 0xdc, 0x5e, 0x5e, 0xde, 0xde,
+	0x60, 0x60, 0xe0, 0xe0, 0x62, 0x62, 0xe2, 0xe2,
+	0x64, 0x64, 0xe4, 0xe4, 0x66, 0x66, 0xe6, 0xe6,
+	0x68, 0x68, 0xe8, 0xe8, 0x6a, 0x6a, 0xea, 0xea,
+	0x6c, 0x6c, 0xec, 0xec, 0x6e, 0x6e, 0xee, 0xee,
+	0x70, 0x70, 0xf0, 0xf0, 0x72, 0x72, 0xf2, 0xf2,
+	0x74, 0x74, 0xf4, 0xf4, 0x76, 0x76, 0xf6, 0xf6,
+	0x78, 0x78, 0xf8, 0xf8, 0x7a, 0x7a, 0xfa, 0xfa,
+	0x7c, 0x7c, 0xfc, 0xfc, 0x7e, 0x7e, 0xfe, 0xfe
+};
+
+static const u32 pc2[1024] = {
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00040000, 0x00000000, 0x04000000, 0x00100000,
+	0x00400000, 0x00000008, 0x00000800, 0x40000000,
+	0x00440000, 0x00000008, 0x04000800, 0x40100000,
+	0x00000400, 0x00000020, 0x08000000, 0x00000100,
+	0x00040400, 0x00000020, 0x0c000000, 0x00100100,
+	0x00400400, 0x00000028, 0x08000800, 0x40000100,
+	0x00440400, 0x00000028, 0x0c000800, 0x40100100,
+	0x80000000, 0x00000010, 0x00000000, 0x00800000,
+	0x80040000, 0x00000010, 0x04000000, 0x00900000,
+	0x80400000, 0x00000018, 0x00000800, 0x40800000,
+	0x80440000, 0x00000018, 0x04000800, 0x40900000,
+	0x80000400, 0x00000030, 0x08000000, 0x00800100,
+	0x80040400, 0x00000030, 0x0c000000, 0x00900100,
+	0x80400400, 0x00000038, 0x08000800, 0x40800100,
+	0x80440400, 0x00000038, 0x0c000800, 0x40900100,
+	0x10000000, 0x00000000, 0x00200000, 0x00001000,
+	0x10040000, 0x00000000, 0x04200000, 0x00101000,
+	0x10400000, 0x00000008, 0x00200800, 0x40001000,
+	0x10440000, 0x00000008, 0x04200800, 0x40101000,
+	0x10000400, 0x00000020, 0x08200000, 0x00001100,
+	0x10040400, 0x00000020, 0x0c200000, 0x00101100,
+	0x10400400, 0x00000028, 0x08200800, 0x40001100,
+	0x10440400, 0x00000028, 0x0c200800, 0x40101100,
+	0x90000000, 0x00000010, 0x00200000, 0x00801000,
+	0x90040000, 0x00000010, 0x04200000, 0x00901000,
+	0x90400000, 0x00000018, 0x00200800, 0x40801000,
+	0x90440000, 0x00000018, 0x04200800, 0x40901000,
+	0x90000400, 0x00000030, 0x08200000, 0x00801100,
+	0x90040400, 0x00000030, 0x0c200000, 0x00901100,
+	0x90400400, 0x00000038, 0x08200800, 0x40801100,
+	0x90440400, 0x00000038, 0x0c200800, 0x40901100,
+	0x00000200, 0x00080000, 0x00000000, 0x00000004,
+	0x00040200, 0x00080000, 0x04000000, 0x00100004,
+	0x00400200, 0x00080008, 0x00000800, 0x40000004,
+	0x00440200, 0x00080008, 0x04000800, 0x40100004,
+	0x00000600, 0x00080020, 0x08000000, 0x00000104,
+	0x00040600, 0x00080020, 0x0c000000, 0x00100104,
+	0x00400600, 0x00080028, 0x08000800, 0x40000104,
+	0x00440600, 0x00080028, 0x0c000800, 0x40100104,
+	0x80000200, 0x00080010, 0x00000000, 0x00800004,
+	0x80040200, 0x00080010, 0x04000000, 0x00900004,
+	0x80400200, 0x00080018, 0x00000800, 0x40800004,
+	0x80440200, 0x00080018, 0x04000800, 0x40900004,
+	0x80000600, 0x00080030, 0x08000000, 0x00800104,
+	0x80040600, 0x00080030, 0x0c000000, 0x00900104,
+	0x80400600, 0x00080038, 0x08000800, 0x40800104,
+	0x80440600, 0x00080038, 0x0c000800, 0x40900104,
+	0x10000200, 0x00080000, 0x00200000, 0x00001004,
+	0x10040200, 0x00080000, 0x04200000, 0x00101004,
+	0x10400200, 0x00080008, 0x00200800, 0x40001004,
+	0x10440200, 0x00080008, 0x04200800, 0x40101004,
+	0x10000600, 0x00080020, 0x08200000, 0x00001104,
+	0x10040600, 0x00080020, 0x0c200000, 0x00101104,
+	0x10400600, 0x00080028, 0x08200800, 0x40001104,
+	0x10440600, 0x00080028, 0x0c200800, 0x40101104,
+	0x90000200, 0x00080010, 0x00200000, 0x00801004,
+	0x90040200, 0x00080010, 0x04200000, 0x00901004,
+	0x90400200, 0x00080018, 0x00200800, 0x40801004,
+	0x90440200, 0x00080018, 0x04200800, 0x40901004,
+	0x90000600, 0x00080030, 0x08200000, 0x00801104,
+	0x90040600, 0x00080030, 0x0c200000, 0x00901104,
+	0x90400600, 0x00080038, 0x08200800, 0x40801104,
+	0x90440600, 0x00080038, 0x0c200800, 0x40901104,
+	0x00000002, 0x00002000, 0x20000000, 0x00000001,
+	0x00040002, 0x00002000, 0x24000000, 0x00100001,
+	0x00400002, 0x00002008, 0x20000800, 0x40000001,
+	0x00440002, 0x00002008, 0x24000800, 0x40100001,
+	0x00000402, 0x00002020, 0x28000000, 0x00000101,
+	0x00040402, 0x00002020, 0x2c000000, 0x00100101,
+	0x00400402, 0x00002028, 0x28000800, 0x40000101,
+	0x00440402, 0x00002028, 0x2c000800, 0x40100101,
+	0x80000002, 0x00002010, 0x20000000, 0x00800001,
+	0x80040002, 0x00002010, 0x24000000, 0x00900001,
+	0x80400002, 0x00002018, 0x20000800, 0x40800001,
+	0x80440002, 0x00002018, 0x24000800, 0x40900001,
+	0x80000402, 0x00002030, 0x28000000, 0x00800101,
+	0x80040402, 0x00002030, 0x2c000000, 0x00900101,
+	0x80400402, 0x00002038, 0x28000800, 0x40800101,
+	0x80440402, 0x00002038, 0x2c000800, 0x40900101,
+	0x10000002, 0x00002000, 0x20200000, 0x00001001,
+	0x10040002, 0x00002000, 0x24200000, 0x00101001,
+	0x10400002, 0x00002008, 0x20200800, 0x40001001,
+	0x10440002, 0x00002008, 0x24200800, 0x40101001,
+	0x10000402, 0x00002020, 0x28200000, 0x00001101,
+	0x10040402, 0x00002020, 0x2c200000, 0x00101101,
+	0x10400402, 0x00002028, 0x28200800, 0x40001101,
+	0x10440402, 0x00002028, 0x2c200800, 0x40101101,
+	0x90000002, 0x00002010, 0x20200000, 0x00801001,
+	0x90040002, 0x00002010, 0x24200000, 0x00901001,
+	0x90400002, 0x00002018, 0x20200800, 0x40801001,
+	0x90440002, 0x00002018, 0x24200800, 0x40901001,
+	0x90000402, 0x00002030, 0x28200000, 0x00801101,
+	0x90040402, 0x00002030, 0x2c200000, 0x00901101,
+	0x90400402, 0x00002038, 0x28200800, 0x40801101,
+	0x90440402, 0x00002038, 0x2c200800, 0x40901101,
+	0x00000202, 0x00082000, 0x20000000, 0x00000005,
+	0x00040202, 0x00082000, 0x24000000, 0x00100005,
+	0x00400202, 0x00082008, 0x20000800, 0x40000005,
+	0x00440202, 0x00082008, 0x24000800, 0x40100005,
+	0x00000602, 0x00082020, 0x28000000, 0x00000105,
+	0x00040602, 0x00082020, 0x2c000000, 0x00100105,
+	0x00400602, 0x00082028, 0x28000800, 0x40000105,
+	0x00440602, 0x00082028, 0x2c000800, 0x40100105,
+	0x80000202, 0x00082010, 0x20000000, 0x00800005,
+	0x80040202, 0x00082010, 0x24000000, 0x00900005,
+	0x80400202, 0x00082018, 0x20000800, 0x40800005,
+	0x80440202, 0x00082018, 0x24000800, 0x40900005,
+	0x80000602, 0x00082030, 0x28000000, 0x00800105,
+	0x80040602, 0x00082030, 0x2c000000, 0x00900105,
+	0x80400602, 0x00082038, 0x28000800, 0x40800105,
+	0x80440602, 0x00082038, 0x2c000800, 0x40900105,
+	0x10000202, 0x00082000, 0x20200000, 0x00001005,
+	0x10040202, 0x00082000, 0x24200000, 0x00101005,
+	0x10400202, 0x00082008, 0x20200800, 0x40001005,
+	0x10440202, 0x00082008, 0x24200800, 0x40101005,
+	0x10000602, 0x00082020, 0x28200000, 0x00001105,
+	0x10040602, 0x00082020, 0x2c200000, 0x00101105,
+	0x10400602, 0x00082028, 0x28200800, 0x40001105,
+	0x10440602, 0x00082028, 0x2c200800, 0x40101105,
+	0x90000202, 0x00082010, 0x20200000, 0x00801005,
+	0x90040202, 0x00082010, 0x24200000, 0x00901005,
+	0x90400202, 0x00082018, 0x20200800, 0x40801005,
+	0x90440202, 0x00082018, 0x24200800, 0x40901005,
+	0x90000602, 0x00082030, 0x28200000, 0x00801105,
+	0x90040602, 0x00082030, 0x2c200000, 0x00901105,
+	0x90400602, 0x00082038, 0x28200800, 0x40801105,
+	0x90440602, 0x00082038, 0x2c200800, 0x40901105,
+
+	0x00000000, 0x00000000, 0x00000000, 0x00000000,
+	0x00000000, 0x00000008, 0x00080000, 0x10000000,
+	0x02000000, 0x00000000, 0x00000080, 0x00001000,
+	0x02000000, 0x00000008, 0x00080080, 0x10001000,
+	0x00004000, 0x00000000, 0x00000040, 0x00040000,
+	0x00004000, 0x00000008, 0x00080040, 0x10040000,
+	0x02004000, 0x00000000, 0x000000c0, 0x00041000,
+	0x02004000, 0x00000008, 0x000800c0, 0x10041000,
+	0x00020000, 0x00008000, 0x08000000, 0x00200000,
+	0x00020000, 0x00008008, 0x08080000, 0x10200000,
+	0x02020000, 0x00008000, 0x08000080, 0x00201000,
+	0x02020000, 0x00008008, 0x08080080, 0x10201000,
+	0x00024000, 0x00008000, 0x08000040, 0x00240000,
+	0x00024000, 0x00008008, 0x08080040, 0x10240000,
+	0x02024000, 0x00008000, 0x080000c0, 0x00241000,
+	0x02024000, 0x00008008, 0x080800c0, 0x10241000,
+	0x00000000, 0x01000000, 0x00002000, 0x00000020,
+	0x00000000, 0x01000008, 0x00082000, 0x10000020,
+	0x02000000, 0x01000000, 0x00002080, 0x00001020,
+	0x02000000, 0x01000008, 0x00082080, 0x10001020,
+	0x00004000, 0x01000000, 0x00002040, 0x00040020,
+	0x00004000, 0x01000008, 0x00082040, 0x10040020,
+	0x02004000, 0x01000000, 0x000020c0, 0x00041020,
+	0x02004000, 0x01000008, 0x000820c0, 0x10041020,
+	0x00020000, 0x01008000, 0x08002000, 0x00200020,
+	0x00020000, 0x01008008, 0x08082000, 0x10200020,
+	0x02020000, 0x01008000, 0x08002080, 0x00201020,
+	0x02020000, 0x01008008, 0x08082080, 0x10201020,
+	0x00024000, 0x01008000, 0x08002040, 0x00240020,
+	0x00024000, 0x01008008, 0x08082040, 0x10240020,
+	0x02024000, 0x01008000, 0x080020c0, 0x00241020,
+	0x02024000, 0x01008008, 0x080820c0, 0x10241020,
+	0x00000400, 0x04000000, 0x00100000, 0x00000004,
+	0x00000400, 0x04000008, 0x00180000, 0x10000004,
+	0x02000400, 0x04000000, 0x00100080, 0x00001004,
+	0x02000400, 0x04000008, 0x00180080, 0x10001004,
+	0x00004400, 0x04000000, 0x00100040, 0x00040004,
+	0x00004400, 0x04000008, 0x00180040, 0x10040004,
+	0x02004400, 0x04000000, 0x001000c0, 0x00041004,
+	0x02004400, 0x04000008, 0x001800c0, 0x10041004,
+	0x00020400, 0x04008000, 0x08100000, 0x00200004,
+	0x00020400, 0x04008008, 0x08180000, 0x10200004,
+	0x02020400, 0x04008000, 0x08100080, 0x00201004,
+	0x02020400, 0x04008008, 0x08180080, 0x10201004,
+	0x00024400, 0x04008000, 0x08100040, 0x00240004,
+	0x00024400, 0x04008008, 0x08180040, 0x10240004,
+	0x02024400, 0x04008000, 0x081000c0, 0x00241004,
+	0x02024400, 0x04008008, 0x081800c0, 0x10241004,
+	0x00000400, 0x05000000, 0x00102000, 0x00000024,
+	0x00000400, 0x05000008, 0x00182000, 0x10000024,
+	0x02000400, 0x05000000, 0x00102080, 0x00001024,
+	0x02000400, 0x05000008, 0x00182080, 0x10001024,
+	0x00004400, 0x05000000, 0x00102040, 0x00040024,
+	0x00004400, 0x05000008, 0x00182040, 0x10040024,
+	0x02004400, 0x05000000, 0x001020c0, 0x00041024,
+	0x02004400, 0x05000008, 0x001820c0, 0x10041024,
+	0x00020400, 0x05008000, 0x08102000, 0x00200024,
+	0x00020400, 0x05008008, 0x08182000, 0x10200024,
+	0x02020400, 0x05008000, 0x08102080, 0x00201024,
+	0x02020400, 0x05008008, 0x08182080, 0x10201024,
+	0x00024400, 0x05008000, 0x08102040, 0x00240024,
+	0x00024400, 0x05008008, 0x08182040, 0x10240024,
+	0x02024400, 0x05008000, 0x081020c0, 0x00241024,
+	0x02024400, 0x05008008, 0x081820c0, 0x10241024,
+	0x00000800, 0x00010000, 0x20000000, 0x00000010,
+	0x00000800, 0x00010008, 0x20080000, 0x10000010,
+	0x02000800, 0x00010000, 0x20000080, 0x00001010,
+	0x02000800, 0x00010008, 0x20080080, 0x10001010,
+	0x00004800, 0x00010000, 0x20000040, 0x00040010,
+	0x00004800, 0x00010008, 0x20080040, 0x10040010,
+	0x02004800, 0x00010000, 0x200000c0, 0x00041010,
+	0x02004800, 0x00010008, 0x200800c0, 0x10041010,
+	0x00020800, 0x00018000, 0x28000000, 0x00200010,
+	0x00020800, 0x00018008, 0x28080000, 0x10200010,
+	0x02020800, 0x00018000, 0x28000080, 0x00201010,
+	0x02020800, 0x00018008, 0x28080080, 0x10201010,
+	0x00024800, 0x00018000, 0x28000040, 0x00240010,
+	0x00024800, 0x00018008, 0x28080040, 0x10240010,
+	0x02024800, 0x00018000, 0x280000c0, 0x00241010,
+	0x02024800, 0x00018008, 0x280800c0, 0x10241010,
+	0x00000800, 0x01010000, 0x20002000, 0x00000030,
+	0x00000800, 0x01010008, 0x20082000, 0x10000030,
+	0x02000800, 0x01010000, 0x20002080, 0x00001030,
+	0x02000800, 0x01010008, 0x20082080, 0x10001030,
+	0x00004800, 0x01010000, 0x20002040, 0x00040030,
+	0x00004800, 0x01010008, 0x20082040, 0x10040030,
+	0x02004800, 0x01010000, 0x200020c0, 0x00041030,
+	0x02004800, 0x01010008, 0x200820c0, 0x10041030,
+	0x00020800, 0x01018000, 0x28002000, 0x00200030,
+	0x00020800, 0x01018008, 0x28082000, 0x10200030,
+	0x02020800, 0x01018000, 0x28002080, 0x00201030,
+	0x02020800, 0x01018008, 0x28082080, 0x10201030,
+	0x00024800, 0x01018000, 0x28002040, 0x00240030,
+	0x00024800, 0x01018008, 0x28082040, 0x10240030,
+	0x02024800, 0x01018000, 0x280020c0, 0x00241030,
+	0x02024800, 0x01018008, 0x280820c0, 0x10241030,
+	0x00000c00, 0x04010000, 0x20100000, 0x00000014,
+	0x00000c00, 0x04010008, 0x20180000, 0x10000014,
+	0x02000c00, 0x04010000, 0x20100080, 0x00001014,
+	0x02000c00, 0x04010008, 0x20180080, 0x10001014,
+	0x00004c00, 0x04010000, 0x20100040, 0x00040014,
+	0x00004c00, 0x04010008, 0x20180040, 0x10040014,
+	0x02004c00, 0x04010000, 0x201000c0, 0x00041014,
+	0x02004c00, 0x04010008, 0x201800c0, 0x10041014,
+	0x00020c00, 0x04018000, 0x28100000, 0x00200014,
+	0x00020c00, 0x04018008, 0x28180000, 0x10200014,
+	0x02020c00, 0x04018000, 0x28100080, 0x00201014,
+	0x02020c00, 0x04018008, 0x28180080, 0x10201014,
+	0x00024c00, 0x04018000, 0x28100040, 0x00240014,
+	0x00024c00, 0x04018008, 0x28180040, 0x10240014,
+	0x02024c00, 0x04018000, 0x281000c0, 0x00241014,
+	0x02024c00, 0x04018008, 0x281800c0, 0x10241014,
+	0x00000c00, 0x05010000, 0x20102000, 0x00000034,
+	0x00000c00, 0x05010008, 0x20182000, 0x10000034,
+	0x02000c00, 0x05010000, 0x20102080, 0x00001034,
+	0x02000c00, 0x05010008, 0x20182080, 0x10001034,
+	0x00004c00, 0x05010000, 0x20102040, 0x00040034,
+	0x00004c00, 0x05010008, 0x20182040, 0x10040034,
+	0x02004c00, 0x05010000, 0x201020c0, 0x00041034,
+	0x02004c00, 0x05010008, 0x201820c0, 0x10041034,
+	0x00020c00, 0x05018000, 0x28102000, 0x00200034,
+	0x00020c00, 0x05018008, 0x28182000, 0x10200034,
+	0x02020c00, 0x05018000, 0x28102080, 0x00201034,
+	0x02020c00, 0x05018008, 0x28182080, 0x10201034,
+	0x00024c00, 0x05018000, 0x28102040, 0x00240034,
+	0x00024c00, 0x05018008, 0x28182040, 0x10240034,
+	0x02024c00, 0x05018000, 0x281020c0, 0x00241034,
+	0x02024c00, 0x05018008, 0x281820c0, 0x10241034
+};
+
+/* S-box lookup tables */
+
+static const u32 S1[64] = {
+	0x01010400, 0x00000000, 0x00010000, 0x01010404,
+	0x01010004, 0x00010404, 0x00000004, 0x00010000,
+	0x00000400, 0x01010400, 0x01010404, 0x00000400,
+	0x01000404, 0x01010004, 0x01000000, 0x00000004,
+	0x00000404, 0x01000400, 0x01000400, 0x00010400,
+	0x00010400, 0x01010000, 0x01010000, 0x01000404,
+	0x00010004, 0x01000004, 0x01000004, 0x00010004,
+	0x00000000, 0x00000404, 0x00010404, 0x01000000,
+	0x00010000, 0x01010404, 0x00000004, 0x01010000,
+	0x01010400, 0x01000000, 0x01000000, 0x00000400,
+	0x01010004, 0x00010000, 0x00010400, 0x01000004,
+	0x00000400, 0x00000004, 0x01000404, 0x00010404,
+	0x01010404, 0x00010004, 0x01010000, 0x01000404,
+	0x01000004, 0x00000404, 0x00010404, 0x01010400,
+	0x00000404, 0x01000400, 0x01000400, 0x00000000,
+	0x00010004, 0x00010400, 0x00000000, 0x01010004
+};
+
+static const u32 S2[64] = {
+	0x80108020, 0x80008000, 0x00008000, 0x00108020,
+	0x00100000, 0x00000020, 0x80100020, 0x80008020,
+	0x80000020, 0x80108020, 0x80108000, 0x80000000,
+	0x80008000, 0x00100000, 0x00000020, 0x80100020,
+	0x00108000, 0x00100020, 0x80008020, 0x00000000,
+	0x80000000, 0x00008000, 0x00108020, 0x80100000,
+	0x00100020, 0x80000020, 0x00000000, 0x00108000,
+	0x00008020, 0x80108000, 0x80100000, 0x00008020,
+	0x00000000, 0x00108020, 0x80100020, 0x00100000,
+	0x80008020, 0x80100000, 0x80108000, 0x00008000,
+	0x80100000, 0x80008000, 0x00000020, 0x80108020,
+	0x00108020, 0x00000020, 0x00008000, 0x80000000,
+	0x00008020, 0x80108000, 0x00100000, 0x80000020,
+	0x00100020, 0x80008020, 0x80000020, 0x00100020,
+	0x00108000, 0x00000000, 0x80008000, 0x00008020,
+	0x80000000, 0x80100020, 0x80108020, 0x00108000
+};
+
+static const u32 S3[64] = {
+	0x00000208, 0x08020200, 0x00000000, 0x08020008,
+	0x08000200, 0x00000000, 0x00020208, 0x08000200,
+	0x00020008, 0x08000008, 0x08000008, 0x00020000,
+	0x08020208, 0x00020008, 0x08020000, 0x00000208,
+	0x08000000, 0x00000008, 0x08020200, 0x00000200,
+	0x00020200, 0x08020000, 0x08020008, 0x00020208,
+	0x08000208, 0x00020200, 0x00020000, 0x08000208,
+	0x00000008, 0x08020208, 0x00000200, 0x08000000,
+	0x08020200, 0x08000000, 0x00020008, 0x00000208,
+	0x00020000, 0x08020200, 0x08000200, 0x00000000,
+	0x00000200, 0x00020008, 0x08020208, 0x08000200,
+	0x08000008, 0x00000200, 0x00000000, 0x08020008,
+	0x08000208, 0x00020000, 0x08000000, 0x08020208,
+	0x00000008, 0x00020208, 0x00020200, 0x08000008,
+	0x08020000, 0x08000208, 0x00000208, 0x08020000,
+	0x00020208, 0x00000008, 0x08020008, 0x00020200
+};
+
+static const u32 S4[64] = {
+	0x00802001, 0x00002081, 0x00002081, 0x00000080,
+	0x00802080, 0x00800081, 0x00800001, 0x00002001,
+	0x00000000, 0x00802000, 0x00802000, 0x00802081,
+	0x00000081, 0x00000000, 0x00800080, 0x00800001,
+	0x00000001, 0x00002000, 0x00800000, 0x00802001,
+	0x00000080, 0x00800000, 0x00002001, 0x00002080,
+	0x00800081, 0x00000001, 0x00002080, 0x00800080,
+	0x00002000, 0x00802080, 0x00802081, 0x00000081,
+	0x00800080, 0x00800001, 0x00802000, 0x00802081,
+	0x00000081, 0x00000000, 0x00000000, 0x00802000,
+	0x00002080, 0x00800080, 0x00800081, 0x00000001,
+	0x00802001, 0x00002081, 0x00002081, 0x00000080,
+	0x00802081, 0x00000081, 0x00000001, 0x00002000,
+	0x00800001, 0x00002001, 0x00802080, 0x00800081,
+	0x00002001, 0x00002080, 0x00800000, 0x00802001,
+	0x00000080, 0x00800000, 0x00002000, 0x00802080
+};
+
+static const u32 S5[64] = {
+	0x00000100, 0x02080100, 0x02080000, 0x42000100,
+	0x00080000, 0x00000100, 0x40000000, 0x02080000,
+	0x40080100, 0x00080000, 0x02000100, 0x40080100,
+	0x42000100, 0x42080000, 0x00080100, 0x40000000,
+	0x02000000, 0x40080000, 0x40080000, 0x00000000,
+	0x40000100, 0x42080100, 0x42080100, 0x02000100,
+	0x42080000, 0x40000100, 0x00000000, 0x42000000,
+	0x02080100, 0x02000000, 0x42000000, 0x00080100,
+	0x00080000, 0x42000100, 0x00000100, 0x02000000,
+	0x40000000, 0x02080000, 0x42000100, 0x40080100,
+	0x02000100, 0x40000000, 0x42080000, 0x02080100,
+	0x40080100, 0x00000100, 0x02000000, 0x42080000,
+	0x42080100, 0x00080100, 0x42000000, 0x42080100,
+	0x02080000, 0x00000000, 0x40080000, 0x42000000,
+	0x00080100, 0x02000100, 0x40000100, 0x00080000,
+	0x00000000, 0x40080000, 0x02080100, 0x40000100
+};
+
+static const u32 S6[64] = {
+	0x20000010, 0x20400000, 0x00004000, 0x20404010,
+	0x20400000, 0x00000010, 0x20404010, 0x00400000,
+	0x20004000, 0x00404010, 0x00400000, 0x20000010,
+	0x00400010, 0x20004000, 0x20000000, 0x00004010,
+	0x00000000, 0x00400010, 0x20004010, 0x00004000,
+	0x00404000, 0x20004010, 0x00000010, 0x20400010,
+	0x20400010, 0x00000000, 0x00404010, 0x20404000,
+	0x00004010, 0x00404000, 0x20404000, 0x20000000,
+	0x20004000, 0x00000010, 0x20400010, 0x00404000,
+	0x20404010, 0x00400000, 0x00004010, 0x20000010,
+	0x00400000, 0x20004000, 0x20000000, 0x00004010,
+	0x20000010, 0x20404010, 0x00404000, 0x20400000,
+	0x00404010, 0x20404000, 0x00000000, 0x20400010,
+	0x00000010, 0x00004000, 0x20400000, 0x00404010,
+	0x00004000, 0x00400010, 0x20004010, 0x00000000,
+	0x20404000, 0x20000000, 0x00400010, 0x20004010
+};
+
+static const u32 S7[64] = {
+	0x00200000, 0x04200002, 0x04000802, 0x00000000,
+	0x00000800, 0x04000802, 0x00200802, 0x04200800,
+	0x04200802, 0x00200000, 0x00000000, 0x04000002,
+	0x00000002, 0x04000000, 0x04200002, 0x00000802,
+	0x04000800, 0x00200802, 0x00200002, 0x04000800,
+	0x04000002, 0x04200000, 0x04200800, 0x00200002,
+	0x04200000, 0x00000800, 0x00000802, 0x04200802,
+	0x00200800, 0x00000002, 0x04000000, 0x00200800,
+	0x04000000, 0x00200800, 0x00200000, 0x04000802,
+	0x04000802, 0x04200002, 0x04200002, 0x00000002,
+	0x00200002, 0x04000000, 0x04000800, 0x00200000,
+	0x04200800, 0x00000802, 0x00200802, 0x04200800,
+	0x00000802, 0x04000002, 0x04200802, 0x04200000,
+	0x00200800, 0x00000000, 0x00000002, 0x04200802,
+	0x00000000, 0x00200802, 0x04200000, 0x00000800,
+	0x04000002, 0x04000800, 0x00000800, 0x00200002
+};
+
+static const u32 S8[64] = {
+	0x10001040, 0x00001000, 0x00040000, 0x10041040,
+	0x10000000, 0x10001040, 0x00000040, 0x10000000,
+	0x00040040, 0x10040000, 0x10041040, 0x00041000,
+	0x10041000, 0x00041040, 0x00001000, 0x00000040,
+	0x10040000, 0x10000040, 0x10001000, 0x00001040,
+	0x00041000, 0x00040040, 0x10040040, 0x10041000,
+	0x00001040, 0x00000000, 0x00000000, 0x10040040,
+	0x10000040, 0x10001000, 0x00041040, 0x00040000,
+	0x00041040, 0x00040000, 0x10041000, 0x00001000,
+	0x00000040, 0x10040040, 0x00001000, 0x00041040,
+	0x10001000, 0x00000040, 0x10000040, 0x10040000,
+	0x10040040, 0x10000000, 0x00040000, 0x10001040,
+	0x00000000, 0x10041040, 0x00040040, 0x10000040,
+	0x10040000, 0x10001000, 0x10001040, 0x00000000,
+	0x10041040, 0x00041000, 0x00041000, 0x00001040,
+	0x00001040, 0x00040040, 0x10000000, 0x10041000
+};
+
+/* Encryption components: IP, FP, and round function */
+
+#define IP(L, R, T)		\
+	ROL(R, 4);		\
+	T  = L;			\
+	L ^= R;			\
+	L &= 0xf0f0f0f0;	\
+	R ^= L;			\
+	L ^= T;			\
+	ROL(R, 12);		\
+	T  = L;			\
+	L ^= R;			\
+	L &= 0xffff0000;	\
+	R ^= L;			\
+	L ^= T;			\
+	ROR(R, 14);		\
+	T  = L;			\
+	L ^= R;			\
+	L &= 0xcccccccc;	\
+	R ^= L;			\
+	L ^= T;			\
+	ROL(R, 6);		\
+	T  = L;			\
+	L ^= R;			\
+	L &= 0xff00ff00;	\
+	R ^= L;			\
+	L ^= T;			\
+	ROR(R, 7);		\
+	T  = L;			\
+	L ^= R;			\
+	L &= 0xaaaaaaaa;	\
+	R ^= L;			\
+	L ^= T;			\
+	ROL(L, 1);
+
+#define FP(L, R, T)		\
+	ROR(L, 1);		\
+	T  = L;			\
+	L ^= R;			\
+	L &= 0xaaaaaaaa;	\
+	R ^= L;			\
+	L ^= T;			\
+	ROL(R, 7);		\
+	T  = L;			\
+	L ^= R;			\
+	L &= 0xff00ff00;	\
+	R ^= L;			\
+	L ^= T;			\
+	ROR(R, 6);		\
+	T  = L;			\
+	L ^= R;			\
+	L &= 0xcccccccc;	\
+	R ^= L;			\
+	L ^= T;			\
+	ROL(R, 14);		\
+	T  = L;			\
+	L ^= R;			\
+	L &= 0xffff0000;	\
+	R ^= L;			\
+	L ^= T;			\
+	ROR(R, 12);		\
+	T  = L;			\
+	L ^= R;			\
+	L &= 0xf0f0f0f0;	\
+	R ^= L;			\
+	L ^= T;			\
+	ROR(R, 4);
+
+#define ROUND(L, R, A, B, K, d)					\
+	B = K[0];			A = K[1];	K += d;	\
+	B ^= R;				A ^= R;			\
+	B &= 0x3f3f3f3f;		ROR(A, 4);		\
+	L ^= S8[0xff & B];		A &= 0x3f3f3f3f;	\
+	L ^= S6[0xff & (B >> 8)];	B >>= 16;		\
+	L ^= S7[0xff & A];					\
+	L ^= S5[0xff & (A >> 8)];	A >>= 16;		\
+	L ^= S4[0xff & B];					\
+	L ^= S2[0xff & (B >> 8)];				\
+	L ^= S3[0xff & A];					\
+	L ^= S1[0xff & (A >> 8)];
+
+/*
+ * PC2 lookup tables are organized as 2 consecutive sets of 4 interleaved
+ * tables of 128 elements.  One set is for C_i and the other for D_i, while
+ * the 4 interleaved tables correspond to four 7-bit subsets of C_i or D_i.
+ *
+ * After PC1 each of the variables a,b,c,d contains a 7 bit subset of C_i
+ * or D_i in bits 7-1 (bit 0 being the least significant).
+ */
+
+#define T1(x) pt[2 * (x) + 0]
+#define T2(x) pt[2 * (x) + 1]
+#define T3(x) pt[2 * (x) + 2]
+#define T4(x) pt[2 * (x) + 3]
+
+#define DES_PC2(a, b, c, d) (T4(d) | T3(c) | T2(b) | T1(a))
+
+/*
+ * Encryption key expansion
+ *
+ * RFC2451: Weak key checks SHOULD be performed.
+ *
+ * FIPS 74:
+ *
+ *   Keys having duals are keys which produce all zeros, all ones, or
+ *   alternating zero-one patterns in the C and D registers after Permuted
+ *   Choice 1 has operated on the key.
+ *
+ */
+static unsigned long des_ekey(u32 *pe, const u8 *k)
+{
+	/* K&R: long is at least 32 bits */
+	unsigned long a, b, c, d, w;
+	const u32 *pt = pc2;
+
+	d = k[4]; d &= 0x0e; d <<= 4; d |= k[0] & 0x1e; d = pc1[d];
+	c = k[5]; c &= 0x0e; c <<= 4; c |= k[1] & 0x1e; c = pc1[c];
+	b = k[6]; b &= 0x0e; b <<= 4; b |= k[2] & 0x1e; b = pc1[b];
+	a = k[7]; a &= 0x0e; a <<= 4; a |= k[3] & 0x1e; a = pc1[a];
+
+	pe[15 * 2 + 0] = DES_PC2(a, b, c, d); d = rs[d];
+	pe[14 * 2 + 0] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
+	pe[13 * 2 + 0] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
+	pe[12 * 2 + 0] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
+	pe[11 * 2 + 0] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
+	pe[10 * 2 + 0] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
+	pe[ 9 * 2 + 0] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
+	pe[ 8 * 2 + 0] = DES_PC2(d, a, b, c); c = rs[c];
+	pe[ 7 * 2 + 0] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
+	pe[ 6 * 2 + 0] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
+	pe[ 5 * 2 + 0] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
+	pe[ 4 * 2 + 0] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
+	pe[ 3 * 2 + 0] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
+	pe[ 2 * 2 + 0] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
+	pe[ 1 * 2 + 0] = DES_PC2(c, d, a, b); b = rs[b];
+	pe[ 0 * 2 + 0] = DES_PC2(b, c, d, a);
+
+	/* Check if first half is weak */
+	w  = (a ^ c) | (b ^ d) | (rs[a] ^ c) | (b ^ rs[d]);
+
+	/* Skip to next table set */
+	pt += 512;
+
+	d = k[0]; d &= 0xe0; d >>= 4; d |= k[4] & 0xf0; d = pc1[d + 1];
+	c = k[1]; c &= 0xe0; c >>= 4; c |= k[5] & 0xf0; c = pc1[c + 1];
+	b = k[2]; b &= 0xe0; b >>= 4; b |= k[6] & 0xf0; b = pc1[b + 1];
+	a = k[3]; a &= 0xe0; a >>= 4; a |= k[7] & 0xf0; a = pc1[a + 1];
+
+	/* Check if second half is weak */
+	w |= (a ^ c) | (b ^ d) | (rs[a] ^ c) | (b ^ rs[d]);
+
+	pe[15 * 2 + 1] = DES_PC2(a, b, c, d); d = rs[d];
+	pe[14 * 2 + 1] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
+	pe[13 * 2 + 1] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
+	pe[12 * 2 + 1] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
+	pe[11 * 2 + 1] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
+	pe[10 * 2 + 1] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
+	pe[ 9 * 2 + 1] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
+	pe[ 8 * 2 + 1] = DES_PC2(d, a, b, c); c = rs[c];
+	pe[ 7 * 2 + 1] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
+	pe[ 6 * 2 + 1] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
+	pe[ 5 * 2 + 1] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
+	pe[ 4 * 2 + 1] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
+	pe[ 3 * 2 + 1] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
+	pe[ 2 * 2 + 1] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
+	pe[ 1 * 2 + 1] = DES_PC2(c, d, a, b); b = rs[b];
+	pe[ 0 * 2 + 1] = DES_PC2(b, c, d, a);
+
+	/* Fixup: 2413 5768 -> 1357 2468 */
+	for (d = 0; d < 16; ++d) {
+		a = pe[2 * d];
+		b = pe[2 * d + 1];
+		c = a ^ b;
+		c &= 0xffff0000;
+		a ^= c;
+		b ^= c;
+		ROL(b, 18);
+		pe[2 * d] = a;
+		pe[2 * d + 1] = b;
+	}
+
+	/* Zero if weak key */
+	return w;
+}
+
+int des_expand_key(struct des_ctx *ctx, const u8 *key, unsigned int keylen)
+{
+	if (keylen != DES_KEY_SIZE)
+		return -EINVAL;
+
+	return des_ekey(ctx->expkey, key) ? 0 : -ENOKEY;
+}
+EXPORT_SYMBOL_GPL(des_expand_key);
+
+/*
+ * Decryption key expansion
+ *
+ * No weak key checking is performed, as this is only used by triple DES
+ *
+ */
+static void dkey(u32 *pe, const u8 *k)
+{
+	/* K&R: long is at least 32 bits */
+	unsigned long a, b, c, d;
+	const u32 *pt = pc2;
+
+	d = k[4]; d &= 0x0e; d <<= 4; d |= k[0] & 0x1e; d = pc1[d];
+	c = k[5]; c &= 0x0e; c <<= 4; c |= k[1] & 0x1e; c = pc1[c];
+	b = k[6]; b &= 0x0e; b <<= 4; b |= k[2] & 0x1e; b = pc1[b];
+	a = k[7]; a &= 0x0e; a <<= 4; a |= k[3] & 0x1e; a = pc1[a];
+
+	pe[ 0 * 2] = DES_PC2(a, b, c, d); d = rs[d];
+	pe[ 1 * 2] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
+	pe[ 2 * 2] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
+	pe[ 3 * 2] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
+	pe[ 4 * 2] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
+	pe[ 5 * 2] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
+	pe[ 6 * 2] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
+	pe[ 7 * 2] = DES_PC2(d, a, b, c); c = rs[c];
+	pe[ 8 * 2] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
+	pe[ 9 * 2] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
+	pe[10 * 2] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
+	pe[11 * 2] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
+	pe[12 * 2] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
+	pe[13 * 2] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
+	pe[14 * 2] = DES_PC2(c, d, a, b); b = rs[b];
+	pe[15 * 2] = DES_PC2(b, c, d, a);
+
+	/* Skip to next table set */
+	pt += 512;
+
+	d = k[0]; d &= 0xe0; d >>= 4; d |= k[4] & 0xf0; d = pc1[d + 1];
+	c = k[1]; c &= 0xe0; c >>= 4; c |= k[5] & 0xf0; c = pc1[c + 1];
+	b = k[2]; b &= 0xe0; b >>= 4; b |= k[6] & 0xf0; b = pc1[b + 1];
+	a = k[3]; a &= 0xe0; a >>= 4; a |= k[7] & 0xf0; a = pc1[a + 1];
+
+	pe[ 0 * 2 + 1] = DES_PC2(a, b, c, d); d = rs[d];
+	pe[ 1 * 2 + 1] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
+	pe[ 2 * 2 + 1] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
+	pe[ 3 * 2 + 1] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
+	pe[ 4 * 2 + 1] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
+	pe[ 5 * 2 + 1] = DES_PC2(d, a, b, c); c = rs[c]; b = rs[b];
+	pe[ 6 * 2 + 1] = DES_PC2(b, c, d, a); a = rs[a]; d = rs[d];
+	pe[ 7 * 2 + 1] = DES_PC2(d, a, b, c); c = rs[c];
+	pe[ 8 * 2 + 1] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
+	pe[ 9 * 2 + 1] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
+	pe[10 * 2 + 1] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
+	pe[11 * 2 + 1] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
+	pe[12 * 2 + 1] = DES_PC2(c, d, a, b); b = rs[b]; a = rs[a];
+	pe[13 * 2 + 1] = DES_PC2(a, b, c, d); d = rs[d]; c = rs[c];
+	pe[14 * 2 + 1] = DES_PC2(c, d, a, b); b = rs[b];
+	pe[15 * 2 + 1] = DES_PC2(b, c, d, a);
+
+	/* Fixup: 2413 5768 -> 1357 2468 */
+	for (d = 0; d < 16; ++d) {
+		a = pe[2 * d];
+		b = pe[2 * d + 1];
+		c = a ^ b;
+		c &= 0xffff0000;
+		a ^= c;
+		b ^= c;
+		ROL(b, 18);
+		pe[2 * d] = a;
+		pe[2 * d + 1] = b;
+	}
+}
+
+void des_encrypt(const struct des_ctx *ctx, u8 *dst, const u8 *src)
+{
+	const u32 *K = ctx->expkey;
+	u32 L, R, A, B;
+	int i;
+
+	L = get_unaligned_le32(src);
+	R = get_unaligned_le32(src + 4);
+
+	IP(L, R, A);
+	for (i = 0; i < 8; i++) {
+		ROUND(L, R, A, B, K, 2);
+		ROUND(R, L, A, B, K, 2);
+	}
+	FP(R, L, A);
+
+	put_unaligned_le32(R, dst);
+	put_unaligned_le32(L, dst + 4);
+}
+EXPORT_SYMBOL_GPL(des_encrypt);
+
+void des_decrypt(const struct des_ctx *ctx, u8 *dst, const u8 *src)
+{
+	const u32 *K = ctx->expkey + DES_EXPKEY_WORDS - 2;
+	u32 L, R, A, B;
+	int i;
+
+	L = get_unaligned_le32(src);
+	R = get_unaligned_le32(src + 4);
+
+	IP(L, R, A);
+	for (i = 0; i < 8; i++) {
+		ROUND(L, R, A, B, K, -2);
+		ROUND(R, L, A, B, K, -2);
+	}
+	FP(R, L, A);
+
+	put_unaligned_le32(R, dst);
+	put_unaligned_le32(L, dst + 4);
+}
+EXPORT_SYMBOL_GPL(des_decrypt);
+
+int des3_ede_expand_key(struct des3_ede_ctx *ctx, const u8 *key,
+			unsigned int keylen)
+{
+	u32 *pe = ctx->expkey;
+	int err;
+
+	if (keylen != DES3_EDE_KEY_SIZE)
+		return -EINVAL;
+
+	err = des3_ede_verify_key(key, keylen, true);
+	if (err && err != -ENOKEY)
+		return err;
+
+	des_ekey(pe, key); pe += DES_EXPKEY_WORDS; key += DES_KEY_SIZE;
+	dkey(pe, key); pe += DES_EXPKEY_WORDS; key += DES_KEY_SIZE;
+	des_ekey(pe, key);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(des3_ede_expand_key);
+
+void des3_ede_encrypt(const struct des3_ede_ctx *dctx, u8 *dst, const u8 *src)
+{
+	const u32 *K = dctx->expkey;
+	u32 L, R, A, B;
+	int i;
+
+	L = get_unaligned_le32(src);
+	R = get_unaligned_le32(src + 4);
+
+	IP(L, R, A);
+	for (i = 0; i < 8; i++) {
+		ROUND(L, R, A, B, K, 2);
+		ROUND(R, L, A, B, K, 2);
+	}
+	for (i = 0; i < 8; i++) {
+		ROUND(R, L, A, B, K, 2);
+		ROUND(L, R, A, B, K, 2);
+	}
+	for (i = 0; i < 8; i++) {
+		ROUND(L, R, A, B, K, 2);
+		ROUND(R, L, A, B, K, 2);
+	}
+	FP(R, L, A);
+
+	put_unaligned_le32(R, dst);
+	put_unaligned_le32(L, dst + 4);
+}
+EXPORT_SYMBOL_GPL(des3_ede_encrypt);
+
+void des3_ede_decrypt(const struct des3_ede_ctx *dctx, u8 *dst, const u8 *src)
+{
+	const u32 *K = dctx->expkey + DES3_EDE_EXPKEY_WORDS - 2;
+	u32 L, R, A, B;
+	int i;
+
+	L = get_unaligned_le32(src);
+	R = get_unaligned_le32(src + 4);
+
+	IP(L, R, A);
+	for (i = 0; i < 8; i++) {
+		ROUND(L, R, A, B, K, -2);
+		ROUND(R, L, A, B, K, -2);
+	}
+	for (i = 0; i < 8; i++) {
+		ROUND(R, L, A, B, K, -2);
+		ROUND(L, R, A, B, K, -2);
+	}
+	for (i = 0; i < 8; i++) {
+		ROUND(L, R, A, B, K, -2);
+		ROUND(R, L, A, B, K, -2);
+	}
+	FP(R, L, A);
+
+	put_unaligned_le32(R, dst);
+	put_unaligned_le32(L, dst + 4);
+}
+EXPORT_SYMBOL_GPL(des3_ede_decrypt);
+
+MODULE_LICENSE("GPL");
-- 
2.17.1

