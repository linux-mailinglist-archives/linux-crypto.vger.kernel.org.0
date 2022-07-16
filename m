Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBE6576C25
	for <lists+linux-crypto@lfdr.de>; Sat, 16 Jul 2022 08:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbiGPGRP (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 16 Jul 2022 02:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiGPGRL (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 16 Jul 2022 02:17:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D09CC88CCD;
        Fri, 15 Jul 2022 23:16:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7BE86B82F4F;
        Sat, 16 Jul 2022 06:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCAFC34114;
        Sat, 16 Jul 2022 06:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657952201;
        bh=/KQWkrHacvnWTna1+IOR6Oz3wYOUedRH9mzR9HEOWO4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DjRkuTwfFlePZD9Cw5urUO0rRkLX+7phebp1hIj6irmbQ/FWiG+EXnyFuX9dZuYKi
         5S2AlpxLGivZEjVJf0jp+ZhrwNJFTbNxinRc8oz/XKQL6I8n58OrUxqb+bSl3RsLev
         t6rvsN1y5Tf+mX5hiyQcKiT6y9PwJNq7G9t9yWTBExsoKWKacEJ8zuhJyunBc3bmoz
         v7xxHsHwgI4fAQRTYdpa5//Fx1d+kAfH+mPoTKRgevVkaxMVgMFukCbbksHMU2alCs
         Ugx+5sUqZfd8aE5rznU1DiFGlrGLxm+LwAEjANIR7DYid3/u8rChX3mo/b2ug66sqQ
         v2Sk5b99Z7BUA==
Date:   Fri, 15 Jul 2022 23:16:39 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] crypto: testmgr - populate RSA CRT parameters in RSA
 test vectors
Message-ID: <YtJXx3B0glwAxa2F@sol.localdomain>
References: <20220704103840.924-1-ignat@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220704103840.924-1-ignat@cloudflare.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Ignat,

On Mon, Jul 04, 2022 at 11:38:40AM +0100, Ignat Korchagin wrote:
> Changes from v1:
>   * replace some accidental spaces with tabs
> 
> In commit f145d411a67e ("crypto: rsa - implement Chinese Remainder Theorem
> for faster private key operations") we have started to use the additional
> primes and coefficients for RSA private key operations. However, these
> additional parameters are not present (defined as 0 integers) in the RSA
> test vectors.
> 
> Some parameters were borrowed from OpenSSL, so I was able to find the
> source. I could not find the public source for 1 vector though, so had to
> recover the parameters by implementing Appendix C from [1].
> 
> [1]: https://nvlpubs.nist.gov/nistpubs/SpecialPublications/NIST.SP.800-56Br1.pdf
> 
> Fixes: f145d411a67e ("crypto: rsa - implement Chinese Remainder Theorem for faster private key operations")
> Reported-by: Tasmiya Nalatwad <tasmiya@linux.vnet.ibm.com>
> Signed-off-by: Ignat Korchagin <ignat@cloudflare.com>

The rsa-generic self-tests are still failing even after this commit.
Additionally, there is now a KASAN out-of-bounds warning:

[    3.199954] ==================================================================
[    3.199961] BUG: KASAN: global-out-of-bounds in test_akcipher_one (crypto/testmgr.c:3996) 
[    3.199972] Read of size 607 at addr ffffffff82fae860 by task cryptomgr_test/352
[    3.199977]
[    3.199985] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ArchLinux 1.16.0-1 04/01/2014
[    3.199989] Call Trace:
[    3.199990]  <TASK>
[    3.199993] show_stack (arch/x86/kernel/dumpstack.c:313) 
[    3.199999] dump_stack_lvl (lib/dump_stack.c:107 (discriminator 4)) 
[    3.200004] print_address_description.constprop.0 (mm/kasan/report.c:314) 
[    3.200010] print_report.cold (mm/kasan/report.c:430) 
[    3.200015] ? test_akcipher_one (crypto/testmgr.c:3996) 
[    3.200019] kasan_report (mm/kasan/report.c:162 mm/kasan/report.c:493) 
[    3.200022] ? test_akcipher_one (crypto/testmgr.c:3996) 
[    3.200026] kasan_check_range (mm/kasan/generic.c:190) 
[    3.200030] memcpy (mm/kasan/shadow.c:65) 
[    3.200033] test_akcipher_one (crypto/testmgr.c:3996) 
[    3.200038] ? test_shash_vec_cfg (crypto/testmgr.c:3968) 
[    3.200043] ? crypto_create_tfm_node (crypto/api.c:501) 
[    3.200049] ? crypto_alloc_tfm_node (crypto/api.c:589) 
[    3.200053] alg_test_akcipher (crypto/testmgr.c:4158 crypto/testmgr.c:4181) 
[    3.200057] alg_test (crypto/testmgr.c:5790) 
[    3.200061] ? __lock_release.isra.0 (kernel/locking/lockdep.c:5341) 
[    3.200067] ? alg_test_crc32c (crypto/testmgr.c:5745) 
[    3.200071] ? lock_is_held_type (kernel/locking/lockdep.c:466 kernel/locking/lockdep.c:5709) 
[    3.200075] ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/irqflags.h:45 ./arch/x86/include/asm/irqflags.h:80 ./arch/x86/include/asm/irqflags.h:138 ./include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[    3.200080] ? __kthread_parkme (./include/linux/instrumented.h:71 (discriminator 4) ./include/asm-generic/bitops/instrumented-non-atomic.h:134 (discriminator 4) kernel/kthread.c:270 (discriminator 4)) 
[    3.200084] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[    3.200089] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4383) 
[    3.200093] ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/irqflags.h:45 ./arch/x86/include/asm/irqflags.h:80 ./arch/x86/include/asm/irqflags.h:138 ./include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[    3.200097] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:51 (discriminator 22)) 
[    3.200102] ? __kasan_check_read (mm/kasan/shadow.c:32) 
[    3.200106] ? __kthread_parkme (./arch/x86/include/asm/bitops.h:207 (discriminator 4) ./include/asm-generic/bitops/instrumented-non-atomic.h:135 (discriminator 4) kernel/kthread.c:270 (discriminator 4)) 
[    3.200109] ? crypto_unregister_scomps (crypto/algboss.c:177) 
[    3.200113] cryptomgr_test (crypto/algboss.c:187) 
[    3.200117] kthread (kernel/kthread.c:376) 
[    3.200120] ? kthread_exit (kernel/kthread.c:335) 
[    3.200123] ret_from_fork (arch/x86/entry/entry_64.S:308) 
[    3.200128]  </TASK>
[    3.200130]
[    3.200131] The buggy address belongs to the variable:
[    3.200132] ecdsa_nist_p192_tv_template+0x360/0x1a20 
[    3.200137]
[    3.200138] Memory state around the buggy address:
[    3.200140]  ffffffff82fae900: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.200143]  ffffffff82fae980: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[    3.200146] >ffffffff82faea00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 07
[    3.200147]                                                                 ^
[    3.200150]  ffffffff82faea80: f9 f9 f9 f9 00 00 00 00 00 00 00 00 02 f9 f9 f9
[    3.200152]  ffffffff82faeb00: f9 f9 f9 f9 00 00 00 00 00 00 00 00 00 00 00 00
[    3.200154] ==================================================================
[    3.200155] Disabling lock debugging due to kernel taint
[    3.200190] alg: akcipher: test 2 failed for rsa-generic, err=-74
[    3.200194] ------------[ cut here ]------------
[    3.200196] alg: self-tests for rsa-generic (rsa) failed (rc=-74)
[    3.200220] WARNING: CPU: 2 PID: 352 at crypto/testmgr.c:5804 alg_test (crypto/testmgr.c:5804 (discriminator 1)) 
[    3.246192] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS ArchLinux 1.16.0-1 04/01/2014
[    3.247679] RIP: 0010:alg_test (crypto/testmgr.c:5804 (discriminator 1)) 
[ 3.248367] Code: 0f 85 e7 f8 d0 00 48 8b 95 c8 fe ff ff 44 89 c1 48 c7 c7 a0 a8 f4 82 44 89 85 c4 fe ff ff 48 8b b5 d0 fe ff ff e8 f

