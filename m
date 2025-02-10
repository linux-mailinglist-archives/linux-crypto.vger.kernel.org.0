Return-Path: <linux-crypto+bounces-9655-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA6BA2FDDE
	for <lists+linux-crypto@lfdr.de>; Mon, 10 Feb 2025 23:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA6F73A4F0F
	for <lists+linux-crypto@lfdr.de>; Mon, 10 Feb 2025 22:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C33425C6F1;
	Mon, 10 Feb 2025 22:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cZqfPJ7D"
X-Original-To: linux-crypto@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2057.outbound.protection.outlook.com [40.107.94.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8256259498;
	Mon, 10 Feb 2025 22:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739228077; cv=fail; b=Z6sGTIra1DHU6tGSMQ/6KXHtP6rpxNLLnRDSD/5jDDdMyB3gPTVxaDPUMemWiX5XVsSE6Xhzj54H45ZccI3iRxvTjFQYTPPeYNJqKaK/Ic03jcKozS1HgI3F+zssmtO1VSg0p1LyqwnuTD6SsxDhtXYUxNa+MRsopy3VPSgZuec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739228077; c=relaxed/simple;
	bh=gdrlhmFf2Lx4BoOzouMIXKCSfB12PkHdJYO8IL5eEsQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ej8y3ka0/oeuw1jX5HOuUOTNjEljVddvHP2bj8tukXtDuQdkXiT/jp8ulZVDvXTVcFa1GYZCF2QJ9bRyf1aTadfhaMZBSLjkTigAf6TnvDQxg/r0ApVoNfTa34wuG8lM7kGeyVF17u6tEHTJCA7lUqTkp2mJ0p9DQS0rTMe+FrE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cZqfPJ7D; arc=fail smtp.client-ip=40.107.94.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PST+Rm5+M8KBJvhZ1Xe08Qet1QpCSgx938Vs0Kg33DwpTDnreNr8pRyg99qd3Q8DltY492FLISk6iJ/zsrfGmxh3T+T2eOmXjghA3arBbln8XnQaBokFb60LOKXF2jdC2z1bFUWUQ6wLeWklGspyUfTjgcHUzRObVezQUJ/gXk7xzdk4STFj8u0Pwl5HtHsDEq85dck+2t193uqPsvgoCOgx49eNdxB/jhsMQDVytJBSWtia0fWstynZGb4rzw+CdyQJ6EcrzPH42VjLFDuIH/QhL7iiwrSitfSdVyfN2yop1POnVjV5t8FYBTdkDIGBqEhauho4oPsOkKAi3FC2JA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YApLlHsduMvI5/z8JE3f2hmaKHaM4s5h0GLDXZHV/W4=;
 b=EZ5YxpBgFdXuLjzr/VYVrs0e3vXTytiqzm+8XClabg41UuoeQnhAgj84/T06aNMHK8x3Z4XpviM7YA6p4UW0locuVJbtb8spPAhqTjCFclXIA+aZ4WeEIsNgyu8USf4WveVAGQgknssMjo5HvvGU97t+GGBPTd077KKlfUR7soXRwo7pYrP0yWcfuugYewOd/RMemNOEoB1omedQ4ufSHLYhMDbjuKqzUAJ0o4XOPPwDIaDdr8CRGB/9Go0I4u1oVVV3Xzf8ybWy7KtnN3JoRvAJomKmI6A8dUk6Syr2vwlGZrKISXfUEXTxFuYxf+axdwEHZCfm7l7CDX66Gszrqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YApLlHsduMvI5/z8JE3f2hmaKHaM4s5h0GLDXZHV/W4=;
 b=cZqfPJ7DaZ8jfoH/Yu0OfldJCkjNMtH0IHd6DYyx1UTwBAGjQ+vU5UUQ2qe7TOSRxJ9SjXp9VG4+/EXzcbebjt7S9ngPpednxpfB0AjDv+R7fLVK7FFa1aBIDzX3NP8Jq4TnyGDOTuqJVh1VuomW8/KbNiOMy35CGW4BLr8IJJM=
Received: from DS7PR03CA0097.namprd03.prod.outlook.com (2603:10b6:5:3b7::12)
 by LV8PR12MB9183.namprd12.prod.outlook.com (2603:10b6:408:193::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Mon, 10 Feb
 2025 22:54:30 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:5:3b7:cafe::3e) by DS7PR03CA0097.outlook.office365.com
 (2603:10b6:5:3b7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.31 via Frontend Transport; Mon,
 10 Feb 2025 22:54:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8445.10 via Frontend Transport; Mon, 10 Feb 2025 22:54:30 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Feb
 2025 16:54:29 -0600
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <thomas.lendacky@amd.com>,
	<john.allen@amd.com>, <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<joro@8bytes.org>, <suravee.suthikulpanit@amd.com>, <will@kernel.org>,
	<robin.murphy@arm.com>
CC: <michael.roth@amd.com>, <dionnaglaze@google.com>, <nikunj@amd.com>,
	<ardb@kernel.org>, <kevinloughlin@google.com>, <Neeraj.Upadhyay@amd.com>,
	<vasant.hegde@amd.com>, <Stable@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <iommu@lists.linux.dev>
Subject: [PATCH v4 3/3] x86/sev: Fix broken SNP support with KVM module built-in
Date: Mon, 10 Feb 2025 22:54:18 +0000
Message-ID: <138b520fb83964782303b43ade4369cd181fdd9c.1739226950.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1739226950.git.ashish.kalra@amd.com>
References: <cover.1739226950.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|LV8PR12MB9183:EE_
X-MS-Office365-Filtering-Correlation-Id: 49461dd9-8ac5-4942-9dd7-08dd4a25e108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700013|82310400026|921020|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KTDiMRJotobFrw45OSeCad58VVWZs12hDy11Zz5HP0jFHH0AtHhFMjjGhx03?=
 =?us-ascii?Q?8NsjuPoMQU9gc8NtoIbqCdzO2XVFvtESR6ngJGvZfg5hNPZmKbSDAbMvWKYa?=
 =?us-ascii?Q?DAAKP4jvnWC4WkDWzlny3+3w6ie1K7Fmds9kvLl+K3VqSiuTSv97gJVE50FB?=
 =?us-ascii?Q?A5U9Joy8JuVXL0swM1lnCc8914mTZKGNRHqDDk3VXcG/B+CO32WsXVRC7372?=
 =?us-ascii?Q?ZGejemL/fNq1vNkpcWzCG3nMgdMW2DMuznv/q2CeyICIZ/TtQzcaSb5Jg9gs?=
 =?us-ascii?Q?TnybO9SVLc4GDhvhAumDxEywxaDQYf/ybXCj1yJ0qwPtOk99T9rHOXAc164J?=
 =?us-ascii?Q?T24M9bZ976Aw6olPT9zqp+39OUsdZhw34l7oZrjmWjesOucXnbOA+rQ1eM0s?=
 =?us-ascii?Q?0FhVelucK+JdcO1KfT15Uy0b3sq0M4VODIGORePjNRhDt1HqHJv8oGqhCWZF?=
 =?us-ascii?Q?veHrj+Mz8OhKKXeNtHbrEH1fZp3kJ/M0dYVLZP41gztkSIY7TY0rVmuctACQ?=
 =?us-ascii?Q?qt3T7bcEFqYjPhrO55FAvVk3ZK92MA1+XzUu8Iq6XeGvxVDLBtU9+iDk4wee?=
 =?us-ascii?Q?YZRjfq+kQRY/Qa1eH3mC060OeD5F7nDHkYEwlJ86JbhCICXwHhC7CXBK0UKF?=
 =?us-ascii?Q?9gI49qillUvE3E8M+Jd0Anai5kUsn0/4h/xC+Cxsf5SxJvq1373nnLnud+uY?=
 =?us-ascii?Q?mm3raKQ1HRcQHsxLs3oSpWZzlothBTSaAvkxaOm2CtSp0aMMAIM1ySsh6E4c?=
 =?us-ascii?Q?0DoROSf+MdqIp8SDnDnmXnraN85Q0mxa/G8oEV+Hjf1Vheb8Qp05DI7TLGeC?=
 =?us-ascii?Q?SmVykUG51xgIPG7VIC0kJdAqlriIghgyDR2PVhbCnVavMTSktvQMXxz6PKj9?=
 =?us-ascii?Q?AyIB2rEfBufipw7LiQp1FKWkMAi5ZN5dbe6i22G0brWFJW5yCi+mX7KWusTi?=
 =?us-ascii?Q?/zzyVMxa2DHv9DS0RffwdfF0lMjjoQLMGVu+k/Vz+H3L7OOMP2CSh+IwDx2W?=
 =?us-ascii?Q?wWfZW8W6JxzWm5PyrBwtgXNDWm+fCUVtw17lAdFPqgzGd65TOHksL3HFTzKH?=
 =?us-ascii?Q?3/T8fdxttfpxU8juaB60eKTf7G9mcYZTASHK6rg3c8e48gBbVQTfKBoj+A1k?=
 =?us-ascii?Q?5+Vvjr/jHJ3YdSmVxN3cdebMVZ1HREWpxhZWt79y/3Xh3UGXk1ltIEvazmDR?=
 =?us-ascii?Q?XxAPX6176eN3GaKO5r+yWtsBThQ7D/qObvHP6yeZa8nNPelmrTfY46hQ1Vfh?=
 =?us-ascii?Q?jrqGawBMKctAlW//7QLiKW3J+zTzNLv9wok0//uRQI35uoOiKpO08+AS2TQg?=
 =?us-ascii?Q?/COGqiUDQEFPW1WLmTmll5k3F6/kKsW/fF1kljLmGjnx31M374DLe/Gwj9VS?=
 =?us-ascii?Q?tSqFRS8VmYYnv5MS+kZ+KMJ4JJTjTlkkWQqnblb+U7L6e2rBIxl5i0S5PVDM?=
 =?us-ascii?Q?FAEt45ZvC4jD48+9cuLD9ZVUAWimFy+5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700013)(82310400026)(921020)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2025 22:54:30.5068
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49461dd9-8ac5-4942-9dd7-08dd4a25e108
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9183

From: Ashish Kalra <ashish.kalra@amd.com>

Fix issues with enabling SNP host support and effectively SNP support
which is broken with respect to the KVM module being built-in.

SNP host support is enabled in snp_rmptable_init() which is invoked as
device_initcall(). SNP check on IOMMU is done during IOMMU PCI init
(IOMMU_PCI_INIT stage). And for that reason snp_rmptable_init() is
currently invoked via device_initcall() and cannot be invoked via
subsys_initcall() as core IOMMU subsystem gets initialized via
subsys_initcall().

Now, if kvm_amd module is built-in, it gets initialized before SNP host
support is enabled in snp_rmptable_init() :

[   10.131811] kvm_amd: TSC scaling supported
[   10.136384] kvm_amd: Nested Virtualization enabled
[   10.141734] kvm_amd: Nested Paging enabled
[   10.146304] kvm_amd: LBR virtualization supported
[   10.151557] kvm_amd: SEV enabled (ASIDs 100 - 509)
[   10.156905] kvm_amd: SEV-ES enabled (ASIDs 1 - 99)
[   10.162256] kvm_amd: SEV-SNP enabled (ASIDs 1 - 99)
[   10.171508] kvm_amd: Virtual VMLOAD VMSAVE supported
[   10.177052] kvm_amd: Virtual GIF supported
...
...
[   10.201648] kvm_amd: in svm_enable_virtualization_cpu

And then svm_x86_ops->enable_virtualization_cpu()
(svm_enable_virtualization_cpu) programs MSR_VM_HSAVE_PA as following:
wrmsrl(MSR_VM_HSAVE_PA, sd->save_area_pa);

So VM_HSAVE_PA is non-zero before SNP support is enabled on all CPUs.

snp_rmptable_init() gets invoked after svm_enable_virtualization_cpu()
as following :
...
[   11.256138] kvm_amd: in svm_enable_virtualization_cpu
...
[   11.264918] SEV-SNP: in snp_rmptable_init

This triggers a #GP exception in snp_rmptable_init() when snp_enable()
is invoked to set SNP_EN in SYSCFG MSR:

[   11.294289] unchecked MSR access error: WRMSR to 0xc0010010 (tried to write 0x0000000003fc0000) at rIP: 0xffffffffaf5d5c28 (native_write_msr+0x8/0x30)
...
[   11.294404] Call Trace:
[   11.294482]  <IRQ>
[   11.294513]  ? show_stack_regs+0x26/0x30
[   11.294522]  ? ex_handler_msr+0x10f/0x180
[   11.294529]  ? search_extable+0x2b/0x40
[   11.294538]  ? fixup_exception+0x2dd/0x340
[   11.294542]  ? exc_general_protection+0x14f/0x440
[   11.294550]  ? asm_exc_general_protection+0x2b/0x30
[   11.294557]  ? __pfx_snp_enable+0x10/0x10
[   11.294567]  ? native_write_msr+0x8/0x30
[   11.294570]  ? __snp_enable+0x5d/0x70
[   11.294575]  snp_enable+0x19/0x20
[   11.294578]  __flush_smp_call_function_queue+0x9c/0x3a0
[   11.294586]  generic_smp_call_function_single_interrupt+0x17/0x20
[   11.294589]  __sysvec_call_function+0x20/0x90
[   11.294596]  sysvec_call_function+0x80/0xb0
[   11.294601]  </IRQ>
[   11.294603]  <TASK>
[   11.294605]  asm_sysvec_call_function+0x1f/0x30
...
[   11.294631]  arch_cpu_idle+0xd/0x20
[   11.294633]  default_idle_call+0x34/0xd0
[   11.294636]  do_idle+0x1f1/0x230
[   11.294643]  ? complete+0x71/0x80
[   11.294649]  cpu_startup_entry+0x30/0x40
[   11.294652]  start_secondary+0x12d/0x160
[   11.294655]  common_startup_64+0x13e/0x141
[   11.294662]  </TASK>

This #GP exception is getting triggered due to the following errata for
AMD family 19h Models 10h-1Fh Processors:

Processor may generate spurious #GP(0) Exception on WRMSR instruction:
Description:
The Processor will generate a spurious #GP(0) Exception on a WRMSR
instruction if the following conditions are all met:
- the target of the WRMSR is a SYSCFG register.
- the write changes the value of SYSCFG.SNPEn from 0 to 1.
- One of the threads that share the physical core has a non-zero
value in the VM_HSAVE_PA MSR.

The document being referred to above:
https://www.amd.com/content/dam/amd/en/documents/processor-tech-docs/revision-guides/57095-PUB_1_01.pdf

To summarize, with kvm_amd module being built-in, KVM/SVM initialization
happens before host SNP is enabled and this SVM initialization
sets VM_HSAVE_PA to non-zero, which then triggers a #GP when
SYSCFG.SNPEn is being set and this will subsequently cause
SNP_INIT(_EX) to fail with INVALID_CONFIG error as SYSCFG[SnpEn] is not
set on all CPUs.

Essentially SNP host enabling code should be invoked before KVM
initialization, which is currently not the case when KVM is built-in.

Add fix to call snp_rmptable_init() early from iommu_snp_enable()
directly and not invoked via device_initcall() which enables SNP host
support before KVM initialization with kvm_amd module built-in.

Add additional handling for `iommu=off` or `amd_iommu=off` options.

Note that IOMMUs need to be enabled for SNP initialization, therefore,
if host SNP support is enabled but late IOMMU initialization fails
then that will cause PSP driver's SNP_INIT to fail as IOMMU SNP sanity
checks in SNP firmware will fail with invalid configuration error as
below:

[    9.723114] ccp 0000:23:00.1: sev enabled
[    9.727602] ccp 0000:23:00.1: psp enabled
[    9.732527] ccp 0000:a2:00.1: enabling device (0000 -> 0002)
[    9.739098] ccp 0000:a2:00.1: no command queues available
[    9.745167] ccp 0000:a2:00.1: psp enabled
[    9.805337] ccp 0000:23:00.1: SEV-SNP: failed to INIT rc -5, error 0x3
[    9.866426] ccp 0000:23:00.1: SEV API:1.53 build:5

Fixes: c3b86e61b756 ("x86/cpufeatures: Enable/unmask SEV-SNP CPU feature")
Co-developed-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/include/asm/sev.h |  2 ++
 arch/x86/virt/svm/sev.c    | 23 +++++++----------------
 drivers/iommu/amd/init.c   | 34 ++++++++++++++++++++++++++++++----
 3 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 5d9685f92e5c..1581246491b5 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -531,6 +531,7 @@ static inline void __init snp_secure_tsc_init(void) { }
 
 #ifdef CONFIG_KVM_AMD_SEV
 bool snp_probe_rmptable_info(void);
+int snp_rmptable_init(void);
 int snp_lookup_rmpentry(u64 pfn, bool *assigned, int *level);
 void snp_dump_hva_rmpentry(unsigned long address);
 int psmash(u64 pfn);
@@ -541,6 +542,7 @@ void kdump_sev_callback(void);
 void snp_fixup_e820_tables(void);
 #else
 static inline bool snp_probe_rmptable_info(void) { return false; }
+static inline int snp_rmptable_init(void) { return -ENOSYS; }
 static inline int snp_lookup_rmpentry(u64 pfn, bool *assigned, int *level) { return -ENODEV; }
 static inline void snp_dump_hva_rmpentry(unsigned long address) {}
 static inline int psmash(u64 pfn) { return -ENODEV; }
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 1dcc027ec77e..42e74a5a7d78 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -505,19 +505,19 @@ static bool __init setup_rmptable(void)
  * described in the SNP_INIT_EX firmware command description in the SNP
  * firmware ABI spec.
  */
-static int __init snp_rmptable_init(void)
+int __init snp_rmptable_init(void)
 {
 	unsigned int i;
 	u64 val;
 
-	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
-		return 0;
+	if (WARN_ON_ONCE(!cc_platform_has(CC_ATTR_HOST_SEV_SNP)))
+		return -ENOSYS;
 
-	if (!amd_iommu_snp_en)
-		goto nosnp;
+	if (WARN_ON_ONCE(!amd_iommu_snp_en))
+		return -ENOSYS;
 
 	if (!setup_rmptable())
-		goto nosnp;
+		return -ENOSYS;
 
 	/*
 	 * Check if SEV-SNP is already enabled, this can happen in case of
@@ -530,7 +530,7 @@ static int __init snp_rmptable_init(void)
 	/* Zero out the RMP bookkeeping area */
 	if (!clear_rmptable_bookkeeping()) {
 		free_rmp_segment_table();
-		goto nosnp;
+		return -ENOSYS;
 	}
 
 	/* Zero out the RMP entries */
@@ -562,17 +562,8 @@ static int __init snp_rmptable_init(void)
 	crash_kexec_post_notifiers = true;
 
 	return 0;
-
-nosnp:
-	cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
-	return -ENOSYS;
 }
 
-/*
- * This must be called after the IOMMU has been initialized.
- */
-device_initcall(snp_rmptable_init);
-
 static void set_rmp_segment_info(unsigned int segment_shift)
 {
 	rmp_segment_shift = segment_shift;
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index c5cd92edada0..2fecfed75e54 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3194,7 +3194,7 @@ static bool __init detect_ivrs(void)
 	return true;
 }
 
-static void iommu_snp_enable(void)
+static __init void iommu_snp_enable(void)
 {
 #ifdef CONFIG_KVM_AMD_SEV
 	if (!cc_platform_has(CC_ATTR_HOST_SEV_SNP))
@@ -3219,6 +3219,14 @@ static void iommu_snp_enable(void)
 		goto disable_snp;
 	}
 
+	/*
+	 * Enable host SNP support once SNP support is checked on IOMMU.
+	 */
+	if (snp_rmptable_init()) {
+		pr_warn("SNP: RMP initialization failed, SNP cannot be supported.\n");
+		goto disable_snp;
+	}
+
 	pr_info("IOMMU SNP support enabled.\n");
 	return;
 
@@ -3318,6 +3326,19 @@ static int __init iommu_go_to_state(enum iommu_init_state state)
 		ret = state_next();
 	}
 
