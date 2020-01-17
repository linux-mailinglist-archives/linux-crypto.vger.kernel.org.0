Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3B0140826
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Jan 2020 11:42:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbgAQKma (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 17 Jan 2020 05:42:30 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:56425 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgAQKma (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 17 Jan 2020 05:42:30 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 4e386738;
        Fri, 17 Jan 2020 09:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-transfer-encoding;
         s=mail; bh=Ew3xej6KngIGHQvI5TbFIQsPzpg=; b=1JrRf0nBvixM+O8MiTwy
        j7bEWRRvYmA5UKRdKTstvGTqC0kWwtbq/cdhSrxPpGW6ZLH3WAcN1dkAvk8kivUY
        DSdda9bB+QeteUEUtEe301nw9389uaNhJl46TKmfW+teD/bBk1Nb0J4vX349/tfX
        /rNtWETNwNw8mUL79vUgoU0EAJcFd9DGqNIg4BOnA1O6xiAn+rWgvWZgKGoFKVKp
        xZsbAnMfSodG4h97jaO+/icmdycv1OjtHmtCbMcBHiL2g33kheNDQOl70aOhHaCv
        dvWOpxiyoWFCDJiaZbnLjxUdU6tykniCm80YnD1SChsR3j1sh3jS04A8U/Jl3yYs
        7w==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 379364e0 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 17 Jan 2020 09:42:03 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] crypto: x86/poly1305 - emit does base conversion itself
Date:   Fri, 17 Jan 2020 11:42:22 +0100
Message-Id: <20200117104222.303112-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The emit code does optional base conversion itself in assembly, so we
don't need to do that here. Also, neither one of these functions uses
simd instructions, so checking for that doesn't make sense either.

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/x86/crypto/poly1305_glue.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/crypto/poly1305_glue.c b/arch/x86/crypto/poly1305_glue.c
index 657363588e0c..79bb58737d52 100644
--- a/arch/x86/crypto/poly1305_glue.c
+++ b/arch/x86/crypto/poly1305_glue.c
@@ -123,13 +123,9 @@ static void poly1305_simd_blocks(void *ctx, const u8 *inp, size_t len,
 static void poly1305_simd_emit(void *ctx, u8 mac[POLY1305_DIGEST_SIZE],
 			       const u32 nonce[4])
 {
-	struct poly1305_arch_internal *state = ctx;
-
-	if (!IS_ENABLED(CONFIG_AS_AVX) || !static_branch_likely(&poly1305_use_avx) ||
-	    !state->is_base2_26 || !crypto_simd_usable()) {
-		convert_to_base2_64(ctx);
+	if (!IS_ENABLED(CONFIG_AS_AVX) || !static_branch_likely(&poly1305_use_avx))
 		poly1305_emit_x86_64(ctx, mac, nonce);
-	} else
+	else
 		poly1305_emit_avx(ctx, mac, nonce);
 }
 
-- 
2.24.1

