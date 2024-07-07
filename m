Return-Path: <linux-crypto+bounces-5451-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61997929626
	for <lists+linux-crypto@lfdr.de>; Sun,  7 Jul 2024 02:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9995B21401
	for <lists+linux-crypto@lfdr.de>; Sun,  7 Jul 2024 00:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62F3279D2;
	Sun,  7 Jul 2024 00:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RqAIFIA/"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19004D2FA;
	Sun,  7 Jul 2024 00:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720312043; cv=none; b=qO/8945AJHC1Vj0MHBSSmZEp25p/lhYrVovCbqI1RjEzCaw3VJk+PwZC1rZG3P9RWvgzzirStmUeiERduBKlpD5uLeoAC8WoBx/VxPDijDFh9AsdAChoDXU4bBH7RDPKPcjJDF7J/g2jLR58qUQUD0E69fGdkTXnrw0i0BVy50A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720312043; c=relaxed/simple;
	bh=Wzch4xQ9esrxdmOm22Pn2ApKmukjCb985hoIkY+IA1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h90rHVW1cB7MxqbdjoLJaQZkTiowmR1cvFKGv0PY70zo5cn8cxnyrveVuWNqBptDQzwV2r7ZnZhmCkPoMz+bClpw6TfbNH+tfiRY+8C/A5QsbFdk+tm/igHfEqeCJqOJy1G6zWJ9klwxg16JIguXSuk0Flr/hB8XG55ONKj5YiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=RqAIFIA/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2789DC32786;
	Sun,  7 Jul 2024 00:27:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="RqAIFIA/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1720312040;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C22YhHPyr4iBlxXvXl9KGgqSL9EPC/GQkIIWgMAk9R4=;
	b=RqAIFIA/W/HDatfFXfjhzvuDHs/k2rCo56owYBjiCwMn4vGgYagdwf2iAL/fcBoLeJ/NKg
	whoj+yEIng1FCL1z5Fq2yE0Sh3ygC1GaUWyhKChxyw1pkyoJb21bpzLX4fmAnvwyuJYefW
	aaMVePrdv8Q5+ks+2rY46DtsMBtb8XQ=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 423ceeea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 7 Jul 2024 00:27:20 +0000 (UTC)
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	tglx@linutronix.de
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-crypto@vger.kernel.org,
	linux-api@vger.kernel.org,
	x86@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Carlos O'Donell <carlos@redhat.com>,
	Florian Weimer <fweimer@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <dhildenb@redhat.com>,
	Samuel Neves <sneves@dei.uc.pt>
Subject: [PATCH v21 3/4] x86: vdso: Wire up getrandom() vDSO implementation
Date: Sun,  7 Jul 2024 02:26:53 +0200
Message-ID: <20240707002658.1917440-4-Jason@zx2c4.com>
In-Reply-To: <20240707002658.1917440-1-Jason@zx2c4.com>
References: <20240707002658.1917440-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hook up the generic vDSO implementation to the x86 vDSO data page. Since
the existing vDSO infrastructure is heavily based on the timekeeping
functionality, which works over arrays of bases, a new macro is
introduced for vvars that are not arrays.

The vDSO function requires a ChaCha20 implementation that does not write
to the stack, yet can still do an entire ChaCha20 permutation, so
provide this using SSE2, since this is userland code that must work on
all x86-64 processors.

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Samuel Neves <sneves@dei.uc.pt> # for vgetrandom-chacha.S
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 MAINTAINERS                             |   2 +
 arch/x86/Kconfig                        |   1 +
 arch/x86/entry/vdso/Makefile            |   3 +-
 arch/x86/entry/vdso/vdso.lds.S          |   2 +
 arch/x86/entry/vdso/vgetrandom-chacha.S | 178 ++++++++++++++++++++++++
 arch/x86/entry/vdso/vgetrandom.c        |  17 +++
 arch/x86/include/asm/vdso/getrandom.h   |  55 ++++++++
 arch/x86/include/asm/vdso/vsyscall.h    |   2 +
 arch/x86/include/asm/vvar.h             |  16 +++
 9 files changed, 275 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/entry/vdso/vgetrandom-chacha.S
 create mode 100644 arch/x86/entry/vdso/vgetrandom.c
 create mode 100644 arch/x86/include/asm/vdso/getrandom.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 798158329ad8..00cf0362482b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18749,6 +18749,8 @@ F:	drivers/char/random.c
 F:	drivers/virt/vmgenid.c
 F:	include/vdso/getrandom.h
 F:	lib/vdso/getrandom.c
