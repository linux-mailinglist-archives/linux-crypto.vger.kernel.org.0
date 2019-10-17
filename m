Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3662CDB700
	for <lists+linux-crypto@lfdr.de>; Thu, 17 Oct 2019 21:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503404AbfJQTKr (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 17 Oct 2019 15:10:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44555 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2503401AbfJQTKq (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 17 Oct 2019 15:10:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id z9so3575027wrl.11
        for <linux-crypto@vger.kernel.org>; Thu, 17 Oct 2019 12:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=znN/RrI6tRSNlBeMWx/0wRExB4/z++8IXsB6rYgerF0=;
        b=wRiZbYfRC2EAcADKvF1R0p1gMVwG3WiuqYbkGN53Dl39G617X55nyCR+1amAOurm39
         oNFzRgLNpu5oiWMdw4bi1vFIXiwGrUe1MScsvh4fRHx26Kzx+xch1N876BAVtKlM367G
         hIJ3TZG68OYsUNM2XMS1y6KYhVMI7cU+//hBLIWqgB9BqstyDQXI32nUTXLRDVJOwDl/
         vA52xtB18K9r8S5g6Qd1zxR8m6VvoCQFsl79AEF0ScEw1TqyAIoNKISl5uxnbGbtHrPt
         V6TozX0vSi9kzgn7tN+R/KToy+VrenFIJ2PbXip46lRT2lysPGR51nvaUlkd5G2iQw+E
         qaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=znN/RrI6tRSNlBeMWx/0wRExB4/z++8IXsB6rYgerF0=;
        b=iZM0eKRmVFpawTk2F/c0HzccENuQqKU1bWxP2yYxo3B1dpXtN85kBAlUtW9+JtTmyr
         AGXqxJFyOo976wrQfV2hPzkf0DepNiiIKjokdnPLCYTD4AaD2SWlHzth4jplPV1PNgDn
         /Dcz8TR6Sq2d8vxg3HyZ/Zxak//71r8AiHZnQwd1cxJOQKn9KU2cjlUusFct3x1JW6P8
         Q2dmGXX3rnKjBbnzgPLpl5oub4Dyx4+jRl5sz2DwOVv7/OoMbfUJy6HUhFfCZf+tntVH
         84Y6G2geV+SqkQXPt+Osr9IB2p81lKolU61S8pq2LvyzDogvb8Ds/THusS1lP7Ma5qhE
         0qPA==
X-Gm-Message-State: APjAAAXvTFOfiueaF5yBjXBeA5MO5BwCsI/OtrF3UoxYIVUd2214D6qp
        twWJCbR4s2sBto5dVbiA9oOTfeLK+EEdF9mt
X-Google-Smtp-Source: APXvYqymY6oorTIOUwB32l1z0rcvQg7YCHKnuP99DHgHzd7nAfqVbzi3U6Lya/PUIBbfZqqtvnjsvw==
X-Received: by 2002:a5d:5591:: with SMTP id i17mr4195144wrv.352.1571339437819;
        Thu, 17 Oct 2019 12:10:37 -0700 (PDT)
Received: from sudo.home ([2a01:cb1d:112:6f00:ccb6:e9d4:c1bc:d107])
        by smtp.gmail.com with ESMTPSA id y3sm5124528wro.36.2019.10.17.12.10.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Oct 2019 12:10:34 -0700 (PDT)
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
To:     linux-crypto@vger.kernel.org
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biggers <ebiggers@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Martin Willi <martin@strongswan.org>,
        Rene van Dorst <opensource@vdorst.com>,
        David Sterba <dsterba@suse.com>
Subject: [PATCH v4 26/35] crypto: Curve25519 - generic C library implementations
Date:   Thu, 17 Oct 2019 21:09:23 +0200
Message-Id: <20191017190932.1947-27-ard.biesheuvel@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017190932.1947-1-ard.biesheuvel@linaro.org>
References: <20191017190932.1947-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: "Jason A. Donenfeld" <Jason@zx2c4.com>

This contains two formally verified C implementations of the Curve25519
scalar multiplication function, one for 32-bit systems, and one for
64-bit systems whose compiler supports efficient 128-bit integer types.
Not only are these implementations formally verified, but they are also
the fastest available C implementations. They have been modified to be
friendly to kernel space and to be generally less horrendous looking,
but still an effort has been made to retain their formally verified
characteristic, and so the C might look slightly unidiomatic.

The 64-bit version comes from HACL*: https://github.com/project-everest/hacl-star
The 32-bit version comes from Fiat: https://github.com/mit-plv/fiat-crypto

Information: https://cr.yp.to/ecdh.html

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
[ardb: - move from lib/zinc to lib/crypto
       - replace .c #includes with Kconfig based object selection
       - drop simd handling and simplify support for per-arch versions ]
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 include/crypto/curve25519.h    |  71 ++
 lib/crypto/Kconfig             |  25 +
 lib/crypto/Makefile            |   5 +
 lib/crypto/curve25519-fiat32.c | 864 ++++++++++++++++++++
 lib/crypto/curve25519-hacl64.c | 788 ++++++++++++++++++
 lib/crypto/curve25519.c        |  25 +
 6 files changed, 1778 insertions(+)

diff --git a/include/crypto/curve25519.h b/include/crypto/curve25519.h
new file mode 100644
index 000000000000..4e6dc840b159
--- /dev/null
+++ b/include/crypto/curve25519.h
@@ -0,0 +1,71 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#ifndef CURVE25519_H
+#define CURVE25519_H
+
+#include <crypto/algapi.h> // For crypto_memneq.
+#include <linux/types.h>
+#include <linux/random.h>
+
+enum curve25519_lengths {
+	CURVE25519_KEY_SIZE = 32
+};
+
+extern const u8 curve25519_null_point[];
+extern const u8 curve25519_base_point[];
+
+void curve25519_generic(u8 out[CURVE25519_KEY_SIZE],
+			const u8 scalar[CURVE25519_KEY_SIZE],
+			const u8 point[CURVE25519_KEY_SIZE]);
+
+void curve25519_arch(u8 out[CURVE25519_KEY_SIZE],
+		     const u8 scalar[CURVE25519_KEY_SIZE],
+		     const u8 point[CURVE25519_KEY_SIZE]);
+
+void curve25519_base_arch(u8 pub[CURVE25519_KEY_SIZE],
+			  const u8 secret[CURVE25519_KEY_SIZE]);
+
+static inline
+bool __must_check curve25519(u8 mypublic[CURVE25519_KEY_SIZE],
+			     const u8 secret[CURVE25519_KEY_SIZE],
+			     const u8 basepoint[CURVE25519_KEY_SIZE])
+{
+	if (IS_ENABLED(CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519))
+		curve25519_arch(mypublic, secret, basepoint);
+	else
+		curve25519_generic(mypublic, secret, basepoint);
+	return crypto_memneq(mypublic, curve25519_null_point,
+			     CURVE25519_KEY_SIZE);
+}
+
+static inline bool
+__must_check curve25519_generate_public(u8 pub[CURVE25519_KEY_SIZE],
+					const u8 secret[CURVE25519_KEY_SIZE])
+{
+	if (unlikely(!crypto_memneq(secret, curve25519_null_point,
+				    CURVE25519_KEY_SIZE)))
+		return false;
+
+	if (IS_ENABLED(CONFIG_CRYPTO_ARCH_HAVE_LIB_CURVE25519))
+		curve25519_base_arch(pub, secret);
+	else
+		curve25519_generic(pub, secret, curve25519_base_point);
+	return crypto_memneq(pub, curve25519_null_point, CURVE25519_KEY_SIZE);
+}
+
+static inline void curve25519_clamp_secret(u8 secret[CURVE25519_KEY_SIZE])
+{
+	secret[0] &= 248;
+	secret[31] = (secret[31] & 127) | 64;
+}
+
+static inline void curve25519_generate_secret(u8 secret[CURVE25519_KEY_SIZE])
+{
+	get_random_bytes_wait(secret, CURVE25519_KEY_SIZE);
+	curve25519_clamp_secret(secret);
+}
+
+#endif /* CURVE25519_H */
diff --git a/lib/crypto/Kconfig b/lib/crypto/Kconfig
index 7ad98b624e55..b1d830dc1c9e 100644
--- a/lib/crypto/Kconfig
+++ b/lib/crypto/Kconfig
@@ -59,6 +59,31 @@ config CRYPTO_LIB_CHACHA
 	  by either the generic implementation or an arch-specific one, if one
 	  is available and enabled.
 
+config CRYPTO_ARCH_HAVE_LIB_CURVE25519
+	tristate
+	help
+	  Declares whether the architecture provides an arch-specific
+	  accelerated implementation of the Curve25519 library interface,
+	  either builtin or as a module.
+
+config CRYPTO_LIB_CURVE25519_GENERIC
+	tristate
+	help
+	  This symbol can be depended upon by arch implementations of the
+	  Curve25519 library interface that require the generic code as a
+	  fallback, e.g., for SIMD implementations. If no arch specific
+	  implementation is enabled, this implementation serves the users
+	  of CRYPTO_LIB_CURVE25519.
+
+config CRYPTO_LIB_CURVE25519
+	tristate "Curve25519 scalar multiplication library"
+	depends on CRYPTO_ARCH_HAVE_LIB_CURVE25519 || !CRYPTO_ARCH_HAVE_LIB_CURVE25519
+	select CRYPTO_LIB_CURVE25519_GENERIC if CRYPTO_ARCH_HAVE_LIB_CURVE25519=n
+	help
+	  Enable the Curve25519 library interface. This interface may be
+	  fulfilled by either the generic implementation or an arch-specific
+	  one, if one is available and enabled.
+
 config CRYPTO_LIB_DES
 	tristate
 
diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 8ca66b5f9807..273c55d5e147 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -16,6 +16,11 @@ libblake2s-generic-y				+= blake2s-generic.o
 obj-$(CONFIG_CRYPTO_LIB_BLAKE2S)		+= libblake2s.o
 libblake2s-y					+= blake2s.o
 
+obj-$(CONFIG_CRYPTO_LIB_CURVE25519_GENERIC)	+= libcurve25519.o
+libcurve25519-y					:= curve25519-fiat32.o
+libcurve25519-$(CONFIG_ARCH_SUPPORTS_INT128)	:= curve25519-hacl64.o
+libcurve25519-y					+= curve25519.o
+
 obj-$(CONFIG_CRYPTO_LIB_DES)			+= libdes.o
 libdes-y					:= des.o
 
diff --git a/lib/crypto/curve25519-fiat32.c b/lib/crypto/curve25519-fiat32.c
new file mode 100644
index 000000000000..1c455207341d
--- /dev/null
+++ b/lib/crypto/curve25519-fiat32.c
@@ -0,0 +1,864 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2015-2016 The fiat-crypto Authors.
+ * Copyright (C) 2018-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ *
+ * This is a machine-generated formally verified implementation of Curve25519
+ * ECDH from: <https://github.com/mit-plv/fiat-crypto>. Though originally
+ * machine generated, it has been tweaked to be suitable for use in the kernel.
+ * It is optimized for 32-bit machines and machines that cannot work efficiently
+ * with 128-bit integer types.
+ */
+
+#include <asm/unaligned.h>
+#include <crypto/curve25519.h>
+#include <linux/string.h>
+
+/* fe means field element. Here the field is \Z/(2^255-19). An element t,
+ * entries t[0]...t[9], represents the integer t[0]+2^26 t[1]+2^51 t[2]+2^77
+ * t[3]+2^102 t[4]+...+2^230 t[9].
+ * fe limbs are bounded by 1.125*2^26,1.125*2^25,1.125*2^26,1.125*2^25,etc.
+ * Multiplication and carrying produce fe from fe_loose.
+ */
+typedef struct fe { u32 v[10]; } fe;
+
+/* fe_loose limbs are bounded by 3.375*2^26,3.375*2^25,3.375*2^26,3.375*2^25,etc
+ * Addition and subtraction produce fe_loose from (fe, fe).
+ */
+typedef struct fe_loose { u32 v[10]; } fe_loose;
+
+static __always_inline void fe_frombytes_impl(u32 h[10], const u8 *s)
+{
+	/* Ignores top bit of s. */
+	u32 a0 = get_unaligned_le32(s);
+	u32 a1 = get_unaligned_le32(s+4);
+	u32 a2 = get_unaligned_le32(s+8);
+	u32 a3 = get_unaligned_le32(s+12);
+	u32 a4 = get_unaligned_le32(s+16);
+	u32 a5 = get_unaligned_le32(s+20);
+	u32 a6 = get_unaligned_le32(s+24);
+	u32 a7 = get_unaligned_le32(s+28);
+	h[0] = a0&((1<<26)-1);                    /* 26 used, 32-26 left.   26 */
+	h[1] = (a0>>26) | ((a1&((1<<19)-1))<< 6); /* (32-26) + 19 =  6+19 = 25 */
+	h[2] = (a1>>19) | ((a2&((1<<13)-1))<<13); /* (32-19) + 13 = 13+13 = 26 */
+	h[3] = (a2>>13) | ((a3&((1<< 6)-1))<<19); /* (32-13) +  6 = 19+ 6 = 25 */
+	h[4] = (a3>> 6);                          /* (32- 6)              = 26 */
+	h[5] = a4&((1<<25)-1);                    /*                        25 */
+	h[6] = (a4>>25) | ((a5&((1<<19)-1))<< 7); /* (32-25) + 19 =  7+19 = 26 */
+	h[7] = (a5>>19) | ((a6&((1<<12)-1))<<13); /* (32-19) + 12 = 13+12 = 25 */
+	h[8] = (a6>>12) | ((a7&((1<< 6)-1))<<20); /* (32-12) +  6 = 20+ 6 = 26 */
+	h[9] = (a7>> 6)&((1<<25)-1); /*                                     25 */
+}
+
+static __always_inline void fe_frombytes(fe *h, const u8 *s)
+{
+	fe_frombytes_impl(h->v, s);
+}
+
+static __always_inline u8 /*bool*/
+addcarryx_u25(u8 /*bool*/ c, u32 a, u32 b, u32 *low)
+{
+	/* This function extracts 25 bits of result and 1 bit of carry
+	 * (26 total), so a 32-bit intermediate is sufficient.
+	 */
+	u32 x = a + b + c;
+	*low = x & ((1 << 25) - 1);
+	return (x >> 25) & 1;
+}
+
+static __always_inline u8 /*bool*/
+addcarryx_u26(u8 /*bool*/ c, u32 a, u32 b, u32 *low)
+{
+	/* This function extracts 26 bits of result and 1 bit of carry
+	 * (27 total), so a 32-bit intermediate is sufficient.
+	 */
+	u32 x = a + b + c;
+	*low = x & ((1 << 26) - 1);
+	return (x >> 26) & 1;
+}
+
+static __always_inline u8 /*bool*/
+subborrow_u25(u8 /*bool*/ c, u32 a, u32 b, u32 *low)
+{
+	/* This function extracts 25 bits of result and 1 bit of borrow
+	 * (26 total), so a 32-bit intermediate is sufficient.
+	 */
+	u32 x = a - b - c;
+	*low = x & ((1 << 25) - 1);
+	return x >> 31;
+}
+
+static __always_inline u8 /*bool*/
+subborrow_u26(u8 /*bool*/ c, u32 a, u32 b, u32 *low)
+{
+	/* This function extracts 26 bits of result and 1 bit of borrow
+	 *(27 total), so a 32-bit intermediate is sufficient.
+	 */
+	u32 x = a - b - c;
+	*low = x & ((1 << 26) - 1);
+	return x >> 31;
+}
+
+static __always_inline u32 cmovznz32(u32 t, u32 z, u32 nz)
+{
+	t = -!!t; /* all set if nonzero, 0 if 0 */
+	return (t&nz) | ((~t)&z);
+}
+
+static __always_inline void fe_freeze(u32 out[10], const u32 in1[10])
+{
+	{ const u32 x17 = in1[9];
+	{ const u32 x18 = in1[8];
+	{ const u32 x16 = in1[7];
+	{ const u32 x14 = in1[6];
+	{ const u32 x12 = in1[5];
+	{ const u32 x10 = in1[4];
+	{ const u32 x8 = in1[3];
+	{ const u32 x6 = in1[2];
+	{ const u32 x4 = in1[1];
+	{ const u32 x2 = in1[0];
+	{ u32 x20; u8/*bool*/ x21 = subborrow_u26(0x0, x2, 0x3ffffed, &x20);
+	{ u32 x23; u8/*bool*/ x24 = subborrow_u25(x21, x4, 0x1ffffff, &x23);
+	{ u32 x26; u8/*bool*/ x27 = subborrow_u26(x24, x6, 0x3ffffff, &x26);
+	{ u32 x29; u8/*bool*/ x30 = subborrow_u25(x27, x8, 0x1ffffff, &x29);
+	{ u32 x32; u8/*bool*/ x33 = subborrow_u26(x30, x10, 0x3ffffff, &x32);
+	{ u32 x35; u8/*bool*/ x36 = subborrow_u25(x33, x12, 0x1ffffff, &x35);
+	{ u32 x38; u8/*bool*/ x39 = subborrow_u26(x36, x14, 0x3ffffff, &x38);
+	{ u32 x41; u8/*bool*/ x42 = subborrow_u25(x39, x16, 0x1ffffff, &x41);
+	{ u32 x44; u8/*bool*/ x45 = subborrow_u26(x42, x18, 0x3ffffff, &x44);
+	{ u32 x47; u8/*bool*/ x48 = subborrow_u25(x45, x17, 0x1ffffff, &x47);
+	{ u32 x49 = cmovznz32(x48, 0x0, 0xffffffff);
+	{ u32 x50 = (x49 & 0x3ffffed);
+	{ u32 x52; u8/*bool*/ x53 = addcarryx_u26(0x0, x20, x50, &x52);
+	{ u32 x54 = (x49 & 0x1ffffff);
+	{ u32 x56; u8/*bool*/ x57 = addcarryx_u25(x53, x23, x54, &x56);
+	{ u32 x58 = (x49 & 0x3ffffff);
+	{ u32 x60; u8/*bool*/ x61 = addcarryx_u26(x57, x26, x58, &x60);
+	{ u32 x62 = (x49 & 0x1ffffff);
+	{ u32 x64; u8/*bool*/ x65 = addcarryx_u25(x61, x29, x62, &x64);
+	{ u32 x66 = (x49 & 0x3ffffff);
+	{ u32 x68; u8/*bool*/ x69 = addcarryx_u26(x65, x32, x66, &x68);
+	{ u32 x70 = (x49 & 0x1ffffff);
+	{ u32 x72; u8/*bool*/ x73 = addcarryx_u25(x69, x35, x70, &x72);
+	{ u32 x74 = (x49 & 0x3ffffff);
+	{ u32 x76; u8/*bool*/ x77 = addcarryx_u26(x73, x38, x74, &x76);
+	{ u32 x78 = (x49 & 0x1ffffff);
+	{ u32 x80; u8/*bool*/ x81 = addcarryx_u25(x77, x41, x78, &x80);
+	{ u32 x82 = (x49 & 0x3ffffff);
+	{ u32 x84; u8/*bool*/ x85 = addcarryx_u26(x81, x44, x82, &x84);
+	{ u32 x86 = (x49 & 0x1ffffff);
+	{ u32 x88; addcarryx_u25(x85, x47, x86, &x88);
+	out[0] = x52;
+	out[1] = x56;
+	out[2] = x60;
+	out[3] = x64;
+	out[4] = x68;
+	out[5] = x72;
+	out[6] = x76;
+	out[7] = x80;
+	out[8] = x84;
+	out[9] = x88;
+	}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
+}
+
+static __always_inline void fe_tobytes(u8 s[32], const fe *f)
+{
+	u32 h[10];
+	fe_freeze(h, f->v);
+	s[0] = h[0] >> 0;
+	s[1] = h[0] >> 8;
+	s[2] = h[0] >> 16;
+	s[3] = (h[0] >> 24) | (h[1] << 2);
+	s[4] = h[1] >> 6;
+	s[5] = h[1] >> 14;
+	s[6] = (h[1] >> 22) | (h[2] << 3);
+	s[7] = h[2] >> 5;
+	s[8] = h[2] >> 13;
+	s[9] = (h[2] >> 21) | (h[3] << 5);
+	s[10] = h[3] >> 3;
+	s[11] = h[3] >> 11;
+	s[12] = (h[3] >> 19) | (h[4] << 6);
+	s[13] = h[4] >> 2;
+	s[14] = h[4] >> 10;
+	s[15] = h[4] >> 18;
+	s[16] = h[5] >> 0;
+	s[17] = h[5] >> 8;
+	s[18] = h[5] >> 16;
+	s[19] = (h[5] >> 24) | (h[6] << 1);
+	s[20] = h[6] >> 7;
+	s[21] = h[6] >> 15;
+	s[22] = (h[6] >> 23) | (h[7] << 3);
+	s[23] = h[7] >> 5;
+	s[24] = h[7] >> 13;
+	s[25] = (h[7] >> 21) | (h[8] << 4);
+	s[26] = h[8] >> 4;
+	s[27] = h[8] >> 12;
+	s[28] = (h[8] >> 20) | (h[9] << 6);
+	s[29] = h[9] >> 2;
+	s[30] = h[9] >> 10;
+	s[31] = h[9] >> 18;
+}
+
+/* h = f */
+static __always_inline void fe_copy(fe *h, const fe *f)
+{
+	memmove(h, f, sizeof(u32) * 10);
+}
+
+static __always_inline void fe_copy_lt(fe_loose *h, const fe *f)
+{
+	memmove(h, f, sizeof(u32) * 10);
+}
+
+/* h = 0 */
+static __always_inline void fe_0(fe *h)
+{
+	memset(h, 0, sizeof(u32) * 10);
+}
+
+/* h = 1 */
+static __always_inline void fe_1(fe *h)
+{
+	memset(h, 0, sizeof(u32) * 10);
+	h->v[0] = 1;
+}
+
+static void fe_add_impl(u32 out[10], const u32 in1[10], const u32 in2[10])
+{
+	{ const u32 x20 = in1[9];
+	{ const u32 x21 = in1[8];
+	{ const u32 x19 = in1[7];
+	{ const u32 x17 = in1[6];
+	{ const u32 x15 = in1[5];
+	{ const u32 x13 = in1[4];
+	{ const u32 x11 = in1[3];
+	{ const u32 x9 = in1[2];
+	{ const u32 x7 = in1[1];
+	{ const u32 x5 = in1[0];
+	{ const u32 x38 = in2[9];
+	{ const u32 x39 = in2[8];
+	{ const u32 x37 = in2[7];
+	{ const u32 x35 = in2[6];
+	{ const u32 x33 = in2[5];
+	{ const u32 x31 = in2[4];
+	{ const u32 x29 = in2[3];
+	{ const u32 x27 = in2[2];
+	{ const u32 x25 = in2[1];
+	{ const u32 x23 = in2[0];
+	out[0] = (x5 + x23);
+	out[1] = (x7 + x25);
+	out[2] = (x9 + x27);
+	out[3] = (x11 + x29);
+	out[4] = (x13 + x31);
+	out[5] = (x15 + x33);
+	out[6] = (x17 + x35);
+	out[7] = (x19 + x37);
+	out[8] = (x21 + x39);
+	out[9] = (x20 + x38);
+	}}}}}}}}}}}}}}}}}}}}
+}
+
+/* h = f + g
+ * Can overlap h with f or g.
+ */
+static __always_inline void fe_add(fe_loose *h, const fe *f, const fe *g)
+{
+	fe_add_impl(h->v, f->v, g->v);
+}
+
+static void fe_sub_impl(u32 out[10], const u32 in1[10], const u32 in2[10])
+{
+	{ const u32 x20 = in1[9];
+	{ const u32 x21 = in1[8];
+	{ const u32 x19 = in1[7];
+	{ const u32 x17 = in1[6];
+	{ const u32 x15 = in1[5];
+	{ const u32 x13 = in1[4];
+	{ const u32 x11 = in1[3];
+	{ const u32 x9 = in1[2];
+	{ const u32 x7 = in1[1];
+	{ const u32 x5 = in1[0];
+	{ const u32 x38 = in2[9];
+	{ const u32 x39 = in2[8];
+	{ const u32 x37 = in2[7];
+	{ const u32 x35 = in2[6];
+	{ const u32 x33 = in2[5];
+	{ const u32 x31 = in2[4];
+	{ const u32 x29 = in2[3];
+	{ const u32 x27 = in2[2];
+	{ const u32 x25 = in2[1];
+	{ const u32 x23 = in2[0];
+	out[0] = ((0x7ffffda + x5) - x23);
+	out[1] = ((0x3fffffe + x7) - x25);
+	out[2] = ((0x7fffffe + x9) - x27);
+	out[3] = ((0x3fffffe + x11) - x29);
+	out[4] = ((0x7fffffe + x13) - x31);
+	out[5] = ((0x3fffffe + x15) - x33);
+	out[6] = ((0x7fffffe + x17) - x35);
+	out[7] = ((0x3fffffe + x19) - x37);
+	out[8] = ((0x7fffffe + x21) - x39);
+	out[9] = ((0x3fffffe + x20) - x38);
+	}}}}}}}}}}}}}}}}}}}}
+}
+
+/* h = f - g
+ * Can overlap h with f or g.
+ */
+static __always_inline void fe_sub(fe_loose *h, const fe *f, const fe *g)
+{
+	fe_sub_impl(h->v, f->v, g->v);
+}
+
+static void fe_mul_impl(u32 out[10], const u32 in1[10], const u32 in2[10])
+{
+	{ const u32 x20 = in1[9];
+	{ const u32 x21 = in1[8];
+	{ const u32 x19 = in1[7];
+	{ const u32 x17 = in1[6];
+	{ const u32 x15 = in1[5];
+	{ const u32 x13 = in1[4];
+	{ const u32 x11 = in1[3];
+	{ const u32 x9 = in1[2];
+	{ const u32 x7 = in1[1];
+	{ const u32 x5 = in1[0];
+	{ const u32 x38 = in2[9];
+	{ const u32 x39 = in2[8];
+	{ const u32 x37 = in2[7];
+	{ const u32 x35 = in2[6];
+	{ const u32 x33 = in2[5];
+	{ const u32 x31 = in2[4];
+	{ const u32 x29 = in2[3];
+	{ const u32 x27 = in2[2];
+	{ const u32 x25 = in2[1];
+	{ const u32 x23 = in2[0];
+	{ u64 x40 = ((u64)x23 * x5);
+	{ u64 x41 = (((u64)x23 * x7) + ((u64)x25 * x5));
+	{ u64 x42 = ((((u64)(0x2 * x25) * x7) + ((u64)x23 * x9)) + ((u64)x27 * x5));
+	{ u64 x43 = (((((u64)x25 * x9) + ((u64)x27 * x7)) + ((u64)x23 * x11)) + ((u64)x29 * x5));
+	{ u64 x44 = (((((u64)x27 * x9) + (0x2 * (((u64)x25 * x11) + ((u64)x29 * x7)))) + ((u64)x23 * x13)) + ((u64)x31 * x5));
+	{ u64 x45 = (((((((u64)x27 * x11) + ((u64)x29 * x9)) + ((u64)x25 * x13)) + ((u64)x31 * x7)) + ((u64)x23 * x15)) + ((u64)x33 * x5));
+	{ u64 x46 = (((((0x2 * ((((u64)x29 * x11) + ((u64)x25 * x15)) + ((u64)x33 * x7))) + ((u64)x27 * x13)) + ((u64)x31 * x9)) + ((u64)x23 * x17)) + ((u64)x35 * x5));
+	{ u64 x47 = (((((((((u64)x29 * x13) + ((u64)x31 * x11)) + ((u64)x27 * x15)) + ((u64)x33 * x9)) + ((u64)x25 * x17)) + ((u64)x35 * x7)) + ((u64)x23 * x19)) + ((u64)x37 * x5));
+	{ u64 x48 = (((((((u64)x31 * x13) + (0x2 * (((((u64)x29 * x15) + ((u64)x33 * x11)) + ((u64)x25 * x19)) + ((u64)x37 * x7)))) + ((u64)x27 * x17)) + ((u64)x35 * x9)) + ((u64)x23 * x21)) + ((u64)x39 * x5));
+	{ u64 x49 = (((((((((((u64)x31 * x15) + ((u64)x33 * x13)) + ((u64)x29 * x17)) + ((u64)x35 * x11)) + ((u64)x27 * x19)) + ((u64)x37 * x9)) + ((u64)x25 * x21)) + ((u64)x39 * x7)) + ((u64)x23 * x20)) + ((u64)x38 * x5));
+	{ u64 x50 = (((((0x2 * ((((((u64)x33 * x15) + ((u64)x29 * x19)) + ((u64)x37 * x11)) + ((u64)x25 * x20)) + ((u64)x38 * x7))) + ((u64)x31 * x17)) + ((u64)x35 * x13)) + ((u64)x27 * x21)) + ((u64)x39 * x9));
+	{ u64 x51 = (((((((((u64)x33 * x17) + ((u64)x35 * x15)) + ((u64)x31 * x19)) + ((u64)x37 * x13)) + ((u64)x29 * x21)) + ((u64)x39 * x11)) + ((u64)x27 * x20)) + ((u64)x38 * x9));
+	{ u64 x52 = (((((u64)x35 * x17) + (0x2 * (((((u64)x33 * x19) + ((u64)x37 * x15)) + ((u64)x29 * x20)) + ((u64)x38 * x11)))) + ((u64)x31 * x21)) + ((u64)x39 * x13));
+	{ u64 x53 = (((((((u64)x35 * x19) + ((u64)x37 * x17)) + ((u64)x33 * x21)) + ((u64)x39 * x15)) + ((u64)x31 * x20)) + ((u64)x38 * x13));
+	{ u64 x54 = (((0x2 * ((((u64)x37 * x19) + ((u64)x33 * x20)) + ((u64)x38 * x15))) + ((u64)x35 * x21)) + ((u64)x39 * x17));
+	{ u64 x55 = (((((u64)x37 * x21) + ((u64)x39 * x19)) + ((u64)x35 * x20)) + ((u64)x38 * x17));
+	{ u64 x56 = (((u64)x39 * x21) + (0x2 * (((u64)x37 * x20) + ((u64)x38 * x19))));
+	{ u64 x57 = (((u64)x39 * x20) + ((u64)x38 * x21));
+	{ u64 x58 = ((u64)(0x2 * x38) * x20);
+	{ u64 x59 = (x48 + (x58 << 0x4));
+	{ u64 x60 = (x59 + (x58 << 0x1));
+	{ u64 x61 = (x60 + x58);
+	{ u64 x62 = (x47 + (x57 << 0x4));
+	{ u64 x63 = (x62 + (x57 << 0x1));
+	{ u64 x64 = (x63 + x57);
+	{ u64 x65 = (x46 + (x56 << 0x4));
+	{ u64 x66 = (x65 + (x56 << 0x1));
+	{ u64 x67 = (x66 + x56);
+	{ u64 x68 = (x45 + (x55 << 0x4));
+	{ u64 x69 = (x68 + (x55 << 0x1));
+	{ u64 x70 = (x69 + x55);
+	{ u64 x71 = (x44 + (x54 << 0x4));
+	{ u64 x72 = (x71 + (x54 << 0x1));
+	{ u64 x73 = (x72 + x54);
+	{ u64 x74 = (x43 + (x53 << 0x4));
+	{ u64 x75 = (x74 + (x53 << 0x1));
+	{ u64 x76 = (x75 + x53);
+	{ u64 x77 = (x42 + (x52 << 0x4));
+	{ u64 x78 = (x77 + (x52 << 0x1));
+	{ u64 x79 = (x78 + x52);
+	{ u64 x80 = (x41 + (x51 << 0x4));
+	{ u64 x81 = (x80 + (x51 << 0x1));
+	{ u64 x82 = (x81 + x51);
+	{ u64 x83 = (x40 + (x50 << 0x4));
+	{ u64 x84 = (x83 + (x50 << 0x1));
+	{ u64 x85 = (x84 + x50);
+	{ u64 x86 = (x85 >> 0x1a);
+	{ u32 x87 = ((u32)x85 & 0x3ffffff);
+	{ u64 x88 = (x86 + x82);
+	{ u64 x89 = (x88 >> 0x19);
+	{ u32 x90 = ((u32)x88 & 0x1ffffff);
+	{ u64 x91 = (x89 + x79);
+	{ u64 x92 = (x91 >> 0x1a);
+	{ u32 x93 = ((u32)x91 & 0x3ffffff);
+	{ u64 x94 = (x92 + x76);
+	{ u64 x95 = (x94 >> 0x19);
+	{ u32 x96 = ((u32)x94 & 0x1ffffff);
+	{ u64 x97 = (x95 + x73);
+	{ u64 x98 = (x97 >> 0x1a);
+	{ u32 x99 = ((u32)x97 & 0x3ffffff);
+	{ u64 x100 = (x98 + x70);
+	{ u64 x101 = (x100 >> 0x19);
+	{ u32 x102 = ((u32)x100 & 0x1ffffff);
+	{ u64 x103 = (x101 + x67);
+	{ u64 x104 = (x103 >> 0x1a);
+	{ u32 x105 = ((u32)x103 & 0x3ffffff);
+	{ u64 x106 = (x104 + x64);
+	{ u64 x107 = (x106 >> 0x19);
+	{ u32 x108 = ((u32)x106 & 0x1ffffff);
+	{ u64 x109 = (x107 + x61);
+	{ u64 x110 = (x109 >> 0x1a);
+	{ u32 x111 = ((u32)x109 & 0x3ffffff);
+	{ u64 x112 = (x110 + x49);
+	{ u64 x113 = (x112 >> 0x19);
+	{ u32 x114 = ((u32)x112 & 0x1ffffff);
+	{ u64 x115 = (x87 + (0x13 * x113));
+	{ u32 x116 = (u32) (x115 >> 0x1a);
+	{ u32 x117 = ((u32)x115 & 0x3ffffff);
+	{ u32 x118 = (x116 + x90);
+	{ u32 x119 = (x118 >> 0x19);
+	{ u32 x120 = (x118 & 0x1ffffff);
+	out[0] = x117;
+	out[1] = x120;
+	out[2] = (x119 + x93);
+	out[3] = x96;
+	out[4] = x99;
+	out[5] = x102;
+	out[6] = x105;
+	out[7] = x108;
+	out[8] = x111;
+	out[9] = x114;
+	}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
+}
+
+static __always_inline void fe_mul_ttt(fe *h, const fe *f, const fe *g)
+{
+	fe_mul_impl(h->v, f->v, g->v);
+}
+
+static __always_inline void fe_mul_tlt(fe *h, const fe_loose *f, const fe *g)
+{
+	fe_mul_impl(h->v, f->v, g->v);
+}
+
+static __always_inline void
+fe_mul_tll(fe *h, const fe_loose *f, const fe_loose *g)
+{
+	fe_mul_impl(h->v, f->v, g->v);
+}
+
+static void fe_sqr_impl(u32 out[10], const u32 in1[10])
+{
+	{ const u32 x17 = in1[9];
+	{ const u32 x18 = in1[8];
+	{ const u32 x16 = in1[7];
+	{ const u32 x14 = in1[6];
+	{ const u32 x12 = in1[5];
+	{ const u32 x10 = in1[4];
+	{ const u32 x8 = in1[3];
+	{ const u32 x6 = in1[2];
+	{ const u32 x4 = in1[1];
+	{ const u32 x2 = in1[0];
+	{ u64 x19 = ((u64)x2 * x2);
+	{ u64 x20 = ((u64)(0x2 * x2) * x4);
+	{ u64 x21 = (0x2 * (((u64)x4 * x4) + ((u64)x2 * x6)));
+	{ u64 x22 = (0x2 * (((u64)x4 * x6) + ((u64)x2 * x8)));
+	{ u64 x23 = ((((u64)x6 * x6) + ((u64)(0x4 * x4) * x8)) + ((u64)(0x2 * x2) * x10));
+	{ u64 x24 = (0x2 * ((((u64)x6 * x8) + ((u64)x4 * x10)) + ((u64)x2 * x12)));
+	{ u64 x25 = (0x2 * (((((u64)x8 * x8) + ((u64)x6 * x10)) + ((u64)x2 * x14)) + ((u64)(0x2 * x4) * x12)));
+	{ u64 x26 = (0x2 * (((((u64)x8 * x10) + ((u64)x6 * x12)) + ((u64)x4 * x14)) + ((u64)x2 * x16)));
+	{ u64 x27 = (((u64)x10 * x10) + (0x2 * ((((u64)x6 * x14) + ((u64)x2 * x18)) + (0x2 * (((u64)x4 * x16) + ((u64)x8 * x12))))));
+	{ u64 x28 = (0x2 * ((((((u64)x10 * x12) + ((u64)x8 * x14)) + ((u64)x6 * x16)) + ((u64)x4 * x18)) + ((u64)x2 * x17)));
+	{ u64 x29 = (0x2 * (((((u64)x12 * x12) + ((u64)x10 * x14)) + ((u64)x6 * x18)) + (0x2 * (((u64)x8 * x16) + ((u64)x4 * x17)))));
+	{ u64 x30 = (0x2 * (((((u64)x12 * x14) + ((u64)x10 * x16)) + ((u64)x8 * x18)) + ((u64)x6 * x17)));
+	{ u64 x31 = (((u64)x14 * x14) + (0x2 * (((u64)x10 * x18) + (0x2 * (((u64)x12 * x16) + ((u64)x8 * x17))))));
+	{ u64 x32 = (0x2 * ((((u64)x14 * x16) + ((u64)x12 * x18)) + ((u64)x10 * x17)));
+	{ u64 x33 = (0x2 * ((((u64)x16 * x16) + ((u64)x14 * x18)) + ((u64)(0x2 * x12) * x17)));
+	{ u64 x34 = (0x2 * (((u64)x16 * x18) + ((u64)x14 * x17)));
+	{ u64 x35 = (((u64)x18 * x18) + ((u64)(0x4 * x16) * x17));
+	{ u64 x36 = ((u64)(0x2 * x18) * x17);
+	{ u64 x37 = ((u64)(0x2 * x17) * x17);
+	{ u64 x38 = (x27 + (x37 << 0x4));
+	{ u64 x39 = (x38 + (x37 << 0x1));
+	{ u64 x40 = (x39 + x37);
+	{ u64 x41 = (x26 + (x36 << 0x4));
+	{ u64 x42 = (x41 + (x36 << 0x1));
+	{ u64 x43 = (x42 + x36);
+	{ u64 x44 = (x25 + (x35 << 0x4));
+	{ u64 x45 = (x44 + (x35 << 0x1));
+	{ u64 x46 = (x45 + x35);
+	{ u64 x47 = (x24 + (x34 << 0x4));
+	{ u64 x48 = (x47 + (x34 << 0x1));
+	{ u64 x49 = (x48 + x34);
+	{ u64 x50 = (x23 + (x33 << 0x4));
+	{ u64 x51 = (x50 + (x33 << 0x1));
+	{ u64 x52 = (x51 + x33);
+	{ u64 x53 = (x22 + (x32 << 0x4));
+	{ u64 x54 = (x53 + (x32 << 0x1));
+	{ u64 x55 = (x54 + x32);
+	{ u64 x56 = (x21 + (x31 << 0x4));
+	{ u64 x57 = (x56 + (x31 << 0x1));
+	{ u64 x58 = (x57 + x31);
+	{ u64 x59 = (x20 + (x30 << 0x4));
+	{ u64 x60 = (x59 + (x30 << 0x1));
+	{ u64 x61 = (x60 + x30);
+	{ u64 x62 = (x19 + (x29 << 0x4));
+	{ u64 x63 = (x62 + (x29 << 0x1));
+	{ u64 x64 = (x63 + x29);
+	{ u64 x65 = (x64 >> 0x1a);
+	{ u32 x66 = ((u32)x64 & 0x3ffffff);
+	{ u64 x67 = (x65 + x61);
+	{ u64 x68 = (x67 >> 0x19);
+	{ u32 x69 = ((u32)x67 & 0x1ffffff);
+	{ u64 x70 = (x68 + x58);
+	{ u64 x71 = (x70 >> 0x1a);
+	{ u32 x72 = ((u32)x70 & 0x3ffffff);
+	{ u64 x73 = (x71 + x55);
+	{ u64 x74 = (x73 >> 0x19);
+	{ u32 x75 = ((u32)x73 & 0x1ffffff);
+	{ u64 x76 = (x74 + x52);
+	{ u64 x77 = (x76 >> 0x1a);
+	{ u32 x78 = ((u32)x76 & 0x3ffffff);
+	{ u64 x79 = (x77 + x49);
+	{ u64 x80 = (x79 >> 0x19);
+	{ u32 x81 = ((u32)x79 & 0x1ffffff);
+	{ u64 x82 = (x80 + x46);
+	{ u64 x83 = (x82 >> 0x1a);
+	{ u32 x84 = ((u32)x82 & 0x3ffffff);
+	{ u64 x85 = (x83 + x43);
+	{ u64 x86 = (x85 >> 0x19);
+	{ u32 x87 = ((u32)x85 & 0x1ffffff);
+	{ u64 x88 = (x86 + x40);
+	{ u64 x89 = (x88 >> 0x1a);
+	{ u32 x90 = ((u32)x88 & 0x3ffffff);
+	{ u64 x91 = (x89 + x28);
+	{ u64 x92 = (x91 >> 0x19);
+	{ u32 x93 = ((u32)x91 & 0x1ffffff);
+	{ u64 x94 = (x66 + (0x13 * x92));
+	{ u32 x95 = (u32) (x94 >> 0x1a);
+	{ u32 x96 = ((u32)x94 & 0x3ffffff);
+	{ u32 x97 = (x95 + x69);
+	{ u32 x98 = (x97 >> 0x19);
+	{ u32 x99 = (x97 & 0x1ffffff);
+	out[0] = x96;
+	out[1] = x99;
+	out[2] = (x98 + x72);
+	out[3] = x75;
+	out[4] = x78;
+	out[5] = x81;
+	out[6] = x84;
+	out[7] = x87;
+	out[8] = x90;
+	out[9] = x93;
+	}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
+}
+
+static __always_inline void fe_sq_tl(fe *h, const fe_loose *f)
+{
+	fe_sqr_impl(h->v, f->v);
+}
+
+static __always_inline void fe_sq_tt(fe *h, const fe *f)
+{
+	fe_sqr_impl(h->v, f->v);
+}
+
+static __always_inline void fe_loose_invert(fe *out, const fe_loose *z)
+{
+	fe t0;
+	fe t1;
+	fe t2;
+	fe t3;
+	int i;
+
+	fe_sq_tl(&t0, z);
+	fe_sq_tt(&t1, &t0);
+	for (i = 1; i < 2; ++i)
+		fe_sq_tt(&t1, &t1);
+	fe_mul_tlt(&t1, z, &t1);
+	fe_mul_ttt(&t0, &t0, &t1);
+	fe_sq_tt(&t2, &t0);
+	fe_mul_ttt(&t1, &t1, &t2);
+	fe_sq_tt(&t2, &t1);
+	for (i = 1; i < 5; ++i)
+		fe_sq_tt(&t2, &t2);
+	fe_mul_ttt(&t1, &t2, &t1);
+	fe_sq_tt(&t2, &t1);
+	for (i = 1; i < 10; ++i)
+		fe_sq_tt(&t2, &t2);
+	fe_mul_ttt(&t2, &t2, &t1);
+	fe_sq_tt(&t3, &t2);
+	for (i = 1; i < 20; ++i)
+		fe_sq_tt(&t3, &t3);
+	fe_mul_ttt(&t2, &t3, &t2);
+	fe_sq_tt(&t2, &t2);
+	for (i = 1; i < 10; ++i)
+		fe_sq_tt(&t2, &t2);
+	fe_mul_ttt(&t1, &t2, &t1);
+	fe_sq_tt(&t2, &t1);
+	for (i = 1; i < 50; ++i)
+		fe_sq_tt(&t2, &t2);
+	fe_mul_ttt(&t2, &t2, &t1);
+	fe_sq_tt(&t3, &t2);
+	for (i = 1; i < 100; ++i)
+		fe_sq_tt(&t3, &t3);
+	fe_mul_ttt(&t2, &t3, &t2);
+	fe_sq_tt(&t2, &t2);
+	for (i = 1; i < 50; ++i)
+		fe_sq_tt(&t2, &t2);
+	fe_mul_ttt(&t1, &t2, &t1);
+	fe_sq_tt(&t1, &t1);
+	for (i = 1; i < 5; ++i)
+		fe_sq_tt(&t1, &t1);
+	fe_mul_ttt(out, &t1, &t0);
+}
+
+static __always_inline void fe_invert(fe *out, const fe *z)
+{
+	fe_loose l;
+	fe_copy_lt(&l, z);
+	fe_loose_invert(out, &l);
+}
+
+/* Replace (f,g) with (g,f) if b == 1;
+ * replace (f,g) with (f,g) if b == 0.
+ *
+ * Preconditions: b in {0,1}
+ */
+static __always_inline void fe_cswap(fe *f, fe *g, unsigned int b)
+{
+	unsigned i;
+	b = 0 - b;
+	for (i = 0; i < 10; i++) {
+		u32 x = f->v[i] ^ g->v[i];
+		x &= b;
+		f->v[i] ^= x;
+		g->v[i] ^= x;
+	}
+}
+
+/* NOTE: based on fiat-crypto fe_mul, edited for in2=121666, 0, 0.*/
+static __always_inline void fe_mul_121666_impl(u32 out[10], const u32 in1[10])
+{
+	{ const u32 x20 = in1[9];
+	{ const u32 x21 = in1[8];
+	{ const u32 x19 = in1[7];
+	{ const u32 x17 = in1[6];
+	{ const u32 x15 = in1[5];
+	{ const u32 x13 = in1[4];
+	{ const u32 x11 = in1[3];
+	{ const u32 x9 = in1[2];
+	{ const u32 x7 = in1[1];
+	{ const u32 x5 = in1[0];
+	{ const u32 x38 = 0;
+	{ const u32 x39 = 0;
+	{ const u32 x37 = 0;
+	{ const u32 x35 = 0;
+	{ const u32 x33 = 0;
+	{ const u32 x31 = 0;
+	{ const u32 x29 = 0;
+	{ const u32 x27 = 0;
+	{ const u32 x25 = 0;
+	{ const u32 x23 = 121666;
+	{ u64 x40 = ((u64)x23 * x5);
+	{ u64 x41 = (((u64)x23 * x7) + ((u64)x25 * x5));
+	{ u64 x42 = ((((u64)(0x2 * x25) * x7) + ((u64)x23 * x9)) + ((u64)x27 * x5));
+	{ u64 x43 = (((((u64)x25 * x9) + ((u64)x27 * x7)) + ((u64)x23 * x11)) + ((u64)x29 * x5));
+	{ u64 x44 = (((((u64)x27 * x9) + (0x2 * (((u64)x25 * x11) + ((u64)x29 * x7)))) + ((u64)x23 * x13)) + ((u64)x31 * x5));
+	{ u64 x45 = (((((((u64)x27 * x11) + ((u64)x29 * x9)) + ((u64)x25 * x13)) + ((u64)x31 * x7)) + ((u64)x23 * x15)) + ((u64)x33 * x5));
+	{ u64 x46 = (((((0x2 * ((((u64)x29 * x11) + ((u64)x25 * x15)) + ((u64)x33 * x7))) + ((u64)x27 * x13)) + ((u64)x31 * x9)) + ((u64)x23 * x17)) + ((u64)x35 * x5));
+	{ u64 x47 = (((((((((u64)x29 * x13) + ((u64)x31 * x11)) + ((u64)x27 * x15)) + ((u64)x33 * x9)) + ((u64)x25 * x17)) + ((u64)x35 * x7)) + ((u64)x23 * x19)) + ((u64)x37 * x5));
+	{ u64 x48 = (((((((u64)x31 * x13) + (0x2 * (((((u64)x29 * x15) + ((u64)x33 * x11)) + ((u64)x25 * x19)) + ((u64)x37 * x7)))) + ((u64)x27 * x17)) + ((u64)x35 * x9)) + ((u64)x23 * x21)) + ((u64)x39 * x5));
+	{ u64 x49 = (((((((((((u64)x31 * x15) + ((u64)x33 * x13)) + ((u64)x29 * x17)) + ((u64)x35 * x11)) + ((u64)x27 * x19)) + ((u64)x37 * x9)) + ((u64)x25 * x21)) + ((u64)x39 * x7)) + ((u64)x23 * x20)) + ((u64)x38 * x5));
+	{ u64 x50 = (((((0x2 * ((((((u64)x33 * x15) + ((u64)x29 * x19)) + ((u64)x37 * x11)) + ((u64)x25 * x20)) + ((u64)x38 * x7))) + ((u64)x31 * x17)) + ((u64)x35 * x13)) + ((u64)x27 * x21)) + ((u64)x39 * x9));
+	{ u64 x51 = (((((((((u64)x33 * x17) + ((u64)x35 * x15)) + ((u64)x31 * x19)) + ((u64)x37 * x13)) + ((u64)x29 * x21)) + ((u64)x39 * x11)) + ((u64)x27 * x20)) + ((u64)x38 * x9));
+	{ u64 x52 = (((((u64)x35 * x17) + (0x2 * (((((u64)x33 * x19) + ((u64)x37 * x15)) + ((u64)x29 * x20)) + ((u64)x38 * x11)))) + ((u64)x31 * x21)) + ((u64)x39 * x13));
+	{ u64 x53 = (((((((u64)x35 * x19) + ((u64)x37 * x17)) + ((u64)x33 * x21)) + ((u64)x39 * x15)) + ((u64)x31 * x20)) + ((u64)x38 * x13));
+	{ u64 x54 = (((0x2 * ((((u64)x37 * x19) + ((u64)x33 * x20)) + ((u64)x38 * x15))) + ((u64)x35 * x21)) + ((u64)x39 * x17));
+	{ u64 x55 = (((((u64)x37 * x21) + ((u64)x39 * x19)) + ((u64)x35 * x20)) + ((u64)x38 * x17));
+	{ u64 x56 = (((u64)x39 * x21) + (0x2 * (((u64)x37 * x20) + ((u64)x38 * x19))));
+	{ u64 x57 = (((u64)x39 * x20) + ((u64)x38 * x21));
+	{ u64 x58 = ((u64)(0x2 * x38) * x20);
+	{ u64 x59 = (x48 + (x58 << 0x4));
+	{ u64 x60 = (x59 + (x58 << 0x1));
+	{ u64 x61 = (x60 + x58);
+	{ u64 x62 = (x47 + (x57 << 0x4));
+	{ u64 x63 = (x62 + (x57 << 0x1));
+	{ u64 x64 = (x63 + x57);
+	{ u64 x65 = (x46 + (x56 << 0x4));
+	{ u64 x66 = (x65 + (x56 << 0x1));
+	{ u64 x67 = (x66 + x56);
+	{ u64 x68 = (x45 + (x55 << 0x4));
+	{ u64 x69 = (x68 + (x55 << 0x1));
+	{ u64 x70 = (x69 + x55);
+	{ u64 x71 = (x44 + (x54 << 0x4));
+	{ u64 x72 = (x71 + (x54 << 0x1));
+	{ u64 x73 = (x72 + x54);
+	{ u64 x74 = (x43 + (x53 << 0x4));
+	{ u64 x75 = (x74 + (x53 << 0x1));
+	{ u64 x76 = (x75 + x53);
+	{ u64 x77 = (x42 + (x52 << 0x4));
+	{ u64 x78 = (x77 + (x52 << 0x1));
+	{ u64 x79 = (x78 + x52);
+	{ u64 x80 = (x41 + (x51 << 0x4));
+	{ u64 x81 = (x80 + (x51 << 0x1));
+	{ u64 x82 = (x81 + x51);
+	{ u64 x83 = (x40 + (x50 << 0x4));
+	{ u64 x84 = (x83 + (x50 << 0x1));
+	{ u64 x85 = (x84 + x50);
+	{ u64 x86 = (x85 >> 0x1a);
+	{ u32 x87 = ((u32)x85 & 0x3ffffff);
+	{ u64 x88 = (x86 + x82);
+	{ u64 x89 = (x88 >> 0x19);
+	{ u32 x90 = ((u32)x88 & 0x1ffffff);
+	{ u64 x91 = (x89 + x79);
+	{ u64 x92 = (x91 >> 0x1a);
+	{ u32 x93 = ((u32)x91 & 0x3ffffff);
+	{ u64 x94 = (x92 + x76);
+	{ u64 x95 = (x94 >> 0x19);
+	{ u32 x96 = ((u32)x94 & 0x1ffffff);
+	{ u64 x97 = (x95 + x73);
+	{ u64 x98 = (x97 >> 0x1a);
+	{ u32 x99 = ((u32)x97 & 0x3ffffff);
+	{ u64 x100 = (x98 + x70);
+	{ u64 x101 = (x100 >> 0x19);
+	{ u32 x102 = ((u32)x100 & 0x1ffffff);
+	{ u64 x103 = (x101 + x67);
+	{ u64 x104 = (x103 >> 0x1a);
+	{ u32 x105 = ((u32)x103 & 0x3ffffff);
+	{ u64 x106 = (x104 + x64);
+	{ u64 x107 = (x106 >> 0x19);
+	{ u32 x108 = ((u32)x106 & 0x1ffffff);
+	{ u64 x109 = (x107 + x61);
+	{ u64 x110 = (x109 >> 0x1a);
+	{ u32 x111 = ((u32)x109 & 0x3ffffff);
+	{ u64 x112 = (x110 + x49);
+	{ u64 x113 = (x112 >> 0x19);
+	{ u32 x114 = ((u32)x112 & 0x1ffffff);
+	{ u64 x115 = (x87 + (0x13 * x113));
+	{ u32 x116 = (u32) (x115 >> 0x1a);
+	{ u32 x117 = ((u32)x115 & 0x3ffffff);
+	{ u32 x118 = (x116 + x90);
+	{ u32 x119 = (x118 >> 0x19);
+	{ u32 x120 = (x118 & 0x1ffffff);
+	out[0] = x117;
+	out[1] = x120;
+	out[2] = (x119 + x93);
+	out[3] = x96;
+	out[4] = x99;
+	out[5] = x102;
+	out[6] = x105;
+	out[7] = x108;
+	out[8] = x111;
+	out[9] = x114;
+	}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}}
+}
+
+static __always_inline void fe_mul121666(fe *h, const fe_loose *f)
+{
+	fe_mul_121666_impl(h->v, f->v);
+}
+
+void curve25519_generic(u8 out[CURVE25519_KEY_SIZE],
+			const u8 scalar[CURVE25519_KEY_SIZE],
+			const u8 point[CURVE25519_KEY_SIZE])
+{
+	fe x1, x2, z2, x3, z3;
+	fe_loose x2l, z2l, x3l;
+	unsigned swap = 0;
+	int pos;
+	u8 e[32];
+
+	memcpy(e, scalar, 32);
+	curve25519_clamp_secret(e);
+
+	/* The following implementation was transcribed to Coq and proven to
+	 * correspond to unary scalar multiplication in affine coordinates given
+	 * that x1 != 0 is the x coordinate of some point on the curve. It was
+	 * also checked in Coq that doing a ladderstep with x1 = x3 = 0 gives
+	 * z2' = z3' = 0, and z2 = z3 = 0 gives z2' = z3' = 0. The statement was
+	 * quantified over the underlying field, so it applies to Curve25519
+	 * itself and the quadratic twist of Curve25519. It was not proven in
+	 * Coq that prime-field arithmetic correctly simulates extension-field
+	 * arithmetic on prime-field values. The decoding of the byte array
+	 * representation of e was not considered.
+	 *
+	 * Specification of Montgomery curves in affine coordinates:
+	 * <https://github.com/mit-plv/fiat-crypto/blob/2456d821825521f7e03e65882cc3521795b0320f/src/Spec/MontgomeryCurve.v#L27>
+	 *
+	 * Proof that these form a group that is isomorphic to a Weierstrass
+	 * curve:
+	 * <https://github.com/mit-plv/fiat-crypto/blob/2456d821825521f7e03e65882cc3521795b0320f/src/Curves/Montgomery/AffineProofs.v#L35>
+	 *
+	 * Coq transcription and correctness proof of the loop
+	 * (where scalarbits=255):
+	 * <https://github.com/mit-plv/fiat-crypto/blob/2456d821825521f7e03e65882cc3521795b0320f/src/Curves/Montgomery/XZ.v#L118>
+	 * <https://github.com/mit-plv/fiat-crypto/blob/2456d821825521f7e03e65882cc3521795b0320f/src/Curves/Montgomery/XZProofs.v#L278>
+	 * preconditions: 0 <= e < 2^255 (not necessarily e < order),
+	 * fe_invert(0) = 0
+	 */
+	fe_frombytes(&x1, point);
+	fe_1(&x2);
+	fe_0(&z2);
+	fe_copy(&x3, &x1);
+	fe_1(&z3);
+
+	for (pos = 254; pos >= 0; --pos) {
+		fe tmp0, tmp1;
+		fe_loose tmp0l, tmp1l;
+		/* loop invariant as of right before the test, for the case
+		 * where x1 != 0:
+		 *   pos >= -1; if z2 = 0 then x2 is nonzero; if z3 = 0 then x3
+		 *   is nonzero
+		 *   let r := e >> (pos+1) in the following equalities of
+		 *   projective points:
+		 *   to_xz (r*P)     === if swap then (x3, z3) else (x2, z2)
+		 *   to_xz ((r+1)*P) === if swap then (x2, z2) else (x3, z3)
+		 *   x1 is the nonzero x coordinate of the nonzero
+		 *   point (r*P-(r+1)*P)
+		 */
+		unsigned b = 1 & (e[pos / 8] >> (pos & 7));
+		swap ^= b;
+		fe_cswap(&x2, &x3, swap);
+		fe_cswap(&z2, &z3, swap);
+		swap = b;
+		/* Coq transcription of ladderstep formula (called from
+		 * transcribed loop):
+		 * <https://github.com/mit-plv/fiat-crypto/blob/2456d821825521f7e03e65882cc3521795b0320f/src/Curves/Montgomery/XZ.v#L89>
+		 * <https://github.com/mit-plv/fiat-crypto/blob/2456d821825521f7e03e65882cc3521795b0320f/src/Curves/Montgomery/XZProofs.v#L131>
+		 * x1 != 0 <https://github.com/mit-plv/fiat-crypto/blob/2456d821825521f7e03e65882cc3521795b0320f/src/Curves/Montgomery/XZProofs.v#L217>
+		 * x1  = 0 <https://github.com/mit-plv/fiat-crypto/blob/2456d821825521f7e03e65882cc3521795b0320f/src/Curves/Montgomery/XZProofs.v#L147>
+		 */
+		fe_sub(&tmp0l, &x3, &z3);
+		fe_sub(&tmp1l, &x2, &z2);
+		fe_add(&x2l, &x2, &z2);
+		fe_add(&z2l, &x3, &z3);
+		fe_mul_tll(&z3, &tmp0l, &x2l);
+		fe_mul_tll(&z2, &z2l, &tmp1l);
+		fe_sq_tl(&tmp0, &tmp1l);
+		fe_sq_tl(&tmp1, &x2l);
+		fe_add(&x3l, &z3, &z2);
+		fe_sub(&z2l, &z3, &z2);
+		fe_mul_ttt(&x2, &tmp1, &tmp0);
+		fe_sub(&tmp1l, &tmp1, &tmp0);
+		fe_sq_tl(&z2, &z2l);
+		fe_mul121666(&z3, &tmp1l);
+		fe_sq_tl(&x3, &x3l);
+		fe_add(&tmp0l, &tmp0, &z3);
+		fe_mul_ttt(&z3, &x1, &z2);
+		fe_mul_tll(&z2, &tmp1l, &tmp0l);
+	}
+	/* here pos=-1, so r=e, so to_xz (e*P) === if swap then (x3, z3)
+	 * else (x2, z2)
+	 */
+	fe_cswap(&x2, &x3, swap);
+	fe_cswap(&z2, &z3, swap);
+
+	fe_invert(&z2, &z2);
+	fe_mul_ttt(&x2, &x2, &z2);
+	fe_tobytes(out, &x2);
+
+	memzero_explicit(&x1, sizeof(x1));
+	memzero_explicit(&x2, sizeof(x2));
+	memzero_explicit(&z2, sizeof(z2));
+	memzero_explicit(&x3, sizeof(x3));
+	memzero_explicit(&z3, sizeof(z3));
+	memzero_explicit(&x2l, sizeof(x2l));
+	memzero_explicit(&z2l, sizeof(z2l));
+	memzero_explicit(&x3l, sizeof(x3l));
+	memzero_explicit(&e, sizeof(e));
+}
diff --git a/lib/crypto/curve25519-hacl64.c b/lib/crypto/curve25519-hacl64.c
new file mode 100644
index 000000000000..771d82dc5f14
--- /dev/null
+++ b/lib/crypto/curve25519-hacl64.c
@@ -0,0 +1,788 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2016-2017 INRIA and Microsoft Corporation.
+ * Copyright (C) 2018-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ *
+ * This is a machine-generated formally verified implementation of Curve25519
+ * ECDH from: <https://github.com/mitls/hacl-star>. Though originally machine
+ * generated, it has been tweaked to be suitable for use in the kernel. It is
+ * optimized for 64-bit machines that can efficiently work with 128-bit
+ * integer types.
+ */
+
+#include <asm/unaligned.h>
+#include <crypto/curve25519.h>
+#include <linux/string.h>
+
+typedef __uint128_t u128;
+
+static __always_inline u64 u64_eq_mask(u64 a, u64 b)
+{
+	u64 x = a ^ b;
+	u64 minus_x = ~x + (u64)1U;
+	u64 x_or_minus_x = x | minus_x;
+	u64 xnx = x_or_minus_x >> (u32)63U;
+	u64 c = xnx - (u64)1U;
+	return c;
+}
+
+static __always_inline u64 u64_gte_mask(u64 a, u64 b)
+{
+	u64 x = a;
+	u64 y = b;
+	u64 x_xor_y = x ^ y;
+	u64 x_sub_y = x - y;
+	u64 x_sub_y_xor_y = x_sub_y ^ y;
+	u64 q = x_xor_y | x_sub_y_xor_y;
+	u64 x_xor_q = x ^ q;
+	u64 x_xor_q_ = x_xor_q >> (u32)63U;
+	u64 c = x_xor_q_ - (u64)1U;
+	return c;
+}
+
+static __always_inline void modulo_carry_top(u64 *b)
+{
+	u64 b4 = b[4];
+	u64 b0 = b[0];
+	u64 b4_ = b4 & 0x7ffffffffffffLLU;
+	u64 b0_ = b0 + 19 * (b4 >> 51);
+	b[4] = b4_;
+	b[0] = b0_;
+}
+
+static __always_inline void fproduct_copy_from_wide_(u64 *output, u128 *input)
+{
+	{
+		u128 xi = input[0];
+		output[0] = ((u64)(xi));
+	}
+	{
+		u128 xi = input[1];
+		output[1] = ((u64)(xi));
+	}
+	{
+		u128 xi = input[2];
+		output[2] = ((u64)(xi));
+	}
+	{
+		u128 xi = input[3];
+		output[3] = ((u64)(xi));
+	}
+	{
+		u128 xi = input[4];
+		output[4] = ((u64)(xi));
+	}
+}
+
+static __always_inline void
+fproduct_sum_scalar_multiplication_(u128 *output, u64 *input, u64 s)
+{
+	output[0] += (u128)input[0] * s;
+	output[1] += (u128)input[1] * s;
+	output[2] += (u128)input[2] * s;
+	output[3] += (u128)input[3] * s;
+	output[4] += (u128)input[4] * s;
+}
+
+static __always_inline void fproduct_carry_wide_(u128 *tmp)
+{
+	{
+		u32 ctr = 0;
+		u128 tctr = tmp[ctr];
+		u128 tctrp1 = tmp[ctr + 1];
+		u64 r0 = ((u64)(tctr)) & 0x7ffffffffffffLLU;
+		u128 c = ((tctr) >> (51));
+		tmp[ctr] = ((u128)(r0));
+		tmp[ctr + 1] = ((tctrp1) + (c));
+	}
+	{
+		u32 ctr = 1;
+		u128 tctr = tmp[ctr];
+		u128 tctrp1 = tmp[ctr + 1];
+		u64 r0 = ((u64)(tctr)) & 0x7ffffffffffffLLU;
+		u128 c = ((tctr) >> (51));
+		tmp[ctr] = ((u128)(r0));
+		tmp[ctr + 1] = ((tctrp1) + (c));
+	}
+
+	{
+		u32 ctr = 2;
+		u128 tctr = tmp[ctr];
+		u128 tctrp1 = tmp[ctr + 1];
+		u64 r0 = ((u64)(tctr)) & 0x7ffffffffffffLLU;
+		u128 c = ((tctr) >> (51));
+		tmp[ctr] = ((u128)(r0));
+		tmp[ctr + 1] = ((tctrp1) + (c));
+	}
+	{
+		u32 ctr = 3;
+		u128 tctr = tmp[ctr];
+		u128 tctrp1 = tmp[ctr + 1];
+		u64 r0 = ((u64)(tctr)) & 0x7ffffffffffffLLU;
+		u128 c = ((tctr) >> (51));
+		tmp[ctr] = ((u128)(r0));
+		tmp[ctr + 1] = ((tctrp1) + (c));
+	}
+}
+
+static __always_inline void fmul_shift_reduce(u64 *output)
+{
+	u64 tmp = output[4];
+	u64 b0;
+	{
+		u32 ctr = 5 - 0 - 1;
+		u64 z = output[ctr - 1];
+		output[ctr] = z;
+	}
+	{
+		u32 ctr = 5 - 1 - 1;
+		u64 z = output[ctr - 1];
+		output[ctr] = z;
+	}
+	{
+		u32 ctr = 5 - 2 - 1;
+		u64 z = output[ctr - 1];
+		output[ctr] = z;
+	}
+	{
+		u32 ctr = 5 - 3 - 1;
+		u64 z = output[ctr - 1];
+		output[ctr] = z;
+	}
+	output[0] = tmp;
+	b0 = output[0];
+	output[0] = 19 * b0;
+}
+
+static __always_inline void fmul_mul_shift_reduce_(u128 *output, u64 *input,
+						   u64 *input21)
+{
+	u32 i;
+	u64 input2i;
+	{
+		u64 input2i = input21[0];
+		fproduct_sum_scalar_multiplication_(output, input, input2i);
+		fmul_shift_reduce(input);
+	}
+	{
+		u64 input2i = input21[1];
+		fproduct_sum_scalar_multiplication_(output, input, input2i);
+		fmul_shift_reduce(input);
+	}
+	{
+		u64 input2i = input21[2];
+		fproduct_sum_scalar_multiplication_(output, input, input2i);
+		fmul_shift_reduce(input);
+	}
+	{
+		u64 input2i = input21[3];
+		fproduct_sum_scalar_multiplication_(output, input, input2i);
+		fmul_shift_reduce(input);
+	}
+	i = 4;
+	input2i = input21[i];
+	fproduct_sum_scalar_multiplication_(output, input, input2i);
+}
+
+static __always_inline void fmul_fmul(u64 *output, u64 *input, u64 *input21)
+{
+	u64 tmp[5] = { input[0], input[1], input[2], input[3], input[4] };
+	{
+		u128 b4;
+		u128 b0;
+		u128 b4_;
+		u128 b0_;
+		u64 i0;
+		u64 i1;
+		u64 i0_;
+		u64 i1_;
+		u128 t[5] = { 0 };
+		fmul_mul_shift_reduce_(t, tmp, input21);
+		fproduct_carry_wide_(t);
+		b4 = t[4];
+		b0 = t[0];
+		b4_ = ((b4) & (((u128)(0x7ffffffffffffLLU))));
+		b0_ = ((b0) + (((u128)(19) * (((u64)(((b4) >> (51))))))));
+		t[4] = b4_;
+		t[0] = b0_;
+		fproduct_copy_from_wide_(output, t);
+		i0 = output[0];
+		i1 = output[1];
+		i0_ = i0 & 0x7ffffffffffffLLU;
+		i1_ = i1 + (i0 >> 51);
+		output[0] = i0_;
+		output[1] = i1_;
+	}
+}
+
+static __always_inline void fsquare_fsquare__(u128 *tmp, u64 *output)
+{
+	u64 r0 = output[0];
+	u64 r1 = output[1];
+	u64 r2 = output[2];
+	u64 r3 = output[3];
+	u64 r4 = output[4];
+	u64 d0 = r0 * 2;
+	u64 d1 = r1 * 2;
+	u64 d2 = r2 * 2 * 19;
+	u64 d419 = r4 * 19;
+	u64 d4 = d419 * 2;
+	u128 s0 = ((((((u128)(r0) * (r0))) + (((u128)(d4) * (r1))))) +
+		   (((u128)(d2) * (r3))));
+	u128 s1 = ((((((u128)(d0) * (r1))) + (((u128)(d4) * (r2))))) +
+		   (((u128)(r3 * 19) * (r3))));
+	u128 s2 = ((((((u128)(d0) * (r2))) + (((u128)(r1) * (r1))))) +
+		   (((u128)(d4) * (r3))));
+	u128 s3 = ((((((u128)(d0) * (r3))) + (((u128)(d1) * (r2))))) +
+		   (((u128)(r4) * (d419))));
+	u128 s4 = ((((((u128)(d0) * (r4))) + (((u128)(d1) * (r3))))) +
+		   (((u128)(r2) * (r2))));
+	tmp[0] = s0;
+	tmp[1] = s1;
+	tmp[2] = s2;
+	tmp[3] = s3;
+	tmp[4] = s4;
+}
+
+static __always_inline void fsquare_fsquare_(u128 *tmp, u64 *output)
+{
+	u128 b4;
+	u128 b0;
+	u128 b4_;
+	u128 b0_;
+	u64 i0;
+	u64 i1;
+	u64 i0_;
+	u64 i1_;
+	fsquare_fsquare__(tmp, output);
+	fproduct_carry_wide_(tmp);
+	b4 = tmp[4];
+	b0 = tmp[0];
+	b4_ = ((b4) & (((u128)(0x7ffffffffffffLLU))));
+	b0_ = ((b0) + (((u128)(19) * (((u64)(((b4) >> (51))))))));
+	tmp[4] = b4_;
+	tmp[0] = b0_;
+	fproduct_copy_from_wide_(output, tmp);
+	i0 = output[0];
+	i1 = output[1];
+	i0_ = i0 & 0x7ffffffffffffLLU;
+	i1_ = i1 + (i0 >> 51);
+	output[0] = i0_;
+	output[1] = i1_;
+}
+
+static __always_inline void fsquare_fsquare_times_(u64 *output, u128 *tmp,
+						   u32 count1)
+{
+	u32 i;
+	fsquare_fsquare_(tmp, output);
+	for (i = 1; i < count1; ++i)
+		fsquare_fsquare_(tmp, output);
+}
+
+static __always_inline void fsquare_fsquare_times(u64 *output, u64 *input,
+						  u32 count1)
+{
+	u128 t[5];
+	memcpy(output, input, 5 * sizeof(*input));
+	fsquare_fsquare_times_(output, t, count1);
+}
+
+static __always_inline void fsquare_fsquare_times_inplace(u64 *output,
+							  u32 count1)
+{
+	u128 t[5];
+	fsquare_fsquare_times_(output, t, count1);
+}
+
+static __always_inline void crecip_crecip(u64 *out, u64 *z)
+{
+	u64 buf[20] = { 0 };
+	u64 *a0 = buf;
+	u64 *t00 = buf + 5;
+	u64 *b0 = buf + 10;
+	u64 *t01;
+	u64 *b1;
+	u64 *c0;
+	u64 *a;
+	u64 *t0;
+	u64 *b;
+	u64 *c;
+	fsquare_fsquare_times(a0, z, 1);
+	fsquare_fsquare_times(t00, a0, 2);
+	fmul_fmul(b0, t00, z);
+	fmul_fmul(a0, b0, a0);
+	fsquare_fsquare_times(t00, a0, 1);
+	fmul_fmul(b0, t00, b0);
+	fsquare_fsquare_times(t00, b0, 5);
+	t01 = buf + 5;
+	b1 = buf + 10;
+	c0 = buf + 15;
+	fmul_fmul(b1, t01, b1);
+	fsquare_fsquare_times(t01, b1, 10);
+	fmul_fmul(c0, t01, b1);
+	fsquare_fsquare_times(t01, c0, 20);
+	fmul_fmul(t01, t01, c0);
+	fsquare_fsquare_times_inplace(t01, 10);
+	fmul_fmul(b1, t01, b1);
+	fsquare_fsquare_times(t01, b1, 50);
+	a = buf;
+	t0 = buf + 5;
+	b = buf + 10;
+	c = buf + 15;
+	fmul_fmul(c, t0, b);
+	fsquare_fsquare_times(t0, c, 100);
+	fmul_fmul(t0, t0, c);
+	fsquare_fsquare_times_inplace(t0, 50);
+	fmul_fmul(t0, t0, b);
+	fsquare_fsquare_times_inplace(t0, 5);
+	fmul_fmul(out, t0, a);
+}
+
+static __always_inline void fsum(u64 *a, u64 *b)
+{
+	a[0] += b[0];
+	a[1] += b[1];
+	a[2] += b[2];
+	a[3] += b[3];
+	a[4] += b[4];
+}
+
+static __always_inline void fdifference(u64 *a, u64 *b)
+{
+	u64 tmp[5] = { 0 };
+	u64 b0;
+	u64 b1;
+	u64 b2;
+	u64 b3;
+	u64 b4;
+	memcpy(tmp, b, 5 * sizeof(*b));
+	b0 = tmp[0];
+	b1 = tmp[1];
+	b2 = tmp[2];
+	b3 = tmp[3];
+	b4 = tmp[4];
+	tmp[0] = b0 + 0x3fffffffffff68LLU;
+	tmp[1] = b1 + 0x3ffffffffffff8LLU;
+	tmp[2] = b2 + 0x3ffffffffffff8LLU;
+	tmp[3] = b3 + 0x3ffffffffffff8LLU;
+	tmp[4] = b4 + 0x3ffffffffffff8LLU;
+	{
+		u64 xi = a[0];
+		u64 yi = tmp[0];
+		a[0] = yi - xi;
+	}
+	{
+		u64 xi = a[1];
+		u64 yi = tmp[1];
+		a[1] = yi - xi;
+	}
+	{
+		u64 xi = a[2];
+		u64 yi = tmp[2];
+		a[2] = yi - xi;
+	}
+	{
+		u64 xi = a[3];
+		u64 yi = tmp[3];
+		a[3] = yi - xi;
+	}
+	{
+		u64 xi = a[4];
+		u64 yi = tmp[4];
+		a[4] = yi - xi;
+	}
+}
+
+static __always_inline void fscalar(u64 *output, u64 *b, u64 s)
+{
+	u128 tmp[5];
+	u128 b4;
+	u128 b0;
+	u128 b4_;
+	u128 b0_;
+	{
+		u64 xi = b[0];
+		tmp[0] = ((u128)(xi) * (s));
+	}
+	{
+		u64 xi = b[1];
+		tmp[1] = ((u128)(xi) * (s));
+	}
+	{
+		u64 xi = b[2];
+		tmp[2] = ((u128)(xi) * (s));
+	}
+	{
+		u64 xi = b[3];
+		tmp[3] = ((u128)(xi) * (s));
+	}
+	{
+		u64 xi = b[4];
+		tmp[4] = ((u128)(xi) * (s));
+	}
+	fproduct_carry_wide_(tmp);
+	b4 = tmp[4];
+	b0 = tmp[0];
+	b4_ = ((b4) & (((u128)(0x7ffffffffffffLLU))));
+	b0_ = ((b0) + (((u128)(19) * (((u64)(((b4) >> (51))))))));
+	tmp[4] = b4_;
+	tmp[0] = b0_;
+	fproduct_copy_from_wide_(output, tmp);
+}
+
+static __always_inline void fmul(u64 *output, u64 *a, u64 *b)
+{
+	fmul_fmul(output, a, b);
+}
+
+static __always_inline void crecip(u64 *output, u64 *input)
+{
+	crecip_crecip(output, input);
+}
+
+static __always_inline void point_swap_conditional_step(u64 *a, u64 *b,
+							u64 swap1, u32 ctr)
+{
+	u32 i = ctr - 1;
+	u64 ai = a[i];
+	u64 bi = b[i];
+	u64 x = swap1 & (ai ^ bi);
+	u64 ai1 = ai ^ x;
+	u64 bi1 = bi ^ x;
+	a[i] = ai1;
+	b[i] = bi1;
+}
+
+static __always_inline void point_swap_conditional5(u64 *a, u64 *b, u64 swap1)
+{
+	point_swap_conditional_step(a, b, swap1, 5);
+	point_swap_conditional_step(a, b, swap1, 4);
+	point_swap_conditional_step(a, b, swap1, 3);
+	point_swap_conditional_step(a, b, swap1, 2);
+	point_swap_conditional_step(a, b, swap1, 1);
+}
+
+static __always_inline void point_swap_conditional(u64 *a, u64 *b, u64 iswap)
+{
+	u64 swap1 = 0 - iswap;
+	point_swap_conditional5(a, b, swap1);
+	point_swap_conditional5(a + 5, b + 5, swap1);
+}
+
+static __always_inline void point_copy(u64 *output, u64 *input)
+{
+	memcpy(output, input, 5 * sizeof(*input));
+	memcpy(output + 5, input + 5, 5 * sizeof(*input));
+}
+
+static __always_inline void addanddouble_fmonty(u64 *pp, u64 *ppq, u64 *p,
+						u64 *pq, u64 *qmqp)
+{
+	u64 *qx = qmqp;
+	u64 *x2 = pp;
+	u64 *z2 = pp + 5;
+	u64 *x3 = ppq;
+	u64 *z3 = ppq + 5;
+	u64 *x = p;
+	u64 *z = p + 5;
+	u64 *xprime = pq;
+	u64 *zprime = pq + 5;
+	u64 buf[40] = { 0 };
+	u64 *origx = buf;
+	u64 *origxprime0 = buf + 5;
+	u64 *xxprime0;
+	u64 *zzprime0;
+	u64 *origxprime;
+	xxprime0 = buf + 25;
+	zzprime0 = buf + 30;
+	memcpy(origx, x, 5 * sizeof(*x));
+	fsum(x, z);
+	fdifference(z, origx);
+	memcpy(origxprime0, xprime, 5 * sizeof(*xprime));
+	fsum(xprime, zprime);
+	fdifference(zprime, origxprime0);
+	fmul(xxprime0, xprime, z);
+	fmul(zzprime0, x, zprime);
+	origxprime = buf + 5;
+	{
+		u64 *xx0;
+		u64 *zz0;
+		u64 *xxprime;
+		u64 *zzprime;
+		u64 *zzzprime;
+		xx0 = buf + 15;
+		zz0 = buf + 20;
+		xxprime = buf + 25;
+		zzprime = buf + 30;
+		zzzprime = buf + 35;
+		memcpy(origxprime, xxprime, 5 * sizeof(*xxprime));
+		fsum(xxprime, zzprime);
+		fdifference(zzprime, origxprime);
+		fsquare_fsquare_times(x3, xxprime, 1);
+		fsquare_fsquare_times(zzzprime, zzprime, 1);
+		fmul(z3, zzzprime, qx);
+		fsquare_fsquare_times(xx0, x, 1);
+		fsquare_fsquare_times(zz0, z, 1);
+		{
+			u64 *zzz;
+			u64 *xx;
+			u64 *zz;
+			u64 scalar;
+			zzz = buf + 10;
+			xx = buf + 15;
+			zz = buf + 20;
+			fmul(x2, xx, zz);
+			fdifference(zz, xx);
+			scalar = 121665;
+			fscalar(zzz, zz, scalar);
+			fsum(zzz, xx);
+			fmul(z2, zzz, zz);
+		}
+	}
+}
+
+static __always_inline void
+ladder_smallloop_cmult_small_loop_step(u64 *nq, u64 *nqpq, u64 *nq2, u64 *nqpq2,
+				       u64 *q, u8 byt)
+{
+	u64 bit0 = (u64)(byt >> 7);
+	u64 bit;
+	point_swap_conditional(nq, nqpq, bit0);
+	addanddouble_fmonty(nq2, nqpq2, nq, nqpq, q);
+	bit = (u64)(byt >> 7);
+	point_swap_conditional(nq2, nqpq2, bit);
+}
+
+static __always_inline void
+ladder_smallloop_cmult_small_loop_double_step(u64 *nq, u64 *nqpq, u64 *nq2,
+					      u64 *nqpq2, u64 *q, u8 byt)
+{
+	u8 byt1;
+	ladder_smallloop_cmult_small_loop_step(nq, nqpq, nq2, nqpq2, q, byt);
+	byt1 = byt << 1;
+	ladder_smallloop_cmult_small_loop_step(nq2, nqpq2, nq, nqpq, q, byt1);
+}
+
+static __always_inline void
+ladder_smallloop_cmult_small_loop(u64 *nq, u64 *nqpq, u64 *nq2, u64 *nqpq2,
+				  u64 *q, u8 byt, u32 i)
+{
+	while (i--) {
+		ladder_smallloop_cmult_small_loop_double_step(nq, nqpq, nq2,
+							      nqpq2, q, byt);
+		byt <<= 2;
+	}
+}
+
+static __always_inline void ladder_bigloop_cmult_big_loop(u8 *n1, u64 *nq,
+							  u64 *nqpq, u64 *nq2,
+							  u64 *nqpq2, u64 *q,
+							  u32 i)
+{
+	while (i--) {
+		u8 byte = n1[i];
+		ladder_smallloop_cmult_small_loop(nq, nqpq, nq2, nqpq2, q,
+						  byte, 4);
+	}
+}
+
+static void ladder_cmult(u64 *result, u8 *n1, u64 *q)
+{
+	u64 point_buf[40] = { 0 };
+	u64 *nq = point_buf;
+	u64 *nqpq = point_buf + 10;
+	u64 *nq2 = point_buf + 20;
+	u64 *nqpq2 = point_buf + 30;
+	point_copy(nqpq, q);
+	nq[0] = 1;
+	ladder_bigloop_cmult_big_loop(n1, nq, nqpq, nq2, nqpq2, q, 32);
+	point_copy(result, nq);
+}
+
+static __always_inline void format_fexpand(u64 *output, const u8 *input)
+{
+	const u8 *x00 = input + 6;
+	const u8 *x01 = input + 12;
+	const u8 *x02 = input + 19;
+	const u8 *x0 = input + 24;
+	u64 i0, i1, i2, i3, i4, output0, output1, output2, output3, output4;
+	i0 = get_unaligned_le64(input);
+	i1 = get_unaligned_le64(x00);
+	i2 = get_unaligned_le64(x01);
+	i3 = get_unaligned_le64(x02);
+	i4 = get_unaligned_le64(x0);
+	output0 = i0 & 0x7ffffffffffffLLU;
+	output1 = i1 >> 3 & 0x7ffffffffffffLLU;
+	output2 = i2 >> 6 & 0x7ffffffffffffLLU;
+	output3 = i3 >> 1 & 0x7ffffffffffffLLU;
+	output4 = i4 >> 12 & 0x7ffffffffffffLLU;
+	output[0] = output0;
+	output[1] = output1;
+	output[2] = output2;
+	output[3] = output3;
+	output[4] = output4;
+}
+
+static __always_inline void format_fcontract_first_carry_pass(u64 *input)
+{
+	u64 t0 = input[0];
+	u64 t1 = input[1];
+	u64 t2 = input[2];
+	u64 t3 = input[3];
+	u64 t4 = input[4];
+	u64 t1_ = t1 + (t0 >> 51);
+	u64 t0_ = t0 & 0x7ffffffffffffLLU;
+	u64 t2_ = t2 + (t1_ >> 51);
+	u64 t1__ = t1_ & 0x7ffffffffffffLLU;
+	u64 t3_ = t3 + (t2_ >> 51);
+	u64 t2__ = t2_ & 0x7ffffffffffffLLU;
+	u64 t4_ = t4 + (t3_ >> 51);
+	u64 t3__ = t3_ & 0x7ffffffffffffLLU;
+	input[0] = t0_;
+	input[1] = t1__;
+	input[2] = t2__;
+	input[3] = t3__;
+	input[4] = t4_;
+}
+
+static __always_inline void format_fcontract_first_carry_full(u64 *input)
+{
+	format_fcontract_first_carry_pass(input);
+	modulo_carry_top(input);
+}
+
+static __always_inline void format_fcontract_second_carry_pass(u64 *input)
+{
+	u64 t0 = input[0];
+	u64 t1 = input[1];
+	u64 t2 = input[2];
+	u64 t3 = input[3];
+	u64 t4 = input[4];
+	u64 t1_ = t1 + (t0 >> 51);
+	u64 t0_ = t0 & 0x7ffffffffffffLLU;
+	u64 t2_ = t2 + (t1_ >> 51);
+	u64 t1__ = t1_ & 0x7ffffffffffffLLU;
+	u64 t3_ = t3 + (t2_ >> 51);
+	u64 t2__ = t2_ & 0x7ffffffffffffLLU;
+	u64 t4_ = t4 + (t3_ >> 51);
+	u64 t3__ = t3_ & 0x7ffffffffffffLLU;
+	input[0] = t0_;
+	input[1] = t1__;
+	input[2] = t2__;
+	input[3] = t3__;
+	input[4] = t4_;
+}
+
+static __always_inline void format_fcontract_second_carry_full(u64 *input)
+{
+	u64 i0;
+	u64 i1;
+	u64 i0_;
+	u64 i1_;
+	format_fcontract_second_carry_pass(input);
+	modulo_carry_top(input);
+	i0 = input[0];
+	i1 = input[1];
+	i0_ = i0 & 0x7ffffffffffffLLU;
+	i1_ = i1 + (i0 >> 51);
+	input[0] = i0_;
+	input[1] = i1_;
+}
+
+static __always_inline void format_fcontract_trim(u64 *input)
+{
+	u64 a0 = input[0];
+	u64 a1 = input[1];
+	u64 a2 = input[2];
+	u64 a3 = input[3];
+	u64 a4 = input[4];
+	u64 mask0 = u64_gte_mask(a0, 0x7ffffffffffedLLU);
+	u64 mask1 = u64_eq_mask(a1, 0x7ffffffffffffLLU);
+	u64 mask2 = u64_eq_mask(a2, 0x7ffffffffffffLLU);
+	u64 mask3 = u64_eq_mask(a3, 0x7ffffffffffffLLU);
+	u64 mask4 = u64_eq_mask(a4, 0x7ffffffffffffLLU);
+	u64 mask = (((mask0 & mask1) & mask2) & mask3) & mask4;
+	u64 a0_ = a0 - (0x7ffffffffffedLLU & mask);
+	u64 a1_ = a1 - (0x7ffffffffffffLLU & mask);
+	u64 a2_ = a2 - (0x7ffffffffffffLLU & mask);
+	u64 a3_ = a3 - (0x7ffffffffffffLLU & mask);
+	u64 a4_ = a4 - (0x7ffffffffffffLLU & mask);
+	input[0] = a0_;
+	input[1] = a1_;
+	input[2] = a2_;
+	input[3] = a3_;
+	input[4] = a4_;
+}
+
+static __always_inline void format_fcontract_store(u8 *output, u64 *input)
+{
+	u64 t0 = input[0];
+	u64 t1 = input[1];
+	u64 t2 = input[2];
+	u64 t3 = input[3];
+	u64 t4 = input[4];
+	u64 o0 = t1 << 51 | t0;
+	u64 o1 = t2 << 38 | t1 >> 13;
+	u64 o2 = t3 << 25 | t2 >> 26;
+	u64 o3 = t4 << 12 | t3 >> 39;
+	u8 *b0 = output;
+	u8 *b1 = output + 8;
+	u8 *b2 = output + 16;
+	u8 *b3 = output + 24;
+	put_unaligned_le64(o0, b0);
+	put_unaligned_le64(o1, b1);
+	put_unaligned_le64(o2, b2);
+	put_unaligned_le64(o3, b3);
+}
+
+static __always_inline void format_fcontract(u8 *output, u64 *input)
+{
+	format_fcontract_first_carry_full(input);
+	format_fcontract_second_carry_full(input);
+	format_fcontract_trim(input);
+	format_fcontract_store(output, input);
+}
+
+static __always_inline void format_scalar_of_point(u8 *scalar, u64 *point)
+{
+	u64 *x = point;
+	u64 *z = point + 5;
+	u64 buf[10] __aligned(32) = { 0 };
+	u64 *zmone = buf;
+	u64 *sc = buf + 5;
+	crecip(zmone, z);
+	fmul(sc, x, zmone);
+	format_fcontract(scalar, sc);
+}
+
+void curve25519_generic(u8 mypublic[CURVE25519_KEY_SIZE],
+			const u8 secret[CURVE25519_KEY_SIZE],
+			const u8 basepoint[CURVE25519_KEY_SIZE])
+{
+	u64 buf0[10] __aligned(32) = { 0 };
+	u64 *x0 = buf0;
+	u64 *z = buf0 + 5;
+	u64 *q;
+	format_fexpand(x0, basepoint);
+	z[0] = 1;
+	q = buf0;
+	{
+		u8 e[32] __aligned(32) = { 0 };
+		u8 *scalar;
+		memcpy(e, secret, 32);
+		curve25519_clamp_secret(e);
+		scalar = e;
+		{
+			u64 buf[15] = { 0 };
+			u64 *nq = buf;
+			u64 *x = nq;
+			x[0] = 1;
+			ladder_cmult(nq, scalar, q);
+			format_scalar_of_point(mypublic, nq);
+			memzero_explicit(buf, sizeof(buf));
+		}
+		memzero_explicit(e, sizeof(e));
+	}
+	memzero_explicit(buf0, sizeof(buf0));
+}
diff --git a/lib/crypto/curve25519.c b/lib/crypto/curve25519.c
new file mode 100644
index 000000000000..0106bebe6900
--- /dev/null
+++ b/lib/crypto/curve25519.c
@@ -0,0 +1,25 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/*
+ * Copyright (C) 2015-2019 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ *
+ * This is an implementation of the Curve25519 ECDH algorithm, using either
+ * a 32-bit implementation or a 64-bit implementation with 128-bit integers,
+ * depending on what is supported by the target compiler.
+ *
+ * Information: https://cr.yp.to/ecdh.html
+ */
+
+#include <crypto/curve25519.h>
+#include <linux/module.h>
+#include <linux/init.h>
+
+const u8 curve25519_null_point[CURVE25519_KEY_SIZE] __aligned(32) = { 0 };
+const u8 curve25519_base_point[CURVE25519_KEY_SIZE] __aligned(32) = { 9 };
+
+EXPORT_SYMBOL(curve25519_null_point);
+EXPORT_SYMBOL(curve25519_base_point);
+EXPORT_SYMBOL(curve25519_generic);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Curve25519 scalar multiplication");
+MODULE_AUTHOR("Jason A. Donenfeld <Jason@zx2c4.com>");
-- 
2.20.1

