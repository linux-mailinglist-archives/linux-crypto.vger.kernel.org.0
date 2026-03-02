Return-Path: <linux-crypto+bounces-21423-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEPUAc7ipWkvHgAAu9opvQ
	(envelope-from <linux-crypto+bounces-21423-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 02 Mar 2026 20:19:42 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6711E1DEC87
	for <lists+linux-crypto@lfdr.de>; Mon, 02 Mar 2026 20:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E86F30F52CB
	for <lists+linux-crypto@lfdr.de>; Mon,  2 Mar 2026 19:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B0D387352;
	Mon,  2 Mar 2026 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sb8NCgph"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844213859FD;
	Mon,  2 Mar 2026 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772478884; cv=none; b=fQKVQBY+qyLQGApuNj3lnKDBmZN1/KrR30oNQaR5C9+SzUtVGCQzTibgtlxc9oYxrm+BDt449VPaxkeRYo0o9YWh/8RmaQJ1KzQb90TaaInqsr2Bb0FzkPxC4blxkvBXhIxE0HkMzCOsGaIRG/4voNHuyFmH/PHDAmStOCq4ExE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772478884; c=relaxed/simple;
	bh=scqSkI1wuci+U/aGIgSppjWdI7sQBnMTjpRIS4c6EVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sxlJ5L4k9vfP0ANKRZOzbWUEorvcRhXaKf60/ICVcI0kS/9vdsTePh2uz6MlWsXDGL6LG0giNjqJybnv6zA51JysjGwe7soVQHg9A0lMK1C7gveKqLjZfc6DKZQ4Nl7uUr5cJQApC3sUv2C/QxAzpvkadtMfOiqgiAZoeLgSpmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sb8NCgph; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2E1FC2BC87;
	Mon,  2 Mar 2026 19:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772478884;
	bh=scqSkI1wuci+U/aGIgSppjWdI7sQBnMTjpRIS4c6EVE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sb8NCgphYlCeUd/mSHzZDsHBuFknF5UnGuGenyTOsoIIbQT2XvZy+tBJdpI40aV18
	 wxlT8kmJ9FRfyLbFWNuxAwS0suHU9VJxRpQ21xkAP7tgK/3UOnHqMVhCXj1CmDvtea
	 nx3w9Cc757Xd2jO6yZifCUYJ3ynEwUeAiWBgK50jwe4NCJ9yBBnPZIDFw7/r6RxMoO
	 P8xF3UthUxZ4tZXE5w0eToDdGz9b+GcJzAv1rapvF99C/cVKCRxy1GpK/LuIYhtRUV
	 fZlcd7fWVeFh5v2ev9Afnkfbzb670N5i7xIRKsoY5XYhNo5kXnXEXDz4Xb9FgW5qkq
	 EEOT5ueX+MguQ==
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
Subject: [PATCH 06/11] x86/snp, crypto: move SNP init to ccp driver
Date: Mon,  2 Mar 2026 12:13:29 -0700
Message-ID: <20260302191334.937981-7-tycho@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302191334.937981-1-tycho@kernel.org>
References: <20260302191334.937981-1-tycho@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 6711E1DEC87
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21423-lists,linux-crypto=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tycho@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

From: "Tycho Andersen (AMD)" <tycho@kernel.org>

Use the new snp_prepare_for_snp_init() to initialize SNP from the ccp
driver instead of at boot time. This means that SNP is not enabled unless
it is really going to be used (i.e. kvm_amd loads the ccp driver
automatically).

Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
---
 arch/x86/virt/svm/sev.c      | 2 --
 drivers/crypto/ccp/sev-dev.c | 2 ++
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 8f50538baf7b..aa784542b32d 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -549,8 +549,6 @@ int __init snp_rmptable_init(void)
 	if (!setup_rmptable())
 		return -ENOSYS;
 
-	snp_prepare_for_snp_init();
-
 	/*
 	 * Setting crash_kexec_post_notifiers to 'true' to ensure that SNP panic
 	 * notifier is invoked to do SNP IOMMU shutdown before kdump.
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 096f993974d1..5b1a24b11e3e 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -1375,6 +1375,8 @@ static int __sev_snp_init_locked(int *error, unsigned int max_snp_asid)
 		return -EOPNOTSUPP;
 	}
 
+	snp_prepare_for_snp_init();
+
 	/* SNP_INIT requires MSR_VM_HSAVE_PA to be cleared on all CPUs. */
 	on_each_cpu(snp_set_hsave_pa, NULL, 1);
 
-- 
2.53.0