+F:	arch/x86/entry/vdso/vgetrandom*
+F:	arch/x86/include/asm/vdso/getrandom*
 
 RAPIDIO SUBSYSTEM
 M:	Matt Porter <mporter@kernel.crashing.org>
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 1d7122a1883e..9c98b7a88cc2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -287,6 +287,7 @@ config X86
 	select HAVE_UNSTABLE_SCHED_CLOCK
 	select HAVE_USER_RETURN_NOTIFIER
 	select HAVE_GENERIC_VDSO
+	select VDSO_GETRANDOM			if X86_64
 	select HOTPLUG_PARALLEL			if SMP && X86_64
 	select HOTPLUG_SMT			if SMP
 	select HOTPLUG_SPLIT_STARTUP		if SMP && X86_32
diff --git a/arch/x86/entry/vdso/Makefile b/arch/x86/entry/vdso/Makefile
index 215a1b202a91..c9216ac4fb1e 100644
--- a/arch/x86/entry/vdso/Makefile
+++ b/arch/x86/entry/vdso/Makefile
@@ -7,7 +7,7 @@
 include $(srctree)/lib/vdso/Makefile
 
 # Files to link into the vDSO:
-vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o
+vobjs-y := vdso-note.o vclock_gettime.o vgetcpu.o vgetrandom.o vgetrandom-chacha.o
 vobjs32-y := vdso32/note.o vdso32/system_call.o vdso32/sigreturn.o
 vobjs32-y += vdso32/vclock_gettime.o vdso32/vgetcpu.o
 vobjs-$(CONFIG_X86_SGX)	+= vsgx.o
@@ -73,6 +73,7 @@ CFLAGS_REMOVE_vdso32/vclock_gettime.o = -pg
 CFLAGS_REMOVE_vgetcpu.o = -pg
 CFLAGS_REMOVE_vdso32/vgetcpu.o = -pg
 CFLAGS_REMOVE_vsgx.o = -pg
+CFLAGS_REMOVE_vgetrandom.o = -pg
 
 #
 # X32 processes use x32 vDSO to access 64bit kernel data.
diff --git a/arch/x86/entry/vdso/vdso.lds.S b/arch/x86/entry/vdso/vdso.lds.S
index e8c60ae7a7c8..0bab5f4af6d1 100644
--- a/arch/x86/entry/vdso/vdso.lds.S
+++ b/arch/x86/entry/vdso/vdso.lds.S
@@ -30,6 +30,8 @@ VERSION {
 #ifdef CONFIG_X86_SGX
 		__vdso_sgx_enter_enclave;
 #endif
+		getrandom;
+		__vdso_getrandom;
 	local: *;
 	};
 }
