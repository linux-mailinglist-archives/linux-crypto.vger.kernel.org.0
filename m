Return-Path: <linux-crypto+bounces-22350-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJgjGB+6wmlilAQAu9opvQ
	(envelope-from <linux-crypto+bounces-22350-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 24 Mar 2026 17:21:51 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C76A7318E9F
	for <lists+linux-crypto@lfdr.de>; Tue, 24 Mar 2026 17:21:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 284BD30E7CA8
	for <lists+linux-crypto@lfdr.de>; Tue, 24 Mar 2026 16:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C89F3F7A8F;
	Tue, 24 Mar 2026 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jv36aHef"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDF33CEBB8;
	Tue, 24 Mar 2026 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774368815; cv=none; b=mjQOyAn+PanakPe4MCtt09GrCIG1jsnEDI/vsRfPoF7norGxgYivKbIjFf0oBx2YyCB4LuocPrvjVkjlMsUSgc4UE64TrSTmbBG2Tn0AInTf+GRxpV6IbUiWWESxBJNLJ4RJq0/myzhmdDyh+1J14iUyaZdD/3RHtOaZImqO64w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774368815; c=relaxed/simple;
	bh=EFFPAkfKUBUtv+l4cFHBmfeFlJDbrj3N6cEEBH5VfVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ikrWkeiWxYMdDrK4FgwY/LABPnNIaDe7X3cigZsGwrcDSwz2W13i1o1CuwAg/KOvzH6u9HFAea/rIKIUTYeVnkfiOSSesRe21iSmE7wHp9/fxfWwKnotOjUdcnq8tclFdQV855I4GXS0bxg8jdPZnw3MvYaIC7ZB+3pfiuL7bjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jv36aHef; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E64C2BCB2;
	Tue, 24 Mar 2026 16:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774368814;
	bh=EFFPAkfKUBUtv+l4cFHBmfeFlJDbrj3N6cEEBH5VfVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jv36aHefmib16GGIaKFL/N1FTeUk/ldxvWX+N5fwKo0FxP2TPk9hD/bgQ7GwO/SJe
	 l+2Uh3XiP4/mHgP87j/ISh/ypNs3XViiKem9MA7b0HGg8q4jhtcaEznLvVFT0LPQpX
	 /3HIwai8Gxf/pf15ANIDB1KYOK3xOIry01peiIVoh5ThPWUZWNps/DKt/o4dtHb/9s
	 PduOyoCb2U27R5fZ20Xzpn7n/sUZZbOTfznBkb9VGUoEUsGxc+SbnYJ31ZVuWZYAFW
	 73KKLvv7xkeRjxejLx1q8G1DvEJzhRTV97wUObWCyzh8AQIohEnoxtlwi1VJCf1IFM
	 PT3oSgSC9ps4g==
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
Subject: [PATCH v4 6/7] crypto/ccp: Implement SNP x86 shutdown
Date: Tue, 24 Mar 2026 10:13:00 -0600
Message-ID: <20260324161301.1353976-7-tycho@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22350-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tycho@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,apana.org.au:email]
X-Rspamd-Queue-Id: C76A7318E9F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Tycho Andersen (AMD)" <tycho@kernel.org>

The SEV firmware has support to disable SNP during an SNP_SHUTDOWN_EX
command. Verify that this support is available and set the flag so that SNP
is disabled when it is not being used. In cases where SNP is disabled, skip
the call to amd_iommu_snp_disable(), as all of the IOMMU pages have already
been made shared. Also skip the panic case, since snp_shutdown() does
IPIs.

Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 drivers/crypto/ccp/sev-dev.c | 41 +++++++++++++++++++++---------------
 include/linux/psp-sev.h      |  5 ++++-
 2 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 47cb8fca4e6c..366303ff6466 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -2039,6 +2039,8 @@ static int __sev_snp_shutdown_locked(int *error, bool panic)
 	memset(&data, 0, sizeof(data));
 	data.len = sizeof(data);
 	data.iommu_snp_shutdown = 1;
