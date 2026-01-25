Return-Path: <linux-crypto+bounces-20377-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mGEGMjmQdWkcGQEAu9opvQ
	(envelope-from <linux-crypto+bounces-20377-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 25 Jan 2026 04:38:33 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 796E37FA17
	for <lists+linux-crypto@lfdr.de>; Sun, 25 Jan 2026 04:38:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 50E6B30141BD
	for <lists+linux-crypto@lfdr.de>; Sun, 25 Jan 2026 03:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B036D23E340;
	Sun, 25 Jan 2026 03:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OF9tUF/f"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658B4233721;
	Sun, 25 Jan 2026 03:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769312174; cv=none; b=H3EYxxN3b/7OEOxN623AW7XX1YaDbEjv7NfOPNkmzOL9fDqj8ZYukTOvCLMCqY17gkybdDewnBAs56YDbW0CN72eYLvsOQQUWCjB4kjt0YCLsTwVLfhV0KeTHJa2mMdrxORdJQiV953+qd5Dj9k31JAe3zedRHEZeM/gpTdx+CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769312174; c=relaxed/simple;
	bh=q1mVf0QKYvPJ+4NSUc+0SqCKPiVImrf5Dhf0M/kxVrY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=A1F61mgKAiLuA5aHOXv7yrujn1KtVQp5++l5puW/28ezXnuWwgPWw9OHUfUnjL5OlsLpSwFoa5GWPQobJR7O5YCTaOD+6ZvqW4bpPQiv3U/UBO0qltZ8OryixprIjmQUUSlXPYFx+7tLz+O88BVGn273gwHyS0k1H1Ge+ZDucow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OF9tUF/f; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769312171; x=1800848171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q1mVf0QKYvPJ+4NSUc+0SqCKPiVImrf5Dhf0M/kxVrY=;
  b=OF9tUF/fV2deo3aWMzPrN+49388Apg20IDlI4x+8UTtp64WJMHzP07eP
   kYtO2qQTBqRMe2MPv7AX4KxpYoum2CzRIK9fbPq1GrvKNZ0BgRakIFF7t
   dmQhoxz9b7lQ+Tp+Ol79o3pda85UVZYPn4yi+RY/I0lWq6S37n0z5QEba
   JIn3gxb0yb0BN8IH6eAIQBneUUc0BautOXrACII+SBu6syJDgq6tTLyyr
   7QlQwTKzPXTUDYsdJJdE04DWnWBi+qLFQAuZ3r1twBSH5OAOMouY9kP8K
   rqcnsVufYkumiXMh+ZwGp3uvh8b0SAD4h5gAt3N+NdTeaf856gKMwuDwu
   Q==;
X-CSE-ConnectionGUID: qBc2TNEHRu2LFfwj54V1GQ==
X-CSE-MsgGUID: 7rjT7Jq7RfODPeQKOFTOGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11681"; a="81887588"
X-IronPort-AV: E=Sophos;i="6.21,252,1763452800"; 
   d="scan'208";a="81887588"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2026 19:36:06 -0800
X-CSE-ConnectionGUID: 5/eD9vAJTqqE4jtBlE15YQ==
X-CSE-MsgGUID: COri05SvQWSM2HYSqWh0YQ==
X-ExtLoop1: 1
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.115])
  by fmviesa003.fm.intel.com with ESMTP; 24 Jan 2026 19:36:05 -0800
From: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
To: linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	hannes@cmpxchg.org,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	usamaarif642@gmail.com,
	ryan.roberts@arm.com,
	21cnbao@gmail.com,
	ying.huang@linux.alibaba.com,
	akpm@linux-foundation.org,
	senozhatsky@chromium.org,
	sj@kernel.org,
	kasong@tencent.com,
	linux-crypto@vger.kernel.org,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	clabbe@baylibre.com,
	ardb@kernel.org,
	ebiggers@google.com,
	surenb@google.com,
	kristen.c.accardi@intel.com,
	vinicius.gomes@intel.com,
	giovanni.cabiddu@intel.com
