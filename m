Return-Path: <linux-crypto+bounces-21476-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Dm3KkR6pmldQQAAu9opvQ
	(envelope-from <linux-crypto+bounces-21476-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Mar 2026 07:05:56 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 312411E9649
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Mar 2026 07:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C6F723053746
	for <lists+linux-crypto@lfdr.de>; Tue,  3 Mar 2026 06:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B17430DEB5;
	Tue,  3 Mar 2026 06:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jvdsn.com header.i=@jvdsn.com header.b="pukjEq0F"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.jvdsn.com (smtp.jvdsn.com [129.153.194.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E882DF144;
	Tue,  3 Mar 2026 06:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.153.194.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772517937; cv=none; b=fSh1/T7e4c4OoDtivDS3GahGAzD20gu5srDDkIWThRmGPsweR9LZB5nIt0ij3v1mVf0nkkr2/rfEiBIQBwjH5D/WM72t5la8qa830UEZ97A8bteZlIzzgH2ec0ULh+HO8yxyLJn2DvFy1iUDxhxVgDRlrILypfLzyOq1eiqW40w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772517937; c=relaxed/simple;
	bh=enmyVlM9QgRzuKEYUPIKv1hMr+WrNhZ5gYCBMQMAZ8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uxMuENqIDSnSWKRR0OiwR/uAT9UVVDOySeITi/3AwPiRJKFbuTUDCCwGDF+N18vMyOm+MvdEbfEcKqIENeIuo6rE3MB2M4DM5kQqcZz0ZjYzu6m/OtsBXAnNXrnrm8HDisHqYFVzy0yJBvX2762AqFMtcmFU8UiZy7ExL37+VMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jvdsn.com; spf=pass smtp.mailfrom=jvdsn.com; dkim=pass (2048-bit key) header.d=jvdsn.com header.i=@jvdsn.com header.b=pukjEq0F; arc=none smtp.client-ip=129.153.194.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=jvdsn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jvdsn.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=jvdsn.com; s=mail;
	t=1772517930; bh=enmyVlM9QgRzuKEYUPIKv1hMr+WrNhZ5gYCBMQMAZ8E=;
	h=From:To:Cc:Subject:Date;
	b=pukjEq0F6SSJxbGXZm4eRcDDr/58o6BsyXvGMdFuIYlRHB03PKiyOyT99FdaLfnVm
	 CQwEBGx+A5njCdAYb+wqe+iiwWSzyJcw0k3/CMzNJXB1BtR1wItUSmMO7pTB35oOO9
	 JVzYGwEesbjmsT/K+8SzeLfMN81/pf/5dMwgwyCW/17JbYNXfwTr2hQaGQRwVrL+rC
	 mY8HQlOL2uM9RCYbklJrfp5hmqM932HwgdeXmtOOQ/kPdZ/vbMIhdyGdwYALME0wOY
	 wxDo/CUdzYRUV5yq+6fb8sk7Dqn5aX6jspqDs/trmV8xXfY3S+sfx5CRZdUmC50PdF
	 HRMonRhp1VC7w==
From: Joachim Vandersmissen <git@jvdsn.com>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-crypto@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Joachim Vandersmissen <git@jvdsn.com>
Subject: [PATCH] crypto: testmgr - block Crypto API xxhash64 in FIPS mode
Date: Tue,  3 Mar 2026 00:05:09 -0600
Message-ID: <20260303060509.246038-1-git@jvdsn.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 312411E9649
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[jvdsn.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[jvdsn.com:s=mail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gondor.apana.org.au,davemloft.net,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-21476-lists,linux-crypto=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[git@jvdsn.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[jvdsn.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

xxhash64 is not a cryptographic hash algorithm, but is offered in the
same API (shash) as actual cryptographic hash algorithms such as
SHA-256. The Cryptographic Module Validation Program (CMVP), managing
FIPS certification, believes that this could cause confusion. xxhash64
must therefore be blocked in FIPS mode.

The only usage of xxhash64 in the kernel is btrfs. Commit fe11ac191ce0
("btrfs: switch to library APIs for checksums") recently modified the
btrfs code to use the lib/crypto API, avoiding the Kernel Cryptographic
API. Consequently, the removal of xxhash64 from the Crypto API in FIPS
mode should now have no impact on btrfs usage.

Signed-off-by: Joachim Vandersmissen <git@jvdsn.com>
---
 crypto/testmgr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/crypto/testmgr.c b/crypto/testmgr.c
index 49b607f65f63..d7475d6000dd 100644
--- a/crypto/testmgr.c
+++ b/crypto/testmgr.c
@@ -5609,7 +5609,6 @@ static const struct alg_test_desc alg_test_descs[] = {
 #endif
 		.alg = "xxhash64",
 		.test = alg_test_hash,
-		.fips_allowed = 1,
 		.suite = {
 			.hash = __VECS(xxhash64_tv_template)
 		}
-- 
2.53.0


