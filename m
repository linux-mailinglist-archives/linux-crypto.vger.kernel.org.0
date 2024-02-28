Return-Path: <linux-crypto+bounces-2353-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0379686AAFB
	for <lists+linux-crypto@lfdr.de>; Wed, 28 Feb 2024 10:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2764A1C21003
	for <lists+linux-crypto@lfdr.de>; Wed, 28 Feb 2024 09:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4F73613E;
	Wed, 28 Feb 2024 09:11:27 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC8135F0C
	for <linux-crypto@vger.kernel.org>; Wed, 28 Feb 2024 09:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709111486; cv=none; b=C4YgKDaGWIxkzvkCB2xSnhA39UbDOg5m/52m0UOr+J3nkvO6IaDSYnG9RBRP9Oe7Wry6gjBgX/GUtO5zw9bH8ird5nIPTD0ld2cU+mnj7fbi9FRsVpkfLBleMFP47xJKbLaQt6WUUVIzwjDB5FF/1O985eFwcXPdJJd3J/XjqzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709111486; c=relaxed/simple;
	bh=xcDwdYJJEp4r8TyMu3Pnz31DA/3vScwJmSDRVQqQOnE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cFaOIiP9VOXeQuXBXFcHTYVWT2gg5iqLA4Ex1McYqOQ7qT7v99j7K/IGoEfWsUc4Lv+o4JzLW2Q1kyJ/tEhF3gJnZou0TB2P3Vy0pI7P63zZX9bjPX6xo9ibQl8JbZDpQD5kQUI3mQNGHhVxWwojVdEhtMyXSatYndMqGto07BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36512fcf643so35892885ab.1
        for <linux-crypto@vger.kernel.org>; Wed, 28 Feb 2024 01:11:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709111484; x=1709716284;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=svxANPvdpBkHU10Jag5NGwbnAk4hftSRF9sS1Y74Ads=;
        b=XOwWEqptiJD6ZN13PT/X6DAHbKAwlnJZz8/dR+VRE34ER9JVfbSq0iaPtvrUpnroH9
         bh51W9xxWc+gElocHZ69x8NrWmVV9ngSgnOEDn4oxNeNI7CV2sTgdEZTCja3d8Lkd5Vi
         hTXWtrqBslW0Z/ZYS1JdkqFHpM4mhJvsPI1OTVbvQU+kczDENeYiBaom+gd4zldxHTIy
         fNfz6kRhvy7f/EQn6yTZxTwrGbgqyUuaZB0EyEUkzGw2ALBs0cDd/jzY0uiDrAjdacDC
         t6xGpAGEjbRXm/XDMogFxZTPfqlcPFFReYRRdBYinSAN45C0J7ruR83YBbFSKCvs7eHP
         eZCg==
X-Forwarded-Encrypted: i=1; AJvYcCUtjxAWTSWJtD74BsvGC9+ZywsiYkL5I20qTv1qBN+JDKjRkx9k3Y5bA68M8ezGeMDvzDcK/3eo4Wgop4r+DT3zKEAC/AfuexZC29rT
X-Gm-Message-State: AOJu0YwHRsSESrV8oDx4v8kBxoEr9Siy/QKdHyuywTT8MUoYFqCwOtjc
	OANSnQiS/ArQZApRtS1l/OqL8kamxFqPbYTWZ1LOxd17HpJOPDJizQ6DDPR6C8DjlBe4zKqsC8S
	SADvhViN49rUVr4hQCz/7R18yvg8/qMwFxxb2H5/Zl4n//HPKW7c4x7s=
X-Google-Smtp-Source: AGHT+IHO481SHBCsww3xPi/HoAb9U+9qVqG56lszqaT1GeyDeiyyy19QVC7kUER63VTlYUVsSdLWknKfkMOhnlGaA5NNyJpw3AlT
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c562:0:b0:365:22a6:596e with SMTP id
 b2-20020a92c562000000b0036522a6596emr871302ilj.6.1709111483875; Wed, 28 Feb
 2024 01:11:23 -0800 (PST)
