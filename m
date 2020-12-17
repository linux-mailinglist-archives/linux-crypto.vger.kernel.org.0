Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1CD2DDB4D
	for <lists+linux-crypto@lfdr.de>; Thu, 17 Dec 2020 23:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbgLQW0W (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 17 Dec 2020 17:26:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:45472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732078AbgLQW0V (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 17 Dec 2020 17:26:21 -0500
From:   Eric Biggers <ebiggers@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-crypto@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Ard Biesheuvel <ardb@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Sterba <dsterba@suse.com>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Paul Crowley <paulcrowley@google.com>
Subject: [PATCH v2 11/11] wireguard: Kconfig: select CRYPTO_BLAKE2S_ARM
Date:   Thu, 17 Dec 2020 14:21:38 -0800
Message-Id: <20201217222138.170526-12-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201217222138.170526-1-ebiggers@kernel.org>
References: <20201217222138.170526-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

When available, select the new implementation of BLAKE2s for 32-bit ARM.
This is faster than the generic C implementation.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 drivers/net/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 260f9f46668b8..672fcdd9aecbb 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -90,6 +90,7 @@ config WIREGUARD
 	select CRYPTO_CHACHA20_NEON if (ARM || ARM64) && KERNEL_MODE_NEON
 	select CRYPTO_POLY1305_NEON if ARM64 && KERNEL_MODE_NEON
 	select CRYPTO_POLY1305_ARM if ARM
+	select CRYPTO_BLAKE2S_ARM if ARM
 	select CRYPTO_CURVE25519_NEON if ARM && KERNEL_MODE_NEON
 	select CRYPTO_CHACHA_MIPS if CPU_MIPS32_R2
 	select CRYPTO_POLY1305_MIPS if CPU_MIPS32 || (CPU_MIPS64 && 64BIT)
-- 
2.29.2