diff --git a/arch/x86/entry/vdso/vgetrandom-chacha.S b/arch/x86/entry/vdso/vgetrandom-chacha.S
new file mode 100644
index 000000000000..bcba5639b8ee
--- /dev/null
+++ b/arch/x86/entry/vdso/vgetrandom-chacha.S
@@ -0,0 +1,178 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022-2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+
+#include <linux/linkage.h>
+#include <asm/frame.h>
+
+.section	.rodata, "a"
+.align 16
+CONSTANTS:	.octa 0x6b20657479622d323320646e61707865
+.text
+
+/*
+ * Very basic SSE2 implementation of ChaCha20. Produces a given positive number
+ * of blocks of output with a nonce of 0, taking an input key and 8-byte
+ * counter. Importantly does not spill to the stack. Its arguments are:
+ *
+ *	rdi: output bytes
+ *	rsi: 32-byte key input
+ *	rdx: 8-byte counter input/output
+ *	rcx: number of 64-byte blocks to write to output
+ */
+SYM_FUNC_START(__arch_chacha20_blocks_nostack)
+
+.set	output,		%rdi
+.set	key,		%rsi
+.set	counter,	%rdx
+.set	nblocks,	%rcx
+.set	i,		%al
+/* xmm registers are *not* callee-save. */
+.set	temp,		%xmm0
+.set	state0,		%xmm1
+.set	state1,		%xmm2
+.set	state2,		%xmm3
+.set	state3,		%xmm4
+.set	copy0,		%xmm5
+.set	copy1,		%xmm6
+.set	copy2,		%xmm7
+.set	copy3,		%xmm8
+.set	one,		%xmm9
+
+	/* copy0 = "expand 32-byte k" */
+	movaps		CONSTANTS(%rip),copy0
+	/* copy1,copy2 = key */
+	movups		0x00(key),copy1
+	movups		0x10(key),copy2
+	/* copy3 = counter || zero nonce */
+	movq		0x00(counter),copy3
+	/* one = 1 || 0 */
+	movq		$1,%rax
+	movq		%rax,one
+
+.Lblock:
+	/* state0,state1,state2,state3 = copy0,copy1,copy2,copy3 */
+	movdqa		copy0,state0
+	movdqa		copy1,state1
+	movdqa		copy2,state2
+	movdqa		copy3,state3
+
+	movb		$10,i
+.Lpermute:
+	/* state0 += state1, state3 = rotl32(state3 ^ state0, 16) */
+	paddd		state1,state0
+	pxor		state0,state3
+	movdqa		state3,temp
+	pslld		$16,temp
+	psrld		$16,state3
+	por		temp,state3
+
+	/* state2 += state3, state1 = rotl32(state1 ^ state2, 12) */
+	paddd		state3,state2
+	pxor		state2,state1
+	movdqa		state1,temp
+	pslld		$12,temp
+	psrld		$20,state1
+	por		temp,state1
+
+	/* state0 += state1, state3 = rotl32(state3 ^ state0, 8) */
+	paddd		state1,state0
+	pxor		state0,state3
+	movdqa		state3,temp
+	pslld		$8,temp
+	psrld		$24,state3
+	por		temp,state3
+
+	/* state2 += state3, state1 = rotl32(state1 ^ state2, 7) */
+	paddd		state3,state2
+	pxor		state2,state1
+	movdqa		state1,temp
+	pslld		$7,temp
+	psrld		$25,state1
+	por		temp,state1
+
+	/* state1[0,1,2,3] = state1[1,2,3,0] */
+	pshufd		$0x39,state1,state1
+	/* state2[0,1,2,3] = state2[2,3,0,1] */
+	pshufd		$0x4e,state2,state2
+	/* state3[0,1,2,3] = state3[3,0,1,2] */
+	pshufd		$0x93,state3,state3
+
+	/* state0 += state1, state3 = rotl32(state3 ^ state0, 16) */
+	paddd		state1,state0
+	pxor		state0,state3
+	movdqa		state3,temp
+	pslld		$16,temp
+	psrld		$16,state3
+	por		temp,state3
+
+	/* state2 += state3, state1 = rotl32(state1 ^ state2, 12) */
+	paddd		state3,state2
+	pxor		state2,state1
+	movdqa		state1,temp
+	pslld		$12,temp
+	psrld		$20,state1
+	por		temp,state1
+
+	/* state0 += state1, state3 = rotl32(state3 ^ state0, 8) */
+	paddd		state1,state0
+	pxor		state0,state3
+	movdqa		state3,temp
+	pslld		$8,temp
+	psrld		$24,state3
+	por		temp,state3
+
+	/* state2 += state3, state1 = rotl32(state1 ^ state2, 7) */
+	paddd		state3,state2
+	pxor		state2,state1
+	movdqa		state1,temp
+	pslld		$7,temp
+	psrld		$25,state1
+	por		temp,state1
+
+	/* state1[0,1,2,3] = state1[3,0,1,2] */
+	pshufd		$0x93,state1,state1
+	/* state2[0,1,2,3] = state2[2,3,0,1] */
+	pshufd		$0x4e,state2,state2
+	/* state3[0,1,2,3] = state3[1,2,3,0] */
+	pshufd		$0x39,state3,state3
+
+	decb		i
+	jnz		.Lpermute
+
+	/* output0 = state0 + copy0 */
+	paddd		copy0,state0
+	movups		state0,0x00(output)
+	/* output1 = state1 + copy1 */
+	paddd		copy1,state1
+	movups		state1,0x10(output)
+	/* output2 = state2 + copy2 */
+	paddd		copy2,state2
+	movups		state2,0x20(output)
+	/* output3 = state3 + copy3 */
+	paddd		copy3,state3
+	movups		state3,0x30(output)
+
+	/* ++copy3.counter */
+	paddq		one,copy3
+
+	/* output += 64, --nblocks */
+	addq		$64,output
+	decq		nblocks
+	jnz		.Lblock
+
+	/* counter = copy3.counter */
+	movq		copy3,0x00(counter)
+
+	/* Zero out the potentially sensitive regs, in case nothing uses these again. */
+	pxor		state0,state0
+	pxor		state1,state1
+	pxor		state2,state2
+	pxor		state3,state3
+	pxor		copy1,copy1
+	pxor		copy2,copy2
+	pxor		temp,temp
+
+	ret
+SYM_FUNC_END(__arch_chacha20_blocks_nostack)
diff --git a/arch/x86/entry/vdso/vgetrandom.c b/arch/x86/entry/vdso/vgetrandom.c
new file mode 100644
index 000000000000..52d3c7faae2e
--- /dev/null
+++ b/arch/x86/entry/vdso/vgetrandom.c
@@ -0,0 +1,17 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2022-2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+#include <linux/types.h>
+
+#include "../../../../lib/vdso/getrandom.c"
+
+ssize_t __vdso_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state, size_t opaque_len);
+
+ssize_t __vdso_getrandom(void *buffer, size_t len, unsigned int flags, void *opaque_state, size_t opaque_len)
+{
+	return __cvdso_getrandom(buffer, len, flags, opaque_state, opaque_len);
+}
+
+ssize_t getrandom(void *, size_t, unsigned int, void *, size_t)
+	__attribute__((weak, alias("__vdso_getrandom")));
diff --git a/arch/x86/include/asm/vdso/getrandom.h b/arch/x86/include/asm/vdso/getrandom.h
new file mode 100644
index 000000000000..b96e674cafde
--- /dev/null
+++ b/arch/x86/include/asm/vdso/getrandom.h
@@ -0,0 +1,55 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022-2024 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ */
+#ifndef __ASM_VDSO_GETRANDOM_H
+#define __ASM_VDSO_GETRANDOM_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/unistd.h>
+#include <asm/vvar.h>
+
+/**
+ * getrandom_syscall - Invoke the getrandom() syscall.
+ * @buffer:	Destination buffer to fill with random bytes.
+ * @len:	Size of @buffer in bytes.
+ * @flags:	Zero or more GRND_* flags.
+ * Returns:	The number of random bytes written to @buffer, or a negative value indicating an error.
+ */
+static __always_inline ssize_t getrandom_syscall(void *buffer, size_t len, unsigned int flags)
+{
+	long ret;
+
+	asm ("syscall" : "=a" (ret) :
+	     "0" (__NR_getrandom), "D" (buffer), "S" (len), "d" (flags) :
+	     "rcx", "r11", "memory");
+
+	return ret;
+}
+
+#define __vdso_rng_data (VVAR(_vdso_rng_data))
+
+static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(void)
+{
+	if (IS_ENABLED(CONFIG_TIME_NS) && __vdso_data->clock_mode == VDSO_CLOCKMODE_TIMENS)
+		return (void *)&__vdso_rng_data + ((void *)&__timens_vdso_data - (void *)&__vdso_data);
+	return &__vdso_rng_data;
+}
+
+/**
+ * __arch_chacha20_blocks_nostack - Generate ChaCha20 stream without using the stack.
+ * @dst_bytes:	Destination buffer to hold @nblocks * 64 bytes of output.
+ * @key:	32-byte input key.
+ * @counter:	8-byte counter, read on input and updated on return.
+ * @nblocks:	Number of blocks to generate.
+ *
+ * Generates a given positive number of blocks of ChaCha20 output with nonce=0, and does not write
+ * to any stack or memory outside of the parameters passed to it, in order to mitigate stack data
+ * leaking into forked child processes.
+ */
+extern void __arch_chacha20_blocks_nostack(u8 *dst_bytes, const u32 *key, u32 *counter, size_t nblocks);
+
+#endif /* !__ASSEMBLY__ */
+
+#endif /* __ASM_VDSO_GETRANDOM_H */
diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso/vsyscall.h
index be199a9b2676..71c56586a22f 100644
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -11,6 +11,8 @@
 #include <asm/vvar.h>
 
 DEFINE_VVAR(struct vdso_data, _vdso_data);
