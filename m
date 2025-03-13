Return-Path: <linux-crypto+bounces-10733-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67336A5EA92
	for <lists+linux-crypto@lfdr.de>; Thu, 13 Mar 2025 05:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 568577AA0D1
	for <lists+linux-crypto@lfdr.de>; Thu, 13 Mar 2025 04:28:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A62143895;
	Thu, 13 Mar 2025 04:29:04 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B18142E6F
	for <linux-crypto@vger.kernel.org>; Thu, 13 Mar 2025 04:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741840144; cv=none; b=svJB7/ZA+JatKZ51esf15/HYpQeYd6JhM77x4kBw1tZXlZEPEIp0r9rkZQX0Xn1WsjxyG4cetsiXYzgJuZ2JoaQx1YihlpvZppfSuI4NZDztUoVRywLWigCsnj4s+roOHB5LVhG6XRZ1KqLM8ZwtlmEcrUDzTDpCZG0wTxvziHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741840144; c=relaxed/simple;
	bh=kWXr62CAog9CAGOGJRrsCFtZNEq79hFLJ3mt5laTGcw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=DLAOsnGd6IGlDZkO+KeO/Qouau5v4evTUYDI7NNIBKiLWmEJUe78MlPzB9zo2kdAdoLFCkhcm0u1r711IkwEWkTlPWFxsQD9yza3AeDbUGwdQOiUHAh8p14h4rH4KVAFA/do4a+ItkfZGvW8xZ2Fbj17WKbFAHA7OfSb8+coeNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3d2b3882febso5183035ab.1
        for <linux-crypto@vger.kernel.org>; Wed, 12 Mar 2025 21:29:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741840142; x=1742444942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0WFfvUCISmueifoL2MCy+RFGIJcBo8BpaxtswOkUKf8=;
        b=Z+36tvNex0dbrpu4W28E6Ec5aUcvMUB0Tzaj9lvRwf/kt0HlV4p8q1c9kQPu57fQSy
         YIdkTp4S9dmfdc+OoHRckgxJyPBayEhUC47+fSq9ksNOdMIeVR+3iKqoZeYxxAG24fAX
         3hhUqn0VXeR/rcO+lQo+igtTe9KsG5yU86VB2/tN/nPawnlhXupz4fYIgIlhM60t8l6v
         558l7Og/VJW+cnSkjaF0YMxmKAU7lD9qhGxusu63YrOZ2hhKKLlCAb9hSu2rRWeME8LY
         5GeNHvmJ9mjWHAWtB+1rKKswEo+dIXs6vIFlwPRXFIFDGdXtfJ6j/lHV1XednxZIPK/L
         Zpcw==
X-Forwarded-Encrypted: i=1; AJvYcCXthV+JIxfUgLJcf0lXhH6UCxtmHJO8DP3pdyAPm7JD+ytDO2+bAZ9jOSGPTqTN/olNifstMrby74YlWo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbNp4154qotfhUGCNfFgBy2IHKFkZwywZQAedNOiv83SDFxESb
	/CzA2HUi3Cpz1bMn3CvDdXdIKVT6klNQfOfqoKCf45+9NpCKzqzsLxRqJPLqMwdEywpnU9e7i2r
	1IACrR4eBzHgwzhMcTn6Ae9UevS2B5RwW2nqiOvNF8Ei+QcjMfw1fATo=
X-Google-Smtp-Source: AGHT+IEvobTDZMgWNZQbo1CELljpz7OYQv02wcDWl6BG6s7X2N/8oYNpbQUE7xADNNqOMrFGqYAEE1xmgkQv/s6Y6rl1JzvJRo3/
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c24b:0:b0:3d4:3ab3:e1c9 with SMTP id
 e9e14a558f8ab-3d441a06d8cmr265782365ab.15.1741840141998; Wed, 12 Mar 2025
 21:29:01 -0700 (PDT)
Date: Wed, 12 Mar 2025 21:29:01 -0700
In-Reply-To: <1f4c7fbe-f666-45d2-911e-59fffdca905d@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d25f0d.050a0220.14e108.002d.GAE@google.com>
Subject: Re: [syzbot] [xfs?] KASAN: slab-out-of-bounds Read in xlog_cksum
From: syzbot <syzbot+9f6d080dece587cfdd4c@syzkaller.appspotmail.com>
To: ardb@kernel.org, bp@alien8.de, chandan.babu@oracle.com, 
	dave.hansen@linux.intel.com, ebiggers@kernel.org, hpa@zytor.com, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-xfs@vger.kernel.org, mingo@redhat.com, sunjunchao2870@gmail.com, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
KASAN: slab-out-of-bounds Read in xlog_cksum

=======================================================
XFS (loop0): Mounting V5 Filesystem bfdc47fc-10d8-4eed-a562-11a831b3f791
==================================================================
BUG: KASAN: slab-out-of-bounds in crc32c_le_arch+0xc7/0x1b0 arch/x86/lib/crc32-glue.c:81
Read of size 8 at addr ffff888040eb5200 by task syz.0.16/5913

