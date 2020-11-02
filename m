Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2AF12A2BF3
	for <lists+linux-crypto@lfdr.de>; Mon,  2 Nov 2020 14:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgKBNsb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 2 Nov 2020 08:48:31 -0500
Received: from mail.zx2c4.com ([192.95.5.64]:45153 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgKBNs3 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 2 Nov 2020 08:48:29 -0500
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 896c32e4;
        Mon, 2 Nov 2020 13:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=71XZlg6/c3iawWaGSIq+uWKMNVQ=; b=y4jbxsBBUVtaEJA2olkG
        kOVMXd1bwblSgXtJPUfuN/ju7quUc+F8n5awczprC0XbyZoAVPkuW00TxMOri6aS
        6SwDXJbiALlh52hJDwDT2Ae4RH1OmeMN37KXvixtIaYC45ySzf0uODAX9lap3VpU
        aZuua6kRr57iBLJ3DQaFyVjk9NGod7ljZXVrGR4OIA+AjEoGB1vByZPwfzY5cTve
        Y07yY/qzWLvlI35wDunLyx3GzG6sq7TzZyLpNH3hHd1+8J6wjai1/BmuIRYns1Io
        leqrCgoCphnpFhbHCQUKsZIOswrSFVXl4Wx6Y4x2Q9QMFM1Otq9i8YpLwCG2sYD0
        CQ==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 7ab7ed02 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 2 Nov 2020 13:46:32 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH crypto] crypto: Kconfig - CRYPTO_MANAGER_EXTRA_TESTS requires the manager
Date:   Mon,  2 Nov 2020 14:48:15 +0100
Message-Id: <20201102134815.512866-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The extra tests in the manager actually require the manager to be
selected too. Otherwise the linker gives errors like:

ld: arch/x86/crypto/chacha_glue.o: in function `chacha_simd_stream_xor':
chacha_glue.c:(.text+0x422): undefined reference to `crypto_simd_disabled_for_test'

Fixes: 2343d1529aff ("crypto: Kconfig - allow tests to be disabled when manager is disabled")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 094ef56ab7b4..37de7d006858 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -145,7 +145,7 @@ config CRYPTO_MANAGER_DISABLE_TESTS
 
 config CRYPTO_MANAGER_EXTRA_TESTS
 	bool "Enable extra run-time crypto self tests"
-	depends on DEBUG_KERNEL && !CRYPTO_MANAGER_DISABLE_TESTS
+	depends on DEBUG_KERNEL && !CRYPTO_MANAGER_DISABLE_TESTS && CRYPTO_MANAGER
 	help
 	  Enable extra run-time self tests of registered crypto algorithms,
 	  including randomized fuzz tests.
-- 
2.29.1

