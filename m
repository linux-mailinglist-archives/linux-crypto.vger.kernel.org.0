Return-Path: <linux-crypto+bounces-2200-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9F885BEF9
	for <lists+linux-crypto@lfdr.de>; Tue, 20 Feb 2024 15:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAEAE288722
	for <lists+linux-crypto@lfdr.de>; Tue, 20 Feb 2024 14:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63BE56A8B3;
	Tue, 20 Feb 2024 14:42:21 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEB62C6AA
	for <linux-crypto@vger.kernel.org>; Tue, 20 Feb 2024 14:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708440141; cv=none; b=tBpXJ9LDEZWl0Uy+PwRUtvWerqkaRjHk8p410Dy/oLXJIvHHDFtGMhc2wf5dlDUJNm3BlIhF0rPnKHSwU83ptJLetN7vHCCCdD+EceFeZ73UJqMP26v0H8V+RZGpiJAT3SQlWUg6ctmUA5q1gJsrFBo/vW9n/0KLUvFY5uH9RZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708440141; c=relaxed/simple;
	bh=/j9TSxsg0U2CWkDn+jqQtyXZfCYVcLD52vIC3gDqNsU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ns7E1H+vD2A2eaob91tZgpdRqSY0x9sWQ4vK2uvgCvx5pGpiHelT/o5VHzNYmWNSa/6k+v6QYtdDo78AFVumDm7InQv6j2MdiSImtv0I6sCxFfcQ7QaSynqIf3rKDxj1KSoQtGJyftAZX6TN3himVgkwySsetOjWKvtunSO4TJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-365256f2efcso27222185ab.0
        for <linux-crypto@vger.kernel.org>; Tue, 20 Feb 2024 06:42:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708440138; x=1709044938;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gsk7rpBiwMjo/yvd4RdYag7s3UmdrA6atoOI+6+UT7E=;
        b=WQKSF4MzQGTzupIm4qb3oWsjdRvZ3xgYcYyB9zE2cEODYEk+pm0EP2kvJARRHTyJFl
         OCTMMXz3UNUNeFvAK9DlA85dOpWmw5k03oX1CAX3ibXsBXFnAAygHl2XO+AhmgK8V/Qk
         55m84cgcbQlpWDRDjw5ZFRcta/TA5SGbWwP0FVeDTZ+V8SRei2ccVR6Z/Sx5Qm10NBc3
         K8HyDVGSAbGWMOkyuomxeYgNN4QXJsAnFMrBeWjnW+cmnSaIgiH975VWK+jARAhqq67i
         OoJjmRaOrTR8QAP1mdvFBIMVUcFINgBfDQqzTShm68EwX8ftWMupjgIDFBq+krzYFFCB
         6LYA==
X-Forwarded-Encrypted: i=1; AJvYcCUnmDXCQbYyUorC7YZpwapf2HRNM4x51wCrvsrHBa1e9kek/zTfxPWM7id1iw73BlwTi6WMwc4dIzaAYPTYLw8JqI2JAEyv7ZE+lmOv
X-Gm-Message-State: AOJu0YxG6fcuzKmJqUWvKoN0CrBL38AC19LvVh2w+DLhgyekkgceT0vg
	drvnV7obFQzUTCtWpOxWpTtDrgVg1HkofrRTGRcbdDWxpZ3FTQbG+fvbsN3zoEI3G3L3vvNH+Ce
	qy6WFTYK+09Iy3Q6ziCAbNtky3LOYI4B08h1XHKc9gD0N0OIrpXjOuOc=
X-Google-Smtp-Source: AGHT+IE/K3YomCc3f3WamjoH8Nr2N1ValaVP3z3F0IOQHHYxAui57mX3HA+w8rlCFP3OZ0k1AC9niZYZbH/GZquWm6BEc1TB3bsd
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3710:b0:363:9176:ca06 with SMTP id
 ck16-20020a056e02371000b003639176ca06mr1368561ilb.2.1708440138805; Tue, 20
 Feb 2024 06:42:18 -0800 (PST)