Code starting with the faulting instruction
===========================================
   0:	0f 85 e7 f8 d0 00    	jne    0xd0f8ed
   6:	48 8b 95 c8 fe ff ff 	mov    -0x138(%rbp),%rdx
   d:	44 89 c1             	mov    %r8d,%ecx
  10:	48 c7 c7 a0 a8 f4 82 	mov    $0xffffffff82f4a8a0,%rdi
  17:	44 89 85 c4 fe ff ff 	mov    %r8d,-0x13c(%rbp)
  1e:	48 8b b5 d0 fe ff ff 	mov    -0x130(%rbp),%rsi
  25:	e8                   	.byte 0xe8
  26:	0f                   	.byte 0xf
[    3.251371] RSP: 0018:ffffc900023afd90 EFLAGS: 00010286
[    3.252226] RAX: 0000000000000000 RBX: 1ffff92000475fb9 RCX: 0000000000000000
[    3.253380] RDX: 0000000000000001 RSI: 0000000000000004 RDI: fffff52000475fa2
[    3.254552] RBP: ffffc900023afef0 R08: 0000000000000001 R09: ffff88806d5275cb
[    3.255718] R10: ffffed100daa4eb9 R11: 000000000000000a R12: 00000000000000b8
[    3.256871] R13: 00000000000000b9 R14: 00000000000000b8 R15: 00000000000000b9
[    3.258042] FS:  0000000000000000(0000) GS:ffff88806d500000(0000) knlGS:0000000000000000
[    3.259350] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.260272] CR2: 0000000000000000 CR3: 0000000003415000 CR4: 00000000003506e0
[    3.261448] Call Trace:
[    3.261869]  <TASK>
[    3.262220] ? __lock_release.isra.0 (kernel/locking/lockdep.c:5341) 
[    3.262966] ? alg_test_crc32c (crypto/testmgr.c:5745) 
[    3.263628] ? lock_is_held_type (kernel/locking/lockdep.c:466 kernel/locking/lockdep.c:5709) 
[    3.264340] ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/irqflags.h:45 ./arch/x86/include/asm/irqflags.h:80 ./arch/x86/include/asm/irqflags.h:138 ./include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[    3.265151] ? __kthread_parkme (./include/linux/instrumented.h:71 (discriminator 4) ./include/asm-generic/bitops/instrumented-non-atomic.h:134 (discriminator 4) kernel/kthread.c:270 (discriminator 4)) 
[    3.265823] ? __this_cpu_preempt_check (lib/smp_processor_id.c:67) 
[    3.266578] ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4383) 
[    3.267301] ? _raw_spin_unlock_irqrestore (./arch/x86/include/asm/irqflags.h:45 ./arch/x86/include/asm/irqflags.h:80 ./arch/x86/include/asm/irqflags.h:138 ./include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[    3.268103] ? trace_hardirqs_on (kernel/trace/trace_preemptirq.c:51 (discriminator 22)) 
[    3.268782] ? __kasan_check_read (mm/kasan/shadow.c:32) 
[    3.269468] ? __kthread_parkme (./arch/x86/include/asm/bitops.h:207 (discriminator 4) ./include/asm-generic/bitops/instrumented-non-atomic.h:135 (discriminator 4) kernel/kthread.c:270 (discriminator 4)) 
[    3.270142] ? crypto_unregister_scomps (crypto/algboss.c:177) 
[    3.270954] cryptomgr_test (crypto/algboss.c:187) 
[    3.270961] kthread (kernel/kthread.c:376) 
[    3.270967] ? kthread_exit (kernel/kthread.c:335) 
[    3.270971] ret_from_fork (arch/x86/entry/entry_64.S:308) 
[    3.270976]  </TASK>
[    3.270978] irq event stamp: 265
[    3.270980] hardirqs last enabled at (265): _raw_spin_unlock_irqrestore (./arch/x86/include/asm/irqflags.h:45 ./arch/x86/include/asm/irqflags.h:80 ./arch/x86/include/asm/irqflags.h:138 ./include/linux/spinlock_api_smp.h:151 kernel/locking/spinlock.c:194) 
[    3.270987] hardirqs last disabled at (264): _raw_spin_lock_irqsave (./include/linux/spinlock_api_smp.h:108 kernel/locking/spinlock.c:162) 
[    3.270992] softirqs last enabled at (0): copy_process (kernel/fork.c:2186) 
[    3.270999] softirqs last disabled at (0): 0x0 
[    3.271002] ---[ end trace 0000000000000000 ]---
