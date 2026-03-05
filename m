Return-Path: <linux-crypto+bounces-21606-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC+/OvtGqWm33gAAu9opvQ
	(envelope-from <linux-crypto+bounces-21606-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 05 Mar 2026 10:03:55 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F7820DE52
	for <lists+linux-crypto@lfdr.de>; Thu, 05 Mar 2026 10:03:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DB765308AFD5
	for <lists+linux-crypto@lfdr.de>; Thu,  5 Mar 2026 09:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07CC6347FC3;
	Thu,  5 Mar 2026 09:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aAUoXojo"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9854B374E79
	for <linux-crypto@vger.kernel.org>; Thu,  5 Mar 2026 08:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772701200; cv=none; b=Nigj8IVvwvBti7zJzYMVZZ+iIJfnkkRwUux7vIR4Z3P2NW52N5PwklrKECSqsMgadkbGMKjx/qyUGo/bpSMXrzsrXX072+d77dGLQ25ZLk7J3U8YXL3UicbwUmTOlJsHweNPwJDC2mZD2cx67C8bOaCdv9RG0NMLwFFQWjKhs+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772701200; c=relaxed/simple;
	bh=9yPYQL3GC7mRDXtbCVK7k1nlpAKbMlQjj+u9pqKys9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B1ghxrWC0eNwGH8v6YYYbQeptottG4iAx6nMmyEwWi4fFlH+IV4UsPIgglV9642KTPArr38+S+uV+q87teowFk//fT5fjDV6EOkxQWj7mmHMJeMa6SNnyX5i5jntjMEMFPdvbymYz44WDTMHSFzfCRVkD3wSzb7fQs8K0PYC0fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aAUoXojo; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772701200; x=1804237200;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9yPYQL3GC7mRDXtbCVK7k1nlpAKbMlQjj+u9pqKys9E=;
  b=aAUoXojoQ603F7bqVBlo7CHgFgP7IY7zFz5KisC/n7v4MHzkTTdldr3o
   lT3KQl3+BsyL+iIxUD89/YLBgt55V9Z3QVRZviMItRfXINRgxj2i3m5oB
   5r1EbosVKPackeuDemxdlPEmspOk21igEv+ieOT7m8KhLOnCE1oAZOXiI
   +RQLXc8CyzmemgY9fbfdzYsceLRgeBht+G9eks3Ug4XCA/5nixoM5mAoO
   RMCTv9oWDZExgqftm8cQTWhVqCIKLqeOOZ7bi6GtUVF7q2rljGp/f8A8P
   LAgZl7MxfOQzyXi74JiQMG4C/frAR+P4elq6ABPIY7eOguXqPI/1SECiq
   w==;
X-CSE-ConnectionGUID: aRWP1ZDVT3W3qrvqeIjk2g==
X-CSE-MsgGUID: XZP6CTlpSFim/MMYTuJd4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="61354508"
X-IronPort-AV: E=Sophos;i="6.23,325,1770624000"; 
   d="scan'208";a="61354508"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2026 00:59:59 -0800
X-CSE-ConnectionGUID: Duy5BrXzTQqdrPC9B5aY5g==
X-CSE-MsgGUID: wbnK1OzzRxSj32dG+zhTDw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,325,1770624000"; 
   d="scan'208";a="215451029"
Received: from dmr-bkc.iind.intel.com ([10.49.14.189])
  by fmviesa006.fm.intel.com with ESMTP; 05 Mar 2026 00:59:58 -0800
From: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	qat-linux@intel.com
Subject: [PATCH 1/2] crypto: qat - fix indentation of macros in qat_hal.c
Date: Thu,  5 Mar 2026 08:58:58 +0000
Message-ID: <20260305085955.66293-2-suman.kumar.chakraborty@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260305085955.66293-1-suman.kumar.chakraborty@intel.com>
References: <20260305085955.66293-1-suman.kumar.chakraborty@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E9F7820DE52
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21606-lists,linux-crypto=lfdr.de];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suman.kumar.chakraborty@intel.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,intel.com:email,intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

The macros in qat_hal.c were using a mixture of tabs and spaces.
Update all macro indentation to use tabs consistently, matching the
predominant style.

This does not introduce any functional change.

Signed-off-by: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
---
 drivers/crypto/intel/qat/qat_common/qat_hal.c | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/qat_hal.c b/drivers/crypto/intel/qat/qat_common/qat_hal.c
index 7a6ba6f22e3e..0f5a2690690a 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_hal.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_hal.c
@@ -9,17 +9,17 @@
 #include "icp_qat_hal.h"
 #include "icp_qat_uclo.h"
 
-#define BAD_REGADDR	       0xffff
-#define MAX_RETRY_TIMES	   10000
-#define INIT_CTX_ARB_VALUE	0x0
-#define INIT_CTX_ENABLE_VALUE     0x0
-#define INIT_PC_VALUE	     0x0
-#define INIT_WAKEUP_EVENTS_VALUE  0x1
-#define INIT_SIG_EVENTS_VALUE     0x1
-#define INIT_CCENABLE_VALUE       0x2000
-#define RST_CSR_QAT_LSB	   20
-#define RST_CSR_AE_LSB		  0
-#define MC_TIMESTAMP_ENABLE       (0x1 << 7)
+#define BAD_REGADDR			0xffff
+#define MAX_RETRY_TIMES			10000
+#define INIT_CTX_ARB_VALUE		0x0
+#define INIT_CTX_ENABLE_VALUE		0x0
+#define INIT_PC_VALUE			0x0
+#define INIT_WAKEUP_EVENTS_VALUE	0x1
+#define INIT_SIG_EVENTS_VALUE		0x1
+#define INIT_CCENABLE_VALUE		0x2000
+#define RST_CSR_QAT_LSB			20
+#define RST_CSR_AE_LSB			0
+#define MC_TIMESTAMP_ENABLE		(0x1 << 7)
 
 #define IGNORE_W1C_MASK ((~(1 << CE_BREAKPOINT_BITPOS)) & \
 	(~(1 << CE_CNTL_STORE_PARITY_ERROR_BITPOS)) & \
-- 
2.52.0


