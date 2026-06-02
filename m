Return-Path: <linux-crypto+bounces-24844-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oNeXC2E4H2qCiwAAu9opvQ
	(envelope-from <linux-crypto+bounces-24844-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 02 Jun 2026 22:09:05 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D53631A77
	for <lists+linux-crypto@lfdr.de>; Tue, 02 Jun 2026 22:09:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=a69Ml8iq;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24844-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24844-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD2A2304501B
	for <lists+linux-crypto@lfdr.de>; Tue,  2 Jun 2026 20:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D052A30E821;
	Tue,  2 Jun 2026 20:02:12 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010022.outbound.protection.outlook.com [40.93.198.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671B1282F1F;
	Tue,  2 Jun 2026 20:02:11 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780430532; cv=fail; b=gKFCHyhKTXpmlMJPTh/sxT5I1QTy2AArNyKHh9ORShvkbuZ4lVWgUFuAcRdDLw7ET5YxjTrgtifmAA6bU0cWXnEa85CeRdwy5fts4umFwxZtlCmPhQgzLRVEYjAtQOvbtwoiNovfb30y0b+ZpayriImtu1c6QG0T8Th6+Ss0h3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780430532; c=relaxed/simple;
	bh=xpAkeaTs1Q+E07KtSeVlwCrMaIRpl9mZy4WRf6MhplY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cyl2DFslTLmdcDlbb79F8wLvDQrghtifqC9Iaguamfawvady1fvXcU27Gu55x44/jCI4KA6J9hlzL7eg99+KfoBxPEq8+DGUUQZrR5X02WHpoDVlfT4TwHyIFzvRqLj7hivVGnVhTEa4jbCo1GZMR+Ok/P3FpK6kFTvbZSnyeik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a69Ml8iq; arc=fail smtp.client-ip=40.93.198.22
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n8RPMtGRj5SFqmgtA/MDkJjZVDX6sV2GltCFely5OioBjjRAt0GHXubCBal8STScuBvPK/tTwdaumDOP7yn9h8uEiRk2xnLnJkxWNcVndOHnKLc50v3gLEYGmUcqKTPNOviXVzY9KOHjwudA2PmSz1uZHpWDidAAuFjpgT3fDuAgO7DxSka1xc9YJdrAewzX3pvulsPTpo7aB6qrIhB3IVPllaPGTeH/30/9VY36wO3ProO2U51tCdm9+i72b1y68wfDMmBS1by2Xq4YnqXT7Ud8rjpS+D8/GFpHrvrA08q5jM5lgClSLAaIofkiuGFm8qUtdzgmM/RXfFnYfA7Bng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4X916o7nBvaPF/sO8XCm1SJuVQr5O3EdzfPAE4Kssc=;
 b=ciTdkBbxcbN+mbchDTZVU1pe7CeIpGx+Lli/o0F6dYfLWgLt0A8xB0iQm8QNgxpc8gvc7AeiogUAGgZCl1sRVJwDo3k0jZOLfvkKNIjyVYKTOv+NXqe5I5Ohiqxaa4Hsl5DTcWkkXLT7+O7UGTj0UXFFQ1qCNmg7lAVCtVriiX2RquGYbanpBSV49j2EVXrX1YGOW6MIkvxepuIUbfBNvDWqrJkDYSXM8Ixnvm1LKf/7xUc77E6wakT1KlX7bywfYvfGLmnkUDO17/OsxpW1c4S7KEDyQhkOfilmACCbxKmt+AKeb6d2LUoaQve4x30ur+GjxHd/FFeEH1NRxv5bxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4X916o7nBvaPF/sO8XCm1SJuVQr5O3EdzfPAE4Kssc=;
 b=a69Ml8iq8xUSYK9uhnmueYT0Gu6on86HxF3OGKDEwB9a6XxSp6ler/xVE1pmtUiRHsq2tSXoqRvFaa2nOGEgitVTs5DbEGtNar3bk+OKs/lZgpExN0H0jtzC6sBBjNafmhc3Vt7DcoCXMMAnzUuq1CB0Ia+Rf6qolPyiOS5moXk=
Received: from BN9PR03CA0205.namprd03.prod.outlook.com (2603:10b6:408:f9::30)
 by DM4PR12MB6374.namprd12.prod.outlook.com (2603:10b6:8:a3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Tue, 2 Jun 2026
 20:02:01 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:408:f9:cafe::24) by BN9PR03CA0205.outlook.office365.com
 (2603:10b6:408:f9::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.7 via Frontend Transport; Tue, 2
 Jun 2026 20:02:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Tue, 2 Jun 2026 20:02:01 +0000
Received: from nigeria-2635-os.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 2 Jun
 2026 15:01:59 -0500
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<seanjc@google.com>, <peterz@infradead.org>, <thomas.lendacky@amd.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <ardb@kernel.org>
CC: <pbonzini@redhat.com>, <aik@amd.com>, <Michael.Roth@amd.com>,
	<KPrateek.Nayak@amd.com>, <Tycho.Andersen@amd.com>,
	<Nathan.Fontenot@amd.com>, <ackerleytng@google.com>, <jackyli@google.com>,
	<pgonda@google.com>, <rientjes@google.com>, <jacobhxu@google.com>,
	<xin@zytor.com>, <pawan.kumar.gupta@linux.intel.com>, <babu.moger@amd.com>,
	<dyoung@redhat.com>, <nikunj@amd.com>, <john.allen@amd.com>,
	<darwi@linutronix.de>, <linux-kernel@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: [PATCH v6 4/6] x86/sev: Add interface to re-enable RMP optimizations.
Date: Tue, 2 Jun 2026 20:01:44 +0000
Message-ID: <3abe3f20a0bfe7518edadd3d36ca57b4189ca46d.1780427587.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780427587.git.ashish.kalra@amd.com>
References: <cover.1780427587.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|DM4PR12MB6374:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cd7c6ab-ae24-4a94-c8e3-08dec0e1cf8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|921020|6133799003|22082099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	zJHi5nQnN1dJ3kXQh+VDJKam7L8f8ZgrrTvQu/2/3XUnSzDiZJFWEA9DeAgeCeXOJP9rDwNCs4tZhAVjSYRmz6Dh0pLnsle/Z8DmmPR0WoJzIH3JFg/J1p0iP75K89KHvRRHuZjJ69NQADXwxSwV6rkQPKHJiyYK/r7WQyjvCwQ6yO5WnL0CTmG6ReTLRuCUivXiGGGnI2/r3hwnMgIxavgL01YYS7aAWUq7AUBG75RuM2dxpl9UHIS84iz0UdLi15O1X2cXiwFXPqa9CieQyH7jvQYMd22sv268+zF3Lk5xnb0mexlG9HI4KXiZwEtiAlne+CE5YTtBL52ri1kQNUZ6UJOnGPacZxyfb6vBQFi+gg1Id26o3+RWO7SwBfyaQ20Ncv2NX+u8YhaKJ2LnpRmGh2rQJ/6KQwtkHUVSIeiNyCQ7sL+zjdEjTQ1JBX5QMuc3NqWxQ9C6kEsE9sIAVaK4zOXwDy4Krt5W9EF4jmSLK5Puqm/CfU9oYH9yos6Ju7dgV+QFV2JPQST9BZ4Fyw8KdXZYyeMaRQAoU9tdsRqBLkhAgrH35keqSkvPVeOtnT57OK8+DP8NeaDMvzTing5Ez8dTpm4L+4R5QpGvPF8OPhIcTui7v1e2O/QPj8UZC3IgBCZQw4D7JhS6D/ExFYEdnGQOcM+ema1oMVR6wR06KEgXUbayu4iaPddj5waBD9DGO03ig+GyNCE8lPMbcnU7E9r9lWQz5O8adYiNXG5nF+trareqKf8HORGQQUU/3IiRGMJc1SqDMM5e3qkSGg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(921020)(6133799003)(22082099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dvL6pRHVrcC81cBAOMcIlkC5pHHn6idrOGaIPUALNeLeF8oSkyqCtVEGL1WNU/ixZVfhA3gBIH+OdfiW1Y40sVuJbCKUwi79zDEn4568Q5EiKLS6FZd/yXv97Zz5KmicttN9TNnvcohp87I0JTYF0oO/zNq6D/8afjidebBgtO0qDviNv7Rr57fG83Xu6BvpVsAFNc6Qy16Zr8j28yM5rRAPcWAhHwSgnUFFAqZutQvTUG6qnXjguKEAC7mBFNjruKPJliTqyMhnXm5X7sM/Zx4Nn84Sl3S5HVgLIk7p6xIezK0fDpZh3fv+AbRv3HIVvg20P9j2XSc+3naDWhKxMb2TgDDKPtjwMiylJUe4P18qsvsTxTJDi+ew9eEuSnKdW8GFYsuktisFfDPPNNHpqsqyl0oGrA32CqrNpMQkh3mpgdKMSUo8hsn39TpiaVMu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2026 20:02:01.5165
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cd7c6ab-ae24-4a94-c8e3-08dec0e1cf8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6374
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:seanjc@google.com,m:peterz@infradead.org,m:thomas.lendacky@amd.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:ardb@kernel.org,m:pbonzini@redhat.com,m:aik@amd.com,m:Michael.Roth@amd.com,m:KPrateek.Nayak@amd.com,m:Tycho.Andersen@amd.com,m:Nathan.Fontenot@amd.com,m:ackerleytng@google.com,m:jackyli@google.com,m:pgonda@google.com,m:rientjes@google.com,m:jacobhxu@google.com,m:xin@zytor.com,m:pawan.kumar.gupta@linux.intel.com,m:babu.moger@amd.com,m:dyoung@redhat.com,m:nikunj@amd.com,m:john.allen@amd.com,m:darwi@linutronix.de,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-coco@lists.linux.dev,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Ashish.Kalra@amd.com,linux-crypto@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-24844-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[34];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ashish.Kalra@amd.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:mid,amd.com:dkim,amd.com:from_mime,amd.com:email];
	TAGGED_RCPT(0.00)[linux-crypto];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 92D53631A77

From: Ashish Kalra <ashish.kalra@amd.com>

RMPOPT table is a per-CPU table which indicates if 1GB regions of
physical memory are entirely hypervisor-owned or not.

When performing host memory accesses in hypervisor mode as well as
non-SNP guest mode, the processor may consult the RMPOPT table to
potentially skip an RMP access and improve performance.

Events such as RMPUPDATE can clear RMP optimizations. Add an interface
to re-enable those optimizations.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/include/asm/sev.h |  2 ++
 arch/x86/virt/svm/sev.c    | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 6fd72a44a51e..09b1c5d33790 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -662,6 +662,7 @@ static inline void snp_leak_pages(u64 pfn, unsigned int pages)
 	__snp_leak_pages(pfn, pages, true);
 }
 int snp_prepare(void);
+void snp_rmpopt_all_physmem(void);
 void snp_setup_rmpopt(void);
 void snp_shutdown(void);
 #else
@@ -681,6 +682,7 @@ static inline void snp_leak_pages(u64 pfn, unsigned int npages) {}
 static inline void kdump_sev_callback(void) { }
 static inline void snp_fixup_e820_tables(void) {}
 static inline int snp_prepare(void) { return -ENODEV; }
+static inline void snp_rmpopt_all_physmem(void) {}
 static inline void snp_setup_rmpopt(void) {}
 static inline void snp_shutdown(void) {}
 #endif
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index d7e40a5fe5ca..4442ecae3d18 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -741,6 +741,21 @@ static void rmpopt_work_handler(struct work_struct *work)
 	free_cpumask_var(follower_mask);
 }
 
+void snp_rmpopt_all_physmem(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_RMPOPT))
+		return;
+
+	guard(mutex)(&rmpopt_wq_mutex);
+
+	if (!rmpopt_wq)
+		return;
+
+	queue_delayed_work(rmpopt_wq, &rmpopt_delayed_work,
+			   msecs_to_jiffies(RMPOPT_WORK_TIMEOUT));
+}
+EXPORT_SYMBOL_GPL(snp_rmpopt_all_physmem);
+
 void snp_setup_rmpopt(void)
 {
 	u64 rmpopt_base;
-- 
2.43.0


