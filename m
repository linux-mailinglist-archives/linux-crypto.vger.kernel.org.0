Return-Path: <linux-crypto+bounces-20373-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MD74L2CRdWkcGQEAu9opvQ
	(envelope-from <linux-crypto+bounces-20373-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 25 Jan 2026 04:43:28 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 620DF7FAF7
	for <lists+linux-crypto@lfdr.de>; Sun, 25 Jan 2026 04:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 475BA309699E
	for <lists+linux-crypto@lfdr.de>; Sun, 25 Jan 2026 03:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB8F233722;
	Sun, 25 Jan 2026 03:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NF1lULkO"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842A221FF2E;
	Sun, 25 Jan 2026 03:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769312171; cv=none; b=Vc8hoU8a3vwTQqminyX9qzusIX5jtBXpjRl63HbLrFWIgTLHd1s9g+zvJfNdn90MKJpZTgGr7m2SHeMeNqg7YLvxFdGDma6+fY+snN8+W3X8Juw/NpSJMMhJ7CZfIITG3HvcgHFpCu3m6jOHRnWdTTD585ECzPuQO7BzMD0J9+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769312171; c=relaxed/simple;
	bh=eQejQGKhQgKGnWoiX4nMcvTJdUUdiRQoPHylKVBWLaw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rPkX+ofhIeGYM6BsDiMmBxl96f1qLv+mr5ddJF4tk/2ch/jD0M7aun/ue4n/z5w8pT75Nqfvo0obkiTKMGMk0qdsYr4MO3z2qC+R/AvYBm09HClbLBf84pGlsfWT0Y4R6IoFRaBnCr7odc7YbpYNgOXj6sPAdBxcOIYtWVnBYZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NF1lULkO; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769312166; x=1800848166;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eQejQGKhQgKGnWoiX4nMcvTJdUUdiRQoPHylKVBWLaw=;
  b=NF1lULkOIXNoKOCoHu/DOHbI6AdIChh3mQNmCl/tmnkHrza1mW/Rt5il
   fOeKBxEf8q1y/FPP3bxh2ni1rWDZVbmzqCWnNjzL3eLIA695nWczgeA1i
   sKkHzjHI1ntqygX+ABvMXBsAS8+0hpVwdDDTxUUk7h8KhiBUFNlJ56P8N
   5H0YJHBAJ1GJ6Ax/PFTOhZ5yUAUwVysUi54pkDWg1coInGAb3anXAMDvn
   0Qia4zbT9LX4o5Qz2RMZzUj7zHM5aSzaBXJ1F4uGs8sHhWkVicoGFgPv4
   XEBbCrczHfTK6pTPD2D5M4Djfc/oJcROU7gDlIyFsKYzbmYsnXeoknI9i
   w==;
X-CSE-ConnectionGUID: R+zgAsHKQ/Su7IMDLs+OCg==
X-CSE-MsgGUID: imcdefKqT6imD/3V92LGvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11681"; a="81887557"
X-IronPort-AV: E=Sophos;i="6.21,252,1763452800"; 
   d="scan'208";a="81887557"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2026 19:36:03 -0800
X-CSE-ConnectionGUID: Z85Pl1NcTsK2IN+kQ6nDfg==
X-CSE-MsgGUID: eHRhIEfTSDKJ2a+6EaNrNg==
X-ExtLoop1: 1
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.115])
  by fmviesa003.fm.intel.com with ESMTP; 24 Jan 2026 19:36:02 -0800
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	21cnbao@gmail.com,
	ying.huang@linux.alibaba.com,
	akpm@linux-foundation.org,
	senozhatsky@chromium.org,
	sj@kernel.org,
	kasong@tencent.com,
	linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	clabbe@baylibre.com,
	ardb@kernel.org,
	ebiggers@google.com,
	surenb@google.com,
	kristen.c.accardi@intel.com,
	vinicius.gomes@intel.com,
	giovanni.cabiddu@intel.com
