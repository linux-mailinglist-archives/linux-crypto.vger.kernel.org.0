Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D47143013BE
	for <lists+linux-crypto@lfdr.de>; Sat, 23 Jan 2021 08:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbhAWHad (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 23 Jan 2021 02:30:33 -0500
Received: from mga12.intel.com ([192.55.52.136]:5181 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbhAWHa1 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 23 Jan 2021 02:30:27 -0500
IronPort-SDR: LNvGXDreA2bx0O1SB96cJdPzCrkZM5nlFHABVkeCYwWojiaJobq8DOjt5pLI9CquYx7CdpqLIh
 Be3R4cdMxZjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="158731937"
X-IronPort-AV: E=Sophos;i="5.79,368,1602572400"; 
   d="scan'208";a="158731937"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 23:29:46 -0800
IronPort-SDR: jweNwgZwbiHJEwpumDYufN77NgHYXIBtWVHVmvtsfymjvenUBXGQk8pLFBIZIdvuC2kLKK2f2Z
 XnEvXOjhYXgw==
X-IronPort-AV: E=Sophos;i="5.79,368,1602572400"; 
   d="scan'208";a="468448073"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.154])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-SHA; 22 Jan 2021 23:29:46 -0800
From:   Megha Dey <megha.dey@intel.com>
To:     linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net
Cc:     ravi.v.shankar@intel.com, tim.c.chen@intel.com,
        andi.kleen@intel.com, dave.hansen@intel.com, megha.dey@intel.com,
        greg.b.tucker@intel.com, robert.a.kasten@intel.com,
        rajendrakumar.chinnaiyan@intel.com, tomasz.kantecki@intel.com,
        ryan.d.saffores@intel.com, ilya.albrekht@intel.com,
        kyung.min.park@intel.com, tony.luck@intel.com, ira.weiny@intel.com,
        ebiggers@kernel.org, ardb@kernel.org
Subject: [RFC V2 1/5] crypto: aesni - fix coding style for if/else block
Date:   Fri, 22 Jan 2021 23:28:36 -0800
Message-Id: <1611386920-28579-2-git-send-email-megha.dey@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611386920-28579-1-git-send-email-megha.dey@intel.com>
References: <1611386920-28579-1-git-send-email-megha.dey@intel.com>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The if-else block in aesni_init does not follow required coding
conventions. If other conditionals are added to the block, it
becomes very difficult to parse. Use the correct coding style
instead.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Megha Dey <megha.dey@intel.com>
---
 arch/x86/crypto/aesni-intel_glue.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
index 2144e54..e2aae07 100644
--- a/arch/x86/crypto/aesni-intel_glue.c
+++ b/arch/x86/crypto/aesni-intel_glue.c
@@ -1146,8 +1146,7 @@ static int __init aesni_init(void)
 		pr_info("AVX2 version of gcm_enc/dec engaged.\n");
 		static_branch_enable(&gcm_use_avx);
 		static_branch_enable(&gcm_use_avx2);
-	} else
-	if (boot_cpu_has(X86_FEATURE_AVX)) {
+	} else if (boot_cpu_has(X86_FEATURE_AVX)) {
 		pr_info("AVX version of gcm_enc/dec engaged.\n");
 		static_branch_enable(&gcm_use_avx);
 	} else {
-- 
2.7.4

