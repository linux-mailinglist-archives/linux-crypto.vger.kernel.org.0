Return-Path: <linux-crypto+bounces-20376-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNlTIDWRdWkcGQEAu9opvQ
	(envelope-from <linux-crypto+bounces-20376-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 25 Jan 2026 04:42:45 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFD87FAD1
	for <lists+linux-crypto@lfdr.de>; Sun, 25 Jan 2026 04:42:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 99299309D616
	for <lists+linux-crypto@lfdr.de>; Sun, 25 Jan 2026 03:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835CC23D7C7;
	Sun, 25 Jan 2026 03:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="imjyim9m"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A5E1F75A6;
	Sun, 25 Jan 2026 03:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769312174; cv=none; b=kuYnbT4ev+h8LwuFpkVCY9PWvHnwcdWuU7BOXUVCbdqSlDpsHWl+3LyszQvwkuS6cDt8FoX3F8jpHoo0Ph7XIoeJ99XGdths3hgK6hyt7hiVIBKAh5b86O6oltbkcJNOKuB6nS03vPKjW1i0DACBxFpywYz5NzkpFBoDSdSNSrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769312174; c=relaxed/simple;
	bh=BTzto9LJZ4dLalRZ5djoz1jmTvw0aNZ/Qf035G+8x48=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lg+Cg8R50yhvpyj5TqNGHeYLIYOM0n1OdiInQDgXlQBNzifMorZqSOt7OuLC0+oT9KbGQaTfA9F19gU4t6ZrhMIJI3476pRJBZYf9NY9FjxLiQmcd/oSw69kL7KBkQe9XONI8eHmKdloZ8URAhzxU/KY0UdVwWgcVX2JDmWqYyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=imjyim9m; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769312172; x=1800848172;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BTzto9LJZ4dLalRZ5djoz1jmTvw0aNZ/Qf035G+8x48=;
  b=imjyim9mv//8z4MWJIbiVM+Vhf6G/ckGuihs+CAcPhToZpopBjuXFsbi
   SbNGWGrBfBXWjDQzR/jgH2HwyG6EAmIpdxDKgTpMQpztrU1gnDgJGNwg+
   YOUVNs/dVM0Bqv2hUwApe1+2JaFmVEd8bnn9zSf7LoKp1OIBZXTV/Puoe
   NS1GFdbHWXRo9LG+0n6okVgkeTnzFKYZr6mICS1f6yT9ggNGW/Any4fkY
   DaxUmaNcQfNVcI9Wo/BjWWvs3nzM40OH5/2gpNMHB+u8Qi5CH3RfGbIVK
   f1iE30ThdPjqkW5TAxQFSMXgD0YxuJv/Is+Ph+c8m9JrOo+W54sghsYHu
   w==;
X-CSE-ConnectionGUID: CSYlkDMqRvWT4D3fzuAFSg==
X-CSE-MsgGUID: 273H3JUmQYK8MbF4zy78bA==
X-IronPort-AV: E=McAfee;i="6800,10657,11681"; a="81887603"
X-IronPort-AV: E=Sophos;i="6.21,252,1763452800"; 
   d="scan'208";a="81887603"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2026 19:36:08 -0800
X-CSE-ConnectionGUID: asSjYB5sRwCnHWdNtxnXag==
X-CSE-MsgGUID: KwOt10VzRiyXQir+QElPeQ==
X-ExtLoop1: 1
Received: from jf5300-b11a338t.jf.intel.com ([10.242.51.115])
  by fmviesa003.fm.intel.com with ESMTP; 24 Jan 2026 19:36:06 -0800
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
Subject: [PATCH v14 20/26] crypto: iaa - Disable iaa_verify_compress by default.
Date: Sat, 24 Jan 2026 19:35:31 -0800
Message-Id: <20260125033537.334628-21-kanchana.p.sridhar@intel.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20376-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[vger.kernel.org,kvack.org,cmpxchg.org,linux.dev,gmail.com,arm.com,linux.alibaba.com,linux-foundation.org,chromium.org,kernel.org,tencent.com,gondor.apana.org.au,davemloft.net,baylibre.com,google.com,intel.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[kanchana.p.sridhar@intel.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[26];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,intel.com:dkim,intel.com:mid]
X-Rspamd-Queue-Id: 1FFD87FAD1
X-Rspamd-Action: no action

This patch makes it easier for IAA hardware acceleration in the iaa_crypto
driver to be loaded by default with "iaa_verify_compress" disabled, to
facilitate performance comparisons with software compressors (which also
do not run compress verification by default). Earlier, iaa_crypto compress
verification used to be enabled by default.

The iaa_crypto driver documentation has been updated with this change.

With this patch, if users want to enable compress verification, they can do
so with these steps:

  1) disable all the IAA device/wq bindings that happen at boot time
  2) rmmod iaa_crypto
  3) modprobe iaa_crypto
  4) echo 1 > /sys/bus/dsa/drivers/crypto/verify_compress
  5) re-run initialization of the IAA devices and wqs

Signed-off-by: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>
---
 Documentation/driver-api/crypto/iaa/iaa-crypto.rst | 2 +-
 drivers/crypto/intel/iaa/iaa_crypto_main.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/crypto/iaa/iaa-crypto.rst b/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
index d5e610ef4612..81a7dbd15f8b 100644
--- a/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
+++ b/Documentation/driver-api/crypto/iaa/iaa-crypto.rst
@@ -239,7 +239,7 @@ The available attributes are:
 
       echo 0 > /sys/bus/dsa/drivers/crypto/verify_compress
 
-    The default setting is '1' - verify all compresses.
+    The default setting is '0' - to not verify compresses.
 
   - sync_mode
 
diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index f6e18f458fbf..7bc4a80bd68b 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -121,7 +121,7 @@ static bool iaa_distribute_decomps;
 static bool iaa_distribute_comps = true;
 
 /* Verify results of IAA compress or not */
-static bool iaa_verify_compress = true;
+static bool iaa_verify_compress;
 
 /*
  * The iaa crypto driver supports three 'sync' methods determining how
-- 
2.27.0


