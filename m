Return-Path: <linux-crypto+bounces-21987-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPlJJbVuuGn5dgEAu9opvQ
	(envelope-from <linux-crypto+bounces-21987-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 16 Mar 2026 21:57:25 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F5F2A075B
	for <lists+linux-crypto@lfdr.de>; Mon, 16 Mar 2026 21:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CE4530205E1
	for <lists+linux-crypto@lfdr.de>; Mon, 16 Mar 2026 20:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86EB535B136;
	Mon, 16 Mar 2026 20:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cr8b3vkC"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D09735A3B8;
	Mon, 16 Mar 2026 20:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773694637; cv=none; b=O0HmmYFKHbYcKRb8D7KD7dzNIFZsts5uVxXp7tv2U81U9WrsFlHT7l/mEnJVmi2cuTEeQOLvbIYijaWU33RvDDhf/wz6ENklThsDjGFmoiHDPEtP4d5Q68JEtdrLed7JcWn+V4wG+OJLF6gSLo+QbYGeSx8ReDk1mDC6GDE9aDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773694637; c=relaxed/simple;
	bh=BIMIJjlsbjMMxSdGDsLQSWVZoKzAT6k9eS4F/MOxtiA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OyUIkFOalZem75u2I1dg3gmERifZFz7P3nLiaTJOGVzjTUMgg010Gm8g7ggyh50ssa9kBPSvdlJYWR0ar4scJjbaNfISu5TNmwjSaEUFziqMBcXDFaCovbjzSS56XaT+cHC9dEeUJYsOHS0gXm9fPejVCGIMiog5i+AIKtmulj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cr8b3vkC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AC60C19421;
	Mon, 16 Mar 2026 20:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773694636;
	bh=BIMIJjlsbjMMxSdGDsLQSWVZoKzAT6k9eS4F/MOxtiA=;
	h=From:To:Cc:Subject:Date:From;
	b=Cr8b3vkC8BCKgg1p/5ByHoGYCkOy9FvKAXlKa+mkmN3diG3wpj0D/WTSN9XlLEf8a
	 mGzj2IYVt3s+owJhFOcJcbu/2o/MXgTgKmxDqI3bNXZaB7LIpAZ3bkyT74j0yfAUx4
	 tNZCXV5HmlVwAHasMigrNXocf+Hq6c0cHcOVjbXi1Umvr9szTh/5C5SKIpxGzgduAq
	 ilwzX14P1QfIbsBf+clhlUMDWJUP/nj1Oj6vJM770qpkjQyT0COTNOWO/W9hK8sWuU
	 awuyaBniBJa3LQCM9wr6C+oZINi5CgbfglHslA64600XB48J3XYEBnZhoP3vQXxSiR
	 fA+Mp1wAnc5aw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] crypto: crc32c - Remove another outdated comment
Date: Mon, 16 Mar 2026 13:56:59 -0700
Message-ID: <20260316205659.17936-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21987-lists,linux-crypto=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 70F5F2A075B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This code just calls crc32c(), which has a number of different
implementations, not just the byte-at-a-time table-based one.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---

This patch is targeting crc-next

 crypto/crc32c.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/crypto/crc32c.c b/crypto/crc32c.c
index 1eff54dde2f7..3754985ab948 100644
--- a/crypto/crc32c.c
+++ b/crypto/crc32c.c
@@ -47,15 +47,10 @@ struct chksum_ctx {
 
 struct chksum_desc_ctx {
 	u32 crc;
 };
 
-/*
- * Steps through buffer one byte at a time, calculates reflected
- * crc using table.
- */
-
 static int chksum_init(struct shash_desc *desc)
 {
 	struct chksum_ctx *mctx = crypto_shash_ctx(desc->tfm);
 	struct chksum_desc_ctx *ctx = shash_desc_ctx(desc);
 

base-commit: c13cee2fc7f137dd25ed50c63eddcc578624f204
-- 
2.53.0