Date: Wed, 28 Feb 2024 01:11:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e0c9f206126d869f@google.com>
Subject: [syzbot] [crypto?] KMSAN: uninit-value in aes_decrypt
From: syzbot <syzbot+b6ce97de27db385d5cd7@syzkaller.appspotmail.com>
To: davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    603c04e27c3e Merge tag 'parisc-for-6.8-rc6' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12bc1372180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b015d567058472
dashboard link: https://syzkaller.appspot.com/bug?extid=b6ce97de27db385d5cd7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6aa7d0a5141b/disk-603c04e2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2578a4f15ecb/vmlinux-603c04e2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1d54b85566c3/bzImage-603c04e2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6ce97de27db385d5cd7@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in inv_subshift lib/crypto/aes.c:158 [inline]
BUG: KMSAN: uninit-value in aes_decrypt+0x173d/0x1f20 lib/crypto/aes.c:333
 inv_subshift lib/crypto/aes.c:158 [inline]
 aes_decrypt+0x173d/0x1f20 lib/crypto/aes.c:333
 aesti_decrypt+0x7d/0xf0 crypto/aes_ti.c:47
 crypto_ecb_crypt crypto/ecb.c:23 [inline]
 crypto_ecb_decrypt2+0x18b/0x2f0 crypto/ecb.c:51
 crypto_lskcipher_crypt+0x66d/0x750 crypto/lskcipher.c:160
 crypto_lskcipher_decrypt+0x82/0xb0 crypto/lskcipher.c:194
 crypto_cbc_decrypt_inplace crypto/cbc.c:108 [inline]
 crypto_cbc_decrypt+0x4df/0x8e0 crypto/cbc.c:131
 crypto_lskcipher_crypt_sg+0x43f/0x930 crypto/lskcipher.c:229
 crypto_lskcipher_decrypt_sg+0x8a/0xc0 crypto/lskcipher.c:258
 crypto_skcipher_decrypt+0x10d/0x1c0 crypto/skcipher.c:693
 cts_cbc_decrypt+0x51b/0x720 crypto/cts.c:219
 crypto_cts_decrypt+0x77f/0x9b0 crypto/cts.c:280
 crypto_skcipher_decrypt+0x189/0x1c0 crypto/skcipher.c:695
 _skcipher_recvmsg crypto/algif_skcipher.c:199 [inline]
 skcipher_recvmsg+0x1691/0x2190 crypto/algif_skcipher.c:221
 sock_recvmsg_nosec+0x7a/0x120 net/socket.c:1046
 ____sys_recvmsg+0x664/0x7f0 net/socket.c:2801
 ___sys_recvmsg+0x223/0x840 net/socket.c:2845
 do_recvmmsg+0x627/0xfd0 net/socket.c:2931
 __sys_recvmmsg+0x10a/0x430 net/socket.c:3018
 __do_compat_sys_recvmmsg_time32 net/compat.c:418 [inline]
 __se_compat_sys_recvmmsg_time32 net/compat.c:414 [inline]
 __ia32_compat_sys_recvmmsg_time32+0xf5/0x180 net/compat.c:414
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb5/0x110 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x37/0x70 arch/x86/entry/common.c:346
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:384
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a

Uninit was stored to memory at:
 memcpy_dir crypto/scatterwalk.c:23 [inline]
 scatterwalk_copychunks crypto/scatterwalk.c:38 [inline]
 scatterwalk_map_and_copy+0x6dc/0x9a0 crypto/scatterwalk.c:67
 cts_cbc_decrypt+0x3e2/0x720 crypto/cts.c:211
 crypto_cts_decrypt+0x77f/0x9b0 crypto/cts.c:280
 crypto_skcipher_decrypt+0x189/0x1c0 crypto/skcipher.c:695
 _skcipher_recvmsg crypto/algif_skcipher.c:199 [inline]
 skcipher_recvmsg+0x1691/0x2190 crypto/algif_skcipher.c:221
 sock_recvmsg_nosec+0x7a/0x120 net/socket.c:1046
 ____sys_recvmsg+0x664/0x7f0 net/socket.c:2801
 ___sys_recvmsg+0x223/0x840 net/socket.c:2845
 do_recvmmsg+0x627/0xfd0 net/socket.c:2931
 __sys_recvmmsg+0x10a/0x430 net/socket.c:3018
 __do_compat_sys_recvmmsg_time32 net/compat.c:418 [inline]
 __se_compat_sys_recvmmsg_time32 net/compat.c:414 [inline]
 __ia32_compat_sys_recvmmsg_time32+0xf5/0x180 net/compat.c:414
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb5/0x110 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x37/0x70 arch/x86/entry/common.c:346
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:384
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a

