Return-Path: <linux-crypto+bounces-21992-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SgLiK8jduGlSkgEAu9opvQ
	(envelope-from <linux-crypto+bounces-21992-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 05:51:20 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1A52A3D34
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 05:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D432D3021E5D
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 04:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33E99366828;
	Tue, 17 Mar 2026 04:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTQl+5Nl"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF4521D599;
	Tue, 17 Mar 2026 04:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773723077; cv=none; b=peXnpWD4/xlyK1YQgxr5Lo5nbezGglM/tUG692HW0/ZjrQCz58EXMD5HoA03fqzXKGlO1zMM3NLKUhBOCnQXHfr/c6OFzEr1wloyn29bADTex4KhPOn9VzulN3OH1kn8MohxiiQd3k1zNA5Q7oiYfh+8YIEXtijj3RqNs7kFLz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773723077; c=relaxed/simple;
	bh=6wmzA6YeKKYQRTyDXyQWVPMulEEjCgindg0VmxPV6V8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZmMnot8N7ontUsBjamdp7Dvq0i2Njs8HSBE8vdRYTgRfiFQXDJmMGe6GpHooJvX9iMRgqNZYYJ+b+r/kHkKsWV2PYBFksCHTcIuFPHunMwHVLkD8JueaOA8PmW9LFqLxdQK8HTMkvzyGEW8dg/FHqTv8EkvfTCjzMrd3Ax3RHbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTQl+5Nl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F59C2BC86;
	Tue, 17 Mar 2026 04:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773723076;
	bh=6wmzA6YeKKYQRTyDXyQWVPMulEEjCgindg0VmxPV6V8=;
	h=From:To:Cc:Subject:Date:From;
	b=kTQl+5NlPAyy2Q+qZwNe+TJAIgpLhmi4l3wxOMBcNsDMn6te04Uy4JEmZe6aDD+TP
	 oGsdhWv+KC2jz1VqcyKGoYgXoCSZLY3fiEdGc2sghbBcQTv+ewI/JNKCPpyl6VqkWB
	 nPWE6dVmKM1UWSUNFqjeivNNfbeF5eiRKOY/OOv+ecMZAwf3W++EJbod+7E3HLNokO
	 IUYVL/7/TqOeIra9rbjxYbOSOfpl80wbUFZOO0RvWxgU1zb1MdFKBRxSvxj+KLE0Uq
	 YE+WZ2aYDmGsPEybxOyhBgI7aR1fqWujTShlVm1DvZNpmUrDJU2cjYeXXV5+sgdmak
	 +zKRioypK1yIA==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linuxppc-dev@lists.ozlabs.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH] lib/crypto: powerpc: Add powerpc/aesp8-ppc.S to clean-files
Date: Mon, 16 Mar 2026 21:49:25 -0700
Message-ID: <20260317044925.104184-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21992-lists,linux-crypto=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0B1A52A3D34
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Make the generated file powerpc/aesp8-ppc.S be removed by 'make clean'.

Fixes: 7cf2082e74ce ("lib/crypto: powerpc/aes: Migrate POWER8 optimized code into library")
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/crypto/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/crypto/Makefile b/lib/crypto/Makefile
index 725eef05b758..dc7a56f7287d 100644
--- a/lib/crypto/Makefile
+++ b/lib/crypto/Makefile
@@ -53,10 +53,13 @@ endif # CONFIG_PPC
 libaes-$(CONFIG_RISCV) += riscv/aes-riscv64-zvkned.o
 libaes-$(CONFIG_SPARC) += sparc/aes_asm.o
 libaes-$(CONFIG_X86) += x86/aes-aesni.o
 endif # CONFIG_CRYPTO_LIB_AES_ARCH
 
+# clean-files must be defined unconditionally
+clean-files += powerpc/aesp8-ppc.S
+
 ################################################################################
 
 obj-$(CONFIG_CRYPTO_LIB_AESCFB)			+= libaescfb.o
 libaescfb-y					:= aescfb.o
 

base-commit: ebba09f198078b7a2565004104ef762d1148e7f0
-- 
2.53.0


