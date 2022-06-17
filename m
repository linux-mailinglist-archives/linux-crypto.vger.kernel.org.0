Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159D454F4B7
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Jun 2022 11:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381159AbiFQJ7x (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 17 Jun 2022 05:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380929AbiFQJ7v (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 17 Jun 2022 05:59:51 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2211566F85;
        Fri, 17 Jun 2022 02:59:51 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 032CF1570;
        Fri, 17 Jun 2022 02:59:51 -0700 (PDT)
Received: from ampere-altra-2-1.usa.Arm.com (ampere-altra-2-1.usa.arm.com [10.118.91.158])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B9EB83F800;
        Fri, 17 Jun 2022 02:59:50 -0700 (PDT)
From:   Yoan Picchi <yoan.picchi@arm.com>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>, qat-linux@intel.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Andre Przywara <andre.przywara@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v3 2/2] crypto: qat - Removes the x86 dependency on the QAT drivers
Date:   Fri, 17 Jun 2022 09:59:45 +0000
Message-Id: <20220617095945.437601-3-yoan.picchi@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220617095945.437601-1-yoan.picchi@arm.com>
References: <20220617095945.437601-1-yoan.picchi@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This dependency looks outdated. After the previous patch, we have been able
to use this driver to encrypt some data and to create working VF on arm64.
We have not tested it yet on any big endian machine, hence the new dependency

Signed-off-by: Yoan Picchi <yoan.picchi@arm.com>
---
 drivers/crypto/qat/Kconfig | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/qat/Kconfig b/drivers/crypto/qat/Kconfig
index 4b90c0f22b03..1220cc86f910 100644
--- a/drivers/crypto/qat/Kconfig
+++ b/drivers/crypto/qat/Kconfig
@@ -17,7 +17,7 @@ config CRYPTO_DEV_QAT
 
 config CRYPTO_DEV_QAT_DH895xCC
 	tristate "Support for Intel(R) DH895xCC"
-	depends on X86 && PCI
+	depends on PCI && (!CPU_BIG_ENDIAN || COMPILE_TEST)
 	select CRYPTO_DEV_QAT
 	help
 	  Support for Intel(R) DH895xcc with Intel(R) QuickAssist Technology
@@ -28,7 +28,7 @@ config CRYPTO_DEV_QAT_DH895xCC
 
 config CRYPTO_DEV_QAT_C3XXX
 	tristate "Support for Intel(R) C3XXX"
-	depends on X86 && PCI
+	depends on PCI && (!CPU_BIG_ENDIAN || COMPILE_TEST)
 	select CRYPTO_DEV_QAT
 	help
 	  Support for Intel(R) C3xxx with Intel(R) QuickAssist Technology
@@ -39,7 +39,7 @@ config CRYPTO_DEV_QAT_C3XXX
 
 config CRYPTO_DEV_QAT_C62X
 	tristate "Support for Intel(R) C62X"
-	depends on X86 && PCI
+	depends on PCI && (!CPU_BIG_ENDIAN || COMPILE_TEST)
 	select CRYPTO_DEV_QAT
 	help
 	  Support for Intel(R) C62x with Intel(R) QuickAssist Technology
@@ -50,7 +50,7 @@ config CRYPTO_DEV_QAT_C62X
 
 config CRYPTO_DEV_QAT_4XXX
 	tristate "Support for Intel(R) QAT_4XXX"
-	depends on X86 && PCI
+	depends on PCI && (!CPU_BIG_ENDIAN || COMPILE_TEST)
 	select CRYPTO_DEV_QAT
 	help
 	  Support for Intel(R) QuickAssist Technology QAT_4xxx
@@ -61,7 +61,7 @@ config CRYPTO_DEV_QAT_4XXX
 
 config CRYPTO_DEV_QAT_DH895xCCVF
 	tristate "Support for Intel(R) DH895xCC Virtual Function"
-	depends on X86 && PCI
+	depends on PCI && (!CPU_BIG_ENDIAN || COMPILE_TEST)
 	select PCI_IOV
 	select CRYPTO_DEV_QAT
 
@@ -74,7 +74,7 @@ config CRYPTO_DEV_QAT_DH895xCCVF
 
 config CRYPTO_DEV_QAT_C3XXXVF
 	tristate "Support for Intel(R) C3XXX Virtual Function"
-	depends on X86 && PCI
+	depends on PCI && (!CPU_BIG_ENDIAN || COMPILE_TEST)
 	select PCI_IOV
 	select CRYPTO_DEV_QAT
 	help
@@ -86,7 +86,7 @@ config CRYPTO_DEV_QAT_C3XXXVF
 
 config CRYPTO_DEV_QAT_C62XVF
 	tristate "Support for Intel(R) C62X Virtual Function"
-	depends on X86 && PCI
+	depends on PCI && (!CPU_BIG_ENDIAN || COMPILE_TEST)
 	select PCI_IOV
 	select CRYPTO_DEV_QAT
 	help
-- 
2.25.1