Uninit was stored to memory at:
 cts_cbc_decrypt+0x3a3/0x720 crypto/cts.c:208
 crypto_cts_decrypt+0x77f/0x9b0 crypto/cts.c:280
 crypto_skcipher_decrypt+0x189/0x1c0 crypto/skcipher.c:695
 _skcipher_recvmsg crypto/algif_skcipher.c:199 [inline]
 skcipher_recvmsg+0x1691/0x2190 crypto/algif_skcipher.c:221
 sock_recvmsg_nosec+0x7a/0x120 net/socket.c:1046
 ____sys_recvmsg+0x664/0x7f0 net/socket.c:2801
 ___sys_recvmsg+0x223/0x840 net/socket.c:2845
 do_recvmmsg+0x627/0xfd0 net/socket.c:2931
 __sys_recvmmsg+0x10a/0x430 net/socket.c:3018
 __do_compat_sys_recvmmsg_time32 net/compat.c:418 [inline]
 __se_compat_sys_recvmmsg_time32 net/compat.c:414 [inline]
 __ia32_compat_sys_recvmmsg_time32+0xf5/0x180 net/compat.c:414
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb5/0x110 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x37/0x70 arch/x86/entry/common.c:346
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:384
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a

Uninit was stored to memory at:
 __crypto_xor+0x171/0x1310 lib/crypto/utils.c:45
 crypto_xor include/crypto/utils.h:31 [inline]
 cts_cbc_decrypt+0x2da/0x720 crypto/cts.c:199
 crypto_cts_decrypt+0x77f/0x9b0 crypto/cts.c:280
 crypto_skcipher_decrypt+0x189/0x1c0 crypto/skcipher.c:695
 _skcipher_recvmsg crypto/algif_skcipher.c:199 [inline]
 skcipher_recvmsg+0x1691/0x2190 crypto/algif_skcipher.c:221
 sock_recvmsg_nosec+0x7a/0x120 net/socket.c:1046
 ____sys_recvmsg+0x664/0x7f0 net/socket.c:2801
 ___sys_recvmsg+0x223/0x840 net/socket.c:2845
 do_recvmmsg+0x627/0xfd0 net/socket.c:2931
 __sys_recvmmsg+0x10a/0x430 net/socket.c:3018
 __do_compat_sys_recvmmsg_time32 net/compat.c:418 [inline]
 __se_compat_sys_recvmmsg_time32 net/compat.c:414 [inline]
 __ia32_compat_sys_recvmmsg_time32+0xf5/0x180 net/compat.c:414
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb5/0x110 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x37/0x70 arch/x86/entry/common.c:346
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:384
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a

Uninit was stored to memory at:
 memcpy_dir crypto/scatterwalk.c:23 [inline]
 scatterwalk_copychunks crypto/scatterwalk.c:38 [inline]
 scatterwalk_map_and_copy+0x6dc/0x9a0 crypto/scatterwalk.c:67
 cts_cbc_decrypt+0x1b9/0x720 crypto/cts.c:197
 crypto_cts_decrypt+0x77f/0x9b0 crypto/cts.c:280
 crypto_skcipher_decrypt+0x189/0x1c0 crypto/skcipher.c:695
 _skcipher_recvmsg crypto/algif_skcipher.c:199 [inline]
 skcipher_recvmsg+0x1691/0x2190 crypto/algif_skcipher.c:221
 sock_recvmsg_nosec+0x7a/0x120 net/socket.c:1046
 ____sys_recvmsg+0x664/0x7f0 net/socket.c:2801
 ___sys_recvmsg+0x223/0x840 net/socket.c:2845
 do_recvmmsg+0x627/0xfd0 net/socket.c:2931
 __sys_recvmmsg+0x10a/0x430 net/socket.c:3018
 __do_compat_sys_recvmmsg_time32 net/compat.c:418 [inline]
 __se_compat_sys_recvmmsg_time32 net/compat.c:414 [inline]
 __ia32_compat_sys_recvmmsg_time32+0xf5/0x180 net/compat.c:414
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb5/0x110 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x37/0x70 arch/x86/entry/common.c:346
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:384
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a

