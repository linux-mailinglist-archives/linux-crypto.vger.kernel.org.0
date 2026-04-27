Return-Path: <linux-crypto+bounces-23446-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGq5FcHM72knGAEAu9opvQ
	(envelope-from <linux-crypto+bounces-23446-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Apr 2026 22:53:21 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CE447A546
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Apr 2026 22:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A13530429AE
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Apr 2026 20:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9582A3C5538;
	Mon, 27 Apr 2026 20:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Uir03wz7"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0E13A75A4;
	Mon, 27 Apr 2026 20:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777323045; cv=none; b=DfyMYUrcEyKaf3/U/v/iio+gQnfKX3KGU15sGadWrVCgmvO0QK4NHiHOxVBkmID1N7QjsOzjMCseoNqotMcpR28VBNEx6hCC5g8Hwy8l3qrY8mVgvdt6QE3xdO6hxjv/Ayl+XmG5/teJxi+6ZknupbgfHCjo3By1VA4fLWNX9FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777323045; c=relaxed/simple;
	bh=GwK3wrKcvZUv9x6NuNYcq4nOFKtJixHLHI7btCyj6D4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ggNkqOgIcaIa0ZUHAOldiFQmLvNbaKeSyXo8EJ0hM7huIiavyKIZbg4n/CKzdK04f9VycIeIi2c2nIh0MM3tqfbK7K9lAVtd2wP80rd+o6sZ9afeY9WpWb5KmH0u51eCjM0h7JdpZseQPLyDYdUitlvBPuy5RTUcpKQKSjRBgs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uir03wz7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D74CC2BCB5;
	Mon, 27 Apr 2026 20:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777323044;
	bh=GwK3wrKcvZUv9x6NuNYcq4nOFKtJixHLHI7btCyj6D4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Uir03wz7kbab8aKtAC3MiktGCtLLWVmGw1d5LJuOQRcuSRAg2Cf2mtoiW9DNykyog
	 wZGMoraaNV9Ocm5czOssbGN5CYBOE1oqJMvB5pHeywORw+GCWZq8xM5W9ngEVCXy55
	 FuvZptLBIMfi9iX3yXUFUkS7XyWPo8OjxfQUA4s0Efm+Mf86gOaEtbWOW5xhJUGtW8
	 X8HgmfFd86qxQohnSmrrM5tDf8sT5VMbtKbRMSg1ydGFNEmoFy0YNK/DdMo6Z58PPP
	 dh0dW8pJZyvnG/6+IHKFrAtLq0plhE3vA6p3y6G2XHCNvzdVsMO7R6ejtsES3Yw6w4
	 hOmqsVFtMNu6g==
From: Tycho Andersen <tycho@kernel.org>
To: Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	John Allen <john.allen@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kim Phillips <kim.phillips@amd.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	"Tycho Andersen (AMD)" <tycho@kernel.org>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Marco Elver <elver@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Li RongQing <lirongqing@baidu.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 3/4] KVM: SEV: Add the kvm-amd.rapl_disable module parameter
Date: Mon, 27 Apr 2026 14:48:46 -0600
Message-ID: <20260427204847.112899-4-tycho@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260427204847.112899-1-tycho@kernel.org>
References: <20260427204847.112899-1-tycho@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C9CE447A546
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23446-lists,linux-crypto=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tycho@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

From: "Tycho Andersen (AMD)" <tycho@kernel.org>

Add a user-visible way to set the RAPL_DIS bit for SNP init.

Since setting RAPL_DIS affects the whole system, put the module parameter
in kvm_amd instead of in the CCP driver to hopefully make it more obvious
to admins.

Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 5 +++++
 arch/x86/kvm/svm/sev.c                          | 8 ++++++++
 2 files changed, 13 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 4d0f545fb3ec..2b50eed8664c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3207,6 +3207,11 @@ Kernel parameters
 			max_snp_asid == min_sev_asid-1, will effectively make
 			SEV-ES unusable.
 
+	kvm-amd.rapl_disable=	[KVM,AMD] Whether to disable RAPL
+			(Running Average Power Limit) when initializing the SNP
+			firmware. This disables the counters for the entire system until an
+			SNP shutdown command is issued.
+
 	kvm-arm.mode=
 			[KVM,ARM,EARLY] Select one of KVM/arm64's modes of
 			operation.
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index c2126b3c3072..c2a30a3d6f50 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -66,6 +66,10 @@ module_param_named(sev_snp, sev_snp_enabled, bool, 0444);
 static unsigned int __ro_after_init nr_ciphertext_hiding_asids;
 module_param_named(ciphertext_hiding_asids, nr_ciphertext_hiding_asids, uint, 0444);
 
+static bool rapl_disable;
+module_param(rapl_disable, bool, 0444);
+MODULE_PARM_DESC(rapl_disable, " if true, disable RAPL during SNP Initialization");
+
 #define AP_RESET_HOLD_NONE		0
 #define AP_RESET_HOLD_NAE_EVENT		1
 #define AP_RESET_HOLD_MSR_PROTO		2
@@ -3163,6 +3167,7 @@ void __init sev_hardware_setup(void)
 out:
 	if (sev_enabled) {
 		init_args.probe = true;
+		init_args.rapl_disable = rapl_disable;
 
 		if (sev_is_snp_ciphertext_hiding_supported())
 			init_args.max_snp_asid = min(nr_ciphertext_hiding_asids,
@@ -3174,6 +3179,9 @@ void __init sev_hardware_setup(void)
 			sev_snp_supported = is_sev_snp_initialized();
 
 		if (sev_snp_supported) {
+			if (!init_args.rapl_disable)
+				rapl_disable = false;
+
 			snp_supported_policy_bits = sev_get_snp_policy_bits() &
 						    KVM_SNP_POLICY_MASK_VALID;
 			nr_ciphertext_hiding_asids = init_args.max_snp_asid;
-- 
2.53.0


