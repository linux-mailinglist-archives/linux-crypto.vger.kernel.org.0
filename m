Return-Path: <linux-crypto+bounces-20367-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJESAcqQdWkcGQEAu9opvQ
	(envelope-from <linux-crypto+bounces-20367-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 25 Jan 2026 04:40:58 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 512187FA9A
	for <lists+linux-crypto@lfdr.de>; Sun, 25 Jan 2026 04:40:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58DCF306B786
	for <lists+linux-crypto@lfdr.de>; Sun, 25 Jan 2026 03:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7963821C9FD;
	Sun, 25 Jan 2026 03:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gKgB/SNT"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C580219A89;
	Sun, 25 Jan 2026 03:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769312156; cv=none; b=BuBS/zyzMn/Tg96mhehpgN8fVdNjdzChYTnjoGG9WwMyXn1gmtWpRG8x5QUnD9fpUkpuTz3biCZ/yu0o3cqqq5uqc3TbnpUSESGaIh8aPFPIxi8RjYct9MCt9k2pOUq+yiFV13camLelzMPd7+hPLSOwbzNDDWQwdkDZLZ6e6t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769312156; c=relaxed/simple;
	bh=XyBt7r+Eb/CYW6xzj2tc3tA7d69o/dOC+UBy7xbkrX8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Y9VqkFp9yc2lWPJhCp2UzQEA/8b02X3bU9BL3Pii/SQR2aAev1xYox1sKteAfvms5hw3BrI83OAmX0FOC7eaZhvAaOtWAedn18lYgcvKti8/Jg02W1/9LWWFC2Mjh0gBloynbtQV8nQmPbjhnngW94PIBilcIj1E9gdsNCrdGdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gKgB/SNT; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769312154; x=1800848154;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XyBt7r+Eb/CYW6xzj2tc3tA7d69o/dOC+UBy7xbkrX8=;
  b=gKgB/SNTNQ0U4cL2ODGQiGAqoCdhZdmb6wUzxJNyrPWJmilh+wJSTTf3
   pgmziMhSZQov1y48hpp+Xp7mpnvWwbbmVVoqCYzYAfuZq7xXxegeuDkxC
   BIJGPI5rztAKhub4llJXTXOZKSfHPdkc0gfl8o8TWcZiALLH4LQQNK4NN
   VseMv0qrPzjL5qGOjFwusKKYQisdSZ3G6fWkkjwFSNQqCrdx9yNd841BP
   EgdUqIMwUb5ju+d67qR+gbvATDLcHM3k6UIeaec6KWqOV57+r17+S1JVc
   6tG4KRIc7damV9vqIR2+ltg7D49IobSEK5uu2HA0c7E2S67/hVnN+q6X7
   Q==;
X-CSE-ConnectionGUID: lHzwZ6ghRvmgMbR2SLT49A==
X-CSE-MsgGUID: e/kKCjAlQUupobiw4OK7pg==
X-IronPort-AV: E=McAfee;i="6800,10657,11681"; a="81887449"
X-IronPort-AV: E=Sophos;i="6.21,252,1763452800"; 
   d="scan'208";a="81887449"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2026 19:35:53 -0800
X-CSE-ConnectionGUID: 8ztUVJHXT8GZ08qRPJ5kqg==
X-CSE-MsgGUID: t76tzkzVRW2oXqaAnEWu3A==
X-ExtLoop1: 1
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.115])
  by fmviesa003.fm.intel.com with ESMTP; 24 Jan 2026 19:35:52 -0800
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
Subject: [PATCH v14 10/26] crypto: iaa - Deprecate exporting add/remove IAA compression modes.
Date: Sat, 24 Jan 2026 19:35:21 -0800
Message-Id: <20260125033537.334628-11-kanchana.p.sridhar@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20367-lists,linux-crypto=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 512187FA9A
X-Rspamd-Action: no action

There is no use case right now for kernel users to dynamically
add/remove IAA compression modes; hence this commit deletes the symbol
exports of add_iaa_compression_mode() and remove_iaa_compression_mode().

The only supported usage model of IAA compression modes is for the code
to be statically linked during the iaa_crypto module build,
e.g. iaa_crypto_comp_fixed.c, and for available modes to be registered
when the first IAA device wq is probed.

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 4b275cc09404..1b44c0524692 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -368,10 +368,6 @@ static void free_iaa_compression_mode(struct iaa_compression_mode *mode)
  * These tables are typically generated and captured using statistics
  * collected from running actual compress/decompress workloads.
  *
- * A module or other kernel code can add and remove compression modes
- * with a given name using the exported @add_iaa_compression_mode()
- * and @remove_iaa_compression_mode functions.
- *
  * When a new compression mode is added, the tables are saved in a
  * global compression mode list.  When IAA devices are added, a
  * per-IAA device dma mapping is created for each IAA device, for each
@@ -405,7 +401,6 @@ void remove_iaa_compression_mode(const char *name)
 out:
 	mutex_unlock(&iaa_devices_lock);
 }
-EXPORT_SYMBOL_GPL(remove_iaa_compression_mode);
 
 /**
  * add_iaa_compression_mode - Add an IAA compression mode
@@ -482,7 +477,6 @@ int add_iaa_compression_mode(const char *name,
 	free_iaa_compression_mode(mode);
 	goto out;
 }
-EXPORT_SYMBOL_GPL(add_iaa_compression_mode);
 
 static void free_device_compression_mode(struct iaa_device *iaa_device,
 					 struct iaa_device_compression_mode *device_mode)
-- 
2.27.0


