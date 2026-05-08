Return-Path: <linux-crypto+bounces-23863-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WJevEFzU/Wl2jgAAu9opvQ
	(envelope-from <linux-crypto+bounces-23863-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 08 May 2026 14:17:32 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6608B4F63DE
	for <lists+linux-crypto@lfdr.de>; Fri, 08 May 2026 14:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD89F3010B9B
	for <lists+linux-crypto@lfdr.de>; Fri,  8 May 2026 12:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A02A3DDDA7;
	Fri,  8 May 2026 12:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="h/rfQxVC"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F11835F162;
	Fri,  8 May 2026 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778242580; cv=none; b=aRdwofh1gxRSf0xHCRqsiohYH6Egr2XYseAv0Y1vAoILfapMRSxxC+NLu25AMOHkBdtfBBkkKarO2/vd/9BTBUdyvyw3ZdXcJUuPKWWO9EjvCgOG27aNHBNX2LEi3OLPazreVILNKRe7Gbam24p2gjvf4CvqnvhAwhUNOjL18EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778242580; c=relaxed/simple;
	bh=gqAZDoNBVw7UoLpKShbpL7YkyA9xZi/yoZVYE6/Azjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GmBfY9JBQwpnLMKm3pdk3GvJk41sPAlnNhGmfc2MbS5wyWMQQWqohhn3K7fkNpfMVBLShDnqp4JJs9HYtaVvP5zrO0KUnT5SmJGzcQTze2B9PBbYghq4WJBP7ulN9VHWTuYy3xhE8w+G/R8hc9ocU4qBQGKE9LJpS1d8EUJA31Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=h/rfQxVC; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778242567; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=FozibAPcd218Q8rcuEIXF/fsaz9qBa8qxrGVF06VcRg=;
	b=h/rfQxVCQxhXweJBzmX6naUKUhljs3DG0vCRLrXDPsFS0Ptrm0O8MkuBsLv6a9sjgVahRbTdugh6uaHha3UcEMnXT1HW4n3VHq/DaU+2lACj5/XLAq59qgKbVZxitTSOa9paVW8oK7GTu/3LrO5HOKtQWIp2jXbIO4OTR6VwyYo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R541e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X2XQgq5_1778242566;
Received: from x31h02109.sqa.na131.tbsite.net(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X2XQgq5_1778242566 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 May 2026 20:16:06 +0800
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
Subject: [PATCH RFC 09/17] ext4: add ext4_inode_bitmap_csum_set_fast() for incremental checksum update
Date: Fri,  8 May 2026 20:15:31 +0800
Message-ID: <20260508121539.4174601-10-libaokun@linux.alibaba.com>
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
X-Rspamd-Queue-Id: 6608B4F63DE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-6.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23863-lists,linux-crypto=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,mit.edu,dilger.ca,suse.cz,huawei.com,linux.ibm.com,gmail.com,linux.alibaba.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[libaokun@linux.alibaba.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:mid,linux.alibaba.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Action: no action

Add a helper function ext4_inode_bitmap_csum_set_fast() that uses
crc32c_flip_range() to incrementally update the inode bitmap checksum
after flipping a single bit at the given offset. This avoids a full
bitmap CRC rescan, computing the CRC delta in O(log N) time.

Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
---
 fs/ext4/bitmap.c | 23 +++++++++++++++++++++++
 fs/ext4/ext4.h   |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/fs/ext4/bitmap.c b/fs/ext4/bitmap.c
index 008acc439301..ea47ca0d7046 100644
--- a/fs/ext4/bitmap.c
+++ b/fs/ext4/bitmap.c
@@ -71,6 +71,29 @@ void ext4_inode_bitmap_csum_set(struct super_block *sb,
 	ext4_inode_bitmap_csum_store(sb, gdp, csum);
 }
 
+/*
+ * Update inode bitmap checksum for a single flipped bit.
+ *
+ * Use crc32c_flip_range() to incrementally update the checksum after
+ * flipping the bit at @offset, avoiding a full bitmap CRC rescan.
+ * The csum_seed cancels out in the XOR delta, so it is not needed here.
+ */
+void ext4_inode_bitmap_csum_set_fast(struct super_block *sb,
+				     struct ext4_group_desc *gdp,
+				     ext4_grpblk_t offset)
+{
+	__u32 new_csum, old_csum;
+
+	if (!ext4_has_feature_metadata_csum(sb))
+		return;
+
+	old_csum = ext4_inode_bitmap_csum_get(sb, gdp);
+	new_csum = crc32c_flip_range(old_csum, EXT4_INODES_PER_GROUP(sb),
+				     offset, 1);
+
+	ext4_inode_bitmap_csum_store(sb, gdp, new_csum);
+}
+
 static inline __u32 ext4_block_bitmap_csum_get(struct super_block *sb,
 					       struct ext4_group_desc *gdp)
 {
diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index c423a9a04047..e6739d5af490 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2764,6 +2764,9 @@ extern unsigned int ext4_count_free(char *bitmap, unsigned numchars);
 void ext4_inode_bitmap_csum_set(struct super_block *sb,
 				struct ext4_group_desc *gdp,
 				struct buffer_head *bh);
+void ext4_inode_bitmap_csum_set_fast(struct super_block *sb,
+				     struct ext4_group_desc *gdp,
+				     ext4_grpblk_t offset);
 int ext4_inode_bitmap_csum_verify(struct super_block *sb,
 				  struct ext4_group_desc *gdp,
 				  struct buffer_head *bh);
-- 
2.43.7


