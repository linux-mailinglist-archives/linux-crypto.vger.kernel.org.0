Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC71E6DCDCC
	for <lists+linux-crypto@lfdr.de>; Tue, 11 Apr 2023 01:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjDJXLw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 10 Apr 2023 19:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjDJXLm (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 10 Apr 2023 19:11:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E65B82118;
        Mon, 10 Apr 2023 16:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681168301; x=1712704301;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ICOUeWJ4MvP0vL80dft48PfCDjzRn/jTo0cQSkMOY5o=;
  b=BJVqyUW6fr1++i17en4FHgZjoOT7E6mRvVuu4LVkLkX94Ve67nWn5fFk
   ho/OoxJQJliW/t1PSfYw1OKyJ2AnPn9LtQurXhS3yFSXvRDII6WTAzyLy
   PQUWnveojym3rAZcUavXzLJ/wEB/QZBIZZW7wWCgkVoKx1UcuHb6+2hhr
   2u6LMp9RGNOVD/MM5uJ+tvCAL8kET4w9lLJC5z8L/1etyuR6nSM7/uDB9
   0EZrcmIgYpsPPBO6ZtEqZMDADx1rGJU/faaKmsN0yHElBxXmZwC5fTagb
   Mql1WALFP/rlrLXuRfAeX83c8bBc/SnlFJz5a7FsIYKuFH4P9Wfn40E1k
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="340962538"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="340962538"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2023 16:11:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10676"; a="757608002"
X-IronPort-AV: E=Sophos;i="5.98,335,1673942400"; 
   d="scan'208";a="757608002"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga004.fm.intel.com with ESMTP; 10 Apr 2023 16:11:40 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        dm-devel@redhat.com
Cc:     ebiggers@kernel.org, gmazyland@gmail.com, luto@kernel.org,
        dave.hansen@linux.intel.com, tglx@linutronix.de, bp@suse.de,
        mingo@kernel.org, x86@kernel.org, herbert@gondor.apana.org.au,
        ardb@kernel.org, dan.j.williams@intel.com, bernie.keany@intel.com,
        charishma1.gairuboyina@intel.com,
        lalithambika.krishnakumar@intel.com, chang.seok.bae@intel.com,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v6 05/12] x86/msr-index: Add MSRs for Key Locker internal wrapping key
Date:   Mon, 10 Apr 2023 15:59:29 -0700
Message-Id: <20230410225936.8940-6-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230410225936.8940-1-chang.seok.bae@intel.com>
References: <20220112211258.21115-1-chang.seok.bae@intel.com>
 <20230410225936.8940-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The CPU state that contains the internal wrapping key is in the same power
domain as the cache. So any sleep state that would invalidate the cache
(like S3) also invalidates the state of the wrapping key.

But, since the state is inaccessible to software, it needs a special
mechanism to save and restore the key during deep sleep.

A set of new MSRs are provided as an abstract interface to save and restore
the wrapping key, and to check the key status.

The wrapping key is saved in a platform-scoped state of non-volatile media.
The backup itself and its path from the CPU are encrypted and integrity
protected.

But this storage's non-volatility is not architecturally guaranteed across
off states, such as S5 and G3.

The MSRs will be used to back up the key for S3/4 sleep states. Then the
kernel code writes one of them to restore the key in each CPU state.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from RFC v2:
* Update the changelog. (Dan Williams)
* Rename the MSRs. (Dan Williams)
---
 arch/x86/include/asm/msr-index.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index ad35355ee43e..4fa3b9e26162 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -1115,4 +1115,10 @@
 						* a #GP
 						*/
 
+/* MSRs for managing an internal wrapping key for Key Locker. */
+#define MSR_IA32_IWKEY_COPY_STATUS		0x00000990
+#define MSR_IA32_IWKEY_BACKUP_STATUS		0x00000991
+#define MSR_IA32_BACKUP_IWKEY_TO_PLATFORM	0x00000d91
+#define MSR_IA32_COPY_IWKEY_TO_LOCAL		0x00000d92
+
 #endif /* _ASM_X86_MSR_INDEX_H */
-- 
2.17.1

