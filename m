Return-Path: <linux-crypto+bounces-22832-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KH5LLH1b1Wmu4wcAu9opvQ
	(envelope-from <linux-crypto+bounces-22832-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 07 Apr 2026 21:31:09 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCB13B3A4F
	for <lists+linux-crypto@lfdr.de>; Tue, 07 Apr 2026 21:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 687A03066896
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Apr 2026 19:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634B8272803;
	Tue,  7 Apr 2026 19:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="AExyMAdr"
X-Original-To: linux-crypto@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FDD35AC2F;
	Tue,  7 Apr 2026 19:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775590182; cv=none; b=HS2PYu2McbQrmtulCqm4mV9AeKVGKLqOJxu3ZIdU/pMGEt/Cniig4BIiskJc1NKUTf1KsEbguCbJsNGQjTZWR3X3VXO4XGCKKpbAM76A8l1ZekRiNbjWPrAOnzZ8xcCvDs4dTPTH4Ou+6fTtJ6wCtJTTaSFLUZxNmg3gAAqOoiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775590182; c=relaxed/simple;
	bh=57m/MHhmb5jz7OVk2BzrYzPNeKdwEks4x6zwHLZ0J6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VwGqP7jMO376O8P69l0gTK72IRZ7ZOCqEM+hRFmw/WMEm851g6CPqYK7kTFkCaNGjMNoH9pDDf3050m8He0k9TXaYmIRtyZxZX25BcbKPLkx3tEBjQGONAS524jEcU9YB4j1hs7JQYjZkRu8Cy32zxS9gVRj2qZo603qLwu6yE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=AExyMAdr; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 0337820B7135; Tue,  7 Apr 2026 12:29:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0337820B7135
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775590181;
	bh=s7BvHIXUu/KyBlp0Bh64m9iU1jIIBC4g+vpzAyrmhA8=;
	h=From:To:Cc:Subject:Date:From;
	b=AExyMAdr/2moVZ3cwtjXrEfUHWE8ytLxMd0Bi3A3BWIfMTPoNYqZgo6ige9DgkoAu
	 eAbIdTsod9SyuHLV177tEg9OwAnZdUZa/hgWdX1n7vGFk0b8lohV77HAHWxXFUD+FP
	 k0W3kNaUohEn0/X3HcoAoTUNCvkqDkRbHH39wz84=
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: linux-crypto@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>,
	Jeff Barnes <jeffbarnes@linux.microsoft.com>,
	Paul Monson <paul.monson@capgemini.com>
Subject: [PATCH] crypto: tstmgr - guard xxhash tests
Date: Tue,  7 Apr 2026 12:28:59 -0700
Message-ID: <20260407192859.270745-1-hamzamahfooz@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gondor.apana.org.au,davemloft.net,gmail.com,foss.st.com,st-md-mailman.stormreply.com,lists.infradead.org,vger.kernel.org,linux.microsoft.com,capgemini.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22832-lists,linux-crypto=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hamzamahfooz@linux.microsoft.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[capgemini.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim,linux.microsoft.com:mid]
X-Rspamd-Queue-Id: 2DCB13B3A4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

If the kernel isn't built with CONFIG_CRYPTO_XXHASH and booted with FIPS
mode enabled it will currently panic. So, only benchmark xxhash64 if
CRYPTO_XXHASH is enabled.

Cc: Jeff Barnes <jeffbarnes@linux.microsoft.com>
Cc: Paul Monson <paul.monson@capgemini.com>
Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
---
 crypto/testmgr.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 4985411dedaec..9e4a040029ab8 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5609,7 +5609,9 @@ static const struct alg_test_desc alg_test_descs[] = {
 #endif
 		.alg = "xxhash64",
 		.test = alg_test_hash,
+#if IS_ENABLED(CONFIG_CRYPTO_XXHASH)
 		.fips_allowed = 1,
+#endif
 		.suite = {
 			.hash = __VECS(xxhash64_tv_template)
 		}
-- 
2.53.0


