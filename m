Return-Path: <linux-crypto+bounces-3677-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99D268AA365
	for <lists+linux-crypto@lfdr.de>; Thu, 18 Apr 2024 21:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 109D51F2208A
	for <lists+linux-crypto@lfdr.de>; Thu, 18 Apr 2024 19:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 150FF190683;
	Thu, 18 Apr 2024 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uDsbgsno"
X-Original-To: linux-crypto@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C265180A7E;
	Thu, 18 Apr 2024 19:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469721; cv=fail; b=tWokRUt8ipELrZkozm8NMPlJtYBLG/w4/NDunGIcP/KPdSQL954GqpOb/epUvGsekIitM02+zpi5CR7t3ck54YTe3OjdNjNVW+eO1Ia2oVjpTOIpw/YGQh72BWaOntEnv3byeB+mBn5oL84dD+EudS7OyFEfUPJIO3bHAg30A0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469721; c=relaxed/simple;
	bh=pOttwpbge6PZmAFanlTk53i/0c7TrXiY2wdpRsaT9PA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TGd1UhecObKoaEv0yX84XT9VlTvF0s0Klum9ba8HyQCrykO4jjw7DIVOg7CBF2EfKdpCuj4Bk4rP+USV/ZIDC4evg9i9zUWFwUPg056Q6g2winrWQzehZDgt29GBFJksWoJnXW/fYtv9touZIkIqh021d5L6fPA6JEeGBctrhXI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uDsbgsno; arc=fail smtp.client-ip=40.107.94.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/YbFe3Dzzr92bzGkriAqPLa+1UPpD7beVB4ZE9WzMW0tBaq9V72PV3UjSUwCUFhP8g+JyZ7TSx6iLmCv6spNRNZ1tnhgV5bghRor3Y/w81Z7RRULA+AKfyNifpdZjvClGJLoeQyv8r0Z6W0uw+aH32nkdWjV88pSTbYh6RPSjbnw+JFaVMIe8rASNVs0a6xYefVf3WdixpJKw/jP1gx30VLRL0T/VDJVdnZqf2OJgrRveI2O0T5xLJB/n2+MgUmWUbgPq7o4ShI8akoVsP95ZUXYRec7YTFvfxwhVjmsYsvSw7AAVUGJfVZpEeYtBLZtbVymLhJg5Kep1tLdRBXIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4EbQR2u1vx30acv76HoyGKL46pweiRqZsZkNn4QVXxI=;
 b=KKGjJ6eG6xY8ylUvf3tXhIrSBjuijHPDWS9ca5YFEI3wACGh7jEX+CPi8vYzPpcConpN/VcNr4XrE1yTvB7BeKzg9iYqc8juYm+YDRHN/tvO2ZJFBvIy2ySbL77w1Q1w5b8v7KpyXn4/JpKoU+mplKUANneFsaQkpyfSJtl9ANAaieynNOJHY606vsMlTCEO2iZzm8GbBw+JcySs4MeM6KbvAnUajQMWWOVf7uhtSjvTIJFBBBS7IlTDJXed07yyTXoT/IjP7VTE+bx+DZbHv6dSPH6/eKnN0M5d1yBMCu0CSkD4PJDvpvG0rbOGJJuchw0zcBpWIi0F6bS62ZEndg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4EbQR2u1vx30acv76HoyGKL46pweiRqZsZkNn4QVXxI=;
 b=uDsbgsnosk3akVoLVNeNnORkXqAUI/DIzHmNNvCF/pETmrLqCn+6rcrDOlqim8DP2cIYeBdCs/QOEP8+SWvmisxVGyHuE3uUTe7wFtZ5QLS2OdIlwuuJTUdE43ZNIq4/On3RqNBvyahuf96MvhfXxaW+uJdr6yKbCwdUdGHpKLE=