Cc: wajdi.k.feghali@intel.com,
	kanchana.p.sridhar@intel.com
Subject: [PATCH v14 19/26] crypto: iaa - Enable async mode and make it the default.
Date: Sat, 24 Jan 2026 19:35:30 -0800
Message-Id: <20260125033537.334628-20-kanchana.p.sridhar@intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20260125033537.334628-1-kanchana.p.sridhar@intel.com>
References: <20260125033537.334628-1-kanchana.p.sridhar@intel.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20377-lists,linux-crypto=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,gmail.com,arm.com,linux.alibaba.com,linux-foundation.org,chromium.org,kernel.org,tencent.com,gondor.apana.org.au,davemloft.net,baylibre.com,google.com,intel.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kanchana.p.sridhar@intel.com,linux-crypto@vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-crypto];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:dkim,intel.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 796E37FA17
X-Rspamd-Action: no action

This patch enables the 'async' sync_mode in the driver. Further, it sets
the default sync_mode to 'async', which makes it easier for IAA hardware
acceleration in the iaa_crypto driver to be loaded by default in the most
efficient/recommended 'async' mode for parallel
compressions/decompressions, namely, asynchronous submission of
descriptors, followed by polling for job completions. Earlier, the
"sync" mode used to be the default.

The iaa_crypto driver documentation has been updated with these
changes.

This way, anyone who wants to use IAA as a zswap compressor, can do so
right after building the kernel. Specifically, they *do not* have to go
through these steps to use async mode:

  1) disable all the IAA device/wq bindings that happen at boot time
  2) rmmod iaa_crypto
  3) modprobe iaa_crypto
  4) echo async > /sys/bus/dsa/drivers/crypto/sync_mode
  5) re-run initialization of the IAA devices and wqs

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 Documentation/driver-api/crypto/iaa/iaa-crypto.rst | 11 ++---------
 drivers/crypto/intel/iaa/iaa_crypto_main.c         |  4 ++--
 2 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/Documentation/driver-api/crypto/iaa/iaa-crypto.rst b/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
index 0ff4ec603b43..d5e610ef4612 100644
--- a/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
+++ b/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
@@ -272,7 +272,7 @@ The available attributes are:
       echo async_irq > /sys/bus/dsa/drivers/crypto/sync_mode
 
     Async mode without interrupts (caller must poll) can be enabled by
-    writing 'async' to it (please see Caveat)::
+    writing 'async' to it::
 
       echo async > /sys/bus/dsa/drivers/crypto/sync_mode
 
@@ -281,14 +281,7 @@ The available attributes are:
 
       echo sync > /sys/bus/dsa/drivers/crypto/sync_mode
 
-    The default mode is 'sync'.
-
-    Caveat: since the only mechanism that iaa_crypto currently implements
-    for async polling without interrupts is via the 'sync' mode as
-    described earlier, writing 'async' to
-    '/sys/bus/dsa/drivers/crypto/sync_mode' will internally enable the
-    'sync' mode. This is to ensure correct iaa_crypto behavior until true
-    async polling without interrupts is enabled in iaa_crypto.
+    The default mode is 'async'.
 
   - g_comp_wqs_per_iaa
 
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 915bf9b17b39..f6e18f458fbf 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -153,7 +153,7 @@ static bool iaa_verify_compress = true;
  */
 
 /* Use async mode */
-static bool async_mode;
+static bool async_mode = true;
 /* Use interrupts */
 static bool use_irq;
 
@@ -207,7 +207,7 @@ static int set_iaa_sync_mode(const char *name)
 		async_mode = false;
 		use_irq = false;
 	} else if (sysfs_streq(name, "async")) {
-		async_mode = false;
+		async_mode = true;
 		use_irq = false;
 	} else if (sysfs_streq(name, "async_irq")) {
 		async_mode = true;
-- 
2.27.0


