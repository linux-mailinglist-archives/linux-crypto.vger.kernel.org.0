Return-Path: <linux-crypto+bounces-22106-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFBaHQ8iu2lofQIAu9opvQ
	(envelope-from <linux-crypto+bounces-22106-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 18 Mar 2026 23:07:11 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E0C22C3426
	for <lists+linux-crypto@lfdr.de>; Wed, 18 Mar 2026 23:07:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D72B3127BEB
	for <lists+linux-crypto@lfdr.de>; Wed, 18 Mar 2026 22:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C3C36212C;
	Wed, 18 Mar 2026 22:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DYkFPIxS"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0358435B646;
	Wed, 18 Mar 2026 22:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773871614; cv=none; b=XLkwSlySrPp2VuNBaMlLMoXvACwVU6/1QNhpqFtQzCLOmEweLNcjR3Yrg+Ypla4eL+f/QNzQ+azAY7EmuUKPvNJplWZ1WVDk0f/EwetWvk1bVEUSUDxrpLz4ppqwiiotRdOa/oQzO09LMMl3Hhgc9sa2sRK/uepSnbZVB9J8FZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773871614; c=relaxed/simple;
	bh=myYDQPfL7BX7R/7XPXrIO62UyPU6hLCTkqBaE/PS850=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EOpQ0lX/jr2rb8pgc8hYxGNh09JFrfC77Djfu9TxJGbQJbZXA3zfOoxfOHfY92vScd4FriysNGi0eSlxxmnWSM1SJpdXoZshL0WczsUo81cEHXJB6UzC19ErQn4J3Iwg5httuM3EuxF/Tqi9eyAYF04vabg2avhx+EUOn3qpxj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DYkFPIxS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25A60C19424;
	Wed, 18 Mar 2026 22:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773871613;
	bh=myYDQPfL7BX7R/7XPXrIO62UyPU6hLCTkqBaE/PS850=;
	h=Date:From:To:Cc:Subject:From;
	b=DYkFPIxSdmAoZR/uSO6IbNabdf7XT1aGYRRFv1Dgm1yOlDEcayHcT2gaki+BIber7
	 cqx8GCgIAK32OiYiMvjTYgDLv3Wm+IjmqHdXn3gcqfcQk8Us0MaDe8+XyJZwWgW1NE
	 mRRYSEGLhCxooWubPV9vgVU4Bmdch/4QZxqJ+Ri7JxG73XClRZinnbMhhwkCnCQ0UV
	 KdG9Oyydq+yiH8Uqjv3tk0fNVKEZhH5jTUAjeUlECyHrISvYmxA8quomj7Q1ZEI2zM
	 OeZJEn/ilpdY6mioD+T+SDW97Ppp4YfHa7E2cxRmrICMmoCJphGlm618nbqnze/ukK
	 9JVTm5F4YhQdg==
Date: Wed, 18 Mar 2026 15:06:51 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	AlanSong-oc <AlanSong-oc@zhaoxin.com>,
	Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: [GIT PULL] Crypto library fixes for v7.0-rc5
Message-ID: <20260318220651.GA2177@quark>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,zx2c4.com,gondor.apana.org.au,zhaoxin.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-22106-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.975];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E0C22C3426
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following changes since commit 1f318b96cc84d7c2ab792fcc0bfd42a7ca890681:

  Linux 7.0-rc3 (2026-03-08 16:56:54 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git tags/libcrypto-for-linus

for you to fetch changes up to d5b66179b0e27c14a9033c4356937506577485e3:

  lib/crypto: powerpc: Add powerpc/aesp8-ppc.S to clean-files (2026-03-17 09:27:11 -0700)

----------------------------------------------------------------

- Disable the "padlock" SHA-1 and SHA-256 driver on Zhaoxin
  processors, since it does not compute hash values correctly.

- Make a generated file be removed by 'make clean'.

- Fix excessive stack usage in some of the arm64 AES code.

----------------------------------------------------------------
AlanSong-oc (1):
      crypto: padlock-sha - Disable for Zhaoxin processor

Cheng-Yang Chou (1):
      crypto: arm64/aes-neonbs - Move key expansion off the stack

Eric Biggers (1):
      lib/crypto: powerpc: Add powerpc/aesp8-ppc.S to clean-files

 arch/arm64/crypto/aes-neonbs-glue.c | 37 +++++++++++++++++++++++--------------
 drivers/crypto/padlock-sha.c        |  7 +++++++
 lib/crypto/Makefile                 |  3 +++
 3 files changed, 33 insertions(+), 14 deletions(-)

