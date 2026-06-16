Return-Path: <linux-crypto+bounces-25198-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ss3xIm/nMGpDYgUAu9opvQ
	(envelope-from <linux-crypto+bounces-25198-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 16 Jun 2026 08:04:31 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 473E168C574
	for <lists+linux-crypto@lfdr.de>; Tue, 16 Jun 2026 08:04:31 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=dqp0y49U;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25198-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25198-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5EE7A301A0B0
	for <lists+linux-crypto@lfdr.de>; Tue, 16 Jun 2026 06:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07FF83DA7E0;
	Tue, 16 Jun 2026 06:04:16 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013061.outbound.protection.outlook.com [40.93.196.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E243DB322;
	Tue, 16 Jun 2026 06:04:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781589855; cv=fail; b=ThAw3/qCg+KJl4Y3s0OHKMSglwySPJC1NiIhUxhOC72uElitoQhRNWrHSj08NXODhIohxtS8P7WIIYOs8J+i+511SO2Dag/tcsaTkM2Bhf0YOMzqNtIJVvboXcWjW0EF81NFDCKOd57BX5koODvzeDNI9+hSUVGtoNiJhbBOrV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781589855; c=relaxed/simple;
	bh=mTgiDi1KF0DwB0HoQjxcIxygCu9t+Smi2caxnDJOhlY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=sA1Bx3cI4rRw81WWrsqx4CvlWse0PT/oqLTnJZgxgpdK6mMvT5MB9sooPuQOGTsR0XTPaG9eQXgtlTYKHkYbnEx2UJEXQTcEoZjqjyy3aRCuym1RAEVXo022Ig80puu7bow7t3zBI41n4YLmus8BOs9Hhy/mO1pPoBZ5hh9ANg4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dqp0y49U; arc=fail smtp.client-ip=40.93.196.61
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8yHNli2q9FcftlAUQ4xUu6kNzvGgNTLXh3h1wJJkBbSkkM+i45jJ81IVMCXw1VjMgnwYqVRVm/y33XVmrUVSe0v5zQO+2R0KAXtIQRLxY4RArhXl728XF985AeR1xggEHWyY77kiSflm2hsXXwTNMkE0ga3P08TSlmaL3ev7nJeJ6u6VtwOS3nbWhCDCSXdLjUKc26shZTK1QlAJx9KWZnmNFkGDmE+3EUrrjEVXPlxtPe/e8UCSiWtKMuJytXk0TGmjjos6MHrBEgCzDg59R76Ln6ziScEubm+EUMFzyAMiWV3Sdlbz+7DFgIAS38ST98abpBdCDWu0us2HBuJXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlCqWAloRLHmBD57Evhm4kk0nDTP2qMQSPDNks/WIzA=;
 b=EhEeKJo6QHyctOiCABGk+EROCMoJc3ix9C0MUpuy6RUmLyGrNau5KNW0d4xrbBpbQm3lI1+9fRY8tNPpWy5/N4DlKOcPjWYxRY79J5GKktN9ddGvf4tMmvPGy536X0fQ3EdYwMFBaroO4y3kubZZalK/KrlUPHWmBlfosKaK7XijQugAcuaSVz6QTOm9MtXpWISWvOvwgHds+CH6TNK9R394sJpDALjFVRFUpZ9Mmua9TAwaiFhWeDpWvMcmhvlz2kKiyq7glkXwOojMsV/BbgG11ExXClQJRqZMGiy/Lk43xLkhLg5X3QsDkKilGfn1XKWIMgOFeGZPLJl+AIo1tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlCqWAloRLHmBD57Evhm4kk0nDTP2qMQSPDNks/WIzA=;
 b=dqp0y49UnO6VX+8VKd521Tta6UrZKJCbreZCc5FkDiyBy1oejs6fj2mepy3mrgQhgOjer9o21+RPLOU6LcYBey7snwxN6ps9QQsKELclCJKe8CYqqKd/Zqg50HSxu391Uwz+kngRHMlVmWW22kvhajdAvu4FrcfusR+OycEEGK8=
Received: from IA1P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::12)
 by DM4PR12MB8521.namprd12.prod.outlook.com (2603:10b6:8:17e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 06:04:07 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:461:cafe::9b) by IA1P220CA0011.outlook.office365.com
 (2603:10b6:208:461::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 06:04:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 06:04:07 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 01:04:04 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 16 Jun
 2026 01:04:01 -0500
Received: from [10.136.46.240] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 16 Jun 2026 01:03:52 -0500
Message-ID: <fb2f1105-3bef-4197-bccd-865c013ce712@amd.com>
Date: Tue, 16 Jun 2026 11:33:51 +0530
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/7] x86/sev: Initialize RMPOPT configuration MSRs
To: Ashish Kalra <Ashish.Kalra@amd.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <seanjc@google.com>,
	<peterz@infradead.org>, <thomas.lendacky@amd.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>, <ardb@kernel.org>
CC: <pbonzini@redhat.com>, <aik@amd.com>, <Michael.Roth@amd.com>,
	<Tycho.Andersen@amd.com>, <Nathan.Fontenot@amd.com>,
	<ackerleytng@google.com>, <jackyli@google.com>, <pgonda@google.com>,
	<rientjes@google.com>, <jacobhxu@google.com>, <xin@zytor.com>,
	<pawan.kumar.gupta@linux.intel.com>, <babu.moger@amd.com>,
	<dyoung@redhat.com>, <nikunj@amd.com>, <john.allen@amd.com>,
	<darwi@linutronix.de>, <linux-kernel@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
References: <cover.1781419998.git.ashish.kalra@amd.com>
 <6a4d0ec9e037d91c0fdba9c525942ca288e1b1b2.1781419998.git.ashish.kalra@amd.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <6a4d0ec9e037d91c0fdba9c525942ca288e1b1b2.1781419998.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|DM4PR12MB8521:EE_
X-MS-Office365-Filtering-Correlation-Id: 053f0527-cd57-4314-900d-08decb6d136e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|23010399003|376014|18002099003|22082099003|921020|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	siPdaCV4olqjDE/qkbDYXOZcY6otKFzrFgiSZOelGdI4nF/n8xhzCQBeZxWT/iMd7DEPdpNo9C+k1EKr5R/W2d//pKvtX13PsGuWY0WdvP+XSZw632m63KarJZBnZCP6L+BD9ObW3zK4tHqosFdwo6159I1fVx2mPJzIyc8KHszmUZsB83IsuRkMt3sQJyqrHxCoAvemtkMmNysi82QmkMZZ1n6UBBNYNZO4rS0Tl4eeZtxDRaPw3101xYOY+iWgmMrhkNdJeTptxkn9se4TWWurjtFi+mmH0jkalg30G82ykKqmUBwHo6faomvws9dsFS0UDeZkiWaQkSa7e6xvZRAq7qdVTxgCnAep3HIXkJ+a4Ca4h+gXOP6qtUjw2QXRsjYWuiykBYgF5a00NFYdNlL/qGGq+PvY7W9VVegW+ziW2Cxa6/2I+Y2diSA+BF2F4xULWBkbOGMMbKx4mIX/DEy2Hwp5/fIjaVHcSVEWCBvHlCXV+FoM+mmF+0UPGiLL8fgflcLORzx2kuzBOkizd/QU+gRXl/8WtuPVxINZhe0EoFJrLkusxOCyU5GJKwcSCr02ChrnP0k3pfvqHtvjSOVWL+nh5skLOPkbs6yU5Dh1D92+VNnuZFFiLK/0ds9AIBS8yuZ/S4JZnV0Mgb1lgTl2y7LYdI7C2hvD2dLF4PEHzCibJUgHzBpoa3+E+orw+sjx0KpSi7JOa/vkh3pdAfAY+u25mOPs5+8ytHCBvTdskIhFgBn7AWWpcKTXzN0qmIsTpwbEK+SAYxzt1xKMOg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(23010399003)(376014)(18002099003)(22082099003)(921020)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	chl6PWOJ0V3OQG3cm0xJx9CrDm5jvItT3XgxKlbOfE8m0m+TQ08CnDGgskrxMzL8H5xRp1VeZ3pq+TIEKtooXx3I062jHnJT3Wkms3+aIUPsgu85qAL11LV+Vefy3iMTKLz5U+twvkXRaS1jfg/Zwh8eJ+xLIRLFs9vk8cJpJDxswTDtDzlamf8HwfQDAnyqv0qBntXMkvveUuY/2zCscRvKMB1j6pDxtZ9QBMtzvYSaaisHxaJpHJ54/5dhuXGp4c0LugIQqxN1bkdLOx8bcdi3GuP1eO+JlG6a8xst5e9Dg1SWywdYNciWvzIuCHmY2ae6yxGDBrA5/b38YsF1ir7UN4URJp5fR3i4/homXis5NffAwo1h5jmHZbBG2RFuucD4M4KyJw4+/iqOreuPtPwhq3RzhR6ejd4Kq9fL0v4bpmjqFhGGKCn0j04lZsc+
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 06:04:07.0806
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 053f0527-cd57-4314-900d-08decb6d136e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8521
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25198-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:Ashish.Kalra@amd.com,m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:seanjc@google.com,m:peterz@infradead.org,m:thomas.lendacky@amd.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:ardb@kernel.org,m:pbonzini@redhat.com,m:aik@amd.com,m:Michael.Roth@amd.com,m:Tycho.Andersen@amd.com,m:Nathan.Fontenot@amd.com,m:ackerleytng@google.com,m:jackyli@google.com,m:pgonda@google.com,m:rientjes@google.com,m:jacobhxu@google.com,m:xin@zytor.com,m:pawan.kumar.gupta@linux.intel.com,m:babu.moger@amd.com,m:dyoung@redhat.com,m:nikunj@amd.com,m:john.allen@amd.com,m:darwi@linutronix.de,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-coco@lists.linux.dev,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kprateek.nayak@amd.com,linux-crypto@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:dkim,amd.com:mid,amd.com:from_mime];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kprateek.nayak@amd.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 473E168C574