Date: Tue, 20 Feb 2024 06:42:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097f7f90611d1370c@google.com>
Subject: [syzbot] [crypto?] KMSAN: uninit-value in des3_ede_decrypt
From: syzbot <syzbot+b90b904ef6bdfdafec1d@syzkaller.appspotmail.com>
To: davem@davemloft.net, herbert@gondor.apana.org.au, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4f5e5092fdbf Merge tag 'net-6.8-rc5' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1679e7b2180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e3dd779fba027968
dashboard link: https://syzkaller.appspot.com/bug?extid=b90b904ef6bdfdafec1d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/34924e0466d4/disk-4f5e5092.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/29d0b1935c61/vmlinux-4f5e5092.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2e033c3d8679/bzImage-4f5e5092.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b90b904ef6bdfdafec1d@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in des3_ede_decrypt+0x845/0x19a0 lib/crypto/des.c:884
 des3_ede_decrypt+0x845/0x19a0 lib/crypto/des.c:884
 crypto_des3_ede_decrypt+0x32/0x40 crypto/des_generic.c:82
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
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg net/socket.c:1068 [inline]
 ____sys_recvmsg+0x283/0x7f0 net/socket.c:2803
 ___sys_recvmsg+0x223/0x840 net/socket.c:2845
 do_recvmmsg+0x4fc/0xfd0 net/socket.c:2939
 __sys_recvmmsg net/socket.c:3018 [inline]
 __do_sys_recvmmsg net/socket.c:3041 [inline]
 __se_sys_recvmmsg net/socket.c:3034 [inline]
 __x64_sys_recvmmsg+0x397/0x490 net/socket.c:3034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 memcpy_dir crypto/scatterwalk.c:23 [inline]
 scatterwalk_copychunks crypto/scatterwalk.c:38 [inline]
 scatterwalk_map_and_copy+0x6dc/0x9a0 crypto/scatterwalk.c:67
 cts_cbc_decrypt+0x3e2/0x720 crypto/cts.c:211
 crypto_cts_decrypt+0x77f/0x9b0 crypto/cts.c:280
 crypto_skcipher_decrypt+0x189/0x1c0 crypto/skcipher.c:695
 _skcipher_recvmsg crypto/algif_skcipher.c:199 [inline]
 skcipher_recvmsg+0x1691/0x2190 crypto/algif_skcipher.c:221
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg net/socket.c:1068 [inline]
 ____sys_recvmsg+0x283/0x7f0 net/socket.c:2803
 ___sys_recvmsg+0x223/0x840 net/socket.c:2845
 do_recvmmsg+0x4fc/0xfd0 net/socket.c:2939
 __sys_recvmmsg net/socket.c:3018 [inline]
 __do_sys_recvmmsg net/socket.c:3041 [inline]
 __se_sys_recvmmsg net/socket.c:3034 [inline]
 __x64_sys_recvmmsg+0x397/0x490 net/socket.c:3034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 cts_cbc_decrypt+0x3a3/0x720 crypto/cts.c:208
 crypto_cts_decrypt+0x77f/0x9b0 crypto/cts.c:280
 crypto_skcipher_decrypt+0x189/0x1c0 crypto/skcipher.c:695
 _skcipher_recvmsg crypto/algif_skcipher.c:199 [inline]
 skcipher_recvmsg+0x1691/0x2190 crypto/algif_skcipher.c:221
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg net/socket.c:1068 [inline]
 ____sys_recvmsg+0x283/0x7f0 net/socket.c:2803
 ___sys_recvmsg+0x223/0x840 net/socket.c:2845
 do_recvmmsg+0x4fc/0xfd0 net/socket.c:2939
 __sys_recvmmsg net/socket.c:3018 [inline]
 __do_sys_recvmmsg net/socket.c:3041 [inline]
 __se_sys_recvmmsg net/socket.c:3034 [inline]
 __x64_sys_recvmmsg+0x397/0x490 net/socket.c:3034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 __crypto_xor+0x171/0x1310 lib/crypto/utils.c:45
 crypto_xor include/crypto/utils.h:31 [inline]
 cts_cbc_decrypt+0x2da/0x720 crypto/cts.c:199
 crypto_cts_decrypt+0x77f/0x9b0 crypto/cts.c:280
 crypto_skcipher_decrypt+0x189/0x1c0 crypto/skcipher.c:695
 _skcipher_recvmsg crypto/algif_skcipher.c:199 [inline]
 skcipher_recvmsg+0x1691/0x2190 crypto/algif_skcipher.c:221
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg net/socket.c:1068 [inline]
 ____sys_recvmsg+0x283/0x7f0 net/socket.c:2803
 ___sys_recvmsg+0x223/0x840 net/socket.c:2845
 do_recvmmsg+0x4fc/0xfd0 net/socket.c:2939
 __sys_recvmmsg net/socket.c:3018 [inline]
 __do_sys_recvmmsg net/socket.c:3041 [inline]
 __se_sys_recvmmsg net/socket.c:3034 [inline]
 __x64_sys_recvmmsg+0x397/0x490 net/socket.c:3034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was stored to memory at:
 memcpy_dir crypto/scatterwalk.c:23 [inline]
 scatterwalk_copychunks crypto/scatterwalk.c:38 [inline]
 scatterwalk_map_and_copy+0x6dc/0x9a0 crypto/scatterwalk.c:67
 cts_cbc_decrypt+0x1b9/0x720 crypto/cts.c:197
 crypto_cts_decrypt+0x77f/0x9b0 crypto/cts.c:280
 crypto_skcipher_decrypt+0x189/0x1c0 crypto/skcipher.c:695
 _skcipher_recvmsg crypto/algif_skcipher.c:199 [inline]
 skcipher_recvmsg+0x1691/0x2190 crypto/algif_skcipher.c:221
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg net/socket.c:1068 [inline]
 ____sys_recvmsg+0x283/0x7f0 net/socket.c:2803
 ___sys_recvmsg+0x223/0x840 net/socket.c:2845
 do_recvmmsg+0x4fc/0xfd0 net/socket.c:2939
 __sys_recvmmsg net/socket.c:3018 [inline]
 __do_sys_recvmmsg net/socket.c:3041 [inline]
 __se_sys_recvmmsg net/socket.c:3034 [inline]
 __x64_sys_recvmmsg+0x397/0x490 net/socket.c:3034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

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
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg net/socket.c:1068 [inline]
 ____sys_recvmsg+0x283/0x7f0 net/socket.c:2803
 ___sys_recvmsg+0x223/0x840 net/socket.c:2845
 do_recvmmsg+0x4fc/0xfd0 net/socket.c:2939
 __sys_recvmmsg net/socket.c:3018 [inline]
 __do_sys_recvmmsg net/socket.c:3041 [inline]
 __se_sys_recvmmsg net/socket.c:3034 [inline]
 __x64_sys_recvmmsg+0x397/0x490 net/socket.c:3034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:3819 [inline]
 slab_alloc_node mm/slub.c:3860 [inline]
 __do_kmalloc_node mm/slub.c:3980 [inline]
 __kmalloc+0x919/0xf80 mm/slub.c:3994
 kmalloc include/linux/slab.h:594 [inline]
 sock_kmalloc+0x134/0x1f0 net/core/sock.c:2685
 af_alg_alloc_areq+0xe4/0x3a0 crypto/af_alg.c:1202
 _skcipher_recvmsg crypto/algif_skcipher.c:118 [inline]
 skcipher_recvmsg+0x4f0/0x2190 crypto/algif_skcipher.c:221
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 sock_recvmsg net/socket.c:1068 [inline]
 ____sys_recvmsg+0x283/0x7f0 net/socket.c:2803
 ___sys_recvmsg+0x223/0x840 net/socket.c:2845
 do_recvmmsg+0x4fc/0xfd0 net/socket.c:2939
 __sys_recvmmsg net/socket.c:3018 [inline]
 __do_sys_recvmmsg net/socket.c:3041 [inline]
 __se_sys_recvmmsg net/socket.c:3034 [inline]
 __x64_sys_recvmmsg+0x397/0x490 net/socket.c:3034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

CPU: 0 PID: 11510 Comm: syz-executor.0 Not tainted 6.8.0-rc4-syzkaller-00180-g4f5e5092fdbf #0
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

