Return-Path: <linux-crypto+bounces-1543-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76326838587
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Jan 2024 03:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E32E28E4C0
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Jan 2024 02:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDCD4F60B;
	Tue, 23 Jan 2024 02:29:12 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mx1.zhaoxin.com (MX1.ZHAOXIN.COM [210.0.225.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37BB4EB24
	for <linux-crypto@vger.kernel.org>; Tue, 23 Jan 2024 02:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.0.225.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705976952; cv=none; b=TE/fvjjhgK4JqQU5ACEwPHRNUwl8bdiPtk2gnzw/DjThLikP2abB8epH/9FVlH3Cw3gkatTuX9gc7AEjK2d0dmDpk+ygdeI6FIllblArpj83y2PD1Z5eQCUQkjOoAa0/aZEI3T1RerNUMI5Bz+fQF9GXaJhBUM3mzFVtR3lxuyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705976952; c=relaxed/simple;
	bh=BNwz8nogyl4n1yMnhodPp9Q+F0gYYUhsajY5U+RhqWE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J1dDoDmwHNxRsFNYRQ8prOZoOc57Ceoxsao+UQEDJKWGFG7VjIEDxtyCrBPqSRmM7MK0kD6VCUB5MaNrVD2VzO6Bae2SYEz13sTd4NAYqY4vQFCizLG23PfOVcllPJ5g6Sp1TouiiaNeuzBbzktAWxyxSXk4rY8M0whRoVRw6Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=210.0.225.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1705976939-086e230f26288d0001-Xm9f1P
Received: from ZXSHMBX2.zhaoxin.com (ZXSHMBX2.zhaoxin.com [10.28.252.164]) by mx1.zhaoxin.com with ESMTP id cdEzdbBKdWckdm3l (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Tue, 23 Jan 2024 10:28:59 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
Received: from zxbjmbx1.zhaoxin.com (10.29.252.163) by ZXSHMBX2.zhaoxin.com
 (10.28.252.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 23 Jan
 2024 10:28:58 +0800
Received: from localhost.localdomain (10.32.65.162) by zxbjmbx1.zhaoxin.com
 (10.29.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 23 Jan
 2024 10:28:56 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.164
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.29.252.163
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
	<seanjc@google.com>, <kim.phillips@amd.com>,
	<kirill.shutemov@linux.intel.com>, <jmattson@google.com>,
	<babu.moger@amd.com>, <kai.huang@intel.com>, <TonyWWang-oc@zhaoxin.com>,
	<acme@redhat.com>, <aik@amd.com>, <namhyung@kernel.org>
CC: <CobeChen@zhaoxin.com>, <TimGuo@zhaoxin.com>, <LeoLiu-oc@zhaoxin.com>,
	<GeorgeXue@zhaoxin.com>
Subject: [PATCH v2 2/3] x86/cpufeatures: Add CPU feature flags for Zhaoxin Hash Engine
Date: Tue, 23 Jan 2024 10:28:51 +0800
X-ASG-Orig-Subj: [PATCH v2 2/3] x86/cpufeatures: Add CPU feature flags for Zhaoxin Hash Engine
Message-ID: <20240123022852.2475-3-TonyWWang-oc@zhaoxin.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240123022852.2475-1-TonyWWang-oc@zhaoxin.com>
References: <20240123022852.2475-1-TonyWWang-oc@zhaoxin.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx1.zhaoxin.com (10.29.252.163)
X-Barracuda-Connect: ZXSHMBX2.zhaoxin.com[10.28.252.164]
X-Barracuda-Start-Time: 1705976939
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.35:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 2994
X-Barracuda-BRTS-Status: 0
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.119808
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------

Zhaoxin CPUs have implemented the SHA(Secure Hash Algorithm) as its
instrucions.
Add two CPU feature flags indicated by CPUID.(EAX=C0000001,ECX=0):EDX
bit 25/26 which will be used by Zhaoxin SHA driver.

Signed-off-by: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
---
 arch/x86/include/asm/cpufeatures.h       | 4 +++-
 tools/arch/x86/include/asm/cpufeatures.h | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 29cb275a219d..28b0e62dbdf5 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -145,7 +145,7 @@
 #define X86_FEATURE_RDRAND		( 4*32+30) /* RDRAND instruction */
 #define X86_FEATURE_HYPERVISOR		( 4*32+31) /* Running on a hypervisor */
 
-/* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word 5 */
+/* VIA/Cyrix/Centaur/Zhaoxin-defined CPU features, CPUID level 0xC0000001, word 5 */
 #define X86_FEATURE_XSTORE		( 5*32+ 2) /* "rng" RNG present (xstore) */
 #define X86_FEATURE_XSTORE_EN		( 5*32+ 3) /* "rng_en" RNG enabled */
 #define X86_FEATURE_XCRYPT		( 5*32+ 6) /* "ace" on-CPU crypto (xcrypt) */
@@ -156,6 +156,8 @@
 #define X86_FEATURE_PHE_EN		( 5*32+11) /* PHE enabled */
 #define X86_FEATURE_PMM			( 5*32+12) /* PadLock Montgomery Multiplier */
 #define X86_FEATURE_PMM_EN		( 5*32+13) /* PMM enabled */
+#define X86_FEATURE_PHE2		( 5*32+25) /* "phe2" Zhaoxin Hash Engine */
+#define X86_FEATURE_PHE2_EN		( 5*32+26) /* "phe2_en" PHE2 enabled */
 
 /* More extended AMD flags: CPUID level 0x80000001, ECX, word 6 */
 #define X86_FEATURE_LAHF_LM		( 6*32+ 0) /* LAHF/SAHF in long mode */
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index f4542d2718f4..21caba9d070b 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -145,7 +145,7 @@
 #define X86_FEATURE_RDRAND		( 4*32+30) /* RDRAND instruction */
 #define X86_FEATURE_HYPERVISOR		( 4*32+31) /* Running on a hypervisor */
 
-/* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word 5 */
+/* VIA/Cyrix/Centaur/Zhaoxin-defined CPU features, CPUID level 0xC0000001, word 5 */
 #define X86_FEATURE_XSTORE		( 5*32+ 2) /* "rng" RNG present (xstore) */
 #define X86_FEATURE_XSTORE_EN		( 5*32+ 3) /* "rng_en" RNG enabled */
 #define X86_FEATURE_XCRYPT		( 5*32+ 6) /* "ace" on-CPU crypto (xcrypt) */
@@ -156,6 +156,8 @@
 #define X86_FEATURE_PHE_EN		( 5*32+11) /* PHE enabled */
 #define X86_FEATURE_PMM			( 5*32+12) /* PadLock Montgomery Multiplier */
 #define X86_FEATURE_PMM_EN		( 5*32+13) /* PMM enabled */
+#define X86_FEATURE_PHE2		( 5*32+25) /* "phe2" Zhaoxin Hash Engine */
+#define X86_FEATURE_PHE2_EN		( 5*32+26) /* "phe2_en" PHE2 enabled */
 
 /* More extended AMD flags: CPUID level 0x80000001, ECX, word 6 */
 #define X86_FEATURE_LAHF_LM		( 6*32+ 0) /* LAHF/SAHF in long mode */
-- 
2.25.1