CPU: 0 UID: 0 PID: 5913 Comm: syz.0.16 Not tainted 6.14.0-rc6-syzkaller-gb7f94fcf5546 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0x16e/0x5b0 mm/kasan/report.c:521
 kasan_report+0x143/0x180 mm/kasan/report.c:634
 crc32c_le_arch+0xc7/0x1b0 arch/x86/lib/crc32-glue.c:81
 __crc32c_le include/linux/crc32.h:36 [inline]
 crc32c include/linux/crc32c.h:9 [inline]
 xlog_cksum+0x91/0xf0 fs/xfs/xfs_log.c:1588
 xlog_recover_process+0x78/0x1e0 fs/xfs/xfs_log_recover.c:2900
 xlog_do_recovery_pass+0xa01/0xdc0 fs/xfs/xfs_log_recover.c:3235
 xlog_verify_head+0x21f/0x5a0 fs/xfs/xfs_log_recover.c:1058
 xlog_find_tail+0xa04/0xdf0 fs/xfs/xfs_log_recover.c:1315
 xlog_recover+0xe1/0x540 fs/xfs/xfs_log_recover.c:3419
 xfs_log_mount+0x252/0x3e0 fs/xfs/xfs_log.c:666
 xfs_mountfs+0xfbb/0x2500 fs/xfs/xfs_mount.c:878
 xfs_fs_fill_super+0x1223/0x1550 fs/xfs/xfs_super.c:1817
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3560
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f010618e90a
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 de 1a 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f0106f3ce68 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007f0106f3cef0 RCX: 00007f010618e90a
RDX: 0000400000000500 RSI: 0000400000000200 RDI: 00007f0106f3ceb0
RBP: 0000400000000500 R08: 00007f0106f3cef0 R09: 0000000002218a5d
R10: 0000000002218a5d R11: 0000000000000246 R12: 0000400000000200
R13: 00007f0106f3ceb0 R14: 0000000000009706 R15: 0000400000000100
 </TASK>

Allocated by task 5913:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
 kasan_kmalloc include/linux/kasan.h:260 [inline]
 __do_kmalloc_node mm/slub.c:4294 [inline]
 __kmalloc_node_noprof+0x290/0x4d0 mm/slub.c:4300
 __kvmalloc_node_noprof+0x72/0x190 mm/util.c:662
 xlog_do_recovery_pass+0x143/0xdc0 fs/xfs/xfs_log_recover.c:3016
 xlog_verify_head+0x21f/0x5a0 fs/xfs/xfs_log_recover.c:1058
 xlog_find_tail+0xa04/0xdf0 fs/xfs/xfs_log_recover.c:1315
 xlog_recover+0xe1/0x540 fs/xfs/xfs_log_recover.c:3419
 xfs_log_mount+0x252/0x3e0 fs/xfs/xfs_log.c:666
 xfs_mountfs+0xfbb/0x2500 fs/xfs/xfs_mount.c:878
 xfs_fs_fill_super+0x1223/0x1550 fs/xfs/xfs_super.c:1817
 get_tree_bdev_flags+0x48c/0x5c0 fs/super.c:1636
 vfs_get_tree+0x90/0x2b0 fs/super.c:1814
 do_new_mount+0x2be/0xb40 fs/namespace.c:3560
 do_mount fs/namespace.c:3900 [inline]
 __do_sys_mount fs/namespace.c:4111 [inline]
 __se_sys_mount+0x2d6/0x3c0 fs/namespace.c:4088
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff888040eb5000
 which belongs to the cache kmalloc-512 of size 512
The buggy address is located 0 bytes to the right of
 allocated 512-byte region [ffff888040eb5000, ffff888040eb5200)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x40eb4
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
ksm flags: 0x4fff00000000040(head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000040 ffff88801b041c80 ffffea0000d00580 dead000000000003
raw: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
head: 04fff00000000040 ffff88801b041c80 ffffea0000d00580 dead000000000003
head: 0000000000000000 0000000080080008 00000000f5000000 0000000000000000
head: 04fff00000000001 ffffea000103ad01 ffffffffffffffff 0000000000000000
head: 0000000000000002 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 2, tgid 2 (kthreadd), ts 23865404352, free_ts 0
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x1f4/0x240 mm/page_alloc.c:1551
 prep_new_page mm/page_alloc.c:1559 [inline]
 get_page_from_freelist+0x365c/0x37a0 mm/page_alloc.c:3477
 __alloc_frozen_pages_noprof+0x292/0x710 mm/page_alloc.c:4740
 alloc_pages_mpol+0x311/0x660 mm/mempolicy.c:2270
 alloc_slab_page mm/slub.c:2423 [inline]
 allocate_slab+0x8f/0x3a0 mm/slub.c:2587
 new_slab mm/slub.c:2640 [inline]
 ___slab_alloc+0xc27/0x14a0 mm/slub.c:3826
 __slab_alloc+0x58/0xa0 mm/slub.c:3916
 __slab_alloc_node mm/slub.c:3991 [inline]
 slab_alloc_node mm/slub.c:4152 [inline]
 __kmalloc_cache_noprof+0x27b/0x390 mm/slub.c:4320
 kmalloc_noprof include/linux/slab.h:901 [inline]
 kzalloc_noprof include/linux/slab.h:1037 [inline]
 set_kthread_struct+0xc2/0x330 kernel/kthread.c:126
 copy_process+0x1179/0x3cf0 kernel/fork.c:2331
 kernel_clone+0x226/0x8e0 kernel/fork.c:2815
 kernel_thread+0x1c0/0x250 kernel/fork.c:2877
 create_kthread kernel/kthread.c:487 [inline]
 kthreadd+0x60d/0x810 kernel/kthread.c:847
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
page_owner free stack trace missing

Memory state around the buggy address:
 ffff888040eb5100: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffff888040eb5180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff888040eb5200: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
                   ^
 ffff888040eb5280: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff888040eb5300: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


Tested on:

commit:         b7f94fcf Merge tag 'sched_ext-for-6.14-rc6-fixes' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f4cc78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=31c94a07ddad0b00
dashboard link: https://syzkaller.appspot.com/bug?extid=9f6d080dece587cfdd4c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.

