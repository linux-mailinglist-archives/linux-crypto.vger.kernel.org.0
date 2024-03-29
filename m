Return-Path: <linux-crypto+bounces-3177-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF2889328B
	for <lists+linux-crypto@lfdr.de>; Sun, 31 Mar 2024 18:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC9B61F21234
	for <lists+linux-crypto@lfdr.de>; Sun, 31 Mar 2024 16:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B351145358;
	Sun, 31 Mar 2024 16:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pVQbPIWb"
X-Original-To: linux-crypto@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F6AF143C75;
	Sun, 31 Mar 2024 16:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711901476; cv=fail; b=qMi2jBS0D8cS0kIQs+Fo9kJJSfNpW064AIWXh9PZvHfn+InviNprxPu/Xl1zpsVqvidbMRZ/zzuQQe+HJCeLD1bSeKfvPCPl+iRn3AAE2ahwJK5TX4ch0+9mILcJr6oUqGddvOS26Y7BGyxRaC2Y06AQ1F/p91lC089wvsAroGU=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711901476; c=relaxed/simple;
	bh=1mt+dPqGVGgxhVCKEG3pXqMiUa4XApuT0BM0owhsWto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=It/MVBRk88x8w85TRuOSGjrSjobuJxwQtfqOhwtir/U2Gd6imZqcB++LjvBr9t11Gt4sVtMtzmbAfNpB97SQp/2qgV+Gf2xv8X0C+vnVHsRrf03xZHhy8HgCdNMM9gYK4C8OGxJQtFvvDLbSV6uV2NLlTq6tDnU35jbPsjjPV+M=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pVQbPIWb; arc=fail smtp.client-ip=40.107.101.48; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id C3900208D1;
	Sun, 31 Mar 2024 18:11:12 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pJdHanpBp5yY; Sun, 31 Mar 2024 18:11:12 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 2B84F208CF;
	Sun, 31 Mar 2024 18:11:12 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 2B84F208CF
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 27DD080004E;
	Sun, 31 Mar 2024 18:02:13 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:02:12 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 15:52:49 +0000
X-sender: <kvm+bounces-13132-martin.weber=secunet.com@vger.kernel.org>
X-Receiver: <martin.weber@secunet.com> ORCPT=rfc822;martin.weber@secunet.com
 NOTIFY=NEVER;
 X-ExtendedProps=BQAMAAIAAAUAWAAXAEYAAACbmB8tL5L8S6Dru31tlnMXQ049V2ViZXIgTWFydGluLE9VPVVzZXJzLE9VPU1pZ3JhdGlvbixEQz1zZWN1bmV0LERDPWRlBQBsAAIAAA8ANgAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5EaXNwbGF5TmFtZQ8ADQAAAFdlYmVyLCBNYXJ0aW4FADwAAgAABQAdAA8ADAAAAG1ieC1lc3Nlbi0wMQUADgARAEAJ/dJgSQNPjrUVnMO/4HsFAAsAFwC+AAAAsylSdUnj6k+wvjsUej6W+0NOPURCMixDTj1EYXRhYmFzZXMsQ049RXhjaGFuZ2UgQWRtaW5pc3RyYXRpdmUgR3JvdXAgKEZZRElCT0hGMjNTUERMVCksQ049QWRtaW5pc3RyYXRpdmUgR3JvdXBzLENOPXNlY3VuZXQsQ049TWljcm9zb2Z0IEV4Y2hhbmdlLENOPVNlcnZpY2VzLENOPUNvbmZpZ3VyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAEgAPAF4AAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249V2ViZXIgTWFydGluOTU1BQBHAAIAAAUARgAHAAMAAAAFAEMAAgAABQAWAAIAAAUAagAJAAEAAAAAAAAABQAVABYAAgAAAA8ANQAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRGlyZWN0b3J5RGF0YS5Jc1Jlc291cmNlAgAABQAUABEAm5gfLS+S/Eug67t9bZZzFwUAIwACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9yeTogRmFsc2UNCg8AL
	wAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAmAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: b.mx.secunet.com
