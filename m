Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE20EB49D5
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Sep 2019 10:50:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389188AbfIQIuU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 17 Sep 2019 04:50:20 -0400
Received: from foss.arm.com ([217.140.110.172]:53126 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728698AbfIQIuU (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 17 Sep 2019 04:50:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 90B69142F;
        Tue, 17 Sep 2019 01:50:19 -0700 (PDT)
Received: from e111045-lin.cambridge.arm.com (e120756.arm.com [10.1.39.60])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F3B063F575;
        Tue, 17 Sep 2019 01:50:18 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@arm.com>
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH 2/2] crypto: arm/aes-ce - add dependency on AES library
Date:   Tue, 17 Sep 2019 09:50:01 +0100
Message-Id: <20190917085001.792-2-ard.biesheuvel@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190917085001.792-1-ard.biesheuvel@arm.com>
References: <20190917085001.792-1-ard.biesheuvel@arm.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Ard Biesheuvel <ard.biesheuvel@linaro.org>

The ARM accelerated AES driver depends on the new AES library for
its non-SIMD fallback so express this in its Kconfig declaration.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm/crypto/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/crypto/Kconfig b/arch/arm/crypto/Kconfig
index b24df84a1d7a..043b0b18bf7e 100644
--- a/arch/arm/crypto/Kconfig
+++ b/arch/arm/crypto/Kconfig
@@ -98,6 +98,7 @@ config CRYPTO_AES_ARM_CE
 	tristate "Accelerated AES using ARMv8 Crypto Extensions"
 	depends on KERNEL_MODE_NEON
 	select CRYPTO_BLKCIPHER
+	select CRYPTO_LIB_AES
 	select CRYPTO_SIMD
 	help
 	  Use an implementation of AES in CBC, CTR and XTS modes that uses
-- 
2.17.1

