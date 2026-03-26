Return-Path: <linux-crypto+bounces-22390-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Jq+LO56xGlXzgQAu9opvQ
	(envelope-from <linux-crypto+bounces-22390-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 01:16:46 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 243DA32D91F
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 01:16:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE5A63039F6B
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 00:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6AB1212550;
	Thu, 26 Mar 2026 00:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNGuLDpe"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF9A20C00A;
	Thu, 26 Mar 2026 00:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774484203; cv=none; b=UuFCbUcnP1NHtqzFPDXDslv4DLhugj+DLHWzYn0zRUZn9LHLCWRoWPjjMRIJ9wE/J5Lf5Z/9xAEm/Peg0q5jHd8yg/s2qVIwleH3QTBUi2RQdBiI9IYM9de1IKUtvk5cevBGcyyIqROo/IbBeP0NcnwtciiiB9EE/pNI605Z/xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774484203; c=relaxed/simple;
	bh=K59JVsZzzV61i6IGo6VkFRuwNYRboTvCPXe3QuBREyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uU7fzMxW11xVQNl5fORxG9wYiOyXzpQa1XRP3stB5ku4AzUNwDC+hA0G3bvjpbmV6a3dHgOYBC91ljmApwSIAuElUV7UYs1ugOlDxX9N3POhqM8i7DK90B8ebaEugw/mjDnDmBnUtKx20rONDJnijQzG/YczO1revz/s7YcVtR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNGuLDpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A5CCC4CEF7;
	Thu, 26 Mar 2026 00:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774484203;
	bh=K59JVsZzzV61i6IGo6VkFRuwNYRboTvCPXe3QuBREyA=;
	h=From:To:Cc:Subject:Date:From;
	b=oNGuLDpe7lcS5xTSjWqewWtNgbkZX/K7vBnln5+Gr1O/BYVkgSkSoF47bFLOLWQ9a
	 D68Rt97a9Ra64wBhbDS7MTtGdDAyt20KmqfzvZNLytmyNrce34fGg7gob0Tb5HF7ph
	 pLHpa/z+YGh6Uh/Va1/Dw1bqLSysPM+lgzHqPHvz8J13QWN4ElSzuHt2uns9yEFFj8
	 EXMMg0iUkpza0hN1Xew8Oth6kmir9DKc6L14GqQ+WtyUtP8KwhWjdkOVg02FIRHbyF
	 TdmJ6AYQSoisTSApe13wESTv+3pBEHZkZQ8c7pE766JWtfLd/DfacEWDOvYYCT9YFO
	 VLqro4Un8nrHw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Stephan Mueller <smueller@chronox.de>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 00/11] Stop pulling DRBG code into non-FIPS kernels
Date: Wed, 25 Mar 2026 17:14:56 -0700
Message-ID: <20260326001507.66500-1-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22390-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 243DA32D91F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Most kernels have CRYPTO_FIPS=n but still include crypto/drbg.c and
everything it depends on, including crypto/jitterentropy.c.

This dependency bloat happens because some kernel code gets random bytes
from "stdrng" in the crypto_rng API instead of from get_random_bytes().
(This is apparently done for FIPS certification reasons.)  Then, that
pulls crypto/drbg.c to provide a "stdrng" implementation.

This series fixes the dependency bloat by making "stdrng" be used only
in FIPS mode, and get_random_bytes_wait() be used otherwise.

This series is targeting cryptodev/master.

Eric Biggers (11):
  crypto: rng - Add crypto_stdrng_get_bytes()
  crypto: dh - Use crypto_stdrng_get_bytes()
  crypto: ecc - Use crypto_stdrng_get_bytes()
  crypto: geniv - Use crypto_stdrng_get_bytes()
  crypto: hisilicon/hpre - Use crypto_stdrng_get_bytes()
  crypto: intel/keembay-ocs-ecc - Use crypto_stdrng_get_bytes()
  net: tipc: Use crypto_stdrng_get_bytes()
  crypto: rng - Unexport "default RNG" symbols
  crypto: rng - Make crypto_stdrng_get_bytes() use normal RNG in
    non-FIPS mode
  crypto: fips - Depend on CRYPTO_DRBG=y
  crypto: rng - Don't pull in DRBG when CRYPTO_FIPS=n

 crypto/Kconfig                                |  9 +------
 crypto/dh.c                                   |  8 +-----
 crypto/ecc.c                                  | 11 +++-----
 crypto/geniv.c                                |  8 +-----
 crypto/rng.c                                  | 23 ++++++++++++-----
 drivers/crypto/hisilicon/hpre/hpre_crypto.c   | 12 ++-------
 .../crypto/intel/keembay/keembay-ocs-ecc.c    | 17 +++----------
 include/crypto/rng.h                          | 25 ++++++++++++++++---
 net/tipc/crypto.c                             | 13 ++--------
 9 files changed, 53 insertions(+), 73 deletions(-)


base-commit: f9bbd547cfb98b1c5e535aab9b0671a2ff22453a
-- 
2.53.0


