Return-Path: <linux-crypto+bounces-4073-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 141708C0BED
	for <lists+linux-crypto@lfdr.de>; Thu,  9 May 2024 09:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3141F226F1
	for <lists+linux-crypto@lfdr.de>; Thu,  9 May 2024 07:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6061482EA;
	Thu,  9 May 2024 07:22:23 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864BB13C9A0
	for <linux-crypto@vger.kernel.org>; Thu,  9 May 2024 07:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715239343; cv=none; b=uCV5uxNy/7Aymc+l0olboVUL1W+pFPHWBxRVG9/e4/cvkFwVVXzApp3PbPysyoLl+wQisVDQwm6LSQHp0DdCDDCntLGsm4BfebMzoC08rNJyDSCjZdfOlphPj2+ck0kC2uAvyVLsLg+x11cPamGKpA+SDA/l2oJ+bXRnb1MwPSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715239343; c=relaxed/simple;
	bh=Ko6t16GyyrkVPvpC6WSFxuhzCq/43+9aWKJKP+o5NfA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UJYZsnaazvGWgdL05oNlmlOt1/D+g/oeHN9KMafL6ytOiLrMidBX2wr1K/l7dKCJo8Y/eXqTQllksh3vUw/ZuzYaq5oz/hsx9ZX+32ZD0OlD8/TOcfasRDmL/NgLMp8lfmoRXKtev62bTo6yxfweqRWUW8r+4vOH2aP5VLgrlQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36c9d7ad3feso6407945ab.1
        for <linux-crypto@vger.kernel.org>; Thu, 09 May 2024 00:22:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715239341; x=1715844141;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OOyau9UMh4oDE4pewSsqZvG8XP2S04jHg3SRpLTqQyk=;
        b=w6eW2ZL/TGv/7+idJFYhqLGcVkPRsFIwLWlQ80PR6RRJpFHqlwgGB7ZCSZRxrXdRnJ
         Z0iEKJ5kIIe8iyVGKDXq8fL2uhxjqu0Qn5bdfkNaS6CThXTcAhU1Ktc0Rk4X5KarxJnN
         fkQC2AJ3mUt6s7fHSeUqKPmAqMpGcobAXqS2bTGePOBuNm4bLphiwl3Y8o336B62DhSA
         BmmCxvCGvhHzET6Xa0XwLsbNCMcbNBgnNgDGiOX8l0lM5PUJPB//6K4Vmd4uNAi/IVY2
         i3lNGicqPXLWG1yB+xli5NfTQQOAylWgkxgRFkEyFY/ZGYN8iNuLJlq3pxH1g9PsgPEt
         vXRA==
X-Forwarded-Encrypted: i=1; AJvYcCWAsg5ysCOgma9o6W2UZBKkrkX/violK9nn6dulwC+iqgm6YpfukjxykOG0faTvxiyIsnDQnB6arsRzTlpeqm3o4ofQ2If3pFlUZ6V2
X-Gm-Message-State: AOJu0YwkT431Wdts9lxqBPvzrJC+WyAidI6E7XvwM+WJob1L1Yufjhaq
	Uu69JiXp76vIVHyItHvIw1MIXvJKslVLJt2cbi0Dx+5pM0BTQjb2qAZs51m3gezSINRaNA2A583
	K539QxNitGz8neQZkmoZe526zcACOFyEQgGZOnHYPsvhuH9Cy3eQgcZc=
X-Google-Smtp-Source: AGHT+IEGdh+QSas5wliqyoJdLB8KQqBGUtF6qVd1tVMmte0ZJnCTfQdfnYUxslFcpjN2FiYw9CieaPgTb6WPeqs0ebamljkvFfxs
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9d:b0:36c:8aa4:f1ec with SMTP id
 e9e14a558f8ab-36caedba85bmr2368745ab.5.1715239340816; Thu, 09 May 2024
 00:22:20 -0700 (PDT)
Date: Thu, 09 May 2024 00:22:20 -0700
In-Reply-To: <000000000000736bd406151001d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d51cc061800470b@google.com>
Subject: Re: [syzbot] [btrfs] KMSAN: uninit-value in __crc32c_le_base (4)
From: syzbot <syzbot+549710bad9c798e25b15@syzkaller.appspotmail.com>
To: clm@fb.com, davem@davemloft.net, dsterba@suse.com, 
	herbert@gondor.apana.org.au, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    6d7ddd805123 Merge tag 'soc-fixes-6.9-3' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1094303f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=617171361dd3cd47
