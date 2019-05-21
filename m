Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38CA924689
	for <lists+linux-crypto@lfdr.de>; Tue, 21 May 2019 06:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbfEUEGj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 21 May 2019 00:06:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:37120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbfEUEGj (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 21 May 2019 00:06:39 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7C7E21479;
        Tue, 21 May 2019 04:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558411598;
        bh=MwT+uj102zYIvEu/km2Y/ltne0ORIYtcONb95DMP6ro=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M/7MObPZJnXHl/ALmSGpNkwocP0Duf1U7wMIaTM9cLgolEoHIs7xH8zlT0OWqwSWY
         jAFMl22PxBd5i7Fqcs4ieUjyz5h/CgzPasz8NMpawsmsx68farlm/n2t7O6FvIu4Wi
         T7mke12Yh91a5iLvGnlXxTH42lIXQG7oOqeAhY/U=
Date:   Mon, 20 May 2019 21:06:36 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Thomas Garnier <thgarnie@chromium.org>
Cc:     kernel-hardening@lists.openwall.com, kristen@linux.intel.com,
        Thomas Garnier <thgarnie@google.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 01/12] x86/crypto: Adapt assembly for PIE support
Message-ID: <20190521040634.GA32379@sol.localdomain>
References: <20190520231948.49693-1-thgarnie@chromium.org>
 <20190520231948.49693-2-thgarnie@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520231948.49693-2-thgarnie@chromium.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, May 20, 2019 at 04:19:26PM -0700, Thomas Garnier wrote:
> diff --git a/arch/x86/crypto/sha256-avx2-asm.S b/arch/x86/crypto/sha256-avx2-asm.S
> index 1420db15dcdd..2ced4b2f6c76 100644
> --- a/arch/x86/crypto/sha256-avx2-asm.S
> +++ b/arch/x86/crypto/sha256-avx2-asm.S
> @@ -588,37 +588,42 @@ last_block_enter:
>  	mov	INP, _INP(%rsp)
>  
>  	## schedule 48 input dwords, by doing 3 rounds of 12 each
> -	xor	SRND, SRND
> +	leaq	K256(%rip), SRND
> +	## loop1 upper bound
> +	leaq	K256+3*4*32(%rip), INP
>  
>  .align 16
>  loop1:
> -	vpaddd	K256+0*32(SRND), X0, XFER
> +	vpaddd	0*32(SRND), X0, XFER
>  	vmovdqa XFER, 0*32+_XFER(%rsp, SRND)
>  	FOUR_ROUNDS_AND_SCHED	_XFER + 0*32
>  
> -	vpaddd	K256+1*32(SRND), X0, XFER
> +	vpaddd	1*32(SRND), X0, XFER
>  	vmovdqa XFER, 1*32+_XFER(%rsp, SRND)
>  	FOUR_ROUNDS_AND_SCHED	_XFER + 1*32
>  
> -	vpaddd	K256+2*32(SRND), X0, XFER
> +	vpaddd	2*32(SRND), X0, XFER
>  	vmovdqa XFER, 2*32+_XFER(%rsp, SRND)
>  	FOUR_ROUNDS_AND_SCHED	_XFER + 2*32
>  
> -	vpaddd	K256+3*32(SRND), X0, XFER
> +	vpaddd	3*32(SRND), X0, XFER
>  	vmovdqa XFER, 3*32+_XFER(%rsp, SRND)
>  	FOUR_ROUNDS_AND_SCHED	_XFER + 3*32
>  
>  	add	$4*32, SRND
> -	cmp	$3*4*32, SRND
> +	cmp	INP, SRND
>  	jb	loop1
>  
> +	## loop2 upper bound
> +	leaq	K256+4*4*32(%rip), INP
> +
>  loop2:
>  	## Do last 16 rounds with no scheduling
> -	vpaddd	K256+0*32(SRND), X0, XFER
> +	vpaddd	0*32(SRND), X0, XFER
>  	vmovdqa XFER, 0*32+_XFER(%rsp, SRND)
>  	DO_4ROUNDS	_XFER + 0*32
>  
> -	vpaddd	K256+1*32(SRND), X1, XFER
> +	vpaddd	1*32(SRND), X1, XFER
>  	vmovdqa XFER, 1*32+_XFER(%rsp, SRND)
>  	DO_4ROUNDS	_XFER + 1*32
>  	add	$2*32, SRND
> @@ -626,7 +631,7 @@ loop2:
>  	vmovdqa	X2, X0
>  	vmovdqa	X3, X1
>  
> -	cmp	$4*4*32, SRND
> +	cmp	INP, SRND
>  	jb	loop2
>  
>  	mov	_CTX(%rsp), CTX

