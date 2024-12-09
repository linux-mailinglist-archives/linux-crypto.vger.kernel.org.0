Return-Path: <linux-crypto+bounces-8477-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 276A79EA2C9
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Dec 2024 00:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5781888081
	for <lists+linux-crypto@lfdr.de>; Mon,  9 Dec 2024 23:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57CB1BEF97;
	Mon,  9 Dec 2024 23:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iodtDyV5"
X-Original-To: linux-crypto@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B861F63ED;
	Mon,  9 Dec 2024 23:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733786813; cv=fail; b=hHfwgvSaEdMOsBmOO1I6NxRTlfX+PmQnCBX7DjaQ1j+3JfkR8xqRROnMVm8QTTZrULQXTPskMHXq1XSaGQma9BI3D6xsB/uoPn025UdwCR/ejukmpwqyu6MZlMqf2HrJzG9iQ04AGZQb7atCBEHX7JOK/GumW6ieR9K/rPwWvps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733786813; c=relaxed/simple;
	bh=+K/vxkwEDi5ITWxFyyh9ydzrNB1ByGyVWGA+yYpUH0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OV7abQcQqclDTA/06pU0JN+M0NKQXXOUXUgwB/3I1fCxWb4GxQmoyg43ucSFzaJNCXq/NBY3YT5TVd5KBjfAbK0nv1kivL7iVKuVh/slXmIVXrL5pW0bh5G+CVnD4P/VBK7wBqLt0/cNVRAnbNOacbqwrPbrTHcgHT+47TRi8Dc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iodtDyV5; arc=fail smtp.client-ip=40.107.92.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ePZzRSgWlDgyhAUtDdPtdlUqvR5BGCBOZqPgsh+6K7j9eyISykrT+sCj6Ymw+anYshDdmLLHBxu/D+BoW13RDDDyV9E+FBb2G2UrQqmiatFnObkXNiMcwlxZorsiX1wuXx17AJ9k/QKuBEkoEXLvUMC+D0KPY2gjHs+Ka42xSP98s0ceJnuorl5nMfZdliLW6aQk/lcCfc7gIT3DefZX3IB49Yc7mrzHJNNNP3sxxMcAv4twHwG8HnaB8r6SnSM8ImSu2FSUI/oICKjODx52tb7O6vb7WL2jY11UBtdlCEoLuAIQrkSI4Y6S1U//ee4MCuFK4QqxprBBjrAHzUMfrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrAwe1BAilVXJlrfkQ47r9N2MLlEwHGTplDZfKUWkbM=;
 b=vVwVJrlDQwieE6g3tpwU85fmwzyZORzI3itMqEWTTUG5kJb3kuVhKuMYbPSNJgjUAxbReedJLUQByBYiqXqjv6VwPbG3b1OMWwJjLs2Swo049T5ucaNFCwKP9vXSBBVyGmsuoSCe74ynJO/ZHDXvYLddbIZ7kkYdz+Yr5pjPz3F2O89EIa9lRBS5bgsw1h3jwTKLlKehvfqOt98NbcN27hAEq+7XrPOm9ifdIorSujzavAGidZ26wiqFZ1y2ACqU07cypEIFYxahJXmYQUQlA9RkClJVpAhHQOjEI14uHxOytVE1A/KaeEr8e8uTMbcBYGQCMPNn1p5IOuhnc2VZ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrAwe1BAilVXJlrfkQ47r9N2MLlEwHGTplDZfKUWkbM=;
 b=iodtDyV5A44rGP9tJRITHVYaJf2px8IiHkBjpvuSj3xUNyZ4lOOxpPi03nJ9g/CYQC5MNcpOKar63YlmfCvyb6iLXjlqVmbeFGVI8CsS6v9IydX9hrJUK0pyfFuaoZ7qFEACU0Ti0UOjDfje1j//94Prn/gsoWBeP3kHGUkZZ3U=
