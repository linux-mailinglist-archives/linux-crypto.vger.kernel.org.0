Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 495063806BB
	for <lists+linux-crypto@lfdr.de>; Fri, 14 May 2021 12:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbhENKFn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 14 May 2021 06:05:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:59564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230326AbhENKFm (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 14 May 2021 06:05:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 537C5613BC;
        Fri, 14 May 2021 10:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620986671;
        bh=7S1uz8WPUYr6sHyb+svdSupepfqKSr+a3yd+f0wW6eA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gcGKic/e94vBDCecXsJC+l7BV+jF61Vl9r4EUSx0TbSq3BTiYwZDDapvHp61A7Zxe
         Acukro9fb8NpiQqoMS70MD4tw4e4XLAaTQvg3UcAbylse0N/q9nalsgt8m3GZQWCGP
         g+ryLKYFd2VHE9OD6BLMNdLqBUDbS20M3a3HH443U6KarQtTCdTGdj6ojYReBWwEXj
         QGZm6nPm/lmpZ/SCS3fxsLB693IXNvdQtX2uyRTr+tigoFEzUVctj8bqBi2++LEZ0j
         2xUqlOkXxJRjXni556isbflaHHKSt9ZxyqKYfWjfF3FYBTUiOWpW22UyfErJKa7DgV
         T3cj+pZfXGPcw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arch@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-mips@vger.kernel.org
Subject: [PATCH v2 07/13] asm-generic: unaligned always use struct helpers
Date:   Fri, 14 May 2021 12:00:55 +0200
Message-Id: <20210514100106.3404011-8-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210514100106.3404011-1-arnd@kernel.org>
References: <20210514100106.3404011-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

As found by Vineet Gupta and Linus Torvalds, gcc has somewhat unexpected
behavior when faced with overlapping unaligned pointers. The kernel's
unaligned/access-ok.h header technically invokes undefined behavior
that happens to usually work on the architectures using it, but if the
compiler optimizes code based on the assumption that undefined behavior
doesn't happen, it can create output that actually causes data corruption.

A related problem was previously found on 32-bit ARMv7, where most
instructions can be used on unaligned data, but 64-bit ldrd/strd causes
an exception. The workaround was to always use the unaligned/le_struct.h
helper instead of unaligned/access-ok.h, in commit 1cce91dfc8f7 ("ARM:
8715/1: add a private asm/unaligned.h").

The same solution should work on all other architectures as well, so
remove the access-ok.h variant and use the other one unconditionally on
all architectures, picking either the big-endian or little-endian version.

With this, the arm specific header can be removed as well, and the
only file including linux/unaligned/access_ok.h gets moved to including
the normal file.

Fortunately, this made almost no difference to the object code produced
by gcc-11. On x86, s390, powerpc, and arc, the resulting binary appears
to be identical to the previous version, while on arm64 and m68k there
are minimal differences that looks like an optimization pass went into
a different direction, usually using fewer stack spills on the new
version.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=100363
---
 arch/arm/include/asm/unaligned.h    | 25 -----------
 arch/mips/crypto/crc32-mips.c       |  2 +-
 include/asm-generic/unaligned.h     | 13 +-----
 include/linux/unaligned/access_ok.h | 68 -----------------------------
 4 files changed, 3 insertions(+), 105 deletions(-)
 delete mode 100644 arch/arm/include/asm/unaligned.h
 delete mode 100644 include/linux/unaligned/access_ok.h

diff --git a/arch/arm/include/asm/unaligned.h b/arch/arm/include/asm/unaligned.h
deleted file mode 100644
index 3c5248fb4cdc..000000000000
--- a/arch/arm/include/asm/unaligned.h
+++ /dev/null
@@ -1,25 +0,0 @@
-#ifndef __ASM_ARM_UNALIGNED_H
-#define __ASM_ARM_UNALIGNED_H
-
-/*
- * We generally want to set CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS on ARMv6+,
- * but we don't want to use linux/unaligned/access_ok.h since that can lead
- * to traps on unaligned stm/ldm or strd/ldrd.
- */
-#include <asm/byteorder.h>
-
-#if defined(__LITTLE_ENDIAN)
-# include <linux/unaligned/le_struct.h>
-# include <linux/unaligned/generic.h>
-# define get_unaligned	__get_unaligned_le
-# define put_unaligned	__put_unaligned_le
-#elif defined(__BIG_ENDIAN)
-# include <linux/unaligned/be_struct.h>
-# include <linux/unaligned/generic.h>
-# define get_unaligned	__get_unaligned_be
-# define put_unaligned	__put_unaligned_be
-#else
-# error need to define endianess
-#endif
-
-#endif /* __ASM_ARM_UNALIGNED_H */
diff --git a/arch/mips/crypto/crc32-mips.c b/arch/mips/crypto/crc32-mips.c
index faa88a6a74c0..0a03529cf317 100644
--- a/arch/mips/crypto/crc32-mips.c
+++ b/arch/mips/crypto/crc32-mips.c
@@ -8,13 +8,13 @@
  * Copyright (C) 2018 MIPS Tech, LLC
  */
 
-#include <linux/unaligned/access_ok.h>
 #include <linux/cpufeature.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/string.h>
 #include <asm/mipsregs.h>
+#include <asm/unaligned.h>
 
 #include <crypto/internal/hash.h>
 
diff --git a/include/asm-generic/unaligned.h b/include/asm-generic/unaligned.h
index d79df721ae60..36bf03aaa674 100644
--- a/include/asm-generic/unaligned.h
+++ b/include/asm-generic/unaligned.h
@@ -8,22 +8,13 @@
  */
 #include <asm/byteorder.h>
 
-/* Set by the arch if it can handle unaligned accesses in hardware. */
-#ifdef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
-# include <linux/unaligned/access_ok.h>
-#endif
-
 #if defined(__LITTLE_ENDIAN)
-# ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
-#  include <linux/unaligned/le_struct.h>
-# endif
+# include <linux/unaligned/le_struct.h>
 # include <linux/unaligned/generic.h>
 # define get_unaligned	__get_unaligned_le
 # define put_unaligned	__put_unaligned_le
 #elif defined(__BIG_ENDIAN)
-# ifndef CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS
-#  include <linux/unaligned/be_struct.h>
-# endif
+# include <linux/unaligned/be_struct.h>
 # include <linux/unaligned/generic.h>
 # define get_unaligned	__get_unaligned_be
 # define put_unaligned	__put_unaligned_be
diff --git a/include/linux/unaligned/access_ok.h b/include/linux/unaligned/access_ok.h
deleted file mode 100644
index 167aa849c0ce..000000000000
--- a/include/linux/unaligned/access_ok.h
+++ /dev/null
@@ -1,68 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_UNALIGNED_ACCESS_OK_H
-#define _LINUX_UNALIGNED_ACCESS_OK_H
-
-#include <linux/kernel.h>
-#include <asm/byteorder.h>
-
-static __always_inline u16 get_unaligned_le16(const void *p)
-{
-	return le16_to_cpup((__le16 *)p);
-}
-
-static __always_inline u32 get_unaligned_le32(const void *p)
-{
-	return le32_to_cpup((__le32 *)p);
-}
-
-static __always_inline u64 get_unaligned_le64(const void *p)
-{
-	return le64_to_cpup((__le64 *)p);
-}
-
-static __always_inline u16 get_unaligned_be16(const void *p)
-{
-	return be16_to_cpup((__be16 *)p);
-}
-
-static __always_inline u32 get_unaligned_be32(const void *p)
-{
-	return be32_to_cpup((__be32 *)p);
-}
-
-static __always_inline u64 get_unaligned_be64(const void *p)
-{
-	return be64_to_cpup((__be64 *)p);
-}
-
-static __always_inline void put_unaligned_le16(u16 val, void *p)
-{
-	*((__le16 *)p) = cpu_to_le16(val);
-}
-
-static __always_inline void put_unaligned_le32(u32 val, void *p)
-{
-	*((__le32 *)p) = cpu_to_le32(val);
-}
-
-static __always_inline void put_unaligned_le64(u64 val, void *p)
-{
-	*((__le64 *)p) = cpu_to_le64(val);
-}
-
-static __always_inline void put_unaligned_be16(u16 val, void *p)
-{
-	*((__be16 *)p) = cpu_to_be16(val);
-}
-
-static __always_inline void put_unaligned_be32(u32 val, void *p)
-{
-	*((__be32 *)p) = cpu_to_be32(val);
-}
-
-static __always_inline void put_unaligned_be64(u64 val, void *p)
-{
-	*((__be64 *)p) = cpu_to_be64(val);
-}
-
-#endif /* _LINUX_UNALIGNED_ACCESS_OK_H */
-- 
2.29.2

