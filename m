Return-Path: <linux-crypto+bounces-24231-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPDyGzamCmpy4wQAu9opvQ
	(envelope-from <linux-crypto+bounces-24231-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 18 May 2026 07:40:06 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B161A5665C7
	for <lists+linux-crypto@lfdr.de>; Mon, 18 May 2026 07:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7AA1C31D7F8D
	for <lists+linux-crypto@lfdr.de>; Mon, 18 May 2026 05:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64231396579;
	Mon, 18 May 2026 05:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SDdM5XD3"
X-Original-To: linux-crypto@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D8F3947AB;
	Mon, 18 May 2026 05:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779081647; cv=none; b=WLBLmwxHnctHR599pqKaQrhKC3EqrFADSfoahDrtopuCBfdKLxpGKb/ei9XbKu8J6Vi5yc7BhdNt1IMfPHkC410oPGP+05IRpuRAqEop6yLMyPbns8KcSi21Ye0oNSodg0T8nlmTWllccXyUwUD8H5K53cTq4I+F1iFn0aPLJOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779081647; c=relaxed/simple;
	bh=Jzh52AmgJp4eeiU7JVahJ/C2EEOmTXryDB0QzrkOHms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=guWKB4ziwTciSYkiAkjYv2cyF6RXScSaoqpHkVe7fnpaiNgvjLld/YJMcM7FmZG6VMI4HJJPltLLU7A08BtzpGk+GwXZZpoXxotAoEOlD/zebkoJz/kCpJJ/YhgLTp1Q1GwkyO8S06+WhFHWRUBF+IMd3tl5HLeH/2qNqHVimOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SDdM5XD3; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=phfgrGTmhjQjM3TY6ZoI4XSopq/ltnl5TBViggGEnP4=; b=SDdM5XD3KGXf2ji8wBwXA3e2wN
	1jeQIc7NadTQHAMNNjok/lc1LrzZ7IYBrjFmF0bzDlvzt4akoIdxQyLb2xj27v8PlFArY0Ap18e8i
	ipyQ++Xch5ZrWzVb6zTppJPkKMa1lEBywu4AdouT4TY8kFPJFxAcUF5A9HhIrEC4woOWgrK7MZ931
	XfPCR7Y8QGCjQLAowTFAbwHwqlA5f5P7nT/ua7gYXlmBgSWtPsdDwamRBjS+gWgzw+ORqGjEIfe+i
	sImhGGJpkr4HI8EWyooLaexcJs6GqRLOoFoiU8zFQMjr6KXxf8RbvMYi9gdCzsmzBDfSxwZgmH8D9
	yiAEC51Q==;
Received: from [2001:4bb8:2d1:6fdb:d67d:128c:34ba:85b8] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOqOn-0000000EGcX-1AkH;
	Mon, 18 May 2026 05:20:17 +0000
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
Subject: [PATCH 08/18] raid6: warn when using less than four devices
Date: Mon, 18 May 2026 07:17:51 +0200
Message-ID: <20260518051804.462141-9-hch@lst.de>
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
X-Rspamd-Queue-Id: B161A5665C7
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
	TAGGED_FROM(0.00)[bounces-24231-lists,linux-crypto=lfdr.de];
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

Quoting H. Peter Anvin who came up with the RAID6 P/Q algorithm, and
who wrote the initial implementation, then still part of the md driver:

  The RAID-6 code has *never* supported only 3 units, and if it ever
  worked for *any* of the implementations it was purely by accident.
  Speaking as the original author I should know; this was deliberate as
  in some cases the degenerate case (3) would have required extra trays
  in the code to no user benefit.

While md never allowed less than 4 devices, btrfs does.  This new
warning will trigger for such file systems, but given how it already
causes havoc that is a good thing.  If btrfs wants to fix third, it
should switch to transparently use three-way mirroring underneath,
which will work as P and Q are copies of the single data device by
the definition of the Linux RAID 6 P/Q algorithm.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Ard Biesheuvel <ardb@kernel.org> # kunit only on arm64
---
 include/linux/raid/pq.h | 2 ++
 lib/raid/raid6/algos.c  | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/raid/pq.h b/include/linux/raid/pq.h
index 425a227591c0..87e3cb55bf07 100644
--- a/include/linux/raid/pq.h
+++ b/include/linux/raid/pq.h
@@ -11,6 +11,8 @@
 #include <linux/blkdev.h>
 #include <linux/mm.h>
 
+#define RAID6_MIN_DISKS		4
+
 void raid6_gen_syndrome(int disks, size_t bytes, void **ptrs);
 void raid6_xor_syndrome(int disks, int start, int stop, size_t bytes,
 		void **ptrs);
diff --git a/lib/raid/raid6/algos.c b/lib/raid/raid6/algos.c
index b0ba31f6d48e..63d1945ba63c 100644
--- a/lib/raid/raid6/algos.c
+++ b/lib/raid/raid6/algos.c
@@ -42,6 +42,7 @@ void raid6_gen_syndrome(int disks, size_t bytes, void **ptrs)
 {
 	WARN_ON_ONCE(!in_task() || irqs_disabled() || softirq_count());
 	WARN_ON_ONCE(bytes & 511);
+	WARN_ON_ONCE(disks < RAID6_MIN_DISKS);
 
 	raid6_call.gen_syndrome(disks, bytes, ptrs);
 }
@@ -77,6 +78,7 @@ void raid6_xor_syndrome(int disks, int start, int stop, size_t bytes,
 {
 	WARN_ON_ONCE(!in_task() || irqs_disabled() || softirq_count());
 	WARN_ON_ONCE(bytes & 511);
+	WARN_ON_ONCE(disks < RAID6_MIN_DISKS);
 	WARN_ON_ONCE(stop < start);
 
 	raid6_call.xor_syndrome(disks, start, stop, bytes, ptrs);
-- 
2.53.0