Received: from PH0PR07CA0061.namprd07.prod.outlook.com (2603:10b6:510:f::6) by
 MN0PR12MB5858.namprd12.prod.outlook.com (2603:10b6:208:379::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.50; Thu, 18 Apr 2024 19:48:36 +0000
Received: from SN1PEPF0002BA50.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::78) by PH0PR07CA0061.outlook.office365.com
 (2603:10b6:510:f::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Thu, 18 Apr 2024 19:48:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA50.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 19:48:35 +0000
Received: from localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 14:48:34 -0500
From: Michael Roth <michael.roth@amd.com>
To: <kvm@vger.kernel.org>
CC: <linux-coco@lists.linux.dev>, <linux-mm@kvack.org>,
	<linux-crypto@vger.kernel.org>, <x86@kernel.org>,
	<linux-kernel@vger.kernel.org>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<jroedel@suse.de>, <thomas.lendacky@amd.com>, <hpa@zytor.com>,
	<ardb@kernel.org>, <pbonzini@redhat.com>, <seanjc@google.com>,
	<vkuznets@redhat.com>, <jmattson@google.com>, <luto@kernel.org>,
	<dave.hansen@linux.intel.com>, <slp@redhat.com>, <pgonda@google.com>,
	<peterz@infradead.org>, <srinivas.pandruvada@linux.intel.com>,
	<rientjes@google.com>, <dovmurik@linux.ibm.com>, <tobin@ibm.com>,
	<bp@alien8.de>, <vbabka@suse.cz>, <kirill@shutemov.name>,
	<ak@linux.intel.com>, <tony.luck@intel.com>,
	<sathyanarayanan.kuppuswamy@linux.intel.com>, <alpergun@google.com>,
	<jarkko@kernel.org>, <ashish.kalra@amd.com>, <nikunj.dadhania@amd.com>,
	<pankaj.gupta@amd.com>, <liam.merwick@oracle.com>
Subject: [PATCH v13 25/26] crypto: ccp: Add the SNP_{PAUSE,RESUME}_ATTESTATION commands
Date: Thu, 18 Apr 2024 14:41:32 -0500
Message-ID: <20240418194133.1452059-26-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240418194133.1452059-1-michael.roth@amd.com>
References: <20240418194133.1452059-1-michael.roth@amd.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA50:EE_|MN0PR12MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 4176da90-1fc5-49e6-3961-08dc5fe08940
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zNX3WRszVwWAvFBDj8BQGEt4X/88j3/kGP4Nmgms+edHMTo2pJor/sM4FHtDNWPpVFYrgatLRg+NYaroZRFqfVtJrcEnTCgywk9s3CSQwGXQpanrv68b3iKPrylo6qu+KDcQJtzSpDpCpn1dXKtvPwaiV6KJuZbvr1F3L8aL71dbSdAcKfaVbOujDDwexCO8nnFHzmuTxrz/bk/IJ3rbaHchk1Xwv10t9y01/ThIDsAt+ILy4skpNUsntNDLo2J060b83hxN+TZsDHALwGBE12t2xXbS5Z/NHigH5J6S6fPO+ET1X7hum1IJEycK/MOerCRnlS8w6G8CvIiX76BC+sMlIRpZ6VNKDtvrhWUtlNypJigijM0qPp9S+N2MMV5T3SzyMVqWlCsqycFQuGzd9b/CcCgI1qd0wmvnZSKN4a1EBB0GcDd6WVZBtv5rcshoG5o7wXtk+DdMaT7GpBH8UJz3lwtJOrJBA2d/NHN1YwmHhycsOr279J0KdTpc4WihqLGUPsdnFKdLOdif7ubqEoPvNGqWbQKXRoZc6C1UT8W4sgDkTScV/aEzTHOFGnPmbFItx8I6QLa8jxCOIhqjinhsPkB1ZKB5t+kTDRXtjodsECXUoBVEzIbm1CecssbnibAKQecj4QNk+mZsq3IFwvYTgOmyJFMFcxAGqyuEkN4XyRro3mcwOsUDBPCL97ipPnhHa+Q0gHqLRs07H+ALpEr+cq0ZgZa9R+mm9E9fBEJQZNB7+YNnj1Y5AkiDFwFz
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(1800799015)(7416005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 19:48:35.8987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4176da90-1fc5-49e6-3961-08dc5fe08940
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA50.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5858

These commands can be used to pause servicing of guest attestation
requests. This useful when updating the reported TCB or signing key with
commands such as SNP_SET_CONFIG/SNP_COMMIT/SNP_VLEK_LOAD, since they may
in turn require updates to userspace-supplied certificates, and if an
attestation request happens to be in-flight at the time those updates
are occurring there is potential for a guest to receive a certificate
blob that is out of sync with the effective signing key for the
attestation report.

These interfaces also provide some versatility with how similar
firmware/certificate update activities can be handled in the future.

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 Documentation/virt/coco/sev-guest.rst | 50 +++++++++++++++++++++++++--
 arch/x86/include/asm/sev.h            |  6 ++++
 arch/x86/virt/svm/sev.c               | 43 +++++++++++++++++++++++
 drivers/crypto/ccp/sev-dev.c          | 47 +++++++++++++++++++++++++
 include/uapi/linux/psp-sev.h          | 12 +++++++
 5 files changed, 156 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/coco/sev-guest.rst b/Documentation/virt/coco/sev-guest.rst
index de68d3a4b540..ab192a008ba7 100644
--- a/Documentation/virt/coco/sev-guest.rst
+++ b/Documentation/virt/coco/sev-guest.rst
@@ -128,8 +128,6 @@ the SEV-SNP specification for further details.
 
 The SNP_GET_EXT_REPORT ioctl is similar to the SNP_GET_REPORT. The difference is
 related to the additional certificate data that is returned with the report.
-The certificate data returned is being provided by the hypervisor through the
-SNP_SET_EXT_CONFIG.
 
 The ioctl uses the SNP_GUEST_REQUEST (MSG_REPORT_REQ) command provided by the SEV-SNP
 firmware to get the attestation report.
@@ -195,6 +193,54 @@ them into the system after obtaining them from the KDS, and corresponds
 closely to the SNP_VLEK_LOAD firmware command specified in the SEV-SNP
 spec.
 
+2.8 SNP_PAUSE_ATTESTATION / SNP_RESUME_ATTESTATION
+--------------------------------------------------
+:Technology: sev-snp
+:Type: hypervisor ioctl cmd
+:Parameters (out): struct sev_user_data_snp_pause_transaction
+:Returns (out): 0 on success, -negative on error
+
+When requesting attestation reports, SNP guests have the option of issuing
+an extended guest request which allows host userspace to supply additional
+certificate data that can be used to validate the signature used to sign
+the attestation report. This signature is generated using a key that is
+derived from the reported TCB that can be set via the SNP_SET_CONFIG and
+SNP_COMMIT ioctls, so the accompanying certificate data needs to be kept in
+sync with the changes made to the reported TCB via these ioctls.
+
+Similarly, interfaces like SNP_LOAD_VLEK can modify the key used to sign
+the attestation reports, which may in turn require updating the certificate
+data provided to guests via extended guest requests.
+
+To allow for updating the reported TCB, endorsement key, and any certificate
+data in a manner that is atomic to guests, the SNP_PAUSE_ATTESTATION and
+SNP_RESUME_ATTESTATION commands are provided.
+
+After SNP_PAUSE_ATTESTATION is issued, any attestation report requests via
+extended guest requests that are in-progress, or received after
+SNP_PAUSE_ATTESTATION is issued, will result in the guest receiving a
+GHCB-defined error message instructing it to retry the request. Once all
+the desired reported TCB, endorsement keys, or certificate data updates
+are completed on the host, the SNP_RESUME_ATTESTATION command must be
+issued to allow guest attestation requests to proceed.
+
+In general, hosts should serialize updates of this sort and never have more
+than 1 outstanding transaction in flight that could result in the
+interleaving of multiple SNP_PAUSE_ATTESTATION/SNP_RESUME_ATTESTATION pairs.
+To guard against this, SNP_PAUSE_ATTESTATION will fail if another process
+has already paused attestation requests.
+
+However, there may be occassions where a transaction needs to be aborted due
+to unexpected activity in userspace such as timeouts, crashes, etc., so
+SNP_RESUME_ATTESTATION will always succeed. Nonetheless, this could
+potentially lead to SNP_RESUME_ATTESTATION being called out of sequence, so
+to allow for callers of SNP_{PAUSE,RESUME}_ATTESTATION to detect such
+occurrences, each ioctl will return a transaction ID in the response so the
+caller can monitor whether the start/end ID both match. If they don't, the
+caller should assume that attestation has been paused/resumed unexpectedly,
+and take whatever measures it deems necessary such as logging, reporting,
+auditing the sequence of events.
+
 3. SEV-SNP CPUID Enforcement
 ============================
 
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 234a998e2d2d..baf223eb5633 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -82,6 +82,8 @@ extern void vc_no_ghcb(void);
 extern void vc_boot_ghcb(void);
 extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
 
+extern struct mutex snp_pause_attestation_lock;
+
 /* PVALIDATE return codes */
 #define PVALIDATE_FAIL_SIZEMISMATCH	6
 
@@ -272,6 +274,8 @@ int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, u32 asid, bool immut
 int rmp_make_shared(u64 pfn, enum pg_level level);
 void snp_leak_pages(u64 pfn, unsigned int npages);
 void kdump_sev_callback(void);
+int snp_pause_attestation(u64 *transaction_id);
+void snp_resume_attestation(u64 *transaction_id);
 #else
 static inline bool snp_probe_rmptable_info(void) { return false; }
 static inline int snp_lookup_rmpentry(u64 pfn, bool *assigned, int *level) { return -ENODEV; }
@@ -285,6 +289,8 @@ static inline int rmp_make_private(u64 pfn, u64 gpa, enum pg_level level, u32 as
 static inline int rmp_make_shared(u64 pfn, enum pg_level level) { return -ENODEV; }
 static inline void snp_leak_pages(u64 pfn, unsigned int npages) {}
 static inline void kdump_sev_callback(void) { }
+static inline int snp_pause_attestation(u64 *transaction_id) { return 0; }
+static inline void snp_resume_attestation(u64 *transaction_id) {}
 #endif
 
 #endif
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index ab0e8448bb6e..b75f2e7d4012 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -70,6 +70,11 @@ static DEFINE_SPINLOCK(snp_leaked_pages_list_lock);
 
 static unsigned long snp_nr_leaked_pages;
 
+/* For synchronizing TCB/certificate updates with extended guest requests */
+DEFINE_MUTEX(snp_pause_attestation_lock);
+static u64 snp_transaction_id;
+static bool snp_attestation_paused;
+
 #undef pr_fmt
 #define pr_fmt(fmt)	"SEV-SNP: " fmt
 
@@ -568,3 +573,41 @@ void kdump_sev_callback(void)
 	if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
 		wbinvd();
 }
+
+int snp_pause_attestation(u64 *transaction_id)
+{
+	mutex_lock(&snp_pause_attestation_lock);
+
+	if (snp_attestation_paused) {
+		mutex_unlock(&snp_pause_attestation_lock);
+		return -EBUSY;
+	}
+
+	/*
+	 * The actual transaction ID update will happen when
+	 * snp_resume_attestation() is called, so return
+	 * the *anticipated* transaction ID that will be
+	 * returned by snp_resume_attestation(). This is
+	 * to ensure that unbalanced/aborted transactions will
+	 * be noticeable when the caller that started the
+	 * transaction calls snp_resume_attestation().
+	 */
+	*transaction_id = snp_transaction_id + 1;
+	snp_attestation_paused = true;
+
+	mutex_unlock(&snp_pause_attestation_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(snp_pause_attestation);
+
+void snp_resume_attestation(u64 *transaction_id)
+{
+	mutex_lock(&snp_pause_attestation_lock);
+
+	snp_attestation_paused = false;
+	*transaction_id = ++snp_transaction_id;
+
+	mutex_unlock(&snp_pause_attestation_lock);
+}
+EXPORT_SYMBOL_GPL(snp_resume_attestation);
diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 97a7959406ee..7eb18a273731 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -2060,6 +2060,47 @@ static int sev_ioctl_do_snp_vlek_load(struct sev_issue_cmd *argp, bool writable)
 	return ret;
 }
 
+static int sev_ioctl_do_snp_pause_attestation(struct sev_issue_cmd *argp, bool writable)
+{
+	struct sev_user_data_snp_pause_attestation transaction = {0};
+	struct sev_device *sev = psp_master->sev_data;
+	int ret;
+
+	if (!sev->snp_initialized || !argp->data)
+		return -EINVAL;
+
+	if (!writable)
+		return -EPERM;
+
+	ret = snp_pause_attestation(&transaction.id);
+	if (ret)
+		return ret;
+
+	if (copy_to_user((void __user *)argp->data, &transaction, sizeof(transaction)))
+		return -EFAULT;
+
+	return 0;
+}
+
+static int sev_ioctl_do_snp_resume_attestation(struct sev_issue_cmd *argp, bool writable)
+{
+	struct sev_user_data_snp_pause_attestation transaction = {0};
+	struct sev_device *sev = psp_master->sev_data;
+
+	if (!sev->snp_initialized || !argp->data)
+		return -EINVAL;
+
+	if (!writable)
+		return -EPERM;
+
+	snp_resume_attestation(&transaction.id);
+
+	if (copy_to_user((void __user *)argp->data, &transaction, sizeof(transaction)))
+		return -EFAULT;
+
+	return 0;
+}
+
 static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
@@ -2123,6 +2164,12 @@ static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 	case SNP_VLEK_LOAD:
 		ret = sev_ioctl_do_snp_vlek_load(&input, writable);
 		break;
+	case SNP_PAUSE_ATTESTATION:
+		ret = sev_ioctl_do_snp_pause_attestation(&input, writable);
+		break;
+	case SNP_RESUME_ATTESTATION:
+		ret = sev_ioctl_do_snp_resume_attestation(&input, writable);
+		break;
 	default:
 		ret = -EINVAL;
 		goto out;
diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
index 2289b7c76c59..7b35b2814a99 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -32,6 +32,8 @@ enum {
 	SNP_COMMIT,
 	SNP_SET_CONFIG,
 	SNP_VLEK_LOAD,
+	SNP_PAUSE_ATTESTATION,
+	SNP_RESUME_ATTESTATION,
 
 	SEV_MAX,
 };
@@ -241,6 +243,16 @@ struct sev_user_data_snp_wrapped_vlek_hashstick {
 	__u8 data[432];				/* In */
 } __packed;
 
+/**
+ * struct sev_user_data_snp_pause_attestation - metadata for pausing attestation
+ *
+ * @id: the ID of the transaction started/ended by a call to SNP_PAUSE_ATTESTATION
+ *	or SNP_RESUME_ATTESTATION, respectively.
+ */
+struct sev_user_data_snp_pause_attestation {
+	__u64 id;				/* Out */
+} __packed;
+
 /**
  * struct sev_issue_cmd - SEV ioctl parameters
  *
-- 
2.25.1


