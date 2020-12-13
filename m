Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68D5F2D8E02
	for <lists+linux-crypto@lfdr.de>; Sun, 13 Dec 2020 15:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgLMOkP (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 13 Dec 2020 09:40:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:46308 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgLMOkP (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 13 Dec 2020 09:40:15 -0500
From:   Ard Biesheuvel <ardb@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2] crypto: arm/chacha-neon - add missing counter increment
Date:   Sun, 13 Dec 2020 15:39:29 +0100
Message-Id: <20201213143929.7088-1-ardb@kernel.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Commit 86cd97ec4b943af3 ("crypto: arm/chacha-neon - optimize for non-block
size multiples") refactored the chacha block handling in the glue code in
a way that may result in the counter increment to be omitted when calling
chacha_block_xor_neon() to process a full block. This violates the skcipher
API, which requires that the output IV is suitable for handling more input
as long as the preceding input has been presented in round multiples of the
block size. Also, the same code is exposed via the chacha library interface
whose callers may actually rely on this increment to occur even for final
blocks that are smaller than the chacha block size.

So increment the counter after calling chacha_block_xor_neon().

Fixes: 86cd97ec4b943af3 ("crypto: arm/chacha-neon - optimize for non-block size multiples")
Reported-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
v2: - use ++ instead of += 1
    - make note in the commit log of the fact that the library API needs the
      increment to occur in all cases, not only for final blocks whose size
      is exactly the block size

 arch/arm/crypto/chacha-glue.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/crypto/chacha-glue.c b/arch/arm/crypto/chacha-glue.c
index 7b5cf8430c6d..cdde8fd01f8f 100644
--- a/arch/arm/crypto/chacha-glue.c
+++ b/arch/arm/crypto/chacha-glue.c
@@ -60,6 +60,7 @@ static void chacha_doneon(u32 *state, u8 *dst, const u8 *src,
 		chacha_block_xor_neon(state, d, s, nrounds);
 		if (d != dst)
 			memcpy(dst, buf, bytes);
+		state[12]++;
 	}
 }
 
-- 
2.17.1

