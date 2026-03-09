Return-Path: <linux-crypto+bounces-21739-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPrhIkIMr2lzMQIAu9opvQ
	(envelope-from <linux-crypto+bounces-21739-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 09 Mar 2026 19:06:58 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 210B523E373
	for <lists+linux-crypto@lfdr.de>; Mon, 09 Mar 2026 19:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8764330571AB
	for <lists+linux-crypto@lfdr.de>; Mon,  9 Mar 2026 18:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D5C3E9F9A;
	Mon,  9 Mar 2026 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTF5wN4n"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269A23E9F88;
	Mon,  9 Mar 2026 18:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079297; cv=none; b=BWcxnQEHHvvv5Bmq46CW677DMUkEsTVzfSCLUcKcGCDVvmx4meGoYMfBpbVjk12RPNLapt8e2nToV9jtbuv5Ygpdbs3X8Y+jgLnwgXUakfJYvRNorTxTetRjxjLKwj4AG5PG5oXBWM2Rr95whfWh6B7lfmhlVEOXJGTpzCIaMvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079297; c=relaxed/simple;
	bh=4qhPs0u0MDTJre/3DNAo+CNY3QBGUHi6CuPNrOVlC7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKRUuUqZowT8i10T2wp5PlN5yr6XrvVtMDWwAbC4a6ojt8TaT774NAr8Wc6plT2k4Bh/frz6Oippjxn4JusDCVoa3Wks9vg29oTmDqeeK/V1CoLRLNL0vVelAxnRx7nK5O1AVFeCuT59SFKp6/I4hGSH7T03JvqrwK9XRTnraeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTF5wN4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAC83C4CEF7;
	Mon,  9 Mar 2026 18:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773079297;
	bh=4qhPs0u0MDTJre/3DNAo+CNY3QBGUHi6CuPNrOVlC7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LTF5wN4nv/R6vnU5SNiOJAuYHqPuFenFPM9l9/fFxiuQR5DRQqkSD5lnARifIAvs2
	 Qp294vBqwa1EdJTCVEI3xSR1njo0PuV9nJSjmbc4CdJFldNheEwEhCLz8vhCZP9mex
	 d7nRGYdHXQgl7LCLZaL4ShlP+ECgqvtwm2YDibGa94gZhjw0MOq+8jXpC4PoYOuEVV
	 qn8fQbkiap9uUHEvDs7SauxcwBmCNmPQktG0YfUdbFbtRrTmv9btjDxN6RpGYst6Gt
	 OrO9Q1LCHa5FdxhlaWfFEw6w+oB/bzigBz5O9yRRPfde/WNw2SxXjttyswSz+UPLbn
	 s8swQNSFYQFWA==
From: Tycho Andersen <tycho@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	John Allen <john.allen@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Ard Biesheuvel <ardb@kernel.org>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Kishon Vijay Abraham I <kvijayab@amd.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Kim Phillips <kim.phillips@amd.com>,
	Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: [PATCH v2 10/10] crypto: ccp - Update HV_FIXED page states to allow freeing of memory
Date: Mon,  9 Mar 2026 12:00:52 -0600
Message-ID: <20260309180053.2389118-11-tycho@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309180053.2389118-1-tycho@kernel.org>
References: <20260306153846.GKaar1Bg_1EKm17tXJ@fat_crate.local>
 <20260309180053.2389118-1-tycho@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 210B523E373
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21739-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tycho@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amd.com:email]
X-Rspamd-Action: no action

From: Tom Lendacky <thomas.lendacky@amd.com>

After SNP is disabled, any pages allocated as HV_FIXED can now be freed.
Update the page state of these pages and the snp_leak_hv_fixed_pages()
function to free pages on SNP_SHUTDOWN.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
---
 drivers/crypto/ccp/sev-dev.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index be6f3720e929..eac1181c2f6a 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1219,7 +1219,7 @@ static void snp_add_hv_fixed_pages(struct sev_device *sev, struct sev_data_range
 
 static void snp_leak_hv_fixed_pages(void)
 {
-	struct snp_hv_fixed_pages_entry *entry;
+	struct snp_hv_fixed_pages_entry *entry, *nentry;
 
 	/* List is protected by sev_cmd_mutex */
 	lockdep_assert_held(&sev_cmd_mutex);
@@ -1227,10 +1227,16 @@ static void snp_leak_hv_fixed_pages(void)
 	if (list_empty(&snp_hv_fixed_pages))
 		return;
 
-	list_for_each_entry(entry, &snp_hv_fixed_pages, list)
-		if (entry->page_state == HV_FIXED)
+	list_for_each_entry_safe(entry, nentry, &snp_hv_fixed_pages, list) {
+		if (entry->free && entry->page_state != HV_FIXED)
+			__free_pages(entry->page, entry->order);
+		else
 			__snp_leak_pages(page_to_pfn(entry->page),
 					 1 << entry->order, false);
+
+		list_del(&entry->list);
+		kfree(entry);
+	}
 }
 
 bool sev_is_snp_ciphertext_hiding_supported(void)
@@ -2077,6 +2083,7 @@ static int __sev_snp_shutdown_locked(int *error, bool panic)
 	if (data.x86_snp_shutdown) {
 		if (!panic)
 			snp_x86_shutdown();
+		snp_hv_fixed_pages_state_update(sev, ALLOCATED);
 	} else {
 		/*
 		 * SNP_SHUTDOWN_EX with IOMMU_SNP_SHUTDOWN set to 1 disables SNP
-- 
2.53.0