There is a crash in sha256-avx2-asm.S with this patch applied.  Looks like the
%rsi register is being used for two different things at the same time: 'INP' and
'y3'?  You should be able to reproduce by booting a kernel configured with:

	CONFIG_CRYPTO_SHA256_SSSE3=y
	# CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set

Crash report:

BUG: unable to handle page fault for address: ffffc8ff83b21a80
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 0 P4D 0 
Oops: 0002 [#1] SMP
CPU: 3 PID: 359 Comm: cryptomgr_test Not tainted 5.2.0-rc1-00109-g9fb4fd100429b #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-20181126_142135-anatol 04/01/2014
RIP: 0010:loop1+0x4/0x888
Code: 83 c6 40 48 89 b4 24 08 02 00 00 48 8d 3d 94 d3 d0 00 48 8d 35 0d d5 d0 00 66 66 2e 0f 1f 84 00 00 00 00 00 66 90 c
RSP: 0018:ffffc90001d43880 EFLAGS: 00010286
RAX: 000000006a09e667 RBX: 00000000bb67ae85 RCX: 000000003c6ef372
RDX: 00000000510e527f RSI: ffffffff81dde380 RDI: ffffffff81dde200
RBP: ffffc90001d43b10 R08: 00000000a54ff53a R09: 000000009b05688c
R10: 000000001f83d9ab R11: 000000005be0cd19 R12: 0000000000000000
R13: ffff88807cfd4598 R14: ffffffff810d0da0 R15: ffffc90001d43cc0
FS:  0000000000000000(0000) GS:ffff88807fd80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc8ff83b21a80 CR3: 000000000200f000 CR4: 00000000003406e0
Call Trace:
 sha256_avx2_finup arch/x86/crypto/sha256_ssse3_glue.c:242 [inline]
 sha256_avx2_final+0x17/0x20 arch/x86/crypto/sha256_ssse3_glue.c:247
 crypto_shash_final+0x13/0x20 crypto/shash.c:166
 shash_async_final+0x11/0x20 crypto/shash.c:265
 crypto_ahash_op+0x24/0x60 crypto/ahash.c:373
 crypto_ahash_final+0x11/0x20 crypto/ahash.c:384
 do_ahash_op.constprop.13+0x10/0x40 crypto/testmgr.c:1049
 test_hash_vec_cfg+0x5b1/0x610 crypto/testmgr.c:1225
 test_hash_vec crypto/testmgr.c:1268 [inline]
 __alg_test_hash.isra.8+0x115/0x1d0 crypto/testmgr.c:1498
 alg_test_hash+0x7b/0x100 crypto/testmgr.c:1546
 alg_test.part.12+0xa4/0x360 crypto/testmgr.c:4931
 alg_test+0x12/0x30 crypto/testmgr.c:4895
 cryptomgr_test+0x26/0x50 crypto/algboss.c:223
 kthread+0x124/0x140 kernel/kthread.c:254
 ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
Modules linked in:
CR2: ffffc8ff83b21a80
---[ end trace ee8ece604888de3e ]---

- Eric
