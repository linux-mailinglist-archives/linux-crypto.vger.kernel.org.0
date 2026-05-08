Return-Path: <linux-crypto+bounces-23857-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LfFOV3V/Wl2jgAAu9opvQ
	(envelope-from <linux-crypto+bounces-23857-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 08 May 2026 14:21:49 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 825894F650F
	for <lists+linux-crypto@lfdr.de>; Fri, 08 May 2026 14:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA1F930ACE21
	for <lists+linux-crypto@lfdr.de>; Fri,  8 May 2026 12:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DC5237F00A;
	Fri,  8 May 2026 12:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tjBAtfru"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC6D37FF76;
	Fri,  8 May 2026 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778242577; cv=none; b=fiyEqN1/9z291DgOCUuB1qG3Lu2fJbIOMPviehhv7OCTEVVUrTz3SUehe3jWRzHOOgbTQw8Fnp8PM4FrP7j1h6tnxddYCYyojiT9wozJUj4VM3EJNmPAUujLu+avc20YUKKpyklUo8pLRsBz3NHqGRZFkwNdQ9340tSigejnNHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778242577; c=relaxed/simple;
	bh=bL9xtueRMZB/tnx1HdmUpFIAF37PXXsQarl8C+rIlAU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HL93BV8UDj+JEzlHrQlk3aPAPOSOX0Fo0e5ehLdw4okjzhfSCIhiDYkWtdnX9QvVjkz4o0elcTq1K9QGNBMelGPtQt6swQ+IYzq2pr7vrTtCt7NKCDyH0x0OMGX/Xz7OG0E9E6YQrrCQjZNAT8kfFPASGHIuToB/ULCVC4R0+sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tjBAtfru; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778242571; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=q0EU33Gl1z9PKYUpXatr0Zn8reHluIfgGtFLoTGtpFE=;
	b=tjBAtfru7/JKOCEYgFtIo709DtoMlYLGnAmK6G0S2diDZLAMAWiOuEt2l9zN2qkoJeXY0gSSfQ3A8yzjz/Yi14A18puoO/SSRHG2s1STSPDGH/SWZengzCXISNQAOExJtob7W/yXhXKt8YSYH9nBk/1AsVhrap7e6zJcS+bDWh8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X2XQgrD_1778242570;
Received: from x31h02109.sqa.na131.tbsite.net(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X2XQgrD_1778242570 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 May 2026 20:16:10 +0800
From: Baokun Li <libaokun@linux.alibaba.com>
To: linux-ext4@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	ebiggers@kernel.org,
	ardb@kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	ojaswin@linux.ibm.com,
	ritesh.list@gmail.com,
	Baokun Li <libaokun@linux.alibaba.com>
Subject: [PATCH RFC 14/17] ext4: rename ino to bit in __ext4_new_inode()
Date: Fri,  8 May 2026 20:15:36 +0800
Message-ID: <20260508121539.4174601-15-libaokun@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260508121539.4174601-1-libaokun@linux.alibaba.com>
References: <20260508121539.4174601-1-libaokun@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 825894F650F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23857-lists,linux-crypto=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,mit.edu,dilger.ca,suse.cz,huawei.com,linux.ibm.com,gmail.com,linux.alibaba.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[libaokun@linux.alibaba.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.alibaba.com:mid,linux.alibaba.com:dkim,alibaba.com:email]
X-Rspamd-Action: no action

In __ext4_new_inode(), the variable 'ino' actually holds a zero-based
bit position within the inode bitmap, not an absolute inode number.
Rename it to 'bit' to better reflect its semantics and avoid confusion
with inode->i_ino.

With this rename, the previous 'ino++' before calculating i_ino is no
longer needed; instead compute i_ino directly as 'bit + 1'.

Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
---
 fs/ext4/ialloc.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index e209e27f827f..8b75b331b26e 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -974,7 +974,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 	struct buffer_head *inode_bitmap_bh = NULL;
 	struct buffer_head *group_desc_bh;
 	ext4_group_t ngroups, group = 0;
-	unsigned long ino = 0;
+	unsigned long bit = 0;
 	struct inode *inode;
 	struct ext4_group_desc *gdp = NULL;
 	struct ext4_inode_info *ei;
@@ -1050,7 +1050,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 
 	if (goal && goal <= le32_to_cpu(sbi->s_es->s_inodes_count)) {
 		group = (goal - 1) / EXT4_INODES_PER_GROUP(sb);
-		ino = (goal - 1) % EXT4_INODES_PER_GROUP(sb);
+		bit = (goal - 1) % EXT4_INODES_PER_GROUP(sb);
 		ret2 = 0;
 		goto got_group;
 	}
@@ -1071,7 +1071,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 	 * unless we get unlucky and it turns out the group we selected
 	 * had its last inode grabbed by someone else.
 	 */
-	for (i = 0; i < ngroups; i++, ino = 0) {
+	for (i = 0; i < ngroups; i++, bit = 0) {
 		err = -EIO;
 
 		gdp = ext4_get_group_desc(sb, group, &group_desc_bh);
@@ -1105,13 +1105,13 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		    EXT4_MB_GRP_IBITMAP_CORRUPT(grp))
 			goto next_group;
 
-		ret2 = find_inode_bit(sb, group, inode_bitmap_bh, &ino);
+		ret2 = find_inode_bit(sb, group, inode_bitmap_bh, &bit);
 		if (!ret2)
 			goto next_group;
 
-		if (group == 0 && (ino + 1) < EXT4_FIRST_INO(sb)) {
+		if (group == 0 && (bit + 1) < EXT4_FIRST_INO(sb)) {
 			ext4_error(sb, "reserved inode found cleared - "
-				   "inode=%lu", ino + 1);
+				   "inode=%lu", bit + 1);
 			ext4_mark_group_bitmap_corrupted(sb, group,
 					EXT4_GROUP_INFO_IBITMAP_CORRUPT);
 			goto next_group;
@@ -1136,21 +1136,20 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 			goto out;
 		}
 		ext4_lock_group(sb, group);
-		ret2 = ext4_test_and_set_bit(ino, inode_bitmap_bh->b_data);
+		ret2 = ext4_test_and_set_bit(bit, inode_bitmap_bh->b_data);
 		if (ret2) {
 			/* Someone already took the bit. Repeat the search
 			 * with lock held.
 			 */
-			ret2 = find_inode_bit(sb, group, inode_bitmap_bh, &ino);
+			ret2 = find_inode_bit(sb, group, inode_bitmap_bh, &bit);
 			if (ret2) {
-				ext4_set_bit(ino, inode_bitmap_bh->b_data);
+				ext4_set_bit(bit, inode_bitmap_bh->b_data);
 				ret2 = 0;
 			} else {
 				ret2 = 1; /* we didn't grab the inode */
 			}
 		}
 		ext4_unlock_group(sb, group);
-		ino++;		/* the inode bitmap is zero-based */
 		if (!ret2)
 			goto got; /* we grabbed the inode! */
 
@@ -1210,9 +1209,9 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		 * relative inode number in this group. if it is greater
 		 * we need to update the bg_itable_unused count
 		 */
-		if (ino > free)
+		if (bit >= free)
 			ext4_itable_unused_set(sb, gdp,
-					(EXT4_INODES_PER_GROUP(sb) - ino));
+					(EXT4_INODES_PER_GROUP(sb) - bit - 1));
 		if (!(sbi->s_mount_state & EXT4_FC_REPLAY))
 			up_read(&grp->alloc_sem);
 	} else {
@@ -1252,7 +1251,8 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 						flex_group)->free_inodes);
 	}
 
-	inode->i_ino = ino + group * EXT4_INODES_PER_GROUP(sb);
+	/* the inode bitmap is zero-based */
+	inode->i_ino = bit + 1 + group * EXT4_INODES_PER_GROUP(sb);
 	/* This is the optimal IO size (for stat), not the fs block size */
 	inode->i_blocks = 0;
 	simple_inode_init_ts(inode);
-- 
2.43.7