+	/*
+	 * SNP platform initilazation requires IOMMUs to be fully configured.
+	 * If the SNP support on IOMMUs has NOT been checked, simply mark SNP
+	 * as unsupported. If the SNP support on IOMMUs has been checked and
+	 * host SNP support enabled but RMP enforcement has not been enabled
+	 * in IOMMUs, then the system is in a half-baked state, but can limp
+	 * along as all memory should be Hypervisor-Owned in the RMP. WARN,
+	 * but leave SNP as "supported" to avoid confusing the kernel.
+	 */
+	if (ret && cc_platform_has(CC_ATTR_HOST_SEV_SNP) &&
+	    !WARN_ON_ONCE(amd_iommu_snp_en))
+		cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
+
 	return ret;
 }
 
@@ -3426,18 +3447,23 @@ void __init amd_iommu_detect(void)
 	int ret;
 
 	if (no_iommu || (iommu_detected && !gart_iommu_aperture))
-		return;
+		goto disable_snp;
 
 	if (!amd_iommu_sme_check())
-		return;
+		goto disable_snp;
 
 	ret = iommu_go_to_state(IOMMU_IVRS_DETECTED);
 	if (ret)
-		return;
+		goto disable_snp;
 
 	amd_iommu_detected = true;
 	iommu_detected = 1;
 	x86_init.iommu.iommu_init = amd_iommu_init;
+	return;
+
+disable_snp:
+	if (cc_platform_has(CC_ATTR_HOST_SEV_SNP))
+		cc_platform_clear(CC_ATTR_HOST_SEV_SNP);
 }
 
 /****************************************************************************
-- 
2.34.1


