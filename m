Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012354D26CF
	for <lists+linux-crypto@lfdr.de>; Wed,  9 Mar 2022 05:06:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbiCIDVF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 8 Mar 2022 22:21:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiCIDVE (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 8 Mar 2022 22:21:04 -0500
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276131598D7
        for <linux-crypto@vger.kernel.org>; Tue,  8 Mar 2022 19:20:06 -0800 (PST)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nRmrq-0002wc-2I; Wed, 09 Mar 2022 14:20:03 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 09 Mar 2022 15:20:02 +1200
Date:   Wed, 9 Mar 2022 15:20:01 +1200
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Harsha <harsha.harsha@xilinx.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: crypto: xilinx - Turn SHA into a tristate and allow COMPILE_TEST
Message-ID: <Yigc4cQlTJRRZsQg@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch turns the new SHA driver into a tristate and also allows
compile testing.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/Kconfig b/drivers/crypto/Kconfig
index 5d7508230b7d..97455a5f05c1 100644
--- a/drivers/crypto/Kconfig
+++ b/drivers/crypto/Kconfig
@@ -809,8 +809,8 @@ config CRYPTO_DEV_ZYNQMP_AES
 	  for AES algorithms.
 
 config CRYPTO_DEV_ZYNQMP_SHA3
-	bool "Support for Xilinx ZynqMP SHA3 hardware accelerator"
-	depends on ZYNQMP_FIRMWARE
+	tristate "Support for Xilinx ZynqMP SHA3 hardware accelerator"
+	depends on ZYNQMP_FIRMWARE || COMPILE_TEST
 	select CRYPTO_SHA3
 	help
 	  Xilinx ZynqMP has SHA3 engine used for secure hash calculation.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
