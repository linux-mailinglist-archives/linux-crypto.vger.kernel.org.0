Return-Path: <linux-crypto+bounces-24962-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id txeiG8XjJmremQIAu9opvQ
	(envelope-from <linux-crypto+bounces-24962-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 08 Jun 2026 17:46:13 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E233E65845B
	for <lists+linux-crypto@lfdr.de>; Mon, 08 Jun 2026 17:46:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=intel.com header.s=Intel header.b=HKnpPhCe;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24962-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24962-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=intel.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4500C33FEABA
	for <lists+linux-crypto@lfdr.de>; Mon,  8 Jun 2026 15:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97F9A4192E1;
	Mon,  8 Jun 2026 15:04:53 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201D2425CC4
	for <linux-crypto@vger.kernel.org>; Mon,  8 Jun 2026 15:04:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780931093; cv=none; b=Aejpp0d6jj4Uhz1agRq64lEx70m7wy6S8CfwfLyasp5QQr6jKdWtGb+d1RnjWcHsYkMFlDILYFNOdhWScy9MV0BUMvZJ2rK029Dsej2Sd1NZzwmuR3zECjEaFcCok6tcDFMUjJIKQSPi4t4tTDLq2zFctxJ4o1fDGEDeMwaMPkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780931093; c=relaxed/simple;
	bh=LkP4EAY2VlweKldvR5b9AXxrurMPRlrJm3hv4Xtyrrs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=o98z3EwP3G6NKLR8Y+Yznp4Awe0UUUeD4YBLXPUbZP+g57mCh/WLjpE9XrX9v9IOn5QqF+YR1SOK75LFlxglrQwJGME1z//ce1j/wVK69llcnDtyu0r/DisJcsqKHAznKHMteSOdwmFfrHDPVQzfZK/NrXZ2k2e4j+6EU9yQFOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HKnpPhCe; arc=none smtp.client-ip=192.198.163.10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780931092; x=1812467092;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LkP4EAY2VlweKldvR5b9AXxrurMPRlrJm3hv4Xtyrrs=;
  b=HKnpPhCemI16mTMOuWJrfaNlOC6Z9lvpBgqcogWv2MJqm4CbGgKAGpSL
   LJLC+sA33QUgh8+ixPKfnCd48npb47PXGtAtVjoTYYY6peRlLR2YpXn58
   1Bok1f/lIvm7sifh8tn0jC5AmOh4HvcaqKOuOcXFLhz+sxe2vUBRNV94h
   /wSYI3cPuiGWoK8haZ0KIiLM6Mb7u2GQMr8EFOqf1mONYWZ52aUj5dZHT
   GhsJ7SmCnmmy2Wv0yhDWEUsNJceddhpkjaauEVtyXHY01iFYLrwi5RXqb
   Za9LvVpO8VgKgEiJ+35txwBJUPpLP8zNgimbYJY8ODVF0x21fcXWt3A2B
   A==;
X-CSE-ConnectionGUID: 2OBcU/sKRk6UoXpdu4KbnQ==
X-CSE-MsgGUID: x/Z24fafSEWa3VOxjNuxKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="93057220"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="93057220"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2026 08:04:51 -0700
X-CSE-ConnectionGUID: 5cR6uXzeRpqetyPLMl72cw==
X-CSE-MsgGUID: UjVtFJb3QOyZXo4IdoWk6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; 
   d="scan'208";a="275782617"
Received: from silpixa00401971.ir.intel.com ([10.20.226.106])
  by orviesa002.jf.intel.com with ESMTP; 08 Jun 2026 08:04:50 -0700
From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	qat-linux@intel.com,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Ahsan Atta <ahsan.atta@intel.com>
Subject: [PATCH] crypto: qat - clear AES key schedule from stack
Date: Mon,  8 Jun 2026 16:04:20 +0100
Message-ID: <20260608150441.136014-1-giovanni.cabiddu@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Research and Development Ireland Ltd - Co. Reg. #308263 - Collinstown Industrial Park, Leixlip, County Kildare - Ireland
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24962-lists,linux-crypto=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:linux-crypto@vger.kernel.org,m:qat-linux@intel.com,m:giovanni.cabiddu@intel.com,m:ahsan.atta@intel.com,s:lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER(0.00)[giovanni.cabiddu@intel.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[giovanni.cabiddu@intel.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:dkim,intel.com:email,intel.com:mid,intel.com:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E233E65845B

qat_alg_xts_reverse_key() expands the forward XTS AES key on the stack.
That schedule contains key material and can remain in the stack frame.

Clear the temporary crypto_aes_ctx with memzero_explicit() after the copy.

Fixes: 5106dfeaeabe ("crypto: qat - add AES-XTS support for QAT GEN4 devices")
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Reviewed-by: Ahsan Atta <ahsan.atta@intel.com>
---
 drivers/crypto/intel/qat/qat_common/qat_algs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/intel/qat/qat_common/qat_algs.c b/drivers/crypto/intel/qat/qat_common/qat_algs.c
index 7f638a62e3ad..91663805d9e6 100644
--- a/drivers/crypto/intel/qat/qat_common/qat_algs.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_algs.c
@@ -405,6 +405,7 @@ static void qat_alg_xts_reverse_key(const u8 *key_forward, unsigned int keylen,
 		memcpy(key_reverse + AES_BLOCK_SIZE, key - AES_BLOCK_SIZE,
 		       AES_BLOCK_SIZE);
 	}
+	memzero_explicit(&aes_expanded, sizeof(aes_expanded));
 }
 
 static void qat_alg_skcipher_init_dec(struct qat_alg_skcipher_ctx *ctx,

base-commit: 36d82ddc0f8a88444e8d65646a3c43147005ed35
-- 
2.54.0