+	if (sev->snp_feat_info_0.ecx & SNP_X86_SHUTDOWN_SUPPORTED)
+		data.x86_snp_shutdown = 1;
 
 	/*
 	 * If invoked during panic handling, local interrupts are disabled
@@ -2072,23 +2074,28 @@ static int __sev_snp_shutdown_locked(int *error, bool panic)
 		return ret;
 	}
 
-	/*
-	 * SNP_SHUTDOWN_EX with IOMMU_SNP_SHUTDOWN set to 1 disables SNP
-	 * enforcement by the IOMMU and also transitions all pages
-	 * associated with the IOMMU to the Reclaim state.
-	 * Firmware was transitioning the IOMMU pages to Hypervisor state
-	 * before version 1.53. But, accounting for the number of assigned
-	 * 4kB pages in a 2M page was done incorrectly by not transitioning
-	 * to the Reclaim state. This resulted in RMP #PF when later accessing
-	 * the 2M page containing those pages during kexec boot. Hence, the
-	 * firmware now transitions these pages to Reclaim state and hypervisor
-	 * needs to transition these pages to shared state. SNP Firmware
-	 * version 1.53 and above are needed for kexec boot.
-	 */
-	ret = amd_iommu_snp_disable();
-	if (ret) {
-		dev_err(sev->dev, "SNP IOMMU shutdown failed\n");
-		return ret;
+	if (data.x86_snp_shutdown) {
+		if (!panic)
+			snp_shutdown();
+	} else {
+		/*
+		 * SNP_SHUTDOWN_EX with IOMMU_SNP_SHUTDOWN set to 1 disables SNP
+		 * enforcement by the IOMMU and also transitions all pages
+		 * associated with the IOMMU to the Reclaim state.
+		 * Firmware was transitioning the IOMMU pages to Hypervisor state
+		 * before version 1.53. But, accounting for the number of assigned
+		 * 4kB pages in a 2M page was done incorrectly by not transitioning
+		 * to the Reclaim state. This resulted in RMP #PF when later accessing
+		 * the 2M page containing those pages during kexec boot. Hence, the
+		 * firmware now transitions these pages to Reclaim state and hypervisor
+		 * needs to transition these pages to shared state. SNP Firmware
+		 * version 1.53 and above are needed for kexec boot.
+		 */
+		ret = amd_iommu_snp_disable();
+		if (ret) {
+			dev_err(sev->dev, "SNP IOMMU shutdown failed\n");
+			return ret;
+		}
 	}
 
 	snp_leak_hv_fixed_pages();
diff --git a/include/linux/psp-sev.h b/include/linux/psp-sev.h
index 69ffa4b4d1fa..d5099a2baca5 100644
--- a/include/linux/psp-sev.h
+++ b/include/linux/psp-sev.h
@@ -829,12 +829,14 @@ struct sev_data_range_list {
  *
  * @len: length of the command buffer read by the PSP
  * @iommu_snp_shutdown: Disable enforcement of SNP in the IOMMU
+ * @x86_snp_shutdown: Disable SNP on all cores
  * @rsvd1: reserved
  */
 struct sev_data_snp_shutdown_ex {
 	u32 len;
 	u32 iommu_snp_shutdown:1;
-	u32 rsvd1:31;
+	u32 x86_snp_shutdown:1;
+	u32 rsvd1:30;
 } __packed;
 
 /**
@@ -891,6 +893,7 @@ struct snp_feature_info {
 } __packed;
 
 /* Feature bits in ECX */
+#define SNP_X86_SHUTDOWN_SUPPORTED		BIT(1)
 #define SNP_RAPL_DISABLE_SUPPORTED		BIT(2)
 #define SNP_CIPHER_TEXT_HIDING_SUPPORTED	BIT(3)
 #define SNP_AES_256_XTS_POLICY_SUPPORTED	BIT(4)
-- 
2.53.0


