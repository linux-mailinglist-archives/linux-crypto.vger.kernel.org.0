Return-Path: <linux-crypto+bounces-8082-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4119C6D12
	for <lists+linux-crypto@lfdr.de>; Wed, 13 Nov 2024 11:43:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB08C1F23AC1
	for <lists+linux-crypto@lfdr.de>; Wed, 13 Nov 2024 10:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3EF1BD9DC;
	Wed, 13 Nov 2024 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbBplr8T"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A941FEFAD;
	Wed, 13 Nov 2024 10:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731494583; cv=none; b=pKRs+GBlUddNLDQBf5jP3zupH/pDklsBA/PB0gN+FmikrAC0yfsuxtTKpIIVXDk0jtT9sneDm9eJMdXsfUC893IPsM2pjo35LQX+RBfdhvn/A6l7nw+xcQDl5o1E2QfBnc2gOHWtkZM+xiCwWY9pf0wQMgWepXqVbhf+dya+JY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731494583; c=relaxed/simple;
	bh=ojDJ7hoinilIo00VeSJD8NZv2IJ+zwudDSVaD2FjkJI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kztofZJLBjpeySaF9RusNX5tmFXoQ8WTTa7Oe/zDzCMYk/rihszxI+8kPRwDL5hkKEqd5WP8PtNSkyU2d//x1dgRpifdEHa+/bGeJkBsNLUVNPD0pRwJ/tyhO0BZoNkg17Ri9f1UoBtWcxU6AeiiIbZtwlo7ir72gWVf8IFSbuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbBplr8T; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20cdbe608b3so69175065ad.1;
        Wed, 13 Nov 2024 02:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731494580; x=1732099380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJDbzZfF3tlFYGxDDkE3yJQKGmMh9qkaak12SMGYtEk=;
        b=QbBplr8Taas08U/dURz4CLpxigUoqh7HzVruP6LK3YUmwOmGNaQju8kYpi4ayEY4+B
         qt7MCk13Qoxg51vtmuzX32JlZd73bWMXrHlNgvxPUx6bdCLdTU+Ewr7lGNM0EibUtY4H
         nXA/SOxrjYFIdRdre2sLEehx4xHrtcAcgXGoQsLDpjUhiYu+E/r+XhX1Kk3xzDql45QQ
         NZp5+dyRIpizk3JbeWfFVa7UxnfedtACjO5PZbJi3hi4a3mUPOMWRPC8bgd0Nj+7/VrS
         1UD3ep+ru3hujBqK3CNndKQyJm/btVHKoPGT0/WTEYYB4F+z8cQK9o2uilRE3y6ssxjw
         fgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731494580; x=1732099380;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JJDbzZfF3tlFYGxDDkE3yJQKGmMh9qkaak12SMGYtEk=;
        b=aQ5wrCYgYfx/9+TvgVpfNKObCuXgvREjKof+/jipwBsqdkUxZsXPHMgzrwhZAlKf50
         JKasUIrxvbvslejGwyzaCVULUFVq6jnTi1iREfemat8IVcoObqJK0Z201uj2DmDY5OyP
         SUELIUX+mPjZPDxK56rbn5e/IOkYo/xm7PTuddzkhuF0kr3iuHoln/583NQ4axnSfpzx
         Js11vLpXlrfBRU8exKKDmgQYKBYXbF/6uR2ejz51em+rrQbzFdk0I7V30mHn6sUl4xH4
         bZaeAd3qaiiv3b6gekRYYRB/BxCcAkuTkXhKnCHhI9+6PTKp/4E2vGFk1C9MRUb2gPms
         OYyw==
X-Forwarded-Encrypted: i=1; AJvYcCUfwj3zSz6KHIrP+eUTK/FnCGuYQWPli7xOrYBqcFz2b56W6cYPmdsfWhgy8f9kUKi7UVNlriooUJnIJN8f@vger.kernel.org, AJvYcCWT6n+r71FitBQkScU+FEuaNosGCaXqSMwVLRxtuF9p7EI/BfCbeZ/IypboQfwrb0E2TlhtHel2ynJ9W0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6mB/yGWVvO6XgN53uBbM10+uG0IqZfvGIkWPVnDikE+wuNdts
	M76P6pRUOcLOM+VI8iV5Ub0IJ1U3jOzmv0dNu+KKQigm4h4Kdg+vKnreGZf9OeI=
X-Google-Smtp-Source: AGHT+IHG57wlZtPPJLOgxjdHa5WNE5H/nGsFy8QXUjJSMX0HqhBCtsdo78NkHvo1SgwXHs+OL6T/nQ==
X-Received: by 2002:a17:902:da8f:b0:20c:c880:c3b0 with SMTP id d9443c01a7336-211ab95080bmr63891235ad.21.1731494580297;
        Wed, 13 Nov 2024 02:43:00 -0800 (PST)
Received: from localhost.localdomain ([45.137.180.202])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177e5a9ebsm108031105ad.198.2024.11.13.02.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 02:42:59 -0800 (PST)
From: Zhihang Shao <zhihang.shao.iscas@gmail.com>
To: herbert@gondor.apana.org.au
Cc: davem@davemloft.net,
	palmer@dabbelt.com,
	paul.walmsley@sifive.com,
	aou@eecs.berkeley.edu,
	akpm@linux-foundation.org,
	linux-crypto@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] lib/crct10diftest.c add selftests for crct10dif
Date: Wed, 13 Nov 2024 10:40:35 +0000
Message-Id: <20241113104036.254491-2-zhihang.shao.iscas@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113104036.254491-1-zhihang.shao.iscas@gmail.com>
References: <20241113104036.254491-1-zhihang.shao.iscas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add selftests for kernel's implementation of CRC-T10DIF algorithm.
The test data includes 100 randomly generated test-cases.
The selftest file is similar to what is done in lib/crc32test.c, and is
used to verify the correctness and measure performance improvement of
the CRC-T10DIF algorithm with zbc extension optimization.

Signed-off-by: Zhihang Shao <zhihang.shao.iscas@gmail.com>
---
 lib/Kconfig         |   9 +
 lib/Makefile        |   1 +
 lib/crct10diftest.c | 687 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 697 insertions(+)
 create mode 100644 lib/crct10diftest.c

diff --git a/lib/Kconfig b/lib/Kconfig
index b38849af6f13..e0e488fd1307 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -187,6 +187,15 @@ config CRC32_SELFTEST
 	  and crc32_be over byte strings with random alignment and length
 	  and computes the total elapsed time and number of bytes processed.
 
+config CRCT10DIF_SELFTEST
+	tristate "CRCT10DIF perform self test on init"
+	depends on CRC_T10DIF
+	help
+	  This option enables the CRCT10DIF library functions to perform a
+	  self test on initialization. The self test computes crc_t10dif_update
+	  over byte strings with random alignment and length
+	  and computes the total elapsed time and number of bytes processed.
+
 choice
 	prompt "CRC32 implementation"
 	depends on CRC32
diff --git a/lib/Makefile b/lib/Makefile
index 773adf88af41..6dac65a3778c 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -161,6 +161,7 @@ obj-$(CONFIG_CRC_ITU_T)	+= crc-itu-t.o
 obj-$(CONFIG_CRC32)	+= crc32.o
 obj-$(CONFIG_CRC64)     += crc64.o
 obj-$(CONFIG_CRC32_SELFTEST)	+= crc32test.o
+obj-$(CONFIG_CRCT10DIF_SELFTEST)	+= crct10diftest.o
 obj-$(CONFIG_CRC4)	+= crc4.o
 obj-$(CONFIG_CRC7)	+= crc7.o
 obj-$(CONFIG_LIBCRC32C)	+= libcrc32c.o
