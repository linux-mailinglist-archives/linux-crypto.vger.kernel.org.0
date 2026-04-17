Return-Path: <linux-crypto+bounces-23087-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACjgH9t94WmdtwAAu9opvQ
	(envelope-from <linux-crypto+bounces-23087-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Apr 2026 02:24:59 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 805D5415CDD
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Apr 2026 02:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DFF1A301D20D
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Apr 2026 00:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C750D1B4F0A;
	Fri, 17 Apr 2026 00:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXv1HusL"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87732199920;
	Fri, 17 Apr 2026 00:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776385492; cv=none; b=HwiHLE4ZMeCVHRR9BJv8suSilSrEPvwAKfQWwzKwbvqgoOH1A6ntlidg63aYv0Rfui1OGxrnM3g5Pv0VTRcPG54TueK8FeX1Z8dMw5QrPU/v1gxdPnMLwAW/wqXRDmV3H5itthEFmX3jGr6VWnggptOnHHUByMGN9UG4Yeiy14k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776385492; c=relaxed/simple;
	bh=+KJ9XVlACVv6ZdQkETY1VRfo9BaCSRo7KefX3MmZ6a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EjoxLdyy8uF6wjBLqRszXed8d+X8Z8abK1dAGeNIKs3C1PhPZCc+I0/JQmhoiDnoviiVkCPXdYPufyW6p+/nyccoCpokYD/MEZqwdxR3ALFZzJ99stkOU+wU+IGU5jIg9ffA6LEQm/72zjAUGIP4ZJLY4lhP+U7auY8iqcVocxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXv1HusL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15408C2BCAF;
	Fri, 17 Apr 2026 00:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776385492;
	bh=+KJ9XVlACVv6ZdQkETY1VRfo9BaCSRo7KefX3MmZ6a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qXv1HusLbMbC+OOnW1UGS3FWvZk0Qc4Q4MxVHJOfti2x8WgbRMmPOi6d+/EPWiudM
	 wJVFOxnZWKGWKh3TM798JUPplLO6RntqeHIHqiGRzYppGYPCklJDeWU60NE4X68YIe
	 xpTWz8fdXdOf3qSh+8hQhM4/o74/Ab8tBWkSEeWfcdJvDfFyedd3CczY3oWM+06R8Z
	 cMLFt2SEOJEJnW8HnSy8XBRHSIPysBZcFAxNlYGblQ/oXl2CS02EpAU+4aM3tDUOdC
	 yMO8W9Xc2vQwlMJK6hfGY0haWlAc2/n/+1a7r8QufJXKqu4BZX0RieoUxg9iTbE9p4
	 NXgyggPNjKidA==
From: Tejun Heo <tj@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	Thomas Graf <tgraf@suug.ch>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	linux-crypto@vger.kernel.org,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH for-7.1-fixes 2/2] sched_ext: mark scx_sched_hash and dsq_hash no_sync_grow
Date: Thu, 16 Apr 2026 14:24:49 -1000
Message-ID: <20260417002449.2290577-2-tj@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417002449.2290577-1-tj@kernel.org>
References: <20260417002449.2290577-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23087-lists,linux-crypto=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tj@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 805D5415CDD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Both are inserted/removed under raw_spinlock_t (scx_sched_lock and dsq->lock
respectively). rhashtable's sync grow path is unsafe under raw_spinlock_t.
Set no_sync_grow so inserts only ever take the bucket bit-spin lock; the
deferred worker continues to grow the table.

Fixes: f0e1a0643a59 ("sched_ext: Implement BPF extensible scheduler class")
Fixes: 25037af712eb ("sched_ext: Add rhashtable lookup for sub-schedulers")
Cc: stable@vger.kernel.org # v6.11+
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 012ca8bd70fb..3f1467fde075 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -32,6 +32,7 @@ static const struct rhashtable_params scx_sched_hash_params = {
 	.key_len		= sizeof_field(struct scx_sched, ops.sub_cgroup_id),
 	.key_offset		= offsetof(struct scx_sched, ops.sub_cgroup_id),
 	.head_offset		= offsetof(struct scx_sched, hash_node),
+	.no_sync_grow		= true,	/* inserted under scx_sched_lock */
 };
 
 static struct rhashtable scx_sched_hash;
@@ -122,6 +123,7 @@ static const struct rhashtable_params dsq_hash_params = {
 	.key_len		= sizeof_field(struct scx_dispatch_q, id),
 	.key_offset		= offsetof(struct scx_dispatch_q, id),
 	.head_offset		= offsetof(struct scx_dispatch_q, hash_node),
+	.no_sync_grow		= true,	/* removed under dsq->lock */
 };
 
 static LLIST_HEAD(dsqs_to_free);
-- 
2.53.0