dashboard link: https://syzkaller.appspot.com/bug?extid=549710bad9c798e25b15
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11047204980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a2905c980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/49caca594b2f/disk-6d7ddd80.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cad0ed0e7e81/vmlinux-6d7ddd80.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c5403827515b/bzImage-6d7ddd80.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/dfb350d62061/mount_2.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+549710bad9c798e25b15@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in crc32_body lib/crc32.c:110 [inline]
BUG: KMSAN: uninit-value in crc32_le_generic lib/crc32.c:179 [inline]
BUG: KMSAN: uninit-value in __crc32c_le_base+0x43c/0xd80 lib/crc32.c:201
 crc32_body lib/crc32.c:110 [inline]
 crc32_le_generic lib/crc32.c:179 [inline]
 __crc32c_le_base+0x43c/0xd80 lib/crc32.c:201
 chksum_update+0x5b/0xd0 crypto/crc32c_generic.c:88
 crypto_shash_update+0x79/0xa0 crypto/shash.c:70
 csum_tree_block+0x35f/0x5d0 fs/btrfs/disk-io.c:96
 btree_csum_one_bio+0x4d5/0xeb0 fs/btrfs/disk-io.c:294
 btrfs_bio_csum fs/btrfs/bio.c:538 [inline]
 btrfs_submit_chunk fs/btrfs/bio.c:741 [inline]
 btrfs_submit_bio+0x1eb6/0x2930 fs/btrfs/bio.c:770
 write_one_eb+0x13fa/0x1570 fs/btrfs/extent_io.c:1740
 submit_eb_page fs/btrfs/extent_io.c:1899 [inline]
 btree_write_cache_pages+0x1d2a/0x29a0 fs/btrfs/extent_io.c:1949
 btree_writepages+0x84/0x270 fs/btrfs/disk-io.c:516
 do_writepages+0x427/0xc30 mm/page-writeback.c:2612
 filemap_fdatawrite_wbc+0x1d8/0x270 mm/filemap.c:397
 __filemap_fdatawrite_range mm/filemap.c:430 [inline]
 filemap_fdatawrite_range+0xe1/0x110 mm/filemap.c:448
 btrfs_write_marked_extents+0x2e7/0x620 fs/btrfs/transaction.c:1153
 btrfs_sync_log+0x9fd/0x3830 fs/btrfs/tree-log.c:2969
 btrfs_sync_file+0x144c/0x1c60 fs/btrfs/file.c:1968
 vfs_fsync_range+0x20d/0x270 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2795 [inline]
 btrfs_do_write_iter+0x1c5f/0x2270 fs/btrfs/file.c:1695
 btrfs_file_write_iter+0x38/0x50 fs/btrfs/file.c:1705
 do_iter_readv_writev+0x7e6/0x960
 vfs_writev+0x574/0x1450 fs/read_write.c:971
 do_writev+0x251/0x5c0 fs/read_write.c:1018
 __do_sys_writev fs/read_write.c:1091 [inline]
 __se_sys_writev fs/read_write.c:1088 [inline]
 __x64_sys_writev+0x98/0xe0 fs/read_write.c:1088
 x64_sys_call+0x23dc/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:21
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 __alloc_pages+0x9d6/0xe70 mm/page_alloc.c:4598
 __alloc_pages_bulk+0x19e/0x21e0 mm/page_alloc.c:4523
 alloc_pages_bulk_array include/linux/gfp.h:202 [inline]
 btrfs_alloc_page_array fs/btrfs/extent_io.c:690 [inline]
 alloc_eb_folio_array+0x19b/0x760 fs/btrfs/extent_io.c:714
 alloc_extent_buffer+0x965/0x3ad0 fs/btrfs/extent_io.c:3849
 btrfs_find_create_tree_block+0x46/0x60 fs/btrfs/disk-io.c:610
 btrfs_init_new_buffer fs/btrfs/extent-tree.c:5071 [inline]
 btrfs_alloc_tree_block+0x35c/0x17c0 fs/btrfs/extent-tree.c:5186
 btrfs_alloc_log_tree_node fs/btrfs/disk-io.c:960 [inline]
 btrfs_add_log_tree+0x1b7/0x7a0 fs/btrfs/disk-io.c:1008
 start_log_trans fs/btrfs/tree-log.c:208 [inline]
 btrfs_log_inode_parent+0x9b6/0x1dd0 fs/btrfs/tree-log.c:7066
 btrfs_log_dentry_safe+0x9a/0x100 fs/btrfs/tree-log.c:7171
 btrfs_sync_file+0x126c/0x1c60 fs/btrfs/file.c:1933
 vfs_fsync_range+0x20d/0x270 fs/sync.c:188
 generic_write_sync include/linux/fs.h:2795 [inline]
 btrfs_do_write_iter+0x1c5f/0x2270 fs/btrfs/file.c:1695
 btrfs_file_write_iter+0x38/0x50 fs/btrfs/file.c:1705
 do_iter_readv_writev+0x7e6/0x960
 vfs_writev+0x574/0x1450 fs/read_write.c:971
 do_writev+0x251/0x5c0 fs/read_write.c:1018
 __do_sys_writev fs/read_write.c:1091 [inline]
 __se_sys_writev fs/read_write.c:1088 [inline]
 __x64_sys_writev+0x98/0xe0 fs/read_write.c:1088
 x64_sys_call+0x23dc/0x3b50 arch/x86/include/generated/asm/syscalls_64.h:21
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x1e0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 PID: 5036 Comm: syz-executor761 Not tainted 6.9.0-rc7-syzkaller-00023-g6d7ddd805123 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
=====================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