Uninit was stored to memory at:
 __crypto_xor+0x171/0x1310 lib/crypto/utils.c:45
 crypto_xor include/crypto/utils.h:31 [inline]
 crypto_cbc_decrypt_segment crypto/cbc.c:81 [inline]
 crypto_cbc_decrypt+0x2b1/0x8e0 crypto/cbc.c:133
 crypto_lskcipher_crypt_sg+0x43f/0x930 crypto/lskcipher.c:229
 crypto_lskcipher_decrypt_sg+0x8a/0xc0 crypto/lskcipher.c:258
 crypto_skcipher_decrypt+0x10d/0x1c0 crypto/skcipher.c:693
 crypto_cts_decrypt+0x704/0x9b0 crypto/cts.c:279
 crypto_skcipher_decrypt+0x189/0x1c0 crypto/skcipher.c:695
 _skcipher_recvmsg crypto/algif_skcipher.c:199 [inline]
 skcipher_recvmsg+0x1691/0x2190 crypto/algif_skcipher.c:221
 sock_recvmsg_nosec+0x7a/0x120 net/socket.c:1046
 ____sys_recvmsg+0x664/0x7f0 net/socket.c:2801
 ___sys_recvmsg+0x223/0x840 net/socket.c:2845
 do_recvmmsg+0x627/0xfd0 net/socket.c:2931
 __sys_recvmmsg+0x10a/0x430 net/socket.c:3018
 __do_compat_sys_recvmmsg_time32 net/compat.c:418 [inline]
 __se_compat_sys_recvmmsg_time32 net/compat.c:414 [inline]
 __ia32_compat_sys_recvmmsg_time32+0xf5/0x180 net/compat.c:414
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb5/0x110 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x37/0x70 arch/x86/entry/common.c:346
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:384
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3819 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc+0x919/0xf80 mm/slub.c:3994
 kmalloc include/linux/slab.h:594 [inline]
 sock_kmalloc+0x134/0x1f0 net/core/sock.c:2684
 af_alg_alloc_areq+0xe4/0x3a0 crypto/af_alg.c:1202
 _skcipher_recvmsg crypto/algif_skcipher.c:118 [inline]
 skcipher_recvmsg+0x4f0/0x2190 crypto/algif_skcipher.c:221
 sock_recvmsg_nosec+0x7a/0x120 net/socket.c:1046
 ____sys_recvmsg+0x664/0x7f0 net/socket.c:2801
 ___sys_recvmsg+0x223/0x840 net/socket.c:2845
 do_recvmmsg+0x627/0xfd0 net/socket.c:2931
 __sys_recvmmsg+0x10a/0x430 net/socket.c:3018
 __do_compat_sys_recvmmsg_time32 net/compat.c:418 [inline]
 __se_compat_sys_recvmmsg_time32 net/compat.c:414 [inline]
 __ia32_compat_sys_recvmmsg_time32+0xf5/0x180 net/compat.c:414
 do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
 __do_fast_syscall_32+0xb5/0x110 arch/x86/entry/common.c:321
 do_fast_syscall_32+0x37/0x70 arch/x86/entry/common.c:346
 do_SYSENTER_32+0x1f/0x30 arch/x86/entry/common.c:384
 entry_SYSENTER_compat_after_hwframe+0x70/0x7a

CPU: 1 PID: 11951 Comm: syz-executor.1 Not tainted 6.8.0-rc5-syzkaller-00278-g603c04e27c3e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

