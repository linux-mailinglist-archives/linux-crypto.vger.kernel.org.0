Return-Path: <linux-crypto+bounces-25368-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GxE4OipTPGqjmggAu9opvQ
	(envelope-from <linux-crypto+bounces-25368-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 24 Jun 2026 23:59:06 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 891A76C1A5F
	for <lists+linux-crypto@lfdr.de>; Wed, 24 Jun 2026 23:59:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=1SL2hOV8;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25368-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25368-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 693843010633
	for <lists+linux-crypto@lfdr.de>; Wed, 24 Jun 2026 21:59:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8986828D8D0;
	Wed, 24 Jun 2026 21:59:03 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011068.outbound.protection.outlook.com [52.101.52.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0462028C5CB;
	Wed, 24 Jun 2026 21:59:01 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338343; cv=fail; b=Az2yNXECHmu8m0Y9zHJh8ZE0o6IMjhaWLp79ovLRG25C7z++OwYLULiJ56A//gooCJ4qplmioie2eB20CRMk1fDT4ajJAnVfQiwRBJcsdM4mz4Xhyks09yI6IjfabXJXqvd2jutrwvUcS7UEz1oUVTdL7uNL4zdOJdar+1GWLjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338343; c=relaxed/simple;
	bh=GqhTMaZjWSV66iIzdZWT9NT87wYOANICabeseaeG5Sw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zrle/UZVUHsnlbYZ9mkoXY+BhbM40UqJrKUcUm99NeNx+pBPsiRk/nkb+4zWGIEZKWhBd7oNte8k5swnIYykpH6o/cxp8dNJ57LTFwzxz9S9Fj2FOedQtfzYbxm1x2VfxsQ1J0ylthQYM2R0gAhoZc4Ldl7jcUczZM+1FPGGVAU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1SL2hOV8; arc=fail smtp.client-ip=52.101.52.68
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=op+JIL74kgrb2Z+CqFsqhYg2C2c4kgyWGeeoij9OXeCAuk2UlMh7vZEqJsmiu+1sKhi8ErjyLsqCej9ubgxMnsYa7S0+xENjK8632CDNSAdPHvZGLg4tp47DmCUZ1aHbmYDvPxNH2aBNkuZyZ5fIpQB6XQe3Jn2iSxsM+x200d7z1aqygOettM41HKAMcjTy+inGzxjL8WKv55Q5HZuya4As2ayPi29xYEl1uklYO9lXHR+omQpm74pz6orTPx5tie9LPbvhLht8Ou8DMZ/JAuMpqVE2BYonqxuIw/u4YO6RZc29aNjTyCyj+WfsmdqASvA/yr4SjSSQXIfiar6a2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lg70Jh4RT2FOVbFeIgso4zS0qakzwOj/57bHolmhE6E=;
 b=DSj+Tl5KFQ/hdcs7LTtSO0/CkTsqHulAULkX9gwzNOP6cts6+I1bTfMbTA9L9KbLjfAKUZXHzemy1OnFE/nNzWKg9p8Zy4pJx8YKcccqA5ZpH8XL/ESe2MVUCczOd0mAb7J7B5Y6PY8fH162Vua+U6ATFTpXk8ELQGp74FRkOuQSjITedFhJCWovS20wT320QdEA8rJHhgO5bBnEQIIrUlh5YEyxu0FAjOPxnSZMh6P3NG/IAev6ul3/b2a8DrWqosDkJTHyYwNpWLigNG9x83Uu57bdCYpPALuU2andmnrZEoulgPOWx5wLYOZYwOsJX5vspra3Io3scxmT4LVyQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lg70Jh4RT2FOVbFeIgso4zS0qakzwOj/57bHolmhE6E=;
 b=1SL2hOV8tDNbotcCs0cR9mf0dosoVoTQpgYPaLc9YfouwGSbzRRuViwu3rHyqXFZ+lORWBtkJ93WFJlRObRwdLBDBxyKtWmgzIBf940SRVNBSQ0bG6oNL2FlLFz6mUAcvP8lODvckeiGKC0JeWCdBjD0tuhhY3Ka6Dj26YNmX8E=
Received: from LV3P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::33)
 by CY8PR12MB8338.namprd12.prod.outlook.com (2603:10b6:930:7b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.13; Wed, 24 Jun
 2026 21:58:57 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:234:cafe::ac) by LV3P220CA0001.outlook.office365.com
 (2603:10b6:408:234::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.14 via Frontend Transport; Wed,
 24 Jun 2026 21:58:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Wed, 24 Jun 2026 21:58:56 +0000
Received: from nigeria-2635-os.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 24 Jun
 2026 16:58:55 -0500
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
Subject: [PATCH v9 5/6] x86/sev: Add interface to re-enable RMP optimizations.
Date: Wed, 24 Jun 2026 21:58:44 +0000
Message-ID: <e9fb911f584c514ba7136d642220219dd2938a84.1782336473.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782336473.git.ashish.kalra@amd.com>
References: <cover.1782336473.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|CY8PR12MB8338:EE_
X-MS-Office365-Filtering-Correlation-Id: e069b726-04e7-407c-79c3-08ded23bc9f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|7416014|921020|6133799003|18002099003|22082099003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	Gq2pNX7uxPWCJ8oWaB34Usug1V106zlfbQetV750EUpQWxfHAKDvQUDYYNl0f3obfm+qPTZ5EZ1zRjMuG684Y1/p4eFNWuPhVaCcuQAzcmA7gfAYnnaXdurdolJcScMqlRCpz+0E6wydYIYndYB7AmgeR5Jh7Q6b27hc5dtqPZRirkDmmY9TgivdUj9eHBNZLeu4HTaDlW6WSj0bnoB+eGaniBfxPQkcdRlZWPQ8kUX9PSjg2ebNkpE7YfqWbzUv0943ZTMc0DgIfIH+R0hOsjxZxa/tMFyy76pIJwjDYPT7CqjyL7JsJtASLa9Tu5WyTaBGc93RUimIjeccZ9dqgg4WcqenOr7yjXOXwBIStxs0QbuHyGjpFZ6FVRsgfMViNLZqqqP7frAUj4exkZUlD5jv9fw3HBJEZIbPlF8zfZnZFZZ6EAQpp+51dQ98KW47VuPOpqGt62RviwFU/RVpMc0uUFSNEdIeavUhXyCLI0Tr7y8bWmB+voFQvNV8AlOx9VqH54hssFD5VDEVuPTBsbw8hXVXfWhICVHD0z+YvjlqopXEqwe0hNYe4vZ65qtSijpiwvmmkWZD+As6P1ce6K00Ta2BI9an6Vlz4IjzrW3y4sbx5RDUJOxHxgN7jZH1V3Ex9UFHVpPuZX0Db7kssLGQJk7p1WmZuOeXKxz7eAmZf8BeybduyiAL0/k86RSATeXy6ESVdEBf2dbd44rmF66TblIeyMxtRquA5LUkuTOnAljS4arT38IZAywT1nW5
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(7416014)(921020)(6133799003)(18002099003)(22082099003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	w8FAwNWPCnvRUd9nZisK5GSaGlY+FTTVoYWJS/INOdeRBjzEhzWrx4ZgL9xxgV6qGBwZ+pdUplakLdXupcT1UVU6P0feQPiP/eH6iWMqemjJm4/hhQJ15OI11QxgfMTP0pytq2jeTC5VMZWaXoXQ/PX3UKPXPvc9+D5pAxnR6IGAmvJCbO5e2SeirINbk1c3WM6S0ecMuI6UIAhKmRWgZMGrMQ4xxwqT28osalmsWCu+bgBN76YH4y7UMOcu2JxBIziLGOGf0/8Bj27ZIINwIjBo5KcBFR71r+qkUy1nPvq72Pl6ZhiY984JZJnGfObZNYOWrBy3JSgRPOeLSUUY2JqgJZO0y1bGCUFYwczVa7WwJ6AqYLmPb4N1qjIXpPj1uIzBIXRNyEmecTLWx4GsqxaIxUqMbMeH07SWwUAsqTY2RzWYQyKb9MPXWdFu0E5E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2026 21:58:56.5763
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e069b726-04e7-407c-79c3-08ded23bc9f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8338
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:tglx@kernel.org,m:mingo@redhat.com,m:bp@alien8.de,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:seanjc@google.com,m:peterz@infradead.org,m:thomas.lendacky@amd.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:ardb@kernel.org,m:pbonzini@redhat.com,m:aik@amd.com,m:Michael.Roth@amd.com,m:KPrateek.Nayak@amd.com,m:Tycho.Andersen@amd.com,m:Nathan.Fontenot@amd.com,m:ackerleytng@google.com,m:jackyli@google.com,m:pgonda@google.com,m:rientjes@google.com,m:jacobhxu@google.com,m:xin@zytor.com,m:pawan.kumar.gupta@linux.intel.com,m:babu.moger@amd.com,m:dyoung@redhat.com,m:nikunj@amd.com,m:john.allen@amd.com,m:darwi@linutronix.de,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-coco@lists.linux.dev,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[Ashish.Kalra@amd.com,linux-crypto@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-25368-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[34];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Ashish.Kalra@amd.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,vger.kernel.org:from_smtp];
	TAGGED_RCPT(0.00)[linux-crypto];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 891A76C1A5F

From: Ashish Kalra <ashish.kalra@amd.com>

RMPOPT table is a per-CPU table which indicates if 1GB regions of
physical memory are entirely hypervisor-owned or not.

When performing host memory accesses in hypervisor mode as well as
non-SNP guest mode, the processor may consult the RMPOPT table to
potentially skip an RMP access and improve performance.

Normal guest events clear RMP optimizations: pages are converted from
shared to private as SNP guests are launched, and large pages are split
and collapsed during guest operation -- both clear the RMPOPT
optimizations for the affected 1GB regions.  Conversely, guest pages are
converted back to shared during SNP guest termination, so those regions
may become eligible for RMPOPT optimization again.

Without some intervention, all RMP optimizations would eventually be
lost.  Add an interface to re-optimize all of physical memory.

The interface uses mod_delayed_work() instead of queue_delayed_work()
so that the delay timer is reset on each call. This provides proper
batching semantics: re-optimization runs 10 seconds after the *last*
VM termination rather than after the first. mod_delayed_work() also
re-queues work that is already in-flight, so a re-scan request
during an active scan is not silently dropped.

Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 arch/x86/include/asm/sev.h |  2 ++
 arch/x86/virt/svm/sev.c    | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
index 440c813fedde..d40beafbebb6 100644
--- a/arch/x86/include/asm/sev.h
+++ b/arch/x86/include/asm/sev.h
@@ -662,6 +662,7 @@ static inline void snp_leak_pages(u64 pfn, unsigned int pages)
 	__snp_leak_pages(pfn, pages, true);
 }
 int snp_prepare(void);
+void snp_rmpopt_all_physmem(void);
 void snp_setup_rmpopt(void);
 void snp_clear_rmpopt_capable(void);
 void snp_disable_cpu_hotplug(void);
@@ -683,6 +684,7 @@ static inline void snp_leak_pages(u64 pfn, unsigned int npages) {}
 static inline void kdump_sev_callback(void) { }
 static inline void snp_fixup_e820_tables(void) {}
 static inline int snp_prepare(void) { return -ENODEV; }
+static inline void snp_rmpopt_all_physmem(void) {}
 static inline void snp_setup_rmpopt(void) {}
 static inline void snp_clear_rmpopt_capable(void) {}
 static inline void snp_disable_cpu_hotplug(void) {}
diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
index 5f99cbbc6cbd..4661e5271a2d 100644
--- a/arch/x86/virt/svm/sev.c
+++ b/arch/x86/virt/svm/sev.c
@@ -743,6 +743,21 @@ static void rmpopt_work_handler(struct work_struct *work)
 	free_cpumask_var(follower_mask);
 }
 
+void snp_rmpopt_all_physmem(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_RMPOPT) || !rmpopt_capable)
+		return;
+
+	guard(mutex)(&rmpopt_wq_mutex);
+
+	if (!rmpopt_wq)
+		return;
+
+	mod_delayed_work(rmpopt_wq, &rmpopt_delayed_work,
+			 msecs_to_jiffies(RMPOPT_WORK_TIMEOUT));
+}
+EXPORT_SYMBOL_FOR_MODULES(snp_rmpopt_all_physmem, "kvm-amd");
+
 void snp_setup_rmpopt(void)
 {
 	u64 rmpopt_base;
-- 
2.43.0


