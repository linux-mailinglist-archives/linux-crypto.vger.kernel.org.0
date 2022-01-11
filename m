Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1A448B572
	for <lists+linux-crypto@lfdr.de>; Tue, 11 Jan 2022 19:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243694AbiAKSLF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 11 Jan 2022 13:11:05 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34576 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242957AbiAKSLE (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 11 Jan 2022 13:11:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CFA8B61618;
        Tue, 11 Jan 2022 18:11:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53188C36AE9;
        Tue, 11 Jan 2022 18:11:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="dvzCGTvB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1641924662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y8yaQEJdWGKWQITH4vgPEpVGHGMGT1Gu/a6CeJDd8tQ=;
        b=dvzCGTvB1Pg32mCHrz4E6Puayjl+0i4DqkMN4pZfMUNkE1XsZwpkTzbvp1fJ4gwTxW0Y6d
        LgVIBkKoRzRNyoEJa6aL1HsauIIIWLRr/25GQo1GDBOvzlVdJytf4+gIJUkKuVElXDnFwn
        kScQn3msxVxV8oT8h6AWUp//nGlev1Y=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 840ddccb (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 11 Jan 2022 18:11:01 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-crypto@vger.kernel.org, netdev@vger.kernel.org,
        wireguard@lists.zx2c4.com, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org, geert@linux-m68k.org, tytso@mit.edu,
        gregkh@linuxfoundation.org, jeanphilippe.aumasson@gmail.com,
        ardb@kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH crypto v2 2/2] lib/crypto: sha1: re-roll loops to reduce code size
Date:   Tue, 11 Jan 2022 19:10:37 +0100
Message-Id: <20220111181037.632969-3-Jason@zx2c4.com>
In-Reply-To: <20220111181037.632969-1-Jason@zx2c4.com>
References: <20220111134934.324663-1-Jason@zx2c4.com>
 <20220111181037.632969-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

With SHA-1 no longer being used for anything performance oriented, and
also soon to be phased out entirely, we can make up for the space added
by unrolled BLAKE2s by simply re-rolling SHA-1. Since SHA-1 is so much
more complex, re-rolling it more or less takes care of the code size
added by BLAKE2s. And eventually, hopefully we'll see SHA-1 removed
entirely from most small kernel builds.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 lib/sha1.c | 117 ++++++++++++-----------------------------------------
 1 file changed, 25 insertions(+), 92 deletions(-)

diff --git a/lib/sha1.c b/lib/sha1.c
index 9bd1935a1472..f2acfa294e64 100644
--- a/lib/sha1.c
+++ b/lib/sha1.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/export.h>
 #include <linux/bitops.h>
+#include <linux/string.h>
 #include <crypto/sha1.h>
 #include <asm/unaligned.h>
 