X-ExtendedProps: BQBjAAoAbw5rGbMv3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAGAAAAG1hcnRpbi53ZWJlckBzZWN1bmV0LmNvbQUABgACAAEPACoAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LlJlc3VibWl0Q291bnQHAAMAAAAPAAkAAABDSUF1ZGl0ZWQCAAEFAAIABwABAAAABQADAAcAAAAAAAUABQACAAEFAGIACgA8AAAAzYoAAAUAZAAPAAMAAABIdWIFACkAAgABDwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-01
X-SourceIPAddress: 62.96.220.37
X-EndOfInjectedXHeaders: 22969
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=kvm+bounces-13132-martin.weber=secunet.com@vger.kernel.org; receiver=martin.weber@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 b.mx.secunet.com 4C190200BB
Authentication-Results: b.mx.secunet.com;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pVQbPIWb"
X-Original-To: kvm@vger.kernel.org
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.48
ARC-Seal: i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711753565; cv=fail; b=nySl60dntVQyPamC5zHokQ59i8eUA14VcdmUSIxZVrv4o47wSi2elTNxC+0KAI+xBvRR1sZ2v8HUEYX4B2acaXAd+qH0TnIR7Q7+sZsumOQ9ZNju1Fx6OSRxJjn4j0p84rj90JPzlqxNnU9GHhvHZNXZWDRlF+W/GuH+aAiTJug=
ARC-Message-Signature: i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711753565; c=relaxed/simple;
	bh=1mt+dPqGVGgxhVCKEG3pXqMiUa4XApuT0BM0owhsWto=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MiA9QHfN5QPr81nmkTuaS5BtC7vny4OCpm2fNYUYj783qUCLSPRTm9S1SoUx3OCOiP2TV1katS6TRLP7s1Hn+O7vKGjZzdlBAc0uDl496/6oAq8XFpbE1NnIimM/kIBiMn52lb2Ivs1No1ZN9z6NUmFXuH98rYfvzDBSIsRaAAQ=
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pVQbPIWb; arc=fail smtp.client-ip=40.107.101.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=imaqi7zO++Pueh1kiczxyzbdLQbAvufU75qRWyu2zj1Gky5hCoS3w+yInJ0L3dUXfuaFx9DN08KYjvM03AxEFOUF1M700WDoWkkppUeah6369frkyhubt9gmIPSzEJupYZDwODCSA7DU2A/QdTKWtIvajcJYH+UfhcoaOwL8rbBfvy2IZTm7BukJIUrD6yjpky4ro99oL7ugAgDAIYnTLgywKVhVkw3JZA2jDJmw3s1UPHwouImDX6DyfV8MusvmSstKSkVyQDunHM7KEzBPEyneL7ih4zbEvEb1YRSzyQce/Swsfc3YtoduzRQ9kO36itueeu7Kz2yuT97MVHXOXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CFi7FUdlAWZbxIeQZPeXjgozeEMcnuRszCmTYDdmjJw=;
 b=jr3CpJ2B9ia9wR1FHBCqA3R/rAM6kID2KydtbDP63g9WFvHXi453xc7V7PwiJhBUZYCUj89Xzes5WQvlV0sh/cFMXbKXRy3Ym5LJIngzSC3Vqj55baspbaJHUWtMWx1OUZraxO/2tnABuT/ZhXYqfWXp3U/8WNP/DhkXylSlqMqcIGJ1rp2fZI7/9h6kK6I3pO9kIh3sw/VP9XIA4Q9tdF4fcH+MxqkCVJkBSj7eWj6ZKV9UQ8CPArPPbdh1+nqisbzHp5SyIalfBZnmAv2U/QkEVLAntvMg8ecAQE9lvv9LUqwM6UbuPL2wpiGXvA/uDycwDsIEV1wxijg+TN3tMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CFi7FUdlAWZbxIeQZPeXjgozeEMcnuRszCmTYDdmjJw=;
 b=pVQbPIWbese89EZLyabCbuNSndnvJlEBLQ0FbXJsU/BU5bRdWBMXFlEV5gp+Ry0aZm+Qr6tDyl90OpotfnuRujcOYxMvAlkxrHJvJLYBQCU7ctGa6tenr4X0tdWCCVzDbi7ndk8u5ZUER2aAQ944jHEIlPJOWvsMJVItu6bqIwY=
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
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
Subject: [PATCH v12 27/29] crypto: ccp: Add the SNP_VLEK_LOAD command
Date: Fri, 29 Mar 2024 17:58:33 -0500
Message-ID: <20240329225835.400662-28-michael.roth@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240329225835.400662-1-michael.roth@amd.com>
References: <20240329225835.400662-1-michael.roth@amd.com>
Precedence: bulk
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017094:EE_|DS0PR12MB6389:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c5ce47d-5076-4cef-2387-08dc5044cd0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M108XjrRq0MG2qHrQcGm9f5QoZTpFMpGESUVMEAwEi0Jg/7J8Sx0JfHp3iC8H9S89d26XnzK5RVaR+N6ZfBRD7fWFThxq8QMDl68ulJk2Mf74+t6uO5YrRyhRhGmhr4yV/FrtLRjhb0oVT9g6eoMg4qUNl56tP7p0Krb8gQXsV1NVbL38MQrAiRhb3Y3OZ2XOQiASoe36x+FrWtjv17hp2luILOtcD49WV56UuLNfoTkyMu2hja3vxe8rGXeY6Sf8VqdOWqCz2lXkkVeVDW3NsxzZthoO860rK1TI9ukxS7YiyieJ7TFE7mWV02s5//sfWqDQEzl2784/fSh1eGv3Hp9Yt24EmhxIkqfkxCrV1JpR91l5nCDMwm/MxcL9VqtfoZowhaf9TiT2WXqATZoAMuxhmdA2nHqXz/7pIKpcA2ZYz80Cj0NrJ7fxQIiOGV/WYLsdspbT0crbgqWrSC947+aQzX3g192HkGgthx9y0Vt/xC26IOIGJq4DAI5cBLoAfwrUI5I87osChI5eKSPC9yb9tdrG3NBWVv5rihbacgKtUF9N3oe6SpKfBllelkVPDKY9NAZedjB9+W5QTua9kkbKUWCihKwymTqhwX21WuOjeGGRkq0V8uvQu6vITHwXdcMeuhXZn7ECZfLVvq7zLSf2T5+QxW0AocGlILVlcHt9omD7TQJLkhluUkwsSy+zCjBpvKY+PNuAyzevoWp7/aDmFS5H30wB41TKsS3LdL66ZIodV4x0jQ2fT+hIy4G
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2024 23:06:00.7175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c5ce47d-5076-4cef-2387-08dc5044cd0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017094.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6389
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

