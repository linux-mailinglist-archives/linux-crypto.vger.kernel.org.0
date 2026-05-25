Return-Path: <linux-crypto+bounces-24571-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC3WLf2YFGoUOwcAu9opvQ
	(envelope-from <linux-crypto+bounces-24571-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 25 May 2026 20:46:21 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D1DC5CDC66
	for <lists+linux-crypto@lfdr.de>; Mon, 25 May 2026 20:46:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 965413007367
	for <lists+linux-crypto@lfdr.de>; Mon, 25 May 2026 18:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0143822A3;
	Mon, 25 May 2026 18:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d5DZcuwy"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA00380FD0;
	Mon, 25 May 2026 18:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779734772; cv=none; b=ptW7D0wpRAFsIxXWdddjw1Fp/NXwGL4/CaVobTojvj8jaE59Gu9a+Fm9Z/chqUX96GckpXLRqb/X6oTU4O0bcj6pgxJu622MbNmrfsxtdvL2CBSVDJjKuyHbe087j1uWwXmY7Rp+Jt8GpdhPu/HKGw9gJiFhiSItfv9++h2MxPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779734772; c=relaxed/simple;
	bh=FezIn1FuVgAszVdQ0Ob4HwusSq6J3dngJo2PX54D4wY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RIuz3lgHt+FkO7KePXqlN4yOosKxs/7CInH1dyUyHBZ/dLXAeAAZc7UkI9UAtdOoVKpPDIMtlHZYg8M+dPUifDifc0WXgsOsmk1OxSN4jKz3F1FN+PxUDZbA3GBeyPUIUfrua7q7cJyqD/HJxgpIPt/eRfnmIlkvhpcmgjBAYdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d5DZcuwy; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008CE1F000E9;
	Mon, 25 May 2026 18:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779734770;
	bh=OFhCvtl+ykJd4rDZbBcd9Upc+uQ9FINCRicaxol1Zfg=;
	h=From:To:Cc:Subject:Date;
	b=d5DZcuwyBtPfFvjvQfpOvZnwQDgAT+BJXpMLwQ69okJOYv5n0Mbnz7rhNtV/TwSpB
	 uy0JcFIvWIUHxlGu5o8nJFY/4tzhjjjc8cdY35i2WMJIqadunyiZ/xsE5PtPZrkn2y
	 7F4R+569Lq2YCHZG0WP4S+0+43lexrCA97SlDLKfS27IAH+k58E1jKqhlgOedmwnlC
	 2heF4Uad841zDq2t7X32s5k9lIOK03qK6pGKx2MqSsaeONyNArk5bR0RYp9LEqsjez
	 QCOgNx6+od8v7HbG1nBno9K7OtwsB3lbwaf4nSmzufpGKPp6LxtDe+m6Ke7sWc+4u+
	 ox++IWoIEwfaQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ryan Appel <ryan.appel.333@gmail.com>,
	Chris Leech <cleech@redhat.com>,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 0/5] ML-KEM and X-Wing support
Date: Mon, 25 May 2026 13:43:58 -0500
Message-ID: <20260525184403.101818-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,zx2c4.com,gondor.apana.org.au,gmail.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-24571-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 2D1DC5CDC66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series applies to v7.1-rc5.  It is a proof-of-concept that won't be
merged until there is an in-kernel user.  Multiple people have been
asking about this though, so I wanted to get ahead of the curve and
provide something that people can experiment with if needed.

This series adds support for "post-quantum" (i.e. quantum-resistant) key
encapsulation to the kernel's crypto library.  Specifically this
includes ML-KEM-768 and ML-KEM-1024, and the X-Wing hybrid KEM built on
top of it.  The ML-KEM functions are put in the CRYPTO_INTERNAL
namespace, as they will be used only as a component of hybrid KEMs.

It's likely this will eventually be useful for at least one of the
in-kernel users of classical key agreement schemes (currently NVMe
authentication, Bluetooth, and WireGuard).  However, the details of the
upgrade to "post-quantum" will be up to the protocol authors in each
case.  I suggest that X-Wing be chosen when possible.

Eric Biggers (5):
  lib/crypto: mlkem: Add ML-KEM-768 and ML-KEM-1024 support
  lib/crypto: mlkem: Add KUnit tests for ML-KEM
  lib/crypto: mlkem: Add FIPS 140-3 tests
  lib/crypto: xwing: Add support for X-Wing KEM
  lib/crypto: xwing: Add KUnit tests for X-Wing KEM

 Documentation/crypto/libcrypto-asymmetric.rst |   27 +
 Documentation/crypto/libcrypto-signature.rst  |   11 -
 Documentation/crypto/libcrypto.rst            |    2 +-
 include/crypto/mlkem.h                        |  159 +++
 include/crypto/xwing.h                        |   84 ++
 lib/crypto/.kunitconfig                       |    2 +
 lib/crypto/Kconfig                            |   17 +
 lib/crypto/Makefile                           |   10 +
 lib/crypto/fips-mlkem.h                       |  523 +++++++++
 lib/crypto/mlkem.c                            | 1036 +++++++++++++++++
 lib/crypto/tests/Kconfig                      |   18 +
 lib/crypto/tests/Makefile                     |    2 +
 lib/crypto/tests/mlkem-testvecs.h             |   19 +
 lib/crypto/tests/mlkem_kunit.c                |  520 +++++++++
 lib/crypto/tests/xwing-testvecs.h             |  138 +++
 lib/crypto/tests/xwing_kunit.c                |  129 ++
 lib/crypto/xwing.c                            |  237 ++++
 scripts/crypto/import-mlkem-testvecs.py       |  179 +++
 scripts/crypto/import-xwing-testvecs.py       |  111 ++
 19 files changed, 3212 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/crypto/libcrypto-asymmetric.rst
 delete mode 100644 Documentation/crypto/libcrypto-signature.rst
 create mode 100644 include/crypto/mlkem.h
 create mode 100644 include/crypto/xwing.h
 create mode 100644 lib/crypto/fips-mlkem.h
 create mode 100644 lib/crypto/mlkem.c
 create mode 100644 lib/crypto/tests/mlkem-testvecs.h
 create mode 100644 lib/crypto/tests/mlkem_kunit.c
 create mode 100644 lib/crypto/tests/xwing-testvecs.h
 create mode 100644 lib/crypto/tests/xwing_kunit.c
 create mode 100644 lib/crypto/xwing.c
 create mode 100755 scripts/crypto/import-mlkem-testvecs.py
 create mode 100755 scripts/crypto/import-xwing-testvecs.py


base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
-- 
2.54.0