@@ -83,109 +84,41 @@
  */
 void sha1_transform(__u32 *digest, const char *data, __u32 *array)
 {
-	__u32 A, B, C, D, E;
+	u32 d[5];
+	unsigned int i = 0;
 
-	A = digest[0];
-	B = digest[1];
-	C = digest[2];
-	D = digest[3];
-	E = digest[4];
+	memcpy(d, digest, sizeof(d));
 
 	/* Round 1 - iterations 0-16 take their input from 'data' */
-	T_0_15( 0, A, B, C, D, E);
-	T_0_15( 1, E, A, B, C, D);
-	T_0_15( 2, D, E, A, B, C);
-	T_0_15( 3, C, D, E, A, B);
-	T_0_15( 4, B, C, D, E, A);
-	T_0_15( 5, A, B, C, D, E);
-	T_0_15( 6, E, A, B, C, D);
-	T_0_15( 7, D, E, A, B, C);
-	T_0_15( 8, C, D, E, A, B);
-	T_0_15( 9, B, C, D, E, A);
-	T_0_15(10, A, B, C, D, E);
-	T_0_15(11, E, A, B, C, D);
-	T_0_15(12, D, E, A, B, C);
-	T_0_15(13, C, D, E, A, B);
-	T_0_15(14, B, C, D, E, A);
-	T_0_15(15, A, B, C, D, E);
+	for (; i < 16; ++i)
+		T_0_15(i, d[(-6 - i) % 5], d[(-5 - i) % 5],
+		       d[(-4 - i) % 5], d[(-3 - i) % 5], d[(-2 - i) % 5]);
 
 	/* Round 1 - tail. Input from 512-bit mixing array */
-	T_16_19(16, E, A, B, C, D);
-	T_16_19(17, D, E, A, B, C);
-	T_16_19(18, C, D, E, A, B);
-	T_16_19(19, B, C, D, E, A);
+	for (; i < 20; ++i)
+		T_16_19(i, d[(-6 - i) % 5], d[(-5 - i) % 5],
+			d[(-4 - i) % 5], d[(-3 - i) % 5], d[(-2 - i) % 5]);
 
 	/* Round 2 */
-	T_20_39(20, A, B, C, D, E);
-	T_20_39(21, E, A, B, C, D);
-	T_20_39(22, D, E, A, B, C);
-	T_20_39(23, C, D, E, A, B);
-	T_20_39(24, B, C, D, E, A);
-	T_20_39(25, A, B, C, D, E);
-	T_20_39(26, E, A, B, C, D);
-	T_20_39(27, D, E, A, B, C);
-	T_20_39(28, C, D, E, A, B);
-	T_20_39(29, B, C, D, E, A);
-	T_20_39(30, A, B, C, D, E);
-	T_20_39(31, E, A, B, C, D);
-	T_20_39(32, D, E, A, B, C);
-	T_20_39(33, C, D, E, A, B);
-	T_20_39(34, B, C, D, E, A);
-	T_20_39(35, A, B, C, D, E);
-	T_20_39(36, E, A, B, C, D);
-	T_20_39(37, D, E, A, B, C);
-	T_20_39(38, C, D, E, A, B);
-	T_20_39(39, B, C, D, E, A);
+	for (; i < 40; ++i)
+		T_20_39(i, d[(-6 - i) % 5], d[(-5 - i) % 5],
+			d[(-4 - i) % 5], d[(-3 - i) % 5], d[(-2 - i) % 5]);
 
 	/* Round 3 */
-	T_40_59(40, A, B, C, D, E);
-	T_40_59(41, E, A, B, C, D);
-	T_40_59(42, D, E, A, B, C);
-	T_40_59(43, C, D, E, A, B);
-	T_40_59(44, B, C, D, E, A);
-	T_40_59(45, A, B, C, D, E);
-	T_40_59(46, E, A, B, C, D);
-	T_40_59(47, D, E, A, B, C);
-	T_40_59(48, C, D, E, A, B);
-	T_40_59(49, B, C, D, E, A);
-	T_40_59(50, A, B, C, D, E);
-	T_40_59(51, E, A, B, C, D);
-	T_40_59(52, D, E, A, B, C);
-	T_40_59(53, C, D, E, A, B);
-	T_40_59(54, B, C, D, E, A);
-	T_40_59(55, A, B, C, D, E);
-	T_40_59(56, E, A, B, C, D);
-	T_40_59(57, D, E, A, B, C);
-	T_40_59(58, C, D, E, A, B);
-	T_40_59(59, B, C, D, E, A);
+	for (; i < 60; ++i)
+		T_40_59(i, d[(-6 - i) % 5], d[(-5 - i) % 5],
+			d[(-4 - i) % 5], d[(-3 - i) % 5], d[(-2 - i) % 5]);
 
 	/* Round 4 */
-	T_60_79(60, A, B, C, D, E);
-	T_60_79(61, E, A, B, C, D);
-	T_60_79(62, D, E, A, B, C);
-	T_60_79(63, C, D, E, A, B);
-	T_60_79(64, B, C, D, E, A);
-	T_60_79(65, A, B, C, D, E);
-	T_60_79(66, E, A, B, C, D);
-	T_60_79(67, D, E, A, B, C);
-	T_60_79(68, C, D, E, A, B);
-	T_60_79(69, B, C, D, E, A);
-	T_60_79(70, A, B, C, D, E);
-	T_60_79(71, E, A, B, C, D);
-	T_60_79(72, D, E, A, B, C);
-	T_60_79(73, C, D, E, A, B);
-	T_60_79(74, B, C, D, E, A);
-	T_60_79(75, A, B, C, D, E);
-	T_60_79(76, E, A, B, C, D);
-	T_60_79(77, D, E, A, B, C);
-	T_60_79(78, C, D, E, A, B);
-	T_60_79(79, B, C, D, E, A);
-
-	digest[0] += A;
-	digest[1] += B;
-	digest[2] += C;
-	digest[3] += D;
-	digest[4] += E;
+	for (; i < 80; ++i)
+		T_60_79(i, d[(-6 - i) % 5], d[(-5 - i) % 5],
+			d[(-4 - i) % 5], d[(-3 - i) % 5], d[(-2 - i) % 5]);
+
+	digest[0] += d[0];
+	digest[1] += d[1];
+	digest[2] += d[2];
+	digest[3] += d[3];
+	digest[4] += d[4];
 }
 EXPORT_SYMBOL(sha1_transform);
 
-- 
2.34.1

