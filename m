Return-Path: <linux-crypto+bounces-23852-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eI3zFR7V/Wl2jgAAu9opvQ
	(envelope-from <linux-crypto+bounces-23852-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 08 May 2026 14:20:46 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C632F4F64C6
	for <lists+linux-crypto@lfdr.de>; Fri, 08 May 2026 14:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 117CE309883B
	for <lists+linux-crypto@lfdr.de>; Fri,  8 May 2026 12:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2EE1382F00;
	Fri,  8 May 2026 12:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YA1taRYV"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BAD35F162;
	Fri,  8 May 2026 12:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778242574; cv=none; b=UkXzpA6LQHUG4XLLuIo9nTEhEnnOgoW/JZhaY5+z9JtziMFsNVkCua2S3i5tewP52tIUVEaWXVCEsoAO8X9oEXBnDld7oFnpb8nA9Dod2hnXFX2+H+thWc7qhz+w5fOdqQnaqH3uj2tCEy67YN3AfS/ltahczyEAgd78SPCB5ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778242574; c=relaxed/simple;
	bh=mEsys1h5aQK0DP4Yf0qcPeRK2Era4FTmUC8qic3NsDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fCLRA9cCgoeVeFZW7tHJj/8OGbvIgIiLAtODD7PfDlbLJP9erO5aFAflXbYv4pmrXoNCY7qFvbykwAtcjdtGMPnBbQbhmskN1OLHXFjGFOaPj1kMTr7L2hIyQmnQfOTK9v99yKfNaWQ8LLl+8PkmcpLEFe3RJCGKnhynTeLgWMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YA1taRYV; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1778242562; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=4yw5AFB5qsJSIITpEFRXbsszGR1UshaGAlig0l2OZ7g=;
	b=YA1taRYV+j7hgzLyGGlfMfJir9P1iTJMv7jphvV7k+WggjO/TMRHgHvU1STtPqX/QZna75nU2MIKy7fg6jPhdUe5tHDPMsCOjFijnO7BKZ0t1Ba3weaqrVsLaJPB2bLq4sPk2QUm1yyTgbpxVE85xFXjXz4jWYG0ek/T0QigPHE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=libaokun@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0X2XQgnv_1778242561;
Received: from x31h02109.sqa.na131.tbsite.net(mailfrom:libaokun@linux.alibaba.com fp:SMTPD_---0X2XQgnv_1778242561 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 08 May 2026 20:16:01 +0800
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
Subject: [PATCH RFC 03/17] lib/crc: crc_kunit: add benchmark for crc32c_flip_range()
Date: Fri,  8 May 2026 20:15:25 +0800
Message-ID: <20260508121539.4174601-4-libaokun@linux.alibaba.com>
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
X-Rspamd-Queue-Id: C632F4F64C6
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
	TAGGED_FROM(0.00)[bounces-23852-lists,linux-crypto=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,linux.alibaba.com:mid,linux.alibaba.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add a kunit benchmark comparing crc32c_flip_range() against full crc32c
recomputation across bitmap sizes from 1KB to 64KB. The benchmark reports
per-call latency in nanoseconds and the speedup ratio.

Sample results (x86_64, Intel(R) Xeon(R) Platinum 8331C):

bitmap=1024: flip_range=48 ns, full_crc=45 ns, speedup=0.9x
bitmap=2048: flip_range=53 ns, full_crc=88 ns, speedup=1.6x
bitmap=4096: flip_range=57 ns, full_crc=182 ns, speedup=3.1x
bitmap=8192: flip_range=63 ns, full_crc=357 ns, speedup=5.6x
bitmap=16384: flip_range=68 ns, full_crc=709 ns, speedup=10.3x
bitmap=32768: flip_range=73 ns, full_crc=1421 ns, speedup=19.3x
bitmap=65536: flip_range=78 ns, full_crc=2853 ns, speedup=36.3x

Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
---
 lib/crc/tests/crc_kunit.c | 52 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/lib/crc/tests/crc_kunit.c b/lib/crc/tests/crc_kunit.c
index 46f9df5b58e4..8e8b541b37d3 100644
--- a/lib/crc/tests/crc_kunit.c
+++ b/lib/crc/tests/crc_kunit.c
@@ -554,6 +554,57 @@ static void crc32c_flip_range_test(struct kunit *test)
 	}
 }
 
+/*
+ * Benchmark crc32c_flip_range vs full crc32c recomputation
+ */
+static void crc32c_flip_range_benchmark(struct kunit *test)
+{
+	static const size_t bitmap_sizes[] = {
+		1024, 2048, 4096, 8192, 16384, 32768, 65536,
+	};
+	size_t i, j, num_iters, buflen, total_bits;
+	volatile u32 crc;
+	u64 t_flip, t_full;
+	u8 *buf;
+
+	if (!IS_ENABLED(CONFIG_CRC_BENCHMARK))
+		kunit_skip(test, "not enabled");
+
+	buf = kunit_kzalloc(test, 65536, GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, buf);
+
+	for (i = 0; i < ARRAY_SIZE(bitmap_sizes); i++) {
+		buflen = bitmap_sizes[i];
+		total_bits = buflen * 8;
+		num_iters = 10000000 / (buflen + 128);
+
+		/* Benchmark crc32c_flip_range */
+		crc = crc32c(0, buf, buflen);
+		preempt_disable();
+		t_flip = ktime_get_ns();
+		for (j = 0; j < num_iters; j++)
+			crc = crc32c_flip_range(crc, total_bits, 100, 100);
+		t_flip = ktime_get_ns() - t_flip;
+		preempt_enable();
+
+		/* Benchmark full crc32c recomputation */
+		preempt_disable();
+		t_full = ktime_get_ns();
+		for (j = 0; j < num_iters; j++)
+			crc = crc32c(0, buf, buflen);
+		t_full = ktime_get_ns() - t_full;
+		preempt_enable();
+
+		kunit_info(test,
+			   "bitmap=%zu: flip_range=%llu ns, full_crc=%llu ns, speedup=%llu.%01llux\n",
+			   buflen,
+			   div64_u64(t_flip, num_iters),
+			   div64_u64(t_full, num_iters),
+			   div64_u64(t_full * 10, t_flip ? t_flip : 1) / 10,
+			   div64_u64(t_full * 10, t_flip ? t_flip : 1) % 10);
+	}
+}
+
 static struct kunit_case crc_test_cases[] = {
 #if IS_REACHABLE(CONFIG_CRC7)
 	KUNIT_CASE(crc7_be_test),
@@ -575,6 +626,7 @@ static struct kunit_case crc_test_cases[] = {
 	KUNIT_CASE(crc32c_test),
 	KUNIT_CASE(crc32c_benchmark),
 	KUNIT_CASE(crc32c_flip_range_test),
+	KUNIT_CASE(crc32c_flip_range_benchmark),
 #endif
 #if IS_REACHABLE(CONFIG_CRC64)
 	KUNIT_CASE(crc64_be_test),
-- 
2.43.7


