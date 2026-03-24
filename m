Return-Path: <linux-crypto+bounces-22351-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGmOCY26wmlilAQAu9opvQ
	(envelope-from <linux-crypto+bounces-22351-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 24 Mar 2026 17:23:41 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B9ACC318EF3
	for <lists+linux-crypto@lfdr.de>; Tue, 24 Mar 2026 17:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C9C333059810
	for <lists+linux-crypto@lfdr.de>; Tue, 24 Mar 2026 16:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE3A3FB7D8;
	Tue, 24 Mar 2026 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kT7udDgR"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAEB3FADFB;
	Tue, 24 Mar 2026 16:13:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368817; cv=none; b=sokRnKcBVZSG/96UqqN3oFXwOGOa55BQOZXJ2+TFzefphXniQHaUutLfx2JH1PTehk89oZgnLqhBVj3r+1XwZql6kk6zaoRmPlsRTgFFPsF9G0KczFxVUAFpa2UHboLofarQ7/OObMz6IwjUhuoxL/YezZOaLwUx71+ObZPJFE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368817; c=relaxed/simple;
	bh=mf7bLNEda1Tj+dC56foTRX9C+4x8Hkt0HqdruR97d9g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwL44Vwhxv5WZGqkVcUkunD77gqevaKFhd2P5Ra+QNRLXXJV8Mrm3Sr3q6RAe/OADPECBuh/cKCjTAf8WgVKs+LxmpXs0uRlmM4+eIBSP9VV54Rfr96K9tK0uUo2MxT2YrqkaA1b+ugSmAOvudpuGYC5jiuzk8hhhElj/kgyD2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kT7udDgR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC2CC2BCB4;
	Tue, 24 Mar 2026 16:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774368817;
	bh=mf7bLNEda1Tj+dC56foTRX9C+4x8Hkt0HqdruR97d9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kT7udDgR/eIShGgpxF6EuMMi6/OAJ48Y1unf2nmPvkmIdzyplJ3vhRDP1sXTSts/O
	 FPqMbEOs4OfzYbeN2C6L+UxiX8eMZtAYYVXe5k6XEZ4r6FklqTB3OZldJh2etDI2Iq
	 avC/1KlZmj1E03LPKIRmjMNm2xQV9qIAA34TK/y868S7jrb+dQ0HZ1kJasMPXMkNpf
	 hepG5vVNF5/zek/MFBqq0mViDOoP3iyGlZWTeQXfSijz+VcA2qfEXhiae+CYHm/sOs
	 gUyQ6aT/T75PbtSiRnwGwbNX8XOeDT75vElQBSmIzo1swVTa0qi/e2mH4mWydXsYVq
	 DzoMmrsAEYN2g==
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
	linux-crypto@vger.kernel.org,
	"Tycho Andersen (AMD)" <tycho@kernel.org>
Subject: [PATCH v4 7/7] crypto/ccp: Update HV_FIXED page states to allow freeing of memory
Date: Tue, 24 Mar 2026 10:13:01 -0600
Message-ID: <20260324161301.1353976-8-tycho@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324161301.1353976-1-tycho@kernel.org>
References: <20260324161301.1353976-1-tycho@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22351-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tycho@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:email,apana.org.au:email]
X-Rspamd-Queue-Id: B9ACC318EF3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tom Lendacky <thomas.lendacky@amd.com>

After SNP is disabled, any pages allocated as HV_FIXED can now be freed.
Update the page state of these pages and the snp_leak_hv_fixed_pages()
function to free pages on SNP_SHUTDOWN.

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/ccp/sev-dev.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 366303ff6466..939fa8aa155c 100644
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
 			snp_shutdown();
+		snp_hv_fixed_pages_state_update(sev, ALLOCATED);
 	} else {
 		/*
 		 * SNP_SHUTDOWN_EX with IOMMU_SNP_SHUTDOWN set to 1 disables SNP
-- 
2.53.0


