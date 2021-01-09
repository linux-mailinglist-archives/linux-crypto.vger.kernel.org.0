Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C08B52F0222
	for <lists+linux-crypto@lfdr.de>; Sat,  9 Jan 2021 18:15:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725978AbhAIRPZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 9 Jan 2021 12:15:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:39132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725966AbhAIRPZ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 9 Jan 2021 12:15:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA618236FB;
        Sat,  9 Jan 2021 17:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610212483;
        bh=uTdeVlBgZ5aA+Q3knNl7JhR+crPYN5ZuswrxH+1Mxjg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m01AKH0nqAYsFaRirjgaKkD/GKEMvPaTlpwdvFCGBkySc23ylEwBr3hjmRGN3Dzvv
         ZmXdA0cvhpvKKtwPqiSZTyKbwOFAg9Z+N2CL5j2U4IBaCj0x15eAnQ9fEJnh1uM9Ps
         hBlue473g5zmerGn7KLusXALBFZJwZ3Gvvt6R9zEiMTPFMlvcVtkLh6oyVXlmzEVzb
         Gs262LXUiY0Znyp8VDdq/ZddqX4F7v/AYIjOhLhyeoiAOwy2H11fyitY2b+c5jAJJv
         NQ15YZ5DC9eMMh+pZmXjIEdQkkXmbPEpnED+n++cDWlz21jf0GYrHvwDN+MXAH0FrI
         h3h49PWOLi+Lg==
Date:   Sat, 9 Jan 2021 09:14:41 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     syzbot <syzbot+e0f501056b282add58a6@syzkaller.appspotmail.com>,
        davem@davemloft.net, glider@google.com,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KMSAN: uninit-value in __crypto_memneq (2)
Message-ID: <X/nkga4iirR8QKP2@sol.localdomain>
References: <00000000000079365f05b877530b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000079365f05b877530b@google.com>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

+Jason, since this looks WireGuard-related.

