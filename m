Return-Path: <linux-crypto+bounces-25090-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pvP0EKCyKmovvQMAu9opvQ
	(envelope-from <linux-crypto+bounces-25090-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 15:05:36 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DB76722BD
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 15:05:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VZd0c5nH;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25090-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25090-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48EDA34129CF
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 12:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7C43FADFD;
	Thu, 11 Jun 2026 12:59:58 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2644C2DA76C;
	Thu, 11 Jun 2026 12:59:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781182798; cv=none; b=Ab8AOCT57nbd/UcAisrckVx51rTQvovlnAU7BsXSz7d2PYRO2dWhaVSgHfoVE3pyq0rFsw70c+55MX9CurnAvYnbJmvC9ADiZgFwHrHWs0w4PEnvLMEfQHPnxhzkw08+It6Z3LOWtBk5RVGnNro0OjNl9rmxyNNgKeOfWnCE/60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781182798; c=relaxed/simple;
	bh=8KAGxG+bTzZw0NtXACFDYDhwLup09FdT2xtTamsCuMk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ag1DfnLoVIYnLg6J4cFL12bvNlWAr8q0sDVvivQmSohNcFoB6wSgSJ51bAfBdktHHe1PBXAR9rp+brAxXcgclNWDwMv1IzaJP6gKo39+Mv0my3FM+utICff2bxiDXkng7wnJymrHHzxCMGOpJEGIv1mWH7yX2Hq6E3p9siasw/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZd0c5nH; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B77F1F00893;
	Thu, 11 Jun 2026 12:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781182796;
	bh=zfe+53sDR95Yk81P6I4goSKtYHLjwJCYHiFTrpzsUlc=;
	h=From:To:Cc:Subject:Date;
	b=VZd0c5nHMgfT64+gqRWhAqWqHiJyAx6KhY1MwIRMr8tWmqAOFe+V5O+IujkmUCUwT
	 LulxrT51VENissvj6gyb5iAsFIYuFcku8/wAOQ1V1qt4cDThgatvJJb16gTd3HUSC3
	 vwLyzGfawRHiVHIzdlGyv6Gv1GJkmMNgzCrN0tVWHHuVHPMlC/HHr8DHDEh2tinep7
	 fNfmK3sEc7p8q2ZlR8CWgHGVvC5OYtGprFiubfHURUOaGquQszPOPx92rJ8h/rR0Q9
	 D49ZpkB9rPEO9JLCunMbHWQTIsJzYYs++C3i11xfsv/cEocbebvqAFZ+lDNzE71Zhf
	 MkeBf2bKhWAtg==
From: Arnd Bergmann <arnd@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH] lib/crypto: gf128hash: mark clmul32() as noinline_for_stack
Date: Thu, 11 Jun 2026 14:59:39 +0200
Message-Id: <20260611125952.3387258-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[arndb.de,gmail.com,google.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-25090-lists,linux-crypto=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[arnd@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:Jason@zx2c4.com,m:ardb@kernel.org,m:nathan@kernel.org,m:arnd@arndb.de,m:nick.desaulniers+lkml@gmail.com,m:morbo@google.com,m:justinstitt@google.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:llvm@lists.linux.dev,m:nickdesaulniers@gmail.com,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,arndb.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94DB76722BD

From: Arnd Bergmann <arnd@arndb.de>

During randconfig testing, I came across a lot of warnings for the newly
added carryless multiplication function triggering excessive stack usage
from spilling temporary variables to the stack:

lib/crypto/gf128hash.c:166:1: error: stack frame size (1192) exceeds limit (1024) in 'polyval_mul_generic' [-Werror,-Wframe-larger-than]

In addition to the possible risk of overflowing the kernel stack,
the generated object code surely performs very poorly.

This only happens on architectures that don't provide uint128_t
(which should be all 32-bit architectures on modern compilers), but
though I tested random x86 and arm configs, I only saw this with arm's
CONFIG_THUMB2_KERNEL, which adds more pressure to the register allocator.

The testing was done using clang-22, I don't know if gcc has the same
problem. Marking clmul32() as noinline_for_stack experimentally shows
all of the affected builds to completely solve the problem, reducing
the stack usage to a few bytes as expected.

Since u64 arithmetic frequently leads to compilers badly optimizing
32-bit targets, keeping clmul32 out of line is likely to help on
other 32-bit configurations as well when they run into this problem,
though it may also result in a small performance degradation in
configurations that would benefit from inlining.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
---
 lib/crypto/gf128hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/crypto/gf128hash.c b/lib/crypto/gf128hash.c
index 2650603d8ba8..8dcdf5ec98be 100644
--- a/lib/crypto/gf128hash.c
+++ b/lib/crypto/gf128hash.c
@@ -109,7 +109,7 @@ static void clmul64(u64 a, u64 b, u64 *out_lo, u64 *out_hi)
 #else /* CONFIG_ARCH_SUPPORTS_INT128 */
 
 /* Do a 32 x 32 => 64 bit carryless multiplication. */
-static u64 clmul32(u32 a, u32 b)
+static noinline_for_stack u64 clmul32(u32 a, u32 b)
 {
 	/*
 	 * With 32-bit multiplicands and one term every 4 bits, there are up to
-- 
2.39.5