diff --git a/lib/crct10diftest.c b/lib/crct10diftest.c
new file mode 100644
index 000000000000..9541892eb12c
--- /dev/null
+++ b/lib/crct10diftest.c
@@ -0,0 +1,687 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * CRC-T10DIF selftests
+ *
+ * Copyright (C) 2024 Institute of Software, CAS.
+ */
+#include <linux/crc-t10dif.h>
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <linux/time.h>
+
+static struct crc_test {
+	u16 crc; /* random starting crc*/
+	u16 start; /* random 6 bit offset in buf*/
+	u16 length; /* random 11 bit length of test*/
+	u16 crct10dif; /* expected crc_t10dif result*/
+} tests[] = {
+	{0xdead, 0x0009, 0x0030, 0x8419},
+	{0x37c8, 0x0014, 0x03f0, 0xf4b5},
+	{0x8f45, 0x002d, 0x03b0, 0x6937},
+	{0x4201, 0x0020, 0x0719, 0x665e},
+	{0xe102, 0x0037, 0x0599, 0xb45b},
+	{0xa65d, 0x0008, 0x024d, 0x95d3},
+	{0xadba, 0x0001, 0x0799, 0xbb14},
+	{0x4407, 0x0038, 0x06a3, 0xb401},
+	{0x5188, 0x000c, 0x03f5, 0xf00c},
+	{0x5120, 0x0025, 0x0255, 0x858b},
+	{0x6a92, 0x0006, 0x0559, 0x159a},
+	{0xfa66, 0x0032, 0x0561, 0x0916},
+	{0x40a9, 0x003a, 0x0179, 0x0eb5},
+	{0x3c82, 0x0006, 0x02f0, 0x598c},
+	{0xbe07, 0x000a, 0x0085, 0xb228},
+	{0x7942, 0x0029, 0x033b, 0x0cc4},
+	{0x1275, 0x0030, 0x041b, 0x87b3},
+	{0xb715, 0x0030, 0x03fa, 0xcda8},
+	{0x7476, 0x0013, 0x063b, 0x51e8},
+	{0xa5c5, 0x001c, 0x0245, 0x53af},
+	{0x3e97, 0x003e, 0x0575, 0xdacf},
+	{0xdf84, 0x0025, 0x0556, 0x1154},
+	{0x72ef, 0x001b, 0x079b, 0x07b3},
+	{0x6d04, 0x0016, 0x06fc, 0x8cdf},
+	{0xe206, 0x0017, 0x030e, 0xe609},
+	{0xc188, 0x0008, 0x02c3, 0x504b},
+	{0x705b, 0x003f, 0x04db, 0xcf7c},
+	{0x3c9b, 0x0021, 0x048f, 0x09f9},
+	{0x32df, 0x0004, 0x064c, 0x73fb},
+	{0x0269, 0x0022, 0x07f0, 0xa49e},
+	{0x717d, 0x000b, 0x018b, 0x2ba0},
+	{0xc261, 0x0007, 0x05fb, 0x726e},
+	{0x239f, 0x000a, 0x0582, 0xa055},
+	{0x6812, 0x0006, 0x0325, 0x6399},
+	{0x8145, 0x0001, 0x068e, 0x8a81},
+	{0xaf22, 0x001d, 0x0113, 0xeb59},
+	{0xb521, 0x001f, 0x0465, 0x0648},
+	{0x8b01, 0x0015, 0x04e4, 0xdbf6},
+	{0xf3e0, 0x002f, 0x0300, 0x01b3},
+	{0xa6f6, 0x003c, 0x02a8, 0x56f4},
+	{0x7a06, 0x002b, 0x07bc, 0x5df1},
+	{0x9071, 0x0022, 0x0286, 0x6d8a},
+	{0x8ae3, 0x0015, 0x0796, 0x4fa0},
+	{0x9432, 0x0029, 0x0406, 0xfb2d},
+	{0x3808, 0x002c, 0x00df, 0xb9b6},
+	{0xb4c1, 0x0003, 0x0788, 0x3e7e},
+	{0xbc32, 0x0008, 0x06e3, 0x9c4f},
+	{0xd384, 0x000c, 0x05be, 0x6505},
+	{0x51b7, 0x003a, 0x07a3, 0x4216},
+	{0xa85c, 0x0029, 0x03de, 0xdcfe},
+	{0x933e, 0x0034, 0x0544, 0xecac},
+	{0xcc1e, 0x000b, 0x00c5, 0x832b},
+	{0x99b7, 0x0024, 0x0730, 0x9541},
+	{0x9f67, 0x0038, 0x071a, 0x762b},
+	{0x2140, 0x003e, 0x06c1, 0xe6b5},
+	{0x0f8a, 0x003f, 0x024f, 0xfcdd},
+	{0xc9fa, 0x0032, 0x0369, 0x9192},
+	{0x5c1c, 0x0007, 0x0596, 0x074a},
+	{0xfabb, 0x001a, 0x06cb, 0xd699},
+	{0x9c25, 0x0010, 0x0300, 0x3571},
+	{0xf934, 0x0030, 0x0455, 0xd0ce},
+	{0x18e8, 0x002f, 0x0434, 0x8c42},
+	{0xd16d, 0x0036, 0x06ed, 0x247a},
+	{0x9f75, 0x003d, 0x0238, 0x2508},
+	{0xe32f, 0x0021, 0x03c6, 0x358a},
+	{0xbce8, 0x001c, 0x06a6, 0x11bd},
+	{0x9436, 0x0031, 0x067d, 0x4512},
+	{0xcd02, 0x003d, 0x0638, 0x2bef},
+	{0xdbad, 0x000d, 0x06d2, 0x4e67},
+	{0x65fd, 0x0006, 0x06be, 0xf178},
+	{0x05fc, 0x002b, 0x0062, 0x509d},
+	{0xcee8, 0x001a, 0x06e1, 0xccb1},
+	{0xe03c, 0x0027, 0x0163, 0x2633},
+	{0x6c03, 0x0009, 0x04c8, 0xfec2},
+	{0x657b, 0x0006, 0x0096, 0x1c5a},
+	{0x1cc3, 0x000e, 0x00b3, 0xd233},
+	{0x815c, 0x0005, 0x0506, 0xc241},
+	{0xaa8c, 0x0004, 0x06c3, 0x0e76},
+	{0x7970, 0x0025, 0x05fa, 0x4d7a},
+	{0x91c0, 0x001c, 0x0270, 0x40af},
+	{0x4f83, 0x0014, 0x0720, 0x9d03},
+	{0x0bdd, 0x0029, 0x03c1, 0xac55},
+	{0x372f, 0x0017, 0x03d5, 0x41d2},
+	{0x8325, 0x0009, 0x0463, 0x2add},
+	{0xf40e, 0x002a, 0x03da, 0x45ea},
+	{0x552e, 0x001e, 0x0723, 0x225a},
+	{0x41c3, 0x001d, 0x06f7, 0x1d61},
+	{0x09f9, 0x0027, 0x057f, 0x5cc0},
+	{0xfd3b, 0x0020, 0x0504, 0x8048},
+	{0xb889, 0x0005, 0x0271, 0x43e0},
+	{0xbd1c, 0x0007, 0x03aa, 0x7253},
+	{0xbad0, 0x000e, 0x04c3, 0x9855},
+	{0xc978, 0x001d, 0x0579, 0x2ab0},
+	{0x3b3b, 0x001c, 0x0545, 0x521a},
+	{0x41b9, 0x003c, 0x0082, 0x49b7},
+	{0x15a3, 0x0002, 0x0530, 0xf48a},
+	{0xeaa2, 0x0034, 0x03f8, 0x3aad},
+	{0x8af9, 0x0029, 0x02e3, 0x4b3d},
+	{0xb4b0, 0x000d, 0x0056, 0xecee},
+	{0x669b, 0x0019, 0x065f, 0x28d8},
+};
+
+static const u8 __aligned(8) test_buf[] __initconst = {
+	0x4d, 0x87, 0x5f, 0x10, 0x90, 0xd5, 0x31, 0x96,
+	0x3f, 0x5a, 0x50, 0xc7, 0x30, 0x80, 0x5f, 0x2c,
+	0x78, 0xf0, 0xa2, 0xb5, 0xfb, 0xf9, 0x83, 0x14,
+	0xe9, 0xb6, 0xaa, 0xe6, 0x39, 0x12, 0x0b, 0x87,
+	0x99, 0x6a, 0x97, 0x2a, 0x3f, 0xc8, 0xc0, 0x7e,
+	0x22, 0x10, 0x45, 0x52, 0x90, 0xa4, 0x7e, 0x08,
+	0x94, 0x21, 0xbe, 0x8f, 0x1a, 0x41, 0xa3, 0x04,
+	0xf7, 0x4d, 0xea, 0x30, 0x5f, 0xf5, 0xb7, 0xf9,
+	0x60, 0x4e, 0x23, 0x9f, 0x16, 0xe3, 0x1e, 0x38,
+	0xf3, 0x63, 0x8b, 0x84, 0x08, 0x09, 0x8c, 0x9c,
+	0x2a, 0x4a, 0x2c, 0x45, 0x8b, 0xcf, 0x49, 0x82,
+	0x1d, 0x33, 0xb3, 0x7c, 0x29, 0x6a, 0x75, 0x89,
+	0xb9, 0x98, 0x28, 0xcf, 0x7b, 0x46, 0x08, 0x6f,
+	0xaa, 0x93, 0xf3, 0xb2, 0x9c, 0x7f, 0x4e, 0xc7,
+	0xca, 0x7a, 0x0c, 0x55, 0x4a, 0x55, 0xd8, 0x67,
+	0x88, 0x8b, 0xe3, 0xb1, 0xf5, 0x59, 0x3a, 0xae,
+	0xf1, 0x63, 0x7e, 0x6d, 0xa9, 0x86, 0xdc, 0x53,
+	0x19, 0xcf, 0x05, 0xb5, 0x4e, 0x54, 0x7c, 0x18,
+	0xce, 0x88, 0x6e, 0x18, 0xdd, 0x46, 0x7f, 0x66,
+	0xd1, 0x63, 0x17, 0xc6, 0xbc, 0x52, 0x75, 0xad,
+	0xb5, 0xf3, 0x1a, 0x5e, 0x79, 0xf6, 0xb2, 0x92,
+	0xc5, 0xb7, 0x47, 0x14, 0x0b, 0xc4, 0x2c, 0xda,
+	0x4c, 0x9a, 0xf2, 0x2a, 0xe0, 0x72, 0x90, 0xb1,
+	0xd5, 0xa7, 0x78, 0x91, 0xf9, 0xed, 0x3e, 0xae,
+	0xe0, 0x59, 0x0d, 0x59, 0x4f, 0xbf, 0xeb, 0x15,
+	0x76, 0x32, 0x29, 0x82, 0xf6, 0x55, 0x5c, 0x43,
+	0xf0, 0x4e, 0x6d, 0xd0, 0xc0, 0xfd, 0x82, 0x95,
+	0xa4, 0xfa, 0x26, 0x9e, 0xe7, 0x65, 0x4c, 0xc7,
+	0xbe, 0x59, 0x20, 0x0d, 0x18, 0x0b, 0x22, 0x8f,
+	0x3d, 0x4b, 0x11, 0x34, 0xa1, 0x6d, 0x77, 0x91,
+	0xbb, 0xe4, 0x61, 0x7c, 0xe1, 0xe3, 0x11, 0x85,
+	0xdd, 0x38, 0x23, 0xc4, 0x9d, 0x70, 0x8b, 0x5b,
+	0xc9, 0xab, 0x68, 0xe2, 0xb6, 0x8b, 0x71, 0xf4,
+	0xd6, 0x82, 0x28, 0x77, 0xef, 0x9f, 0x08, 0xaa,
+	0x83, 0x6a, 0x26, 0x64, 0x4d, 0x38, 0xe9, 0x2b,
+	0x70, 0x0d, 0xef, 0x0d, 0x7d, 0x7b, 0x68, 0x46,
+	0x26, 0xd0, 0x28, 0xdd, 0x5b, 0x99, 0xd1, 0x32,
+	0x1b, 0xf9, 0xa9, 0x0a, 0x98, 0xb2, 0xb5, 0x1b,
+	0x1c, 0xdb, 0x7f, 0x69, 0x13, 0x68, 0x94, 0x83,
+	0x75, 0x84, 0x90, 0xf2, 0xff, 0xf8, 0x39, 0x25,
+	0xc9, 0x61, 0x02, 0x24, 0xfb, 0xd3, 0x56, 0x16,
+	0xcc, 0x00, 0x21, 0x64, 0xb2, 0xd6, 0x7f, 0xce,
+	0xb1, 0xfe, 0x37, 0xc5, 0x67, 0xcc, 0x48, 0xdc,
+	0x50, 0xd9, 0xcf, 0x4f, 0xd1, 0x08, 0x74, 0x9a,
+	0x69, 0x77, 0xbf, 0x64, 0x4a, 0x15, 0x7b, 0x17,
+	0x15, 0x9c, 0x7b, 0xc7, 0x72, 0xfb, 0x95, 0x23,
+	0xf9, 0xcd, 0xe8, 0x60, 0x99, 0x31, 0x3d, 0xe9,
+	0x0a, 0x0c, 0x38, 0xdb, 0x14, 0xac, 0x76, 0x7d,
+	0x23, 0x35, 0xe2, 0x6e, 0x4a, 0x5d, 0x85, 0x60,
+	0xf9, 0x00, 0x27, 0x6b, 0xfb, 0xbd, 0x8e, 0xf5,
+	0x8a, 0x77, 0x55, 0x23, 0xa8, 0x92, 0x0c, 0xb2,
+	0x9e, 0x44, 0x8d, 0xb2, 0xf0, 0x03, 0x30, 0x14,
+	0x38, 0x12, 0x82, 0x83, 0x6f, 0x07, 0xe3, 0x68,
+	0x07, 0x0a, 0xd3, 0x03, 0xc7, 0x61, 0xf8, 0x51,
+	0xd8, 0x4d, 0x74, 0x80, 0xe0, 0x80, 0x32, 0x7e,
+	0xc4, 0xc0, 0x31, 0xb5, 0xc3, 0x61, 0xc9, 0xfc,
+	0x73, 0x4b, 0x7f, 0xe2, 0x52, 0x62, 0x4a, 0x59,
+	0x6c, 0x1d, 0x5c, 0x34, 0x7e, 0x54, 0x85, 0x57,
+	0xa2, 0xfa, 0xd7, 0x82, 0x7a, 0x0a, 0x00, 0x3f,
+	0xca, 0x31, 0xf4, 0x8d, 0x92, 0xbd, 0x89, 0x05,
+	0x08, 0x08, 0xe7, 0x5a, 0x6a, 0x31, 0xb3, 0xd7,
+	0x4e, 0x10, 0x0b, 0xcd, 0x64, 0x90, 0x24, 0x06,
+	0x8a, 0xfb, 0x88, 0x05, 0x05, 0x89, 0x44, 0xcf,
+	0xba, 0x38, 0x5d, 0x4d, 0xf5, 0xe6, 0x52, 0xfd,
+	0xef, 0x3a, 0x57, 0x59, 0x6b, 0x0a, 0x30, 0xba,
+	0x1a, 0x3b, 0x87, 0x7f, 0xcc, 0xab, 0x85, 0x56,
+	0xa6, 0x0e, 0x5b, 0xac, 0x97, 0x9f, 0x7b, 0x51,
+	0xd7, 0xd8, 0x9e, 0xcc, 0xbf, 0xf1, 0xc9, 0xae,
+	0x2b, 0x20, 0x07, 0x96, 0x2b, 0x38, 0x50, 0x45,
+	0x73, 0xd7, 0xc4, 0x3f, 0x82, 0x4a, 0x96, 0x29,
+	0x58, 0xf1, 0xd5, 0xef, 0x91, 0x50, 0x40, 0x68,
+	0x29, 0xdf, 0x35, 0xe8, 0xd0, 0xfe, 0x96, 0xfb,
+	0x1f, 0x9d, 0x91, 0x4a, 0xd5, 0xe2, 0x8f, 0x49,
+	0xb9, 0x54, 0x88, 0x3c, 0x9e, 0x1e, 0x65, 0xf6,
+	0x10, 0x3a, 0xe5, 0xa1, 0x8a, 0x25, 0x09, 0xb3,
+	0x04, 0x3e, 0x9b, 0xd4, 0x3d, 0x31, 0xcf, 0x5c,
+	0xcf, 0x61, 0xa6, 0xa4, 0x43, 0x35, 0xed, 0xfc,
+	0x89, 0x76, 0x38, 0x27, 0x94, 0x9d, 0x1d, 0xa4,
+	0xd7, 0x02, 0x45, 0x62, 0x28, 0x4f, 0x15, 0x2c,
+	0x8d, 0xb1, 0x01, 0xca, 0xe2, 0xd0, 0x26, 0xb1,
+	0x31, 0xcc, 0x56, 0x74, 0x02, 0x43, 0x71, 0x8b,
+	0xb9, 0xa9, 0xb3, 0x4e, 0x47, 0xd0, 0xf2, 0x1e,
+	0xd3, 0x38, 0x80, 0xfb, 0x87, 0x96, 0x27, 0x14,
+	0x47, 0x28, 0xdf, 0x29, 0xf9, 0x05, 0xdb, 0x2a,
+	0xd2, 0x31, 0x9f, 0xd4, 0x74, 0x10, 0x5f, 0x2e,
+	0xb9, 0x12, 0x7c, 0x00, 0xe3, 0x6e, 0x1f, 0xb6,
+	0xa6, 0x9f, 0xb1, 0x2d, 0x35, 0xd8, 0x42, 0x7c,
+	0x01, 0x21, 0xa6, 0xfa, 0x26, 0x81, 0x24, 0xf8,
+	0xb2, 0xc3, 0xcc, 0x26, 0xd3, 0x2c, 0x54, 0x8d,
+	0x3e, 0xd0, 0x8d, 0x21, 0x3f, 0xac, 0xd7, 0xe5,
+	0x4c, 0x88, 0x13, 0x81, 0x61, 0x55, 0xfe, 0x62,
+	0x76, 0xa4, 0x5c, 0x9c, 0x25, 0x80, 0x95, 0xd7,
+	0x44, 0x61, 0xfd, 0x17, 0x8d, 0x52, 0xa4, 0xcc,
+	0x22, 0x32, 0xed, 0x61, 0xde, 0xc5, 0x47, 0x2a,
+	0x4d, 0x5a, 0xac, 0xae, 0xaf, 0xaa, 0x10, 0x25,
+	0x4e, 0x6c, 0xc1, 0x73, 0xed, 0x56, 0x4a, 0x31,
+	0xb8, 0x47, 0x48, 0x45, 0x99, 0xed, 0x11, 0xbc,
+	0x1f, 0xff, 0x1d, 0xfd, 0xc4, 0x64, 0x28, 0x11,
+	0xbe, 0xd4, 0xc0, 0x6d, 0x7e, 0xd0, 0x92, 0xcc,
+	0x3d, 0x54, 0x3f, 0x2a, 0xaa, 0x89, 0x5b, 0x62,
+	0xd0, 0xa3, 0xa8, 0x6a, 0x90, 0xb9, 0x26, 0xaf,
+	0xb8, 0x43, 0xad, 0x7c, 0xa8, 0xd5, 0x8e, 0x66,
+	0xa9, 0x4e, 0xd4, 0x27, 0x1e, 0x66, 0xf3, 0x5b,
+	0xba, 0x32, 0x85, 0x65, 0xbb, 0xe0, 0xc7, 0x8b,
+	0x84, 0x6f, 0xf5, 0x14, 0x29, 0x1b, 0xc4, 0xe1,
+	0x5f, 0x71, 0x5e, 0x07, 0x46, 0xec, 0x6d, 0xef,
+	0x3a, 0x41, 0x16, 0x58, 0xa8, 0x09, 0xb4, 0x62,
+	0x3b, 0x39, 0xc7, 0xf6, 0x1a, 0x8f, 0x81, 0x9e,
+	0xfe, 0x77, 0xb2, 0x27, 0x92, 0x76, 0x09, 0xf1,
+	0xe7, 0x67, 0xf8, 0x2d, 0x53, 0x66, 0x1c, 0x8d,
+	0xa7, 0x32, 0xe5, 0x4f, 0x3b, 0x99, 0xb2, 0x76,
+	0xd3, 0x79, 0x6c, 0xed, 0x08, 0xee, 0x8b, 0x07,
+	0x65, 0x3d, 0x2e, 0xf7, 0xb4, 0x37, 0xe9, 0x9b,
+	0x9e, 0xe1, 0xc9, 0xf1, 0x47, 0xe5, 0x7e, 0xef,
+	0x18, 0x64, 0x3e, 0x53, 0xfd, 0xf0, 0xca, 0xd0,
+	0x6a, 0x36, 0xbd, 0x72, 0x24, 0x48, 0x79, 0x89,
+	0x86, 0xa8, 0x81, 0x3a, 0xdf, 0x6a, 0xd5, 0x7e,
+	0x4b, 0x9e, 0x6f, 0x93, 0x84, 0xee, 0x82, 0x9c,
+	0x52, 0xc0, 0xef, 0x4f, 0xb1, 0xb9, 0x20, 0x1b,
+	0xf0, 0xdd, 0x8d, 0x14, 0x26, 0x07, 0x9e, 0xac,
+	0xaf, 0x1f, 0xe6, 0x8e, 0x89, 0xbb, 0x0c, 0xd4,
+	0x5a, 0x7c, 0x67, 0xde, 0x6a, 0xe9, 0x7a, 0xbc,
+	0xaa, 0x69, 0x0b, 0x5b, 0x23, 0x2b, 0x76, 0x13,
+	0x09, 0x03, 0x27, 0x2f, 0x0a, 0xc5, 0xdb, 0xb9,
+	0xe4, 0xc1, 0x48, 0x6d, 0x7c, 0x54, 0x42, 0xd6,
+	0xd0, 0xa9, 0xb4, 0x3a, 0x93, 0x2e, 0xf6, 0x3d,
+	0x98, 0x02, 0x98, 0xbb, 0x2d, 0x0e, 0xce, 0x36,
+	0x11, 0xf5, 0x65, 0x1c, 0xbb, 0x40, 0xd5, 0x9f,
+	0x01, 0x1d, 0x0d, 0x7e, 0x72, 0x4f, 0x54, 0x42,
+	0xf8, 0x09, 0x7d, 0x8b, 0x37, 0x73, 0xc8, 0xcf,
+	0x75, 0x60, 0x8a, 0xa3, 0x6e, 0x58, 0xd9, 0x80,
+	0x4e, 0x3f, 0x9c, 0x09, 0x7f, 0x71, 0xa8, 0x81,
+	0x8f, 0xb5, 0xff, 0x01, 0x04, 0x53, 0x43, 0xfd,
+	0x5c, 0xc0, 0x88, 0x94, 0x34, 0x51, 0x63, 0xa9,
+	0xb1, 0xee, 0x4c, 0x20, 0x46, 0x26, 0xa0, 0x94,
+	0x65, 0x3c, 0x9d, 0xe4, 0xad, 0x46, 0x65, 0x3c,
+	0xfb, 0x64, 0x3d, 0x00, 0xb8, 0x81, 0xfd, 0x14,
+	0x41, 0x85, 0xa8, 0x75, 0xd6, 0x0c, 0x1f, 0x88,
+	0xfa, 0x6b, 0xa8, 0x40, 0x91, 0x48, 0xd5, 0xf6,
+	0x84, 0x72, 0xdb, 0x31, 0xb8, 0x40, 0x6e, 0xb4,
+	0xa5, 0xab, 0xb4, 0x5d, 0x2c, 0xb1, 0x71, 0x6e,
+	0x36, 0x1a, 0xe3, 0x0d, 0x26, 0x02, 0x95, 0x20,
+	0x6e, 0x3d, 0x60, 0xff, 0x85, 0x35, 0xf6, 0x09,
+	0xa8, 0xd1, 0x3a, 0x60, 0x11, 0xa8, 0x14, 0xb6,
+	0x54, 0xc8, 0x13, 0x80, 0x79, 0x85, 0xee, 0xb0,
+	0x9f, 0xd2, 0xbd, 0xc5, 0xd4, 0x52, 0xe5, 0x42,
+	0x8f, 0x45, 0x42, 0x14, 0x7b, 0x38, 0x1d, 0x23,
+	0x09, 0x57, 0x83, 0x1a, 0x00, 0x98, 0xd1, 0x54,
+	0x60, 0xe4, 0xd4, 0xda, 0x69, 0xc3, 0x8a, 0x08,
+	0x95, 0x47, 0xcd, 0x69, 0x99, 0xb2, 0xac, 0x28,
+	0xf8, 0xee, 0x3c, 0x73, 0x26, 0x59, 0x96, 0x2f,
+	0xb0, 0x19, 0x49, 0xb0, 0xb1, 0x1a, 0x04, 0x12,
+	0xff, 0xd9, 0xec, 0x68, 0x9c, 0x76, 0x71, 0x31,
+	0xbd, 0x3e, 0x9a, 0x56, 0xf1, 0x46, 0x7e, 0xe9,
+	0x34, 0xba, 0x5c, 0x5a, 0x13, 0xf2, 0x89, 0xc3,
+	0x0b, 0xd3, 0x74, 0xbd, 0xed, 0x78, 0xcf, 0xec,
+	0x51, 0xbb, 0x55, 0xed, 0x31, 0xc6, 0x1e, 0xee,
+	0x04, 0xb9, 0x44, 0xf5, 0xff, 0xc2, 0xde, 0x34,
+	0x7c, 0x3a, 0x8e, 0x8f, 0x2c, 0x18, 0x52, 0x38,
+	0xeb, 0xc6, 0xf5, 0xd8, 0x3f, 0xc4, 0xc5, 0x90,
+	0x7f, 0x1a, 0x7e, 0xb0, 0xe0, 0x9c, 0x9e, 0xe4,
+	0x55, 0xe2, 0xda, 0x55, 0xa4, 0xb8, 0x89, 0x20,
+	0xf3, 0x17, 0xaf, 0x1f, 0x2f, 0x01, 0x57, 0x1a,
+	0xc8, 0x4c, 0xf3, 0x07, 0x10, 0xb8, 0x97, 0x8f,
+	0xd2, 0x15, 0x3f, 0xb2, 0xb2, 0xdd, 0x96, 0x07,
+	0xbf, 0x70, 0x5c, 0x63, 0x29, 0xe5, 0x83, 0x1c,
+	0xfd, 0x32, 0x3b, 0x2c, 0x34, 0x93, 0x47, 0xfc,
+	0xdf, 0x3a, 0x03, 0xf0, 0xf2, 0x9a, 0x7f, 0xc4,
+	0xb0, 0xbf, 0x76, 0x62, 0x9c, 0x0c, 0x69, 0x5c,
+	0x7d, 0xc6, 0xbf, 0xa6, 0xab, 0x43, 0xc2, 0xa8,
+	0x75, 0xfd, 0xd5, 0xa9, 0x90, 0x1c, 0xa5, 0x70,
+	0x56, 0xa8, 0x60, 0x48, 0x43, 0xdf, 0x0c, 0xf3,
+	0x9e, 0x82, 0x55, 0x3b, 0x8e, 0xbe, 0x97, 0x0b,
+	0x84, 0x56, 0xb1, 0x30, 0x99, 0x73, 0xd8, 0x0f,
+	0x71, 0xad, 0xb8, 0x01, 0xc9, 0x5e, 0x71, 0x1f,
+	0x06, 0xd1, 0x67, 0x49, 0xb1, 0x73, 0x3c, 0x4f,
+	0xf5, 0x91, 0x8a, 0x84, 0x50, 0x21, 0x8f, 0xd4,
+	0x78, 0x41, 0x04, 0x11, 0xb4, 0xdd, 0x20, 0x25,
+	0x8a, 0xd9, 0x27, 0x54, 0x37, 0x98, 0x73, 0x3d,
+	0x6a, 0xdb, 0x87, 0x1b, 0x4e, 0xc3, 0x6a, 0x44,
+	0x55, 0xf5, 0xc8, 0xa5, 0x16, 0x57, 0x79, 0x8e,
+	0x98, 0x7e, 0xa0, 0x4d, 0x5b, 0xc0, 0x72, 0xe5,
+	0x99, 0x99, 0x39, 0xd0, 0x32, 0xad, 0x0e, 0x9c,
+	0x88, 0x95, 0xb7, 0xd6, 0x58, 0x21, 0x1a, 0xad,
+	0x16, 0xe2, 0x52, 0x2d, 0x3a, 0xcc, 0xbb, 0xd2,
+	0x4a, 0x5b, 0x1f, 0xa5, 0x1c, 0x92, 0x8a, 0xb5,
+	0x2b, 0xc4, 0x86, 0x5d, 0x71, 0x94, 0xf9, 0xf9,
+	0x29, 0xb0, 0xcf, 0x81, 0xd2, 0xea, 0x2f, 0xe8,
+	0xcc, 0x81, 0x15, 0x06, 0x4d, 0xd1, 0xd9, 0x97,
+	0x2c, 0xf8, 0x3c, 0x48, 0x8a, 0xc7, 0xfe, 0xb6,
+	0x8b, 0x84, 0x13, 0xfc, 0x18, 0x0d, 0xf5, 0x41,
+	0xbd, 0xc4, 0xc2, 0x8f, 0xae, 0xf1, 0x78, 0x7b,
+	0x73, 0x8d, 0x81, 0xc0, 0x5e, 0x5a, 0x58, 0x8b,
+	0x53, 0x94, 0xd3, 0xdd, 0x5b, 0xd1, 0x93, 0xe6,
+	0x55, 0xa7, 0xe2, 0x6d, 0xb4, 0xd7, 0xae, 0x71,
+	0x9c, 0x71, 0x01, 0x4a, 0x62, 0x79, 0xc5, 0xd5,
+	0x06, 0x47, 0x96, 0x65, 0xa1, 0xee, 0xf0, 0xf4,
+	0x82, 0xc3, 0xd2, 0xde, 0x95, 0x65, 0xc4, 0xea,
+	0x0c, 0xa7, 0x58, 0xc0, 0x7e, 0x06, 0x32, 0x1a,
+	0x77, 0x33, 0x65, 0xda, 0xac, 0x2a, 0xaf, 0xb2,
+	0x71, 0x45, 0x17, 0x13, 0x33, 0x07, 0x07, 0xb6,
+	0xcb, 0xd9, 0x94, 0x60, 0x3f, 0x58, 0x4a, 0x4b,
+	0xff, 0xa2, 0x0c, 0x7e, 0xa9, 0x3e, 0x98, 0x20,
+	0x71, 0xfd, 0xfa, 0x1d, 0x28, 0xaa, 0xcf, 0x99,
+	0xef, 0xe7, 0xac, 0x23, 0xee, 0xb4, 0xd9, 0xb9,
+	0x8d, 0x6d, 0x19, 0xcc, 0xc5, 0x64, 0x18, 0xc5,
+	0x06, 0x24, 0x43, 0xaf, 0x62, 0xdb, 0xd0, 0xd3,
+	0xd9, 0xca, 0xf0, 0x01, 0x74, 0xbf, 0x9a, 0x64,
+	0xa6, 0x47, 0x87, 0x95, 0xfb, 0x60, 0x4e, 0x88,
+	0xcd, 0x68, 0x55, 0x92, 0xcc, 0x6d, 0x57, 0xd2,
+	0x91, 0x9a, 0x82, 0xf3, 0x76, 0x52, 0xc6, 0x4f,
+	0x1c, 0xb6, 0x50, 0x91, 0x75, 0xea, 0xf5, 0x1c,
+	0x31, 0x7c, 0xb1, 0x2c, 0xdc, 0xff, 0xb5, 0xa9,
+	0x67, 0x0a, 0x3b, 0x33, 0x77, 0x93, 0x06, 0x08,
+	0x2d, 0x88, 0xfb, 0xa3, 0xda, 0xc1, 0xf2, 0xf6,
+	0x77, 0x42, 0x87, 0xec, 0x2d, 0x7c, 0x08, 0x5e,
+	0xf8, 0xb9, 0x8b, 0xd4, 0xb9, 0x40, 0x7d, 0x20,
+	0x4a, 0xb9, 0x54, 0xc1, 0x4c, 0x5a, 0xc9, 0x79,
+	0xe2, 0xc4, 0x1d, 0xbc, 0x85, 0x0f, 0xb2, 0xfc,
+	0x52, 0x3a, 0xe8, 0x7f, 0xb6, 0xf1, 0xdd, 0xaf,
+	0xaa, 0x68, 0x83, 0x63, 0xa8, 0x01, 0x84, 0xf2,
+	0xba, 0xd8, 0xb3, 0x06, 0x32, 0x7c, 0x7f, 0x14,
+	0x40, 0x9c, 0xd0, 0xc5, 0xac, 0x82, 0xc1, 0xfe,
+	0xbc, 0xaa, 0x7d, 0x73, 0x9b, 0x5a, 0x22, 0x45,
+	0xc3, 0xa5, 0xa9, 0x6b, 0xa6, 0x2d, 0x5e, 0x60,
+	0x05, 0x11, 0x66, 0x37, 0x8e, 0xe6, 0x4b, 0xce,
+	0x82, 0x1b, 0x94, 0x2e, 0x9d, 0x55, 0x2c, 0x5a,
+	0xff, 0xa9, 0xcd, 0x9a, 0x04, 0xef, 0xe0, 0xc7,
+	0x94, 0x89, 0x32, 0x3b, 0xb6, 0x90, 0x9b, 0xbb,
+	0xa2, 0x02, 0xf2, 0x30, 0xe8, 0x3d, 0xfe, 0x6a,
+	0x58, 0x92, 0x99, 0xf5, 0xe8, 0xc5, 0x4f, 0xe7,
+	0x6f, 0x1c, 0x82, 0x73, 0x0b, 0x62, 0x3a, 0xa0,
+	0xeb, 0x6c, 0xdb, 0xa1, 0xfd, 0x76, 0x5c, 0x9f,
+	0x78, 0x4e, 0xcf, 0x60, 0x8b, 0xcd, 0xcb, 0xe3,
+	0x60, 0x64, 0xd8, 0x48, 0x29, 0x28, 0x2f, 0x98,
+	0x44, 0xb1, 0x0b, 0x50, 0x13, 0x45, 0xf0, 0xfe,
+	0xb2, 0xcb, 0x9f, 0xaf, 0x41, 0xfb, 0x4e, 0xba,
+	0x49, 0x1d, 0x1a, 0xd4, 0xea, 0xe5, 0xb7, 0x4a,
+	0x49, 0x90, 0x92, 0x73, 0xb8, 0xc2, 0x0b, 0xfc,
+	0x73, 0x17, 0x4c, 0x87, 0x5c, 0x3c, 0x85, 0x0e,
+	0x07, 0x25, 0xbd, 0x49, 0x20, 0x0b, 0x03, 0x6a,
+	0x28, 0x1d, 0x3e, 0x13, 0x03, 0xf6, 0x5d, 0x4c,
+	0x86, 0xf0, 0xbf, 0x3e, 0xb2, 0xcb, 0x3a, 0x25,
+	0xe2, 0x87, 0xac, 0x3e, 0xc3, 0x32, 0x4d, 0xcb,
+	0x57, 0x0a, 0x14, 0x77, 0x16, 0x17, 0xe1, 0x3e,
+	0x34, 0x20, 0x51, 0x37, 0x16, 0xaf, 0x84, 0x9c,
+	0x9f, 0x43, 0xda, 0x51, 0x0e, 0x14, 0x76, 0xf0,
+	0x9b, 0x23, 0x2f, 0x5f, 0x55, 0x7c, 0x2a, 0xac,
+	0x86, 0x3e, 0x23, 0x9c, 0x55, 0x05, 0xdb, 0x89,
+	0x25, 0x2c, 0xc1, 0x3b, 0xdb, 0x45, 0xd7, 0x7a,
+	0x88, 0xb1, 0xcb, 0x97, 0xc5, 0x42, 0x87, 0x61,
+	0x65, 0xb6, 0xc0, 0xba, 0x32, 0xea, 0x66, 0xb9,
+	0x28, 0x89, 0x55, 0x7d, 0x8e, 0x30, 0x06, 0xb3,
+	0x5d, 0xc7, 0xee, 0x38, 0x0c, 0xc5, 0xb3, 0x95,
+	0x76, 0x7e, 0x2c, 0x3c, 0xc0, 0xb3, 0x9d, 0x25,
+	0x6a, 0x5d, 0xdf, 0x9c, 0x47, 0x45, 0x55, 0x6f,
+	0xcf, 0xab, 0xec, 0x5d, 0xdb, 0xf2, 0x11, 0x38,
+	0xba, 0xff, 0x71, 0xc6, 0xc5, 0x24, 0x5b, 0x3b,
+	0xa2, 0x87, 0x77, 0x63, 0x3b, 0x14, 0x88, 0xa5,
+	0x71, 0x68, 0x41, 0xb8, 0xad, 0x97, 0x27, 0x7c,
+	0x42, 0x13, 0xda, 0x1d, 0x06, 0xeb, 0x56, 0xc0,
+	0xea, 0xc7, 0x86, 0xaf, 0xeb, 0xe2, 0xeb, 0x8d,
+	0x69, 0x62, 0xf0, 0xa4, 0x77, 0x79, 0x49, 0xe8,
+	0xe1, 0x8b, 0xa1, 0x8e, 0x22, 0xc8, 0x0b, 0x64,
+	0xdc, 0xe5, 0x81, 0xe2, 0xd0, 0xd7, 0xa2, 0xba,
+	0x9e, 0x28, 0x6a, 0x89, 0x0a, 0x55, 0x17, 0x74,
+	0xb7, 0x07, 0x18, 0x2e, 0x80, 0x62, 0x17, 0x61,
+	0xed, 0xb8, 0xf0, 0x0f, 0x80, 0xfb, 0x73, 0x5c,
+	0xe0, 0xf4, 0x3e, 0xb0, 0xcc, 0xe0, 0x6a, 0x6a,
+	0x09, 0xd4, 0xf4, 0x13, 0x29, 0x0b, 0x87, 0xe1,
+	0x12, 0xa0, 0x0f, 0x93, 0x02, 0x26, 0xf4, 0xef,
+	0xde, 0xe4, 0xfe, 0x5f, 0xdf, 0x71, 0xbb, 0xbf,
+	0x65, 0xfa, 0x6f, 0x31, 0xda, 0xda, 0x9c, 0xe3,
+	0xae, 0x90, 0xf7, 0xd8, 0x9b, 0x7e, 0xb9, 0xad,
+	0x1e, 0xc8, 0x40, 0x20, 0xef, 0x35, 0x0f, 0xcd,
+	0x19, 0x0d, 0x2c, 0xf9, 0x7e, 0xe8, 0xb8, 0xe4,
+	0xe2, 0x28, 0x15, 0xbc, 0x02, 0xb1, 0xa0, 0xb0,
+	0x41, 0x97, 0x88, 0xdc, 0x15, 0x41, 0x8a, 0x34,
+	0x0a, 0xca, 0x54, 0xf9, 0xff, 0x64, 0xc6, 0x19,
+	0x71, 0xf3, 0x12, 0xf0, 0xdb, 0xca, 0xd4, 0xbd,
+	0xf2, 0xe9, 0x79, 0xf4, 0x9b, 0x19, 0xa5, 0xdc,
+	0xb0, 0x2d, 0xb9, 0xc6, 0x6f, 0x43, 0xfa, 0x79,
+	0x0d, 0x4e, 0x72, 0x0d, 0xb2, 0x38, 0x26, 0x24,
+	0x2b, 0x38, 0x14, 0x06, 0x02, 0xe8, 0xc3, 0xf5,
+	0xd1, 0x3d, 0xe9, 0x6c, 0x56, 0x8e, 0x49, 0x07,
+	0xbc, 0x02, 0xcd, 0x2b, 0x45, 0xc7, 0xa4, 0x52,
+	0x15, 0x16, 0x5f, 0xc8, 0x4e, 0x85, 0xec, 0x7a,
+	0xbd, 0x00, 0x80, 0xc0, 0xe8, 0x44, 0xb5, 0xb9,
+	0x81, 0x9e, 0x26, 0xd7, 0x2d, 0x6f, 0xde, 0xe9,
+	0x71, 0xab, 0x14, 0xb6, 0x72, 0xb8, 0x08, 0x88,
+	0xce, 0x68, 0x50, 0x1c, 0xed, 0x3c, 0x96, 0xab,
+	0x3c, 0x17, 0x6b, 0x24, 0x5b, 0x20, 0xdd, 0xdc,
+	0xbe, 0x03, 0xb3, 0xeb, 0x72, 0x92, 0xd4, 0xe3,
+	0x3d, 0xe8, 0x99, 0xb0, 0xa0, 0xa2, 0x38, 0x6e,
+	0x0a, 0x88, 0x8b, 0xf7, 0xc4, 0x21, 0xa2, 0x00,
+	0x38, 0x0d, 0x24, 0x93, 0x2d, 0x01, 0x6f, 0xec,
+	0x05, 0x23, 0xd7, 0x77, 0xb5, 0xac, 0x5b, 0xf2,
+	0x94, 0xf4, 0xa2, 0x35, 0x96, 0xda, 0xa3, 0xa0,
+	0x62, 0x2e, 0x98, 0x26, 0x50, 0x3a, 0x26, 0x88,
+	0x48, 0x4a, 0x1c, 0x75, 0x4c, 0x8b, 0x61, 0x51,
+	0xae, 0x39, 0xc8, 0x63, 0xe5, 0x23, 0x56, 0x79,
+	0x18, 0xf8, 0xae, 0xae, 0xd3, 0x52, 0x4f, 0x35,
+	0x80, 0xe7, 0x5c, 0xd0, 0x21, 0x82, 0x59, 0x69,
+	0xcd, 0x75, 0xdf, 0x19, 0x00, 0x40, 0x6a, 0xaf,
+	0x79, 0x32, 0x12, 0x5e, 0x56, 0x68, 0xd8, 0x6e,
+	0x61, 0x86, 0x1c, 0x34, 0xd8, 0x6b, 0x69, 0x59,
+	0x52, 0xc5, 0x29, 0x74, 0x48, 0x82, 0xdd, 0x15,
+	0xf7, 0xbc, 0x2e, 0xf8, 0xfd, 0x98, 0xa7, 0x76,
+	0xca, 0xb9, 0xd5, 0x20, 0x22, 0xad, 0x8e, 0x83,
+	0x33, 0xab, 0xb7, 0x0c, 0x16, 0x20, 0x65, 0x69,
+	0xe6, 0x8e, 0xdd, 0x2e, 0x11, 0xba, 0x43, 0x08,
+	0x77, 0x71, 0x00, 0x74, 0x09, 0xa7, 0xea, 0xd3,
+	0x61, 0xbf, 0xf4, 0x83, 0x6c, 0x82, 0x06, 0xa0,
+	0x2d, 0xbd, 0xac, 0x44, 0xdd, 0x11, 0xad, 0xc3,
+	0x9f, 0x8a, 0xf1, 0xb0, 0x44, 0x34, 0xb9, 0xbb,
+	0xa5, 0xb9, 0x2f, 0xae, 0x61, 0x1a, 0x82, 0xc2,
+	0xd9, 0x76, 0x45, 0x46, 0xf8, 0x4b, 0xe6, 0x26,
+	0x08, 0x92, 0x6a, 0xe5, 0xa3, 0x17, 0xa9, 0x42,
+	0xa1, 0x9a, 0xf3, 0xe5, 0xcf, 0xac, 0xa1, 0x74,
+	0x65, 0xd0, 0x23, 0xc6, 0xea, 0xa5, 0x88, 0xc4,
+	0x1b, 0xcd, 0x0a, 0x13, 0x18, 0xf0, 0x39, 0x20,
+	0x82, 0xa3, 0x06, 0x25, 0xba, 0xaf, 0x67, 0x5b,
+	0x49, 0x5a, 0x41, 0x18, 0x06, 0xe2, 0x8d, 0x6c,
+	0xb2, 0xb0, 0x32, 0x9d, 0x55, 0xbb, 0x61, 0x70,
+	0x88, 0x6b, 0x83, 0xa1, 0x5b, 0xbd, 0xc1, 0xdd,
+	0x60, 0xc7, 0x02, 0x1b, 0x76, 0x69, 0x76, 0xc0,
+	0xc4, 0xb7, 0xd8, 0xca, 0x99, 0x65, 0x36, 0x4c,
+	0x15, 0x69, 0xe9, 0x6a, 0x24, 0x4a, 0xda, 0xac,
+	0xb5, 0x5e, 0x4d, 0x10, 0x1b, 0x0f, 0xed, 0x7b,
+	0xd6, 0xef, 0x96, 0x4d, 0x58, 0x0d, 0x0d, 0x1c,
+	0xc4, 0xe5, 0xe7, 0x5e, 0x4b, 0x1d, 0xaa, 0x60,
+	0x86, 0x93, 0xcb, 0xaa, 0xdd, 0xa5, 0x57, 0x92,
+	0x03, 0xa4, 0xa2, 0x1e, 0xb3, 0x8f, 0x9a, 0x8a,
+	0x7e, 0x30, 0xd7, 0xd6, 0x3d, 0xe4, 0xf3, 0x02,
+	0xc9, 0xda, 0x60, 0x14, 0xf7, 0x0a, 0x75, 0x7e,
+	0x9d, 0x40, 0x28, 0x7a, 0xe5, 0x7f, 0x0c, 0xe9,
+	0x24, 0xae, 0x07, 0xd7, 0x3d, 0xa1, 0x61, 0xbb,
+	0xd2, 0x38, 0x91, 0x0f, 0x1c, 0x84, 0x11, 0xe6,
+	0x5e, 0x71, 0xfa, 0x56, 0x7b, 0x6f, 0xd4, 0x18,
+	0xaf, 0xfc, 0x92, 0x95, 0x7c, 0x9e, 0x7e, 0xa0,
+	0x4c, 0x85, 0x77, 0x89, 0x27, 0xd9, 0x44, 0xf9,
+	0x11, 0xd6, 0x08, 0x2e, 0x5a, 0x1a, 0x14, 0xb9,
+	0x8b, 0x0e, 0x0f, 0x07, 0x7e, 0xe3, 0x1f, 0x2d,
+	0xdf, 0xb2, 0xc2, 0x5b, 0x50, 0x40, 0xfb, 0x9d,
+	0xc6, 0x73, 0x26, 0xed, 0x4c, 0x6b, 0xe6, 0x5d,
+	0x41, 0xee, 0x8b, 0x9b, 0x08, 0x9f, 0x54, 0x94,
+	0xae, 0x63, 0x9b, 0x2c, 0x46, 0xba, 0x59, 0x26,
+	0x6c, 0x1c, 0x81, 0xbd, 0x5c, 0x7d, 0x5a, 0x22,
+	0xf0, 0x80, 0x0f, 0x3c, 0xeb, 0xf5, 0x99, 0x2c,
+	0xe4, 0x25, 0xc8, 0xec, 0xc4, 0x1c, 0x80, 0x72,
+	0x80, 0x1b, 0x9e, 0xc6, 0xd6, 0xf8, 0xec, 0x42,
+	0x14, 0x6e, 0xff, 0x70, 0xeb, 0x59, 0x93, 0xdb,
+	0xda, 0xa2, 0x17, 0xc5, 0x98, 0xb0, 0xf2, 0x7c,
+	0xd5, 0xba, 0x68, 0x9a, 0xd6, 0xe9, 0x0c, 0x56,
+	0x04, 0xab, 0x1d, 0xda, 0xa3, 0x09, 0x1d, 0xb7,
+	0x77, 0x1c, 0x27, 0x62, 0x76, 0xba, 0x3d, 0x50,
+	0x5d, 0x54, 0x15, 0xf5, 0x05, 0x07, 0x71, 0xda,
+	0xc1, 0xd9, 0x74, 0x98, 0xc2, 0x81, 0xee, 0xc7,
+	0x2c, 0x0b, 0xa1, 0xcf, 0x15, 0xbe, 0x86, 0x8c,
+	0xdb, 0xad, 0xef, 0x51, 0x68, 0x2c, 0xa1, 0xc5,
+	0x81, 0xb6, 0xba, 0x86, 0xbe, 0x2b, 0x60, 0x7f,
+	0x04, 0xd5, 0x17, 0xc7, 0x56, 0x06, 0x8e, 0x82,
+	0x11, 0x2f, 0x51, 0x26, 0xee, 0xd7, 0xb3, 0xc9,
+	0x84, 0xa2, 0x1a, 0xec, 0xce, 0xbb, 0xb1, 0x4f,
+	0x71, 0x6b, 0xd5, 0x2f, 0x96, 0x36, 0xaf, 0x9b,
+	0x0b, 0xc6, 0x62, 0x61, 0xcc, 0xf0, 0xe3, 0xde,
+	0x1f, 0x34, 0x04, 0x0d, 0x0b, 0xb7, 0xd6, 0x8f,
+	0x59, 0xf0, 0x7c, 0x28, 0xab, 0x2d, 0x77, 0x1d,
+	0x99, 0x4d, 0x4c, 0x2f, 0x83, 0xfb, 0xca, 0x8e,
+	0xc2, 0x2c, 0xef, 0x8e, 0x1c, 0xd2, 0x6c, 0x3c,
+	0x06, 0x71, 0x49, 0x11, 0x28, 0x20, 0xa0, 0x82,
+	0x10, 0x1c, 0xaa, 0xbc, 0x4a, 0x21, 0xd9, 0xe3,
+	0x6e, 0x25, 0x12, 0xf1, 0x21, 0xdd, 0x7f, 0xe3,
+	0x09, 0x6e, 0x71, 0x26, 0x40, 0xde, 0x62, 0x46,
+	0x4f, 0xab, 0x57, 0x77, 0xcb, 0xf8, 0xf9, 0xdc,
+	0x14, 0xa3, 0x98, 0x5e, 0xc5, 0x71, 0x41, 0x33,
+	0x96, 0x54, 0x25, 0xb7, 0x31, 0xa4, 0x9a, 0x3a,
+	0x13, 0x0c, 0x60, 0x53, 0xea, 0xc2, 0x9a, 0x39,
+	0x6e, 0xf1, 0xb0, 0x39, 0xe9, 0xaa, 0x15, 0xfe,
+	0x4d, 0xad, 0x5c, 0x12, 0x1e, 0x9e, 0x46, 0xb5,
+	0xf2, 0x6b, 0x6c, 0x23, 0x0f, 0x07, 0x5d, 0x22,
+	0x13, 0xbe, 0x76, 0xfd, 0x80, 0x10, 0x36, 0xee,
+	0x01, 0xe6, 0x28, 0xeb, 0x90, 0x3d, 0xe9, 0xde,
+	0xeb, 0x45, 0xf0, 0x09, 0xe3, 0x36, 0xbe, 0xd5,
+	0xa1, 0x2b, 0xf8, 0xb1, 0x32, 0x56, 0xd3, 0x45,
+	0x14, 0x49, 0x42, 0x94, 0x59, 0x78, 0x83, 0x5b,
+	0x5e, 0xab, 0x46, 0xef, 0xe8, 0x2f, 0xcd, 0xd3,
+	0x74, 0xbd, 0xdd, 0x58, 0xf4, 0x9b, 0x2d, 0x95,
+	0xc6, 0x26, 0x46, 0xf8, 0x7c, 0x1a, 0x3d, 0x90,
+	0x63, 0x7f, 0x24, 0xbd, 0xf7, 0xa7, 0x18, 0x56,
+	0x52, 0x5e, 0x45, 0x3b, 0x8d, 0x12, 0x0e, 0x01,
+	0xcf, 0xeb, 0x59, 0xc3, 0x87, 0x87, 0x59, 0x4d,
+	0xad, 0x9f, 0x46, 0x29, 0xb9, 0x83, 0xb9, 0x1d,
+	0x03, 0xdd, 0xda, 0xfa, 0x85, 0xf2, 0x50, 0xd7,
+	0x50, 0x95, 0x12, 0xdd, 0xa7, 0x21, 0xde, 0x77,
+	0x0c, 0x38, 0x3a, 0x93, 0xbf, 0x93, 0xe1, 0x6c,
+	0x33, 0x27, 0x95, 0xec, 0xaa, 0x4e, 0x09, 0xad,
+	0x2b, 0xe3, 0xa8, 0xb0, 0xd5, 0xf8, 0x88, 0x25,
+	0x8e, 0x9a, 0x02, 0x35, 0xbb, 0xe1, 0xac, 0xc8,
+	0x19, 0xe7, 0x5b, 0xd8, 0x7a, 0x3c, 0x44, 0xad,
+	0x63, 0xd9, 0x9a, 0x0e, 0x27, 0xa3, 0xbb, 0x52,
+	0x87, 0x63, 0x03, 0x5c, 0x5c, 0x8b, 0x82, 0xea,
+	0x25, 0x84, 0x1f, 0xe1, 0x65, 0xcc, 0xa9, 0x7e,
+	0xb3, 0x04, 0x56, 0x2d, 0x41, 0x9a, 0xdb, 0xa4,
+	0x73, 0x75, 0xb2, 0x9a, 0x18, 0x6e, 0xed, 0x9f,
+	0xd1, 0xf0, 0xfc, 0x2d, 0x7b, 0x7e, 0x17, 0xa0,
+	0x02, 0x37, 0x81, 0x68, 0x03, 0x2a, 0xe6, 0xb6,
+	0x2f, 0x3d, 0xe3, 0x70, 0xd7, 0xbe, 0x14, 0x4b,
+	0x33, 0xc7, 0xe5, 0x4c, 0x35, 0xd2, 0xeb, 0x06,
+	0xc2, 0xe7, 0x34, 0x3d, 0x65, 0x4b, 0xde, 0x68,
+	0x82, 0x5f, 0xd0, 0x85, 0x8a, 0xb6, 0x3b, 0xb9,
+	0xf3, 0x1f, 0x29, 0xcb, 0xdd, 0x3d, 0x16, 0x11,
+	0x04, 0xfb, 0x5d, 0x39, 0xce, 0x48, 0x40, 0x90,
+	0x30, 0x74, 0xce, 0x95, 0xbf, 0xac, 0xfd, 0x42,
+	0x0b, 0xcd, 0xc7, 0x95, 0x84, 0x03, 0x4e, 0x77,
+	0x22, 0x77, 0x42, 0xff, 0xb5, 0x58, 0x10, 0xb9,
+	0x54, 0x6d, 0xf3, 0x22, 0xb6, 0x33, 0xb2, 0xe6,
+	0xa7, 0x80, 0x7b, 0x66, 0x2c, 0x79, 0xa8, 0x38,
+	0x46, 0x70, 0xcd, 0xca, 0x73, 0x1c, 0x42, 0x95,
+	0x93, 0x84, 0x94, 0x48, 0xdd, 0xa5, 0x02, 0x31,
+	0x12, 0xf5, 0x53, 0xc8, 0x28, 0x05, 0xae, 0xcf,
+	0x86, 0x2a, 0x35, 0xb2, 0xa3, 0xde, 0xea, 0xe9,
+	0x4e, 0xb8, 0xb4, 0xc1, 0xd4, 0xf6, 0x56, 0x67,
+	0x7a, 0xea, 0xb0, 0x57, 0x8f, 0xb2, 0x88, 0xa2,
+	0xa7, 0xdb, 0x6a, 0xcf, 0xe1, 0x19, 0x9e, 0x67,
+	0x43, 0xd3, 0x19, 0xe6, 0xb1, 0x04, 0xcf, 0xff,
+	0xbc, 0x83, 0xc0, 0x90, 0x79, 0x16, 0xf7, 0xf4,
+	0x01, 0xa7, 0x4b, 0x90, 0x59, 0xd4, 0x32, 0x00,
+	0xaf, 0x9d, 0xcf, 0x90, 0xb6, 0x6d, 0xf7, 0xf9,
+	0x41, 0x11, 0xdf, 0xf2, 0x15, 0xae, 0xf2, 0xd1,
+	0x32, 0xb2, 0x61, 0xab, 0xc9, 0x58, 0x9f, 0xca,
+	0x00, 0xeb, 0x5a, 0x59, 0xbf, 0x8d, 0x5a, 0x6e,
+	0x2a, 0x29, 0xff, 0xe0, 0x97, 0xf6, 0xd9, 0xd8,
+	0x07, 0xb8, 0xca, 0x1c, 0x66, 0xbc, 0xed, 0x98,
+	0x6f, 0x4e, 0x44, 0x38, 0xa7, 0xe3, 0x02, 0xa7,
+	0xce, 0x5c, 0x00, 0x8d, 0xe9, 0x5a, 0xfc, 0x13,
+	0x84, 0xfb, 0xf3, 0x1b, 0xf1, 0xcc, 0xf3, 0xf9,
+	0x84, 0xbd, 0x15, 0xeb, 0x7a, 0x03, 0x83, 0xe9,
+	0x51, 0xc7, 0x21, 0xf8, 0xab, 0x23, 0x9f, 0x79,
+	0x7f, 0xa0, 0x07, 0x69, 0xfa, 0x03, 0x7c, 0x7e,
+	0xfe, 0x70, 0x99, 0xef, 0x3c, 0x8c, 0xe8, 0xc1,
+	0x4a, 0xfe, 0xac, 0xc4, 0x01, 0x2f, 0xad, 0x52,
+	0xf7, 0xce, 0x4b, 0xa2, 0xf1, 0xea, 0x1b, 0x70,
+	0x8a, 0x22, 0xd9, 0x85, 0x25, 0x56, 0x03, 0x23,
+	0xc6, 0x9d, 0x13, 0x02, 0x29, 0xfb, 0xc3, 0x73,
+	0xf9, 0x6f, 0x37, 0xfa, 0x9f, 0xe4, 0x4d, 0x96,
+	0xb2, 0x98, 0x38, 0xa3, 0x82, 0x53, 0x14, 0x0d,
+	0x76, 0xed, 0x92, 0x9b, 0x43, 0x95, 0xbf, 0x09,
+	0x32, 0xd2, 0x0c, 0x5c, 0xcd, 0xcf, 0xcf, 0xc7,
+	0x3f, 0x07, 0xc1, 0xde, 0xeb, 0x0e, 0x74, 0x9e,
+	0xa6, 0xac, 0x41, 0x29, 0xff, 0x55, 0x36, 0x75,
+	0x43, 0xc8, 0x11, 0x86, 0x5d, 0xd0, 0x90, 0x90,
+	0xa2, 0x9c, 0xec, 0x6f, 0x6b, 0xbb, 0x36, 0xaa,
+	0xc2, 0xf8, 0x88, 0xae, 0x06, 0xfc, 0x4c, 0xad,
+	0xa8, 0x8d, 0xd6, 0xa8, 0xe3, 0x0c, 0x1d, 0x26,
+	0xd4, 0x2e, 0xac, 0x31, 0xfe, 0x3c, 0xc1, 0xa0,
+	0xd8, 0xad, 0x10, 0x44, 0x69, 0x46, 0xee, 0x2b,
+	0x3e, 0x77, 0xd9, 0x45, 0x73, 0x25, 0xf2, 0x1c,
+	0xb3, 0xc8, 0xc4, 0x96, 0xd4, 0xe1, 0xbc, 0xa8,
+	0x10, 0x68, 0xd9, 0x0e, 0xa5, 0x9b, 0xaf, 0x7d,
+	0x48, 0xbf, 0xc1, 0xb1, 0x05, 0xb0, 0xdd, 0x44,
+	0x27, 0xb6, 0x89, 0x9a, 0xdc, 0x7b, 0xb6, 0x8f,
+	0x43, 0x7a, 0x25, 0x17, 0x5c, 0xe1, 0xbf, 0x6c,
+	0x49, 0x98, 0x7a, 0xee, 0x33, 0x29, 0x6c, 0x7c,
+	0xe8, 0x2d, 0x2d, 0xee, 0xdd, 0x0a, 0x32, 0x04,
+	0xc1, 0xbb, 0x9f, 0x9d, 0x36, 0x55, 0x2c, 0x79,
+	0xd0, 0x51, 0x90, 0x2c, 0x32, 0x4f, 0x98, 0x7b,
+	0xe7, 0x12, 0x6a, 0x1b, 0x3c, 0xd6, 0x97, 0x24,
+	0x03, 0xc4, 0x12, 0xe1, 0xcf, 0x44, 0xe5, 0x90,
+	0xff, 0x84, 0x2d, 0x35, 0xda, 0x59, 0xae, 0xaa,
+	0xaa, 0x3e, 0xd6, 0xdc, 0x8d, 0x6e, 0x57, 0x75,
+	0x80, 0xc1, 0x90, 0xbc, 0x97, 0x27, 0xe1, 0x9b,
+	0xeb, 0xf3, 0x7c, 0xba, 0x38, 0x61, 0x4a, 0x37,
+	0xe6, 0x77, 0x6d, 0xc0, 0xd0, 0x1b, 0x6a, 0x7a,
+	0x5a, 0x40, 0x56, 0xe7, 0xae, 0xae, 0x5c, 0x2e,
+	0x6f, 0xec, 0xeb, 0x07, 0x13, 0xcc, 0xa2, 0xff,
+	0xbf, 0x1e, 0xb9, 0xf7, 0x7f, 0x04, 0x2f, 0x65,
+	0x7b, 0x9c, 0x25, 0x4c, 0xb7, 0x8f, 0xc6, 0x11,
+	0xcf, 0x1d, 0xf9, 0x7d, 0xcb, 0x55, 0xac, 0x3a,
+	0x42, 0x97, 0x41, 0x55, 0x63, 0xe3, 0x54, 0x22,
+	0x01, 0x0e, 0x1a, 0x81, 0x12, 0x49, 0xe6, 0x8d,
+	0xe5, 0x0c, 0xd9, 0x9c, 0x9b, 0xa0, 0xae, 0x6b,
+	0xbd, 0xa7, 0xe8, 0x88, 0xfc, 0x94, 0xc2, 0x3e,
+	0x2b, 0x04, 0x94, 0x8e, 0xe7, 0xe8, 0xb1, 0xe9,
+	0xf6, 0xcb, 0x6a, 0x08, 0x14, 0x50, 0x96, 0xf9,
+	0x5c, 0x6f, 0x95, 0xf8, 0x0f, 0x43, 0x63, 0xcc,
+	0xea, 0x4b, 0x54, 0xe7, 0xe0, 0x17, 0x25, 0x0b,
+	0x1b, 0xb9, 0x9a, 0x02, 0xa2, 0x4b, 0xeb, 0x98,
+	0x16, 0x55, 0xa1, 0x2a, 0xa6, 0x37, 0x23, 0x02,
+	0xa6, 0xb8, 0xfa, 0xb6, 0xfc, 0x5d, 0x82, 0xe6,
+	0xa9, 0xd7, 0xcd, 0x89, 0xee, 0xf3, 0x94, 0x09,
+	0xac, 0x2e, 0x0b, 0x4e, 0x79, 0xf7, 0xe7, 0x8f,
+	0x4c, 0x88, 0xb9, 0xf2, 0xbf, 0xdc, 0xf5, 0x65,
+	0x95, 0xef, 0x1b, 0x91, 0x4d, 0x9e, 0x77, 0xf6,
+	0x75, 0x45, 0x7f, 0x63, 0x38, 0x13, 0x6c, 0xe4,
+	0x42, 0x77, 0x33, 0xbb, 0x6e, 0x1a, 0x4b, 0xbb,
+	0xa2, 0x04, 0xad, 0x61, 0xe1, 0xa2, 0xc6, 0x76,
+	0x92, 0xe2, 0x07, 0xdf, 0x80, 0x7e, 0xd5, 0xf5,
+	0xc3, 0x54, 0x58, 0xfb, 0x67, 0xc4, 0xe0, 0xa9,
+	0x3b, 0x13, 0x65, 0xaa, 0x2d, 0xb0, 0x65, 0xcf,
+	0xb4, 0x12, 0x30, 0x95, 0xb5, 0xf6, 0x0b, 0x47,
+	0xd8, 0x12, 0x26, 0x58, 0x91, 0xfb, 0x4d, 0x54,
+	0x4f, 0xa5, 0x50, 0xb6, 0x69, 0x30, 0x60, 0xa5,
+	0x43, 0xc5, 0x4f, 0x70, 0x75, 0xb4, 0x3f, 0x29,
+	0xc6, 0x6f, 0xbf, 0x7b, 0x65, 0xca, 0xc2, 0x3e,
+	0xdd, 0xe8, 0x96, 0x6e, 0xe3, 0xe4, 0xc2, 0x32,
+	0x89, 0x12, 0xe9, 0xf3, 0x42, 0x49, 0x98, 0x85,
+	0x0e, 0xe7, 0xf5, 0x83, 0x9b, 0x34, 0xac, 0x61,
+	0xa3, 0x6b, 0xdd, 0x09, 0x36, 0x9f, 0x47, 0x13,
+	0x88, 0xdd, 0x81, 0x6b, 0xc1, 0x43, 0x9e, 0x4b,
+	0x56, 0x87, 0x3e, 0x98, 0xd0, 0xd6, 0x1e, 0xde,
+	0xbd, 0x13, 0x61, 0x58, 0x48, 0x0d, 0xb9, 0xeb,
+};
+
+static int __init crct10dif_test_init(void)
+{
+	int i;
+	int errors = 0;
+	int bytes = 0;
+	u64 nsec;
+	unsigned long flags;
+
+	static u16 crc;
+
+	for (i = 0; i < 100; i++) {
+		bytes += tests[i].length;
+		crc ^= crc_t10dif_generic(tests[i].crc, test_buf +
+		tests[i].start, tests[i].length);
+	}
+
+	local_irq_save(flags);
+
+	nsec = ktime_get_ns();
+
+	for (i = 0; i < 100; i++) {
+		if (tests[i].crct10dif != crc_t10dif_update(
+			tests[i].crc,
+			test_buf + tests[i].start,
+			tests[i].length))
+			errors++;
+	}
+
+	nsec = ktime_get_ns() - nsec;
+
+	local_irq_restore(flags);
+
+	if (errors)
+		pr_warn("crct10dif: %d self tests failed\n", errors);
+	else
+		pr_info("crct10dif: self tests passed, processed %d bytes in %lld nsec\n",
+		bytes, nsec);
+
+	return 0;
+}
+
+static void __exit crct10dif_test_exit(void)
+{
+	pr_info("CRC-T10DIF test module unloaded.\n");
+}
+
+module_init(crct10dif_test_init);
+module_exit(crct10dif_test_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("CRC-T10DIF Test Module");
-- 
2.34.1


