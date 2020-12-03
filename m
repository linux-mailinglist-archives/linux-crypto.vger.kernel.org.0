Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EE72CE191
	for <lists+linux-crypto@lfdr.de>; Thu,  3 Dec 2020 23:28:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387396AbgLCW0n (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 3 Dec 2020 17:26:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:53232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728020AbgLCW0n (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 3 Dec 2020 17:26:43 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ondrej Mosnacek <omosnacek@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Eric Biggers <ebiggers@google.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: aegis128 - fix link error without SIMD
Date:   Thu,  3 Dec 2020 23:25:49 +0100
Message-Id: <20201203222557.952393-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

When the SIMD portion of the driver is disabled, the compiler cannot
figure out in advance if it will be called:

ERROR: modpost: "crypto_aegis128_update_simd" [crypto/aegis128.ko] undefined!

Add a conditional to let the compiler use dead code elimination
as before.

Fixes: ac50aec41a9f ("crypto: aegis128 - expose SIMD code path as separate driver")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 crypto/aegis128-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/aegis128-core.c b/crypto/aegis128-core.c
index 2b05f79475d3..89dc1c559689 100644
--- a/crypto/aegis128-core.c
+++ b/crypto/aegis128-core.c
@@ -89,7 +89,7 @@ static void crypto_aegis128_update_a(struct aegis_state *state,
 				     const union aegis_block *msg,
 				     bool do_simd)
 {
-	if (do_simd) {
+	if (IS_ENABLED(CONFIG_CRYPTO_AEGIS128_SIMD) && do_simd) {
 		crypto_aegis128_update_simd(state, msg);
 		return;
 	}
@@ -101,7 +101,7 @@ static void crypto_aegis128_update_a(struct aegis_state *state,
 static void crypto_aegis128_update_u(struct aegis_state *state, const void *msg,
 				     bool do_simd)
 {
-	if (do_simd) {
+	if (IS_ENABLED(CONFIG_CRYPTO_AEGIS128_SIMD) && do_simd) {
 		crypto_aegis128_update_simd(state, msg);
 		return;
 	}
-- 
2.27.0

