Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54474FF765
	for <lists+linux-crypto@lfdr.de>; Sun, 17 Nov 2019 03:54:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbfKQCyh (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 16 Nov 2019 21:54:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43200 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725839AbfKQCyh (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 16 Nov 2019 21:54:37 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EAEC207DD;
        Sun, 17 Nov 2019 02:54:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573959277;
        bh=PaRIDoe+WalcGjTj41xoWyjoqJ7HCGiAD/E0e3C9vVU=;
        h=From:To:Cc:Subject:Date:From;
        b=TsL0IEHiCEF0xACNH3rkfHob2O6wUsbhaqixpo4z9f34XmwEyX2eNN7RZcJauPs2C
         W2vLULiGvv88PLaWXhw5+1ZnrD4GXCdvghWoiVNVYq/mcKGxCd1a6aH0ClyBkfDjsH
         riHAeOSVLuRypuZdNT6rKfU2f4QYguOXx3XjbEEo=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH] crypto: mips/chacha - select CRYPTO_SKCIPHER, not CRYPTO_BLKCIPHER
Date:   Sat, 16 Nov 2019 18:53:24 -0800
Message-Id: <20191117025324.22929-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Another instance of CRYPTO_BLKCIPHER made it in just after it was
renamed to CRYPTO_SKCIPHER.  Fix it.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 472c2ad36063..5575d48473bd 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1487,7 +1487,7 @@ config CRYPTO_CHACHA20_X86_64
 config CRYPTO_CHACHA_MIPS
 	tristate "ChaCha stream cipher algorithms (MIPS 32r2 optimized)"
 	depends on CPU_MIPS32_R2
-	select CRYPTO_BLKCIPHER
+	select CRYPTO_SKCIPHER
 	select CRYPTO_ARCH_HAVE_LIB_CHACHA
 
 config CRYPTO_SEED
-- 
2.24.0