Hello Ashish,

On 6/16/2026 1:18 AM, Ashish Kalra wrote:
> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
> index 8bcdce98f6dc..1b5c18408f0b 100644
> --- a/arch/x86/virt/svm/sev.c
> +++ b/arch/x86/virt/svm/sev.c
> @@ -124,6 +124,10 @@ static void *rmp_bookkeeping __ro_after_init;
>  
>  static u64 probed_rmp_base, probed_rmp_size;
>  
> +static cpumask_t rmpopt_cpumask;

nit.

I believe you can use cpumask_var_t here and do a zalloc_cpumask_var()
during snp_setup_rmpopt(). That way !X86_FEATURE_RMPOPT configs don't
have to needlessly waste space to keep a redundant cpumask around.

Same comment for rmpopt_report_cpumask in Patch 7 which can be
allocated dynamically during rmpopt_debugfs_setup().

> +static phys_addr_t rmpopt_pa_start;
> +static bool rmpopt_configured;
> +
>  static LIST_HEAD(snp_leaked_pages_list);
>  static DEFINE_SPINLOCK(snp_leaked_pages_list_lock);
>  
> @@ -490,7 +494,12 @@ static bool __init setup_rmptable(void)
>  	if (rmp_cfg & MSR_AMD64_SEG_RMP_ENABLED) {
>  		if (!setup_segmented_rmptable())
>  			return false;
> +		rmpopt_configured = true;
>  	} else {
> +		/*
> +		 * RMPOPT requires a segmented RMP table, so leave
> +		 * rmpopt_configured clear on contiguous RMP systems.
> +		 */
>  		if (!setup_contiguous_rmptable())
>  			return false;
>  	}
> @@ -555,6 +564,21 @@ int snp_prepare(void)
>  }
>  EXPORT_SYMBOL_FOR_MODULES(snp_prepare, "ccp");
>  
> +static void rmpopt_cleanup(void)
> +{
> +	int cpu;
> +
> +	cpus_read_lock();

nit.

You can use guard(cpus_read_lock)() unless there is a complicated
locking pattern where you need to drop and re-acquire the read lock.

> +
> +	for_each_cpu(cpu, &rmpopt_cpumask)
> +		WARN_ON_ONCE(wrmsrq_on_cpu(cpu, MSR_AMD64_RMPOPT_BASE, 0));
> +
> +	cpus_read_unlock();
> +
> +	cpumask_clear(&rmpopt_cpumask);
> +	rmpopt_pa_start = 0;
> +}
> +
>  void snp_shutdown(void)
>  {
>  	u64 syscfg;

-- 
Thanks and Regards,
Prateek