+DEFINE_VVAR_SINGLE(struct vdso_rng_data, _vdso_rng_data);
+
 /*
  * Update the vDSO data page to keep in sync with kernel timekeeping.
  */
diff --git a/arch/x86/include/asm/vvar.h b/arch/x86/include/asm/vvar.h
index 183e98e49ab9..9d9af37f7cab 100644
--- a/arch/x86/include/asm/vvar.h
+++ b/arch/x86/include/asm/vvar.h
@@ -26,6 +26,8 @@
  */
 #define DECLARE_VVAR(offset, type, name) \
 	EMIT_VVAR(name, offset)
+#define DECLARE_VVAR_SINGLE(offset, type, name) \
+	EMIT_VVAR(name, offset)
 
 #else
 
@@ -37,6 +39,10 @@ extern char __vvar_page;
 	extern type timens_ ## name[CS_BASES]				\
 	__attribute__((visibility("hidden")));				\
 
+#define DECLARE_VVAR_SINGLE(offset, type, name)				\
+	extern type vvar_ ## name					\
+	__attribute__((visibility("hidden")));				\
+
 #define VVAR(name) (vvar_ ## name)
 #define TIMENS(name) (timens_ ## name)
 
@@ -44,12 +50,22 @@ extern char __vvar_page;
 	type name[CS_BASES]						\
 	__attribute__((section(".vvar_" #name), aligned(16))) __visible
 
+#define DEFINE_VVAR_SINGLE(type, name)					\
+	type name							\
+	__attribute__((section(".vvar_" #name), aligned(16))) __visible
+
 #endif
 
 /* DECLARE_VVAR(offset, type, name) */
 
 DECLARE_VVAR(128, struct vdso_data, _vdso_data)
 
+#if !defined(_SINGLE_DATA)
+#define _SINGLE_DATA
+DECLARE_VVAR_SINGLE(640, struct vdso_rng_data, _vdso_rng_data)
+#endif
+
 #undef DECLARE_VVAR
+#undef DECLARE_VVAR_SINGLE
 
 #endif
-- 
2.45.2