When requesting an attestation report a guest is able to specify whether
it wants SNP firmware to sign the report using either a Versioned Chip
Endorsement Key (VCEK), which is derived from chip-unique secrets, or a
Versioned Loaded Endorsement Key (VLEK) which is obtained from an AMD
Key Derivation Service (KDS) and derived from seeds allocated to
enrolled cloud service providers (CSPs).

For VLEK keys, an SNP_VLEK_LOAD SNP firmware command is used to load
them into the system after obtaining them from the KDS. Add a
corresponding userspace interface so to allow the loading of VLEK keys
into the system.

See SEV-SNP Firmware ABI 1.54, SNP_VLEK_LOAD for more details.

Signed-off-by: Michael Roth <michael.roth@amd.com>
---
 drivers/crypto/ccp/sev-dev.c | 36 ++++++++++++++++++++++++++++++++++++
 include/uapi/linux/psp-sev.h | 27 +++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 2102377f727b..97a7959406ee 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -2027,6 +2027,39 @@ static int sev_ioctl_do_snp_set_config(struct sev_issue_cmd *argp, bool writable
 	return __sev_do_cmd_locked(SEV_CMD_SNP_CONFIG, &config, &argp->error);
 }
 
+static int sev_ioctl_do_snp_vlek_load(struct sev_issue_cmd *argp, bool writable)
+{
+	struct sev_device *sev = psp_master->sev_data;
+	struct sev_user_data_snp_vlek_load input;
+	void *blob;
+	int ret;
+
+	if (!sev->snp_initialized || !argp->data)
+		return -EINVAL;
+
+	if (!writable)
+		return -EPERM;
+
+	if (copy_from_user(&input, u64_to_user_ptr(argp->data), sizeof(input)))
+		return -EFAULT;
+
+	if (input.len != sizeof(input) || input.vlek_wrapped_version != 0)
+		return -EINVAL;
+
+	blob = psp_copy_user_blob(input.vlek_wrapped_address,
+				  sizeof(struct sev_user_data_snp_wrapped_vlek_hashstick));
+	if (IS_ERR(blob))
+		return PTR_ERR(blob);
+
+	input.vlek_wrapped_address = __psp_pa(blob);
+
+	ret = __sev_do_cmd_locked(SEV_CMD_SNP_VLEK_LOAD, &input, &argp->error);
+
+	kfree(blob);
+
+	return ret;
+}
+
 static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
