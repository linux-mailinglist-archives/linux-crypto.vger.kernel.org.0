Return-Path: <linux-crypto+bounces-25407-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0jcRHIYCPmod+ggAu9opvQ
	(envelope-from <linux-crypto+bounces-25407-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 06:39:34 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8884A6CA226
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 06:39:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ij6vpCDh;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25407-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25407-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6622B3017C90
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2026 04:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90228330328;
	Fri, 26 Jun 2026 04:39:25 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609A32FFDD5;
	Fri, 26 Jun 2026 04:39:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782448765; cv=none; b=t5MRAcaxjR4BZcDsOfFeTXVxZGYxkFKgIlCGnVQUJrSwnAJngTbuRTY7sI9kIkUqAPFvVPSkgKKYi3nTYnQVCS7fJT6N5YZ+Koz1d+sG2xPzWwif0/urGdmhDhVUcC5kpjtxn0k9na5HLPR41m/+tcd4DdbjYS0vaDpsN46lG3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782448765; c=relaxed/simple;
	bh=Iiz/QnMDtEg87voSGJUNobj8UoEi8PBqq45GKQWEmD4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oL0OCyUTdV0M7Y4iT7IjAh7xBvy2GIcVFKxqBp3YSK7/yh3ukoiJGl4jnjKmtLXHmQl3hMZWFddunU9wqwJ5pfXoeQTdV3S9hhVvQ445gRpbm+JjogQWcJv4v/ht29zLlf9/WOUOKnD4yNZ58xsblLPdOSxvf4nCi6nBNWQ2e0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ij6vpCDh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AA91F000E9;
	Fri, 26 Jun 2026 04:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782448764;
	bh=EThdRu/11wp6N0JSfRIxy1kA6W323gFL4ICwbKnuv1w=;
	h=From:To:Cc:Subject:Date;
	b=ij6vpCDhyTlRwiqupSK0EHeAXKevHJCyIHbjmW2s/O85CCp68rYWWunAGtELDSHzF
	 tuw7kMRdbe5vx/ULc8iV7pybd4jEEPz/BTc/5b1rEXDNzrisDikUTO+2n9KeN1fjxY
	 vb9lJbaDgvQGbn9hlJ02dZ7FiL95jp5wGu+kl+MKL5QkGNUv+K4hve8OEGtNtNXTAo
	 X8VNIRH//W5F0MnZQSigvXDTODiV/rTsZqwOSM/nKjOIO8lwkRfNQgpeT8lmghCYqy
	 074dsVHwlftgIusGkl0Oaqm8eAzif6n6YIif2LUYi+sm8Zt6/KAJboYJU2dxkvyk8a
	 Ao8VCKNR4Sgjg==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 0/8] x86: Remove cpu_has_xfeatures() and add AVX-512 xor_gen()
Date: Thu, 25 Jun 2026 21:37:23 -0700
Message-ID: <20260626043731.319287-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25407-lists,linux-crypto=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:x86@kernel.org,m:linux-um@lists.infradead.org,m:linux-raid@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:hch@lst.de,m:akpm@linux-foundation.org,m:ebiggers@kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8884A6CA226

My patch "lib/raid/xor: x86: Add AVX-512 optimized xor_gen()"
(https://lore.kernel.org/r/20260615190338.26581-1-ebiggers@kernel.org/)
still seems to be blocked on a Sashiko comment about cpu_has_xfeatures()
not being called.

However, the x86-optimized RAID library code supports UML, and currently
UML doesn't implement cpu_has_xfeatures().  That's perhaps why the
existing AVX-512 optimized RAID6 code doesn't check it either.

In fact, it seems to have been getting by fine without it, which
suggests that it's not truly needed.

But to eliminate any doubts, I've had a go at fully resolving the
situation by making both native x86 and UML explicitly clear any
X86_FEATURE_* flags at boot time whose xfeatures are missing.

Then, cpu_has_xfeatures() is entirely removed from the kernel.

The last patch adds the AVX-512 optimized xor_gen().  I do still think
it would be fine to proceed with it without the rest.  But if there are
any doubts, we can take this more comprehensive cleanup route.

Eric Biggers (8):
  x86/fpu: Check for missing AVX and AVX-512 xstate bits
  um: Check for missing AVX and AVX-512 xstate bits
  crypto: x86 - Stop using cpu_has_xfeatures()
  lib/crypto: x86: Stop using cpu_has_xfeatures()
  lib/crc: x86: Stop using cpu_has_xfeatures()
  x86/fpu: Remove cpu_has_xfeatures()
  lib/raid/xor: x86: Remove redundant X86_FEATURE_OSXSAVE check
  lib/raid/xor: x86: Add AVX-512 optimized xor_gen()

 arch/um/kernel/um_arch.c                   |  78 ++++++++++++-
 arch/x86/crypto/aegis128-aesni-glue.c      |   3 +-
 arch/x86/crypto/aesni-intel_glue.c         |   7 +-
 arch/x86/crypto/aria_aesni_avx2_glue.c     |  11 +-
 arch/x86/crypto/aria_aesni_avx_glue.c      |  11 +-
 arch/x86/crypto/aria_gfni_avx512_glue.c    |  11 +-
 arch/x86/crypto/camellia_aesni_avx2_glue.c |  11 +-
 arch/x86/crypto/camellia_aesni_avx_glue.c  |  11 +-
 arch/x86/crypto/cast5_avx_glue.c           |   7 +-
 arch/x86/crypto/cast6_avx_glue.c           |   7 +-
 arch/x86/crypto/serpent_avx2_glue.c        |   9 +-
 arch/x86/crypto/serpent_avx_glue.c         |   7 +-
 arch/x86/crypto/sm4_aesni_avx2_glue.c      |  11 +-
 arch/x86/crypto/sm4_aesni_avx_glue.c       |  11 +-
 arch/x86/crypto/twofish_avx_glue.c         |   6 +-
 arch/x86/include/asm/fpu/api.h             |   9 --
 arch/x86/kernel/fpu/xstate.c               |  63 ++++-------
 lib/crc/x86/crc-pclmul-template.h          |   6 +-
 lib/crypto/x86/blake2s.h                   |   4 +-
 lib/crypto/x86/chacha.h                    |   3 +-
 lib/crypto/x86/nh.h                        |   4 +-
 lib/crypto/x86/poly1305.h                  |   7 +-
 lib/crypto/x86/sha1.h                      |   4 +-
 lib/crypto/x86/sha256.h                    |   4 +-
 lib/crypto/x86/sha512.h                    |   3 +-
 lib/crypto/x86/sm3.h                       |   3 +-
 lib/raid/xor/Makefile                      |   2 +-
 lib/raid/xor/x86/xor-avx512.c              | 121 +++++++++++++++++++++
 lib/raid/xor/x86/xor_arch.h                |  24 ++--
 29 files changed, 264 insertions(+), 194 deletions(-)
 create mode 100644 lib/raid/xor/x86/xor-avx512.c


base-commit: 4edcdefd4083ae04b1a5656f4be6cd83ae919ef4
-- 
2.54.0