Received: from SA0PR11CA0179.namprd11.prod.outlook.com (2603:10b6:806:1bb::34)
 by SN7PR12MB7249.namprd12.prod.outlook.com (2603:10b6:806:2a9::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.24; Mon, 9 Dec
 2024 23:26:48 +0000
Received: from SA2PEPF00003F63.namprd04.prod.outlook.com
 (2603:10b6:806:1bb:cafe::5e) by SA0PR11CA0179.outlook.office365.com
 (2603:10b6:806:1bb::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Mon,
 9 Dec 2024 23:26:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00003F63.mail.protection.outlook.com (10.167.248.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 23:26:47 +0000
Received: from ethanolx7e2ehost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 17:26:46 -0600
From: Ashish Kalra <Ashish.Kalra@amd.com>
To: <seanjc@google.com>, <pbonzini@redhat.com>, <tglx@linutronix.de>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, <hpa@zytor.com>, <thomas.lendacky@amd.com>,
	<john.allen@amd.com>, <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <michael.roth@amd.com>, <dionnaglaze@google.com>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<linux-coco@lists.linux.dev>
Subject: [PATCH 7/7] crypto: ccp: Move SEV/SNP Platform initialization to KVM
Date: Mon, 9 Dec 2024 23:26:37 +0000
Message-ID: <9ab04dfe22c067eb412ed4198b26c5d1482c6c22.1733785468.git.ashish.kalra@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1733785468.git.ashish.kalra@amd.com>
References: <cover.1733785468.git.ashish.kalra@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F63:EE_|SN7PR12MB7249:EE_
X-MS-Office365-Filtering-Correlation-Id: ee84bfba-3cb7-48f0-a7e4-08dd18a8f379
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iycZSwUYS7G6kQOb+1ckHthZaIrn88c7uHohfwHUQsMz3SMyfec74RRGsOoR?=
 =?us-ascii?Q?ND2VqVvLNP+1fSWzqHzW9ceMKiCtRCd2HzeW80xJfrNRGJ9mbceuBhv+mFEW?=
 =?us-ascii?Q?t8nafgre/hcSleAhldBXqz4ZPnbFGwJI44QFmnGEkvxP02jdAMlRpJynuJ/F?=
 =?us-ascii?Q?Sg21iPI7E/OivWFUUxJqCRC8E4zEvPQL25b7whhcpG8dD734j5S52RhFsX6a?=
 =?us-ascii?Q?bJN+IZqMxAULZNKrywsA/gzVf6Pw8vvqRCe7wwjsrA9JSxyi+o59kWlJj0Sh?=
 =?us-ascii?Q?AgRRI2JBybrAmUIC0w/h5kAfD7oM8eK/vxZXsQzkhwnej6Gb91JEBkRD8co4?=
 =?us-ascii?Q?nIj7zYtI6oPtFhfl08APTo4uefwF88SnvnEqfGS9bCywP9xefMq53/3qop2W?=
 =?us-ascii?Q?eWiJaABavbGqW5KKJpVvFlsN0QZqfL+/iEplrR5PruEyOTEV3P9RtlfzYAI8?=
 =?us-ascii?Q?fejLWlWUGg3ABzC/EoStI3onLdTPAchFTi4lXwCioaMuJakgDLikYrs0MctC?=
 =?us-ascii?Q?x34dAmSixHUz+isEVYXT22rAJJKogSOAFvOE8EdyTcHOXgEQhFlw6qycJooa?=
 =?us-ascii?Q?NnaC85NsIvH5BgtOIL7OFte3GPO0BdbAWbqFPayPN5krvOOYJiymox4yK1CG?=
 =?us-ascii?Q?hHF/8oNZXWq2AFOOANRTsuD5L7r2tSIuUdkFAiX0VwoCnKGoNiHhRZO90oj/?=
 =?us-ascii?Q?vEuD5vGxGjKZLrHPRQfpw1tvzdQGCi+cTT4ChOucwbEEDL7aiIqR8wJEhoMm?=
 =?us-ascii?Q?lxnu4gih6kFHwGFYHjWkP89mxpc6gUsqtnKjx5yc8H0AvxkRnULIqPHPohjC?=
 =?us-ascii?Q?HFoCoB60QpqFutnAc5QZJM658Ov1gP/3EQaQ4oerwak8U6yw7HRt586H3DRD?=
 =?us-ascii?Q?UKEYugiy9vcBIgPX62D8SLc/ccKYeKIhdmpiXkT+lLpzWU9ScYkyKasjplBd?=
 =?us-ascii?Q?QZcQsiCa9938oZpNxxyZj8rd8LWlBJ00VBybbyGKRTd+39EME4lPsF4geuPo?=
 =?us-ascii?Q?2vZOgKtOvhTpZAVOx3Y3cUFqGX8+wNLsZLZTTU3eexU8meHgglI4cBMo1q12?=
 =?us-ascii?Q?SrAXUiADai5aGdPjXkVfY5zZ4i/MmpGDS0Ab7ukkziy+TWziVfP7tles3s7p?=
 =?us-ascii?Q?zW+N1m37C7Qa6Rd9AdXCq2hHm5vR3RhqmBg4es47s70oQFrOd6+yVLBORmQl?=
 =?us-ascii?Q?qbeeL3Jn3322rKLSdHmOp3WfNzSlGNfY3RrYdnZD6ZpUpWC022fqgCH01NBf?=
 =?us-ascii?Q?t9EBmDnPcxTUGyBpjh5r0xMYURogXq+FgpJ1IMUN2ZRm9iQbKt/hvnGdm9ka?=
 =?us-ascii?Q?WYqmvZ88q2tCqZry70HyqHmGE+JQ6kpK86lAGy4av2DC8kQtBMnLGS3+E9P1?=
 =?us-ascii?Q?nOndgfRulzc7l624D1Wwb2VvP40aiO74fD0w1m66BLqm/EEZiKtf+srJTYD+?=
 =?us-ascii?Q?SPgrbaVX1q3zFKLr5Rm7GmmfYgfev5ptH1a2XMSuOcA9fnVv/VGW7A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 23:26:47.4105
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ee84bfba-3cb7-48f0-a7e4-08dd18a8f379
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7249

From: Ashish Kalra <ashish.kalra@amd.com>

SNP initialization is forced during PSP driver probe purely because SNP
can't be initialized if VMs are running.  But the only in-tree user of
SEV/SNP functionality is KVM, and KVM depends on PSP driver for the same.
Forcing SEV/SNP initialization because a hypervisor could be running
legacy non-confidential VMs make no sense.

This patch removes SEV/SNP initialization from the PSP driver probe
time and moves the requirement to initialize SEV/SNP functionality
to KVM if it wants to use SEV/SNP.

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
---
 drivers/crypto/ccp/sev-dev.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index b8938c96915b..52dce46745ba 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -2528,9 +2528,7 @@ EXPORT_SYMBOL_GPL(sev_issue_cmd_external_user);
 void sev_pci_init(void)
 {
 	struct sev_device *sev = psp_master->sev_data;
-	struct sev_platform_init_args args = {0};
 	u8 api_major, api_minor, build;
-	int rc;
 
 	if (!sev)
 		return;
@@ -2553,16 +2551,6 @@ void sev_pci_init(void)
 			 api_major, api_minor, build,
 			 sev->api_major, sev->api_minor, sev->build);
 
-	/* Initialize the platform */
-	args.probe = true;
-	rc = sev_platform_init(&args);
-	if (rc)
-		dev_err(sev->dev, "SEV: failed to INIT error %#x, rc %d\n",
-			args.error, rc);
-
-	dev_info(sev->dev, "SEV%s API:%d.%d build:%d\n", sev->snp_initialized ?
-		"-SNP" : "", sev->api_major, sev->api_minor, sev->build);
-
 	return;
 
 err:
@@ -2577,7 +2565,4 @@ void sev_pci_exit(void)
 
 	if (!sev)
 		return;
-
-	sev_firmware_shutdown(sev);
-
 }
-- 
2.34.1


