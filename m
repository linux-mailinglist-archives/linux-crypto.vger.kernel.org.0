Return-Path: <linux-crypto+bounces-24234-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GDJbGYamCmpy4wQAu9opvQ
	(envelope-from <linux-crypto+bounces-24234-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 18 May 2026 07:41:26 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D463B5665E4
	for <lists+linux-crypto@lfdr.de>; Mon, 18 May 2026 07:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D01331186AC
	for <lists+linux-crypto@lfdr.de>; Mon, 18 May 2026 05:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B2E39A052;
	Mon, 18 May 2026 05:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="l7gqIaK9"
X-Original-To: linux-crypto@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D513A1699;
	Mon, 18 May 2026 05:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779081698; cv=none; b=TKyE7H+hfTFSrKwEXiUTImT8eAMcpDdxcyYTZrvVVpyIPStc4WluRoZgrLQndSDFztdMT1gRfAuzTt0MBcG4lYHK2zitYIcS73MIEurq6NXEmomZ2P7e9q7MHFrb+Va/kkziNEeTvYaTu5mWExRzUMOjMNHWDm/aXsV0Zo6vfT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779081698; c=relaxed/simple;
	bh=KxzGhq1zpPDgSVPxz1zN2eRsr704yDpX/EpXZNFCzKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MUK/WjJ5GZCklcJoE47rwWPl5MIhjucwYFhZYvVG2dfLf8MEkJKBKo8jkIWCXc8uU+G8++X4yOmekTJ656tQJ1t34ecL61HTDSB/WYdmijoZVHrohQAzIa62ubalCsagNdUpN/oWLF6fxCdnXAthF+xbt/ZJFns/aAYes2y/8jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=l7gqIaK9; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=j9R537ys66SDQq4UyRsVqig8kco2STTEA250dwLwyPU=; b=l7gqIaK9590gEyccmAt+EOnDP/
	UhBSeQ0/VaSnNLHGlMiedKqbLTbfO1FePSw+I2RcM+zU859l7SDxkAPet6KoB1ynHShwooywoIZAo
	hHAQk3/inLvNul0R1A4nI01I+9hssMR+jqjadoc0+waVky38dlnplaGbuxJDuOvo11cJkU0msxi7i
	qRVOwte6cVQK6sg7He1NsZ/bVtRRq1gWiBu3wYpmUVFGawjMiWrrfu3ArSXgTyOrp6t73LqbuJeoi
	TzjQ/J4SqyQwYo7u84EGmL+GnOg3/qsr5k6M6xDkKEdFAxpTzWbRNjzm/14lirFieFpnXdXdsTWpM
	OTQcmnvg==;
Received: from [2001:4bb8:2d1:6fdb:d67d:128c:34ba:85b8] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOqPX-0000000EH97-322d;
	Mon, 18 May 2026 05:21:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: [PATCH 11/18] raid6: use static_call for gen_syndrom and xor_syndrom
Date: Mon, 18 May 2026 07:17:54 +0200
Message-ID: <20260518051804.462141-12-hch@lst.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260518051804.462141-1-hch@lst.de>
References: <20260518051804.462141-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Rspamd-Queue-Id: D463B5665E4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), DKIM not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24234-lists,linux-crypto=lfdr.de];
	FREEMAIL_CC(0.00)[arm.com,kernel.org,xen0n.name,linux.ibm.com,ellerman.id.au,gmail.com,dabbelt.com,eecs.berkeley.edu,ghiti.fr,redhat.com,alien8.de,linux.intel.com,zytor.com,gondor.apana.org.au,intel.com,fb.com,suse.com,arndb.de,fnnas.com,huawei.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,lists.ozlabs.org];
	RCPT_COUNT_TWELVE(0.00)[43];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[infradead.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lst.de:email,lst.de:mid,infradead.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Avoid indirect calls for P/Q parity generation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Ard Biesheuvel <ardb@kernel.org> # kunit only on arm64
---
 lib/raid/raid6/algos.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/lib/raid/raid6/algos.c b/lib/raid/raid6/algos.c
index 30d7cb34874f..ff99202cad46 100644
--- a/lib/raid/raid6/algos.c
+++ b/lib/raid/raid6/algos.c
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/gfp.h>
 #include <linux/raid/pq.h>
+#include <linux/static_call.h>
 #include <kunit/visibility.h>
 #include "algos.h"
 
@@ -23,7 +24,8 @@ static unsigned int raid6_nr_algos;
 static const struct raid6_recov_calls *raid6_recov_algo;
 
 /* Selected algorithm */
-static struct raid6_calls raid6_call;
+DEFINE_STATIC_CALL_NULL(raid6_gen_syndrome_impl, *raid6_intx1.gen_syndrome);
+DEFINE_STATIC_CALL_NULL(raid6_xor_syndrome_impl, *raid6_intx1.xor_syndrome);
 
 /**
  * raid6_gen_syndrome - generate RAID6 P/Q parity
@@ -48,7 +50,7 @@ void raid6_gen_syndrome(int disks, size_t bytes, void **ptrs)
 	WARN_ON_ONCE(bytes & 511);
 	WARN_ON_ONCE(disks < RAID6_MIN_DISKS);
 
-	raid6_call.gen_syndrome(disks, bytes, ptrs);
+	static_call(raid6_gen_syndrome_impl)(disks, bytes, ptrs);
 }
 EXPORT_SYMBOL_GPL(raid6_gen_syndrome);
 
@@ -85,7 +87,7 @@ void raid6_xor_syndrome(int disks, int start, int stop, size_t bytes,
 	WARN_ON_ONCE(disks < RAID6_MIN_DISKS);
 	WARN_ON_ONCE(stop < start);
 
-	raid6_call.xor_syndrome(disks, start, stop, bytes, ptrs);
+	static_call(raid6_xor_syndrome_impl)(disks, start, stop, bytes, ptrs);
 }
 EXPORT_SYMBOL_GPL(raid6_xor_syndrome);
 
@@ -96,7 +98,7 @@ EXPORT_SYMBOL_GPL(raid6_xor_syndrome);
  */
 bool raid6_can_xor_syndrome(void)
 {
-	return !!raid6_call.xor_syndrome;
+	return !!static_call_query(raid6_xor_syndrome_impl);
 }
 EXPORT_SYMBOL_GPL(raid6_can_xor_syndrome);
 
@@ -195,7 +197,8 @@ static int raid6_choose_gen(void *(*const dptrs)[RAID6_TEST_DISKS],
 		return -EINVAL;
 	}
 
-	raid6_call = *best;
+	static_call_update(raid6_gen_syndrome_impl, best->gen_syndrome);
+	static_call_update(raid6_xor_syndrome_impl, best->xor_syndrome);
 
 	pr_info("raid6: using algorithm %s gen() %ld MB/s\n",
 		best->name,
@@ -240,7 +243,10 @@ static int __init raid6_select_algo(void)
 	if (!IS_ENABLED(CONFIG_RAID6_PQ_BENCHMARK) || raid6_nr_algos == 1) {
 		pr_info("raid6: skipped pq benchmark and selected %s\n",
 			raid6_algos[raid6_nr_algos - 1]->name);
-		raid6_call = *raid6_algos[raid6_nr_algos - 1];
+		static_call_update(raid6_gen_syndrome_impl,
+				raid6_algos[raid6_nr_algos - 1]->gen_syndrome);
+		static_call_update(raid6_xor_syndrome_impl,
+				raid6_algos[raid6_nr_algos - 1]->xor_syndrome);
 		return 0;
 	}
 
-- 
2.53.0