@@ -2087,6 +2120,9 @@ static long sev_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
 	case SNP_SET_CONFIG:
 		ret = sev_ioctl_do_snp_set_config(&input, writable);
 		break;
+	case SNP_VLEK_LOAD:
+		ret = sev_ioctl_do_snp_vlek_load(&input, writable);
+		break;
 	default:
 		ret = -EINVAL;
 		goto out;
diff --git a/include/uapi/linux/psp-sev.h b/include/uapi/linux/psp-sev.h
index b7a2c2ee35b7..2289b7c76c59 100644
--- a/include/uapi/linux/psp-sev.h
+++ b/include/uapi/linux/psp-sev.h
@@ -31,6 +31,7 @@ enum {
 	SNP_PLATFORM_STATUS,
 	SNP_COMMIT,
 	SNP_SET_CONFIG,
+	SNP_VLEK_LOAD,
 
 	SEV_MAX,
 };
@@ -214,6 +215,32 @@ struct sev_user_data_snp_config {
 	__u8 rsvd1[52];
 } __packed;
 
+/**
+ * struct sev_data_snp_vlek_load - SNP_VLEK_LOAD structure
+ *
+ * @len: length of the command buffer read by the PSP
+ * @vlek_wrapped_version: version of wrapped VLEK hashstick (Must be 0h)
+ * @rsvd: reserved
+ * @vlek_wrapped_address: address of a wrapped VLEK hashstick
+ *                        (struct sev_user_data_snp_wrapped_vlek_hashstick)
+ */
+struct sev_user_data_snp_vlek_load {
+	__u32 len;				/* In */
+	__u8 vlek_wrapped_version;		/* In */
+	__u8 rsvd[3];				/* In */
+	__u64 vlek_wrapped_address;		/* In */
+} __packed;
+
+/**
+ * struct sev_user_data_snp_vlek_wrapped_vlek_hashstick - Wrapped VLEK data
+ *
+ * @data: Opaque data provided by AMD KDS (as described in SEV-SNP Firmware ABI
+ *        1.54, SNP_VLEK_LOAD)
+ */
+struct sev_user_data_snp_wrapped_vlek_hashstick {
+	__u8 data[432];				/* In */
+} __packed;
+
 /**
  * struct sev_issue_cmd - SEV ioctl parameters
  *
-- 
2.25.1