Cc: wajdi.k.feghali@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v14 17/26] crypto: iaa - Submit the two largest source buffers first in batch decompress.
Date: Sat, 24 Jan 2026 19:35:28 -0800
Message-Id: <20260125033537.334628-18-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20260125033537.334628-1-kanchana.p.sridhar@intel.com>
References: <20260125033537.334628-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20373-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,gmail.com,arm.com,linux.alibaba.com,linux-foundation.org,chromium.org,kernel.org,tencent.com,gondor.apana.org.au,davemloft.net,baylibre.com,google.com,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[kanchana.p.sridhar@intel.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 620DF7FAF7
X-Rspamd-Action: no action

This patch finds the two largest source buffers in a given decompression
batch, and submits them first to the IAA decompress engines.

This improves decompress batching latency because the hardware has a
head start on decompressing the highest latency source buffers in the
batch. Workload performance is also significantly improved as a result
of this optimization.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 49 ++++++++++++++++++++--
 1 file changed, 45 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index a447555f4eb9..8d83a1ea15d7 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -2315,12 +2315,46 @@ static __always_inline int iaa_comp_submit_acompress_batch(
 	return ret;
 }
 
+/*
+ * Find the two largest source buffers in @reqs for a decompress batch,
+ * based on @reqs[i]->slen. Save their indices as the first two elements in
+ * @submit_order, and the rest of the indices from the batch order.
+ */
+static void get_decompress_batch_submit_order(
+	struct iaa_req *reqs[],
+	int nr_pages,
+	int submit_order[])
+{
+	int i, j = 0, max_i = 0, next_max_i = 0;
+
+	for (i = 0; i < nr_pages; ++i) {
+		if (reqs[i]->slen >= reqs[max_i]->slen) {
+			next_max_i = max_i;
+			max_i = i;
+		} else if ((next_max_i == max_i) ||
+			   (reqs[i]->slen > reqs[next_max_i]->slen)) {
+			next_max_i = i;
+		}
+	}
+
+	submit_order[j++] = max_i;
+
+	if (next_max_i != max_i)
+		submit_order[j++] = next_max_i;
+
+	for (i = 0; i < nr_pages; ++i) {
+		if ((i != max_i) && (i != next_max_i))
+			submit_order[j++] = i;
+	}
+}
+
 static __always_inline int iaa_comp_submit_adecompress_batch(
 	struct iaa_compression_ctx *ctx,
 	struct iaa_req *parent_req,
 	struct iaa_req **reqs,
 	int nr_reqs)
 {
+	int submit_order[IAA_CRYPTO_MAX_BATCH_SIZE];
 	struct scatterlist *sg;
 	int i, err, ret = 0;
 
@@ -2334,12 +2368,19 @@ static __always_inline int iaa_comp_submit_adecompress_batch(
 		reqs[i]->dlen = PAGE_SIZE;
 	}
 
+	/*
+	 * Construct the submit order by finding the indices of the two largest
+	 * compressed data buffers in the batch, so that they are submitted
+	 * first. This improves latency of the batch.
+	 */
+	get_decompress_batch_submit_order(reqs, nr_reqs, submit_order);
+
 	/*
 	 * Prepare and submit the batch of iaa_reqs to IAA. IAA will process
 	 * these decompress jobs in parallel.
 	 */
 	for (i = 0; i < nr_reqs; ++i) {
-		err = iaa_comp_adecompress(ctx, reqs[i]);
+		err = iaa_comp_adecompress(ctx, reqs[submit_order[i]]);
 
 		/*
 		 * In case of idxd desc allocation/submission errors, the
@@ -2347,12 +2388,12 @@ static __always_inline int iaa_comp_submit_adecompress_batch(
 		 * @err to 0 or an error value.
 		 */
 		if (likely(err == -EINPROGRESS)) {
-			reqs[i]->dst->length = -EAGAIN;
+			reqs[submit_order[i]]->dst->length = -EAGAIN;
 		} else if (unlikely(err)) {
-			reqs[i]->dst->length = err;
+			reqs[submit_order[i]]->dst->length = err;
 			ret = -EINVAL;
 		} else {
-			reqs[i]->dst->length = reqs[i]->dlen;
+			reqs[submit_order[i]]->dst->length = reqs[submit_order[i]]->dlen;
 		}
 	}
 
-- 
2.27.0


