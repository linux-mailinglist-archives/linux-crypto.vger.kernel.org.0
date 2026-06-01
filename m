Return-Path: <linux-crypto+bounces-24780-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gENlMeVKHWphYgkAu9opvQ
	(envelope-from <linux-crypto+bounces-24780-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 01 Jun 2026 11:03:33 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4562C61C0F0
	for <lists+linux-crypto@lfdr.de>; Mon, 01 Jun 2026 11:03:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22F1B30AA11B
	for <lists+linux-crypto@lfdr.de>; Mon,  1 Jun 2026 08:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5884385D60;
	Mon,  1 Jun 2026 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="rHAdCxHs"
X-Original-To: linux-crypto@vger.kernel.org
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com [35.155.198.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E4D32B108;
	Mon,  1 Jun 2026 08:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.155.198.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780304218; cv=none; b=FN2/uAdvTAgKxUyFaEv3Gj3NoFVWVumMnMcvwdfxUcJFMxN3yfx55085VrE6jbXeT1SvziuIuThBlwbESf/K44WxAmEFD3kparVJsm+CL4hc9RG3I3sHFRU4E+BvQJi0hwIhnSzOwF846bd+Dap9fukhrTjI3nsE9NPAbNplFac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780304218; c=relaxed/simple;
	bh=UELCM2h04zdJYWmKKSJlAM9eZYQBgK9+WwrE1+sp08c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uouf6TtWTYOWJeioTVdyucfriZoCXQoSSaYQ12rwRfH1gtX84t+6QymYVg3Pu2IKvX1wv3AnYrxW/SpWfcbVqprlS5wUL7HGRFjm5DvqTVUH0W2Nb7q9rqSitAPk7I+FDzNSwOU+qXG/vi4PL8M542rE4l7E1l6VSgc8QEnXOKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=rHAdCxHs; arc=none smtp.client-ip=35.155.198.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1780304217; x=1811840217;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=avUDsFcJLGOTHoHOJ0Z0BmzumyUYOy0sTCh3tq0rYpM=;
  b=rHAdCxHsIQWYo3qQVI3t4lvoBWW7wJinTiHUPbHb9Gte9ut7kqAaXY14
   bdbiLZb++bhhRfbKHxf5YhUNpkhuGIu7rRLU4gKyCK2hCeLpKu8IGfbqI
   OMfPXiasA2/xjDHoQ3mOYv31CuVoitu+6NAT+5zKsEwHxukagKfOsgRM5
   qQrRRd47e+3NR+K8DcgkX79sF1a1lAIqRTL2evPlp8EuaSQjm3yQF3IoN
   L1P1zph6qgjP5H8k5usIQJ50MWnPIiSoXzLiXFBxDDirIJy+L3cY9VAsv
   pLAf3Oi3NSMKDxI3lnXaRyVCSm+xjAk+8GSWeOy9S9rtuCJzxXoc7J6Zo
   w==;
X-CSE-ConnectionGUID: jgAcCNV6RTujXCHrR9euEQ==
X-CSE-MsgGUID: j9i22Bx8TOW2v8nHVj9GGw==
X-IronPort-AV: E=Sophos;i="6.24,180,1774310400"; 
   d="scan'208";a="20718758"
Received: from ip-10-5-6-203.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.6.203])
  by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 08:56:54 +0000
Received: from EX19MTAUWC002.ant.amazon.com [205.251.233.111:16226]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.154:2525] with esmtp (Farcaster)
 id 89c050f9-5780-47d6-85ef-e3180503e1f5; Mon, 1 Jun 2026 08:56:54 +0000 (UTC)
X-Farcaster-Flow-ID: 89c050f9-5780-47d6-85ef-e3180503e1f5
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 1 Jun 2026 08:56:54 +0000
Received: from dev-dsk-lravich-1b-7405803b.eu-west-1.amazon.com (10.13.225.95)
 by EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.37;
 Mon, 1 Jun 2026 08:56:52 +0000
From: Leonid Ravich <lravich@amazon.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Alasdair Kergon <agk@redhat.com>, Ard Biesheuvel <ardb@kernel.org>, "Eric
 Biggers" <ebiggers@kernel.org>, Jens Axboe <axboe@kernel.dk>, Horia Geanta
	<horia.geanta@nxp.com>, Gilad Ben-Yossef <gilad@benyossef.com>,
	<linux-crypto@vger.kernel.org>, <dm-devel@lists.linux.dev>,
	<linux-block@vger.kernel.org>
