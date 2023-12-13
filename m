Return-Path: <linux-crypto+bounces-820-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8729481210F
	for <lists+linux-crypto@lfdr.de>; Wed, 13 Dec 2023 22:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591041C2118D
	for <lists+linux-crypto@lfdr.de>; Wed, 13 Dec 2023 21:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6450F7FBA4;
	Wed, 13 Dec 2023 21:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="VLqYj4zX"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 628E5A3
	for <linux-crypto@vger.kernel.org>; Wed, 13 Dec 2023 13:58:52 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1d350dff621so11231595ad.1
        for <linux-crypto@vger.kernel.org>; Wed, 13 Dec 2023 13:58:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1702504732; x=1703109532; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GVpOLjrGhdEhg/cul7r0ldAtMuNzrhzuf3xlTocro5U=;
        b=VLqYj4zXL96kBZ8tYGOCvtuLIQR0/qytdpW9wnsuwui6Zz3f7pm5bcGC+4xn+h+maQ
         fndlZzxh8uIfs4wLZkbidwJ8d5X3xLIc7osMqfp3RkqRfhdY2cJ/YYAeOIvtsr6M0bc9
         4bsCpxWpZo4J5GzpfSNpunFy7fzXyeSAPRHZQ452XQ8T9QIOZaxiEyC2ouMQL+dh8sLE
         5oJEBvdRjTnZnPnf+MYE8Y0624TDyt/L0VZJ9BqYtHaDQTqNEJGNFce7mby9MjPrB756
         MOBLtWOTmELBbBSQDvGGvHwHMV8V1U9PI9gx3UUO30kzuR/h6sUWboGTV6ctng4lSxff
         OMdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702504732; x=1703109532;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVpOLjrGhdEhg/cul7r0ldAtMuNzrhzuf3xlTocro5U=;
        b=LAf3T4STd9Q9m4DhK1PjtgKyjuTgqnoISJzrx8ob3C1GUoSdDKu2DSYpt5eNXbVZi7
         ZvMCVhKIzjt7cZfn7RdHNgVi1dKPDHaeDkrt8CF6U6Uw3ABTo0FtBILhsppVKkjke6k8
         h+I6SaQUcH/nl6lCO2rBE9oAvz4WgLlOvbun+DPzVsuez45ZRLlEzng55K5ez9hWMoHE
         1LXw9/eyyblr8lsT0U4JVO38Y7owUxnW9/hNFmINcJs0Gur1ITw5j/ZKD+PQyqjbT1In
         0nz+CFgLx9TWvlpMkzfkKQNztP6zUWF9cdP5lWlG5eIB5MGPbWgzpJNKXnsrlpmYN0/z
         xYdw==
X-Gm-Message-State: AOJu0Ywj86D8hFEhl6NdaABlc4WYk2/QqFsiFBWkB65PJWL/8t0fxTIL
	JZmMKUDwCbul09MJ2L3xpgbDYw==
X-Google-Smtp-Source: AGHT+IHkFCe1DJSdViEkfDewaFZlFcGMbIOKXlUGvJ0SKAGH+lF0wU5Tz+alrhzOGi7OyQn5PfHRiw==
X-Received: by 2002:a17:902:fe82:b0:1cf:b12a:a9eb with SMTP id x2-20020a170902fe8200b001cfb12aa9ebmr7861394plm.19.1702504731792;
        Wed, 13 Dec 2023 13:58:51 -0800 (PST)
Received: from dread.disaster.area (pa49-180-125-5.pa.nsw.optusnet.com.au. [49.180.125.5])
        by smtp.gmail.com with ESMTPSA id c7-20020a170902d48700b001d0c1281ef5sm10995764plg.89.2023.12.13.13.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 13:58:51 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1rDXFg-007vVp-1G;
	Thu, 14 Dec 2023 08:58:48 +1100
Date: Thu, 14 Dec 2023 08:58:48 +1100
From: Dave Chinner <david@fromorbit.com>
To: Dave Chinner <dchinner@redhat.com>
Cc: Alexander Potapenko <glider@google.com>,
	syzbot+a6d6b8fffa294705dbd8@syzkaller.appspotmail.com, hch@lst.de,
	davem@davemloft.net, herbert@gondor.apana.org.au,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com, linux-xfs@vger.kernel.org
Subject: Re: [syzbot] [crypto?] KMSAN: uninit-value in __crc32c_le_base (3)
Message-ID: <ZXopGGh/YqNIdtMJ@dread.disaster.area>
References: <000000000000f66a3005fa578223@google.com>
 <20231213104950.1587730-1-glider@google.com>
 <ZXofF2lXuIUvKi/c@rh>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXofF2lXuIUvKi/c@rh>

On Thu, Dec 14, 2023 at 08:16:07AM +1100, Dave Chinner wrote:
> [cc linux-xfs@vger.kernel.org because that's where all questions
> about XFS stuff should be directed, not to random individual
> developers. ]
> 
> On Wed, Dec 13, 2023 at 11:49:50AM +0100, Alexander Potapenko wrote:
> > Hi Christoph, Dave,
> > 
> > The repro provided by Xingwei indeed works.

Can you please test the patch below?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

xfs: initialise di_crc in xfs_log_dinode

From: Dave Chinner <dchinner@redhat.com>

Alexander Potapenko report that KMSAN was issuing these warnings:

kmalloc-ed xlog buffer of size 512 : ffff88802fc26200
kmalloc-ed xlog buffer of size 368 : ffff88802fc24a00
kmalloc-ed xlog buffer of size 648 : ffff88802b631000
kmalloc-ed xlog buffer of size 648 : ffff88802b632800
kmalloc-ed xlog buffer of size 648 : ffff88802b631c00
xlog_write_iovec: copying 12 bytes from ffff888017ddbbd8 to ffff88802c300400
xlog_write_iovec: copying 28 bytes from ffff888017ddbbe4 to ffff88802c30040c
xlog_write_iovec: copying 68 bytes from ffff88802fc26274 to ffff88802c300428
xlog_write_iovec: copying 188 bytes from ffff88802fc262bc to ffff88802c30046c
=====================================================
BUG: KMSAN: uninit-value in xlog_write_iovec fs/xfs/xfs_log.c:2227
BUG: KMSAN: uninit-value in xlog_write_full fs/xfs/xfs_log.c:2263
BUG: KMSAN: uninit-value in xlog_write+0x1fac/0x2600 fs/xfs/xfs_log.c:2532
 xlog_write_iovec fs/xfs/xfs_log.c:2227
 xlog_write_full fs/xfs/xfs_log.c:2263
 xlog_write+0x1fac/0x2600 fs/xfs/xfs_log.c:2532
 xlog_cil_write_chain fs/xfs/xfs_log_cil.c:918
 xlog_cil_push_work+0x30f2/0x44e0 fs/xfs/xfs_log_cil.c:1263
 process_one_work kernel/workqueue.c:2630
 process_scheduled_works+0x1188/0x1e30 kernel/workqueue.c:2703
 worker_thread+0xee5/0x14f0 kernel/workqueue.c:2784
 kthread+0x391/0x500 kernel/kthread.c:388
 ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242

Uninit was created at:
 slab_post_alloc_hook+0x101/0xac0 mm/slab.h:768
 slab_alloc_node mm/slub.c:3482
 __kmem_cache_alloc_node+0x612/0xae0 mm/slub.c:3521
 __do_kmalloc_node mm/slab_common.c:1006
 __kmalloc+0x11a/0x410 mm/slab_common.c:1020
 kmalloc ./include/linux/slab.h:604
 xlog_kvmalloc fs/xfs/xfs_log_priv.h:704
 xlog_cil_alloc_shadow_bufs fs/xfs/xfs_log_cil.c:343
 xlog_cil_commit+0x487/0x4dc0 fs/xfs/xfs_log_cil.c:1574
 __xfs_trans_commit+0x8df/0x1930 fs/xfs/xfs_trans.c:1017
 xfs_trans_commit+0x30/0x40 fs/xfs/xfs_trans.c:1061
 xfs_create+0x15af/0x2150 fs/xfs/xfs_inode.c:1076
 xfs_generic_create+0x4cd/0x1550 fs/xfs/xfs_iops.c:199
 xfs_vn_create+0x4a/0x60 fs/xfs/xfs_iops.c:275
 lookup_open fs/namei.c:3477
 open_last_lookups fs/namei.c:3546
 path_openat+0x29ac/0x6180 fs/namei.c:3776
 do_filp_open+0x24d/0x680 fs/namei.c:3809
 do_sys_openat2+0x1bc/0x330 fs/open.c:1440
 do_sys_open fs/open.c:1455
 __do_sys_openat fs/open.c:1471
 __se_sys_openat fs/open.c:1466
 __x64_sys_openat+0x253/0x330 fs/open.c:1466
 do_syscall_x64 arch/x86/entry/common.c:51
 do_syscall_64+0x4f/0x140 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b arch/x86/entry/entry_64.S:120

Bytes 112-115 of 188 are uninitialized
Memory access of size 188 starts at ffff88802fc262bc

This is caused by the struct xfs_log_dinode not having the di_crc
field initialised. Log recovery never uses this field (it is only
present these days for on-disk format compatibility reasons) and so
it's value is never checked so nothing in XFS has caught this.

Further, none of the uninitialised memory access warning tools have
caught this (despite catching other uninit memory accesses in the
struct xfs_log_dinode back in 2017!) until recently. Alexander
annotated the XFS code to get the dump of the actual bytes that were
detected as uninitialised, and from that report it took me about 30s
to realise what the issue was.

The issue was introduced back in 2016 and every inode that is logged
fails to initialise this field. This is no actual bad behaviour
caused by this issue - I find it hard to even classify it as a
bug...

Reported-by: Alexander Potapenko <glider@google.com>
Fixes: f8d55aa0523a ("xfs: introduce inode log format object")
Signed-off-by: Dave Chinner <dchinner@redhat.com>
---
 fs/xfs/xfs_inode_item.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/xfs/xfs_inode_item.c b/fs/xfs/xfs_inode_item.c
index 157ae90d3d52..0287918c03dc 100644
--- a/fs/xfs/xfs_inode_item.c
+++ b/fs/xfs/xfs_inode_item.c
@@ -557,6 +557,9 @@ xfs_inode_to_log_dinode(
 		memset(to->di_pad2, 0, sizeof(to->di_pad2));
 		uuid_copy(&to->di_uuid, &ip->i_mount->m_sb.sb_meta_uuid);
 		to->di_v3_pad = 0;
+
+		/* dummy value for initialisation */
+		to->di_crc = 0;
 	} else {
 		to->di_version = 2;
 		to->di_flushiter = ip->i_flushiter;