On Sat, Jan 09, 2021 at 05:05:24AM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    73d62e81 kmsan: random: prevent boot-time reports in _mix_..
> git tree:       https://github.com/google/kmsan.git master
> console output: https://syzkaller.appspot.com/x/log.txt?x=142ab9c0d00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2cdf4151c9653e32
> dashboard link: https://syzkaller.appspot.com/bug?extid=e0f501056b282add58a6
> compiler:       clang version 11.0.0 (https://github.com/llvm/llvm-project.git ca2dcbd030eadbf0aa9b660efe864ff08af6e18b)
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+e0f501056b282add58a6@syzkaller.appspotmail.com
> 
> =====================================================
> BUG: KMSAN: uninit-value in __crypto_memneq_16 crypto/memneq.c:99 [inline]
> BUG: KMSAN: uninit-value in __crypto_memneq+0x42c/0x470 crypto/memneq.c:161
> CPU: 0 PID: 20526 Comm: kworker/0:3 Not tainted 5.10.0-rc4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: wg-crypt-wg1 wg_packet_decrypt_worker
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x21c/0x280 lib/dump_stack.c:118
>  kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
>  __msan_warning+0x5f/0xa0 mm/kmsan/kmsan_instr.c:197
>  __crypto_memneq_16 crypto/memneq.c:99 [inline]
>  __crypto_memneq+0x42c/0x470 crypto/memneq.c:161
>  crypto_memneq include/crypto/algapi.h:277 [inline]
>  chacha20poly1305_crypt_sg_inplace+0x1662/0x1cd0 lib/crypto/chacha20poly1305.c:311
>  chacha20poly1305_decrypt_sg_inplace+0x179/0x1d0 lib/crypto/chacha20poly1305.c:351
>  decrypt_packet drivers/net/wireguard/receive.c:284 [inline]
>  wg_packet_decrypt_worker+0x9cf/0x17d0 drivers/net/wireguard/receive.c:509
>  process_one_work+0x121c/0x1fc0 kernel/workqueue.c:2272
>  worker_thread+0x10cc/0x2740 kernel/workqueue.c:2418
>  kthread+0x51c/0x560 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
> 
> Uninit was stored to memory at:
>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
>  kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:289
>  __msan_chain_origin+0x57/0xa0 mm/kmsan/kmsan_instr.c:147
>  put_unaligned_le64 include/linux/unaligned/access_ok.h:50 [inline]
>  poly1305_core_emit+0x625/0x6a0 lib/crypto/poly1305-donna64.c:182
>  poly1305_final_generic+0xe2/0x280 lib/crypto/poly1305.c:71
>  poly1305_final include/crypto/poly1305.h:94 [inline]
>  chacha20poly1305_crypt_sg_inplace+0x15cf/0x1cd0 lib/crypto/chacha20poly1305.c:310
>  chacha20poly1305_decrypt_sg_inplace+0x179/0x1d0 lib/crypto/chacha20poly1305.c:351
>  decrypt_packet drivers/net/wireguard/receive.c:284 [inline]
>  wg_packet_decrypt_worker+0x9cf/0x17d0 drivers/net/wireguard/receive.c:509
>  process_one_work+0x121c/0x1fc0 kernel/workqueue.c:2272
>  worker_thread+0x10cc/0x2740 kernel/workqueue.c:2418
>  kthread+0x51c/0x560 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
> 
> Uninit was stored to memory at:
>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
>  kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:289
>  __msan_chain_origin+0x57/0xa0 mm/kmsan/kmsan_instr.c:147
>  poly1305_core_blocks+0x8f4/0x940 lib/crypto/poly1305-donna64.c:107
>  poly1305_update_generic+0x1a7/0x5a0 lib/crypto/poly1305.c:49
>  poly1305_update include/crypto/poly1305.h:83 [inline]
>  chacha20poly1305_crypt_sg_inplace+0x1496/0x1cd0 lib/crypto/chacha20poly1305.c:302
>  chacha20poly1305_decrypt_sg_inplace+0x179/0x1d0 lib/crypto/chacha20poly1305.c:351
>  decrypt_packet drivers/net/wireguard/receive.c:284 [inline]
>  wg_packet_decrypt_worker+0x9cf/0x17d0 drivers/net/wireguard/receive.c:509
>  process_one_work+0x121c/0x1fc0 kernel/workqueue.c:2272
>  worker_thread+0x10cc/0x2740 kernel/workqueue.c:2418
>  kthread+0x51c/0x560 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
> 
> Uninit was stored to memory at:
>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
>  kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:289
>  __msan_chain_origin+0x57/0xa0 mm/kmsan/kmsan_instr.c:147
>  poly1305_core_blocks+0x8f4/0x940 lib/crypto/poly1305-donna64.c:107
>  poly1305_update_generic+0x1a7/0x5a0 lib/crypto/poly1305.c:49
>  poly1305_update include/crypto/poly1305.h:83 [inline]
>  chacha20poly1305_crypt_sg_inplace+0xb4d/0x1cd0 lib/crypto/chacha20poly1305.c:263
>  chacha20poly1305_decrypt_sg_inplace+0x179/0x1d0 lib/crypto/chacha20poly1305.c:351
>  decrypt_packet drivers/net/wireguard/receive.c:284 [inline]
>  wg_packet_decrypt_worker+0x9cf/0x17d0 drivers/net/wireguard/receive.c:509
>  process_one_work+0x121c/0x1fc0 kernel/workqueue.c:2272
>  worker_thread+0x10cc/0x2740 kernel/workqueue.c:2418
>  kthread+0x51c/0x560 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
> 
> Uninit was stored to memory at:
>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
>  kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:289
>  __msan_chain_origin+0x57/0xa0 mm/kmsan/kmsan_instr.c:147
>  crypto_xor_cpy include/crypto/algapi.h:167 [inline]
>  chacha_crypt_generic+0x696/0x880 lib/crypto/libchacha.c:23
>  chacha_crypt include/crypto/chacha.h:90 [inline]
>  chacha20_crypt include/crypto/chacha.h:96 [inline]
>  chacha20poly1305_crypt_sg_inplace+0xda2/0x1cd0 lib/crypto/chacha20poly1305.c:280
>  chacha20poly1305_encrypt_sg_inplace+0x125/0x140 lib/crypto/chacha20poly1305.c:338
>  encrypt_packet drivers/net/wireguard/send.c:216 [inline]
>  wg_packet_encrypt_worker+0x1288/0x2680 drivers/net/wireguard/send.c:301
>  process_one_work+0x121c/0x1fc0 kernel/workqueue.c:2272
>  worker_thread+0x10cc/0x2740 kernel/workqueue.c:2418
>  kthread+0x51c/0x560 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
> 
> Uninit was stored to memory at:
>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
>  kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:289
>  kmsan_memcpy_memmove_metadata+0x25e/0x2d0 mm/kmsan/kmsan.c:226
>  kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:246
>  __msan_memcpy+0x46/0x60 mm/kmsan/kmsan_instr.c:110
>  pskb_expand_head+0x3eb/0x1df0 net/core/skbuff.c:1631
>  __skb_cow include/linux/skbuff.h:3165 [inline]
>  skb_cow_head include/linux/skbuff.h:3199 [inline]
>  geneve_build_skb+0x56e/0xf80 drivers/net/geneve.c:753
>  geneve6_xmit_skb drivers/net/geneve.c:1023 [inline]
>  geneve_xmit+0x2d86/0x3cc0 drivers/net/geneve.c:1056
>  __netdev_start_xmit include/linux/netdevice.h:4718 [inline]
>  netdev_start_xmit include/linux/netdevice.h:4732 [inline]
>  xmit_one+0x2b9/0x770 net/core/dev.c:3564
>  dev_hard_start_xmit net/core/dev.c:3580 [inline]
>  __dev_queue_xmit+0x33f2/0x4520 net/core/dev.c:4140
>  dev_queue_xmit+0x4b/0x60 net/core/dev.c:4173
>  batadv_send_skb_packet+0x622/0x970 net/batman-adv/send.c:108
>  batadv_send_broadcast_skb+0x76/0x90 net/batman-adv/send.c:127
>  batadv_iv_ogm_send_to_if net/batman-adv/bat_iv_ogm.c:394 [inline]
>  batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:420 [inline]
>  batadv_iv_send_outstanding_bat_ogm_packet+0xb3a/0xf00 net/batman-adv/bat_iv_ogm.c:1712
>  process_one_work+0x121c/0x1fc0 kernel/workqueue.c:2272
>  worker_thread+0x10cc/0x2740 kernel/workqueue.c:2418
>  kthread+0x51c/0x560 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
> 
> Uninit was stored to memory at:
>  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:121 [inline]
>  kmsan_internal_chain_origin+0xad/0x130 mm/kmsan/kmsan.c:289
>  kmsan_memcpy_memmove_metadata+0x25e/0x2d0 mm/kmsan/kmsan.c:226
>  kmsan_memcpy_metadata+0xb/0x10 mm/kmsan/kmsan.c:246
>  __msan_memcpy+0x46/0x60 mm/kmsan/kmsan_instr.c:110
>  pskb_expand_head+0x3eb/0x1df0 net/core/skbuff.c:1631
>  __skb_cow include/linux/skbuff.h:3165 [inline]
>  skb_cow_head include/linux/skbuff.h:3199 [inline]
>  batadv_skb_head_push+0x2ce/0x410 net/batman-adv/soft-interface.c:75
>  batadv_send_skb_packet+0x1ed/0x970 net/batman-adv/send.c:86
>  batadv_send_broadcast_skb+0x76/0x90 net/batman-adv/send.c:127
>  batadv_iv_ogm_send_to_if net/batman-adv/bat_iv_ogm.c:394 [inline]
>  batadv_iv_ogm_emit net/batman-adv/bat_iv_ogm.c:420 [inline]
>  batadv_iv_send_outstanding_bat_ogm_packet+0xb3a/0xf00 net/batman-adv/bat_iv_ogm.c:1712
>  process_one_work+0x121c/0x1fc0 kernel/workqueue.c:2272
>  worker_thread+0x10cc/0x2740 kernel/workqueue.c:2418
>  kthread+0x51c/0x560 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
> 
> Uninit was created at:
>  kmsan_save_stack_with_flags+0x3c/0x90 mm/kmsan/kmsan.c:121
>  kmsan_alloc_page+0xd3/0x1f0 mm/kmsan/kmsan_shadow.c:274
>  __alloc_pages_nodemask+0x84e/0xfb0 mm/page_alloc.c:4989
>  __alloc_pages include/linux/gfp.h:511 [inline]
>  __alloc_pages_node include/linux/gfp.h:524 [inline]
>  alloc_pages_node include/linux/gfp.h:538 [inline]
>  __page_frag_cache_refill mm/page_alloc.c:5065 [inline]
>  page_frag_alloc+0x35b/0x890 mm/page_alloc.c:5095
>  __netdev_alloc_skb+0xbee/0xc50 net/core/skbuff.c:456
>  __netdev_alloc_skb_ip_align include/linux/skbuff.h:2846 [inline]
>  netdev_alloc_skb_ip_align include/linux/skbuff.h:2856 [inline]
>  batadv_iv_ogm_aggregate_new net/batman-adv/bat_iv_ogm.c:559 [inline]
>  batadv_iv_ogm_queue_add+0x143f/0x1cf0 net/batman-adv/bat_iv_ogm.c:671
>  batadv_iv_ogm_schedule_buff net/batman-adv/bat_iv_ogm.c:834 [inline]
>  batadv_iv_ogm_schedule+0xe4e/0x1670 net/batman-adv/bat_iv_ogm.c:870
>  batadv_iv_send_outstanding_bat_ogm_packet+0xd7b/0xf00 net/batman-adv/bat_iv_ogm.c:1724
>  process_one_work+0x121c/0x1fc0 kernel/workqueue.c:2272
>  worker_thread+0x10cc/0x2740 kernel/workqueue.c:2418
>  kthread+0x51c/0x560 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
> =====================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