Subject: [PATCH v3 2/4] crypto: xts - support multiple data units per request in template
Date: Mon, 1 Jun 2026 08:56:42 +0000
Message-ID: <20260601085644.13026-3-lravich@amazon.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260601085644.13026-1-lravich@amazon.com>
References: <20260601085644.13026-1-lravich@amazon.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA004.ant.amazon.com (10.13.139.85) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[amazon.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amazon.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[amazon.com:s=amazoncorp2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-24780-lists,linux-crypto=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[lravich@amazon.com,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amazon.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4562C61C0F0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Teach the generic xts() template to consume cryptlen larger than one
data unit when the caller has configured a non-zero data_unit_size on
the tfm.  Each data unit is processed with its own IV, derived from
the caller-supplied IV by treating it as a 128-bit little-endian
counter and adding the data-unit index.  This matches the
sector-indexed XTS used by dm-crypt's plain64 IV mode and by typical
inline-encryption hardware.

The single-data-unit body is unchanged and is now reached via a thin
xts_crypt_multi() dispatcher that skips straight to the body when
data_unit_size is zero (the legacy default), so existing users see
no extra cost.

Advertise CRYPTO_ALG_SKCIPHER_MULTI_DATA_UNIT in cra_flags only when
the inner cipher is synchronous.  An async inner cipher would require
a per-DU completion chain which is out of scope for the slow software
template; consumers that need multi-DU on async hardware will use one
of the arch-specific drivers added later in this series.

Signed-off-by: Leonid Ravich <lravich@amazon.com>
---
 crypto/xts.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/crypto/xts.c b/crypto/xts.c
index ad97c8091582..f0585ea9d6d5 100644
--- a/crypto/xts.c
+++ b/crypto/xts.c
@@ -258,7 +258,7 @@ static int xts_init_crypt(struct skcipher_request *req,
 	return 0;
 }
 
-static int xts_encrypt(struct skcipher_request *req)
+static int xts_encrypt_one(struct skcipher_request *req)
 {
 	struct xts_request_ctx *rctx = skcipher_request_ctx(req);
 	struct skcipher_request *subreq = &rctx->subreq;
@@ -275,7 +275,7 @@ static int xts_encrypt(struct skcipher_request *req)
 	return xts_cts_final(req, crypto_skcipher_encrypt);
 }
 
-static int xts_decrypt(struct skcipher_request *req)
+static int xts_decrypt_one(struct skcipher_request *req)
 {
 	struct xts_request_ctx *rctx = skcipher_request_ctx(req);
 	struct skcipher_request *subreq = &rctx->subreq;
@@ -292,6 +292,16 @@ static int xts_decrypt(struct skcipher_request *req)
 	return xts_cts_final(req, crypto_skcipher_decrypt);
 }
 
+static int xts_encrypt(struct skcipher_request *req)
+{
+	return skcipher_walk_data_units(req, xts_encrypt_one);
+}
+
+static int xts_decrypt(struct skcipher_request *req)
+{
+	return skcipher_walk_data_units(req, xts_decrypt_one);
+}
+
 static int xts_init_tfm(struct crypto_skcipher *tfm)
 {
 	struct skcipher_instance *inst = skcipher_alg_instance(tfm);
@@ -427,6 +437,17 @@ static int xts_create(struct crypto_template *tmpl, struct rtattr **tb)
 	inst->alg.base.cra_alignmask = alg->base.cra_alignmask |
 				       (__alignof__(u64) - 1);
 
+	/*
+	 * Advertise multi-data-unit support only when the inner cipher is
+	 * synchronous.  The dispatcher in skcipher_walk_data_units() calls
+	 * the single-DU body in a loop and assumes synchronous completion;
+	 * supporting async would require a per-DU callback chain, which
+	 * the slow software template does not need.
+	 */
+	if (!(alg->base.cra_flags & CRYPTO_ALG_ASYNC))
+		inst->alg.base.cra_flags |=
+			CRYPTO_ALG_SKCIPHER_MULTI_DATA_UNIT;
+
 	inst->alg.ivsize = XTS_BLOCK_SIZE;
 	inst->alg.min_keysize = alg->min_keysize * 2;
 	inst->alg.max_keysize = alg->max_keysize * 2;
-- 
2.47.3


