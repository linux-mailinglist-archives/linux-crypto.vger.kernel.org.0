Return-Path: <linux-crypto+bounces-21647-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MC7MGyBNqmmIOwEAu9opvQ
	(envelope-from <linux-crypto+bounces-21647-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 06 Mar 2026 04:42:24 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C657D21B3CD
	for <lists+linux-crypto@lfdr.de>; Fri, 06 Mar 2026 04:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D38C7302AC30
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Mar 2026 03:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F59936C0C0;
	Fri,  6 Mar 2026 03:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsniiPds"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D30366801;
	Fri,  6 Mar 2026 03:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772768296; cv=none; b=pwEXF5dZxPknKyl191MUydUWY4j2q/2vqu0kPhvSNqPa0xaF282I2y5Z6Az0jrLeIwM9Ei8x0K2B5fXTjKaDv6lWB5q/rhIvTtOeIzUsNQhnBal2fWTXyu1UNXagWzVD/qvAGwsCY45CXAfU10Scsv5Gk9niAYtJuVgVE3gqsGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772768296; c=relaxed/simple;
	bh=j5OSSfhjq4fzEZ8ikkY59xts3gjsKQZ/pEYxs6sL9l0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y9oHz+O4/0MDTzTXFMP3OzabNf9BFeaTP60/+yhu28V7PmoJK1ZIhoIMjmaUiVDN2jGjrRHvLrhs9OF3Pj8QzGNkhz9rcmrFCQxOcZUhFShzuwLJ0cMm8hmdIeUyAHbbioWk8lC4aKQSitvaHbAZaIGwkP8Qc6W1SCun0CngX4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsniiPds; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58A95C116C6;
	Fri,  6 Mar 2026 03:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772768295;
	bh=j5OSSfhjq4fzEZ8ikkY59xts3gjsKQZ/pEYxs6sL9l0=;
	h=From:To:Cc:Subject:Date:From;
	b=NsniiPdstav/u8s8l/0evYSRb2ZuXrMwP7HD9fu1nojsy3Lo8gFDwdlwYVH44qxP/
	 EIAliHRHMeiTpYDIFbC4+u0uznJKWalclF5/Psa2bTMyIn1pZHQENmYMKOsCKVxzj7
	 6FyFBSzWjedRFvsRIplgkxfFFEN+ZvgEh2D6EH5ytPP5tIJFy4kSODx2Oqa7H+myod
	 J2sQPDqu3Vqyv8mM2eZqLjdPTwOtObRLGSs5w6+uX/R/QcuNlrdw9xjERD3DfFZva6
	 dEFHnEfujlkMARer/PMr3xrkycomkaQO8TM+m24V/HIHVzqghG6PB5jbwCUfqDwgT0
	 P8zd9FsnlrNtQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>,
	kunit-dev@googlegroups.com,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 0/3] lib/crc: Fix crc_kunit dependency and add kunitconfig
Date: Thu,  5 Mar 2026 19:35:54 -0800
Message-ID: <20260306033557.250499-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C657D21B3CD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-21647-lists,linux-crypto=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

This series fixes crc_kunit to follow the standard KUnit convention of
depending on the code it tests rather than selecting it, adds a kconfig
option that enables all the CRC variants for KUnit testing, and adds a
kunitconfig file for lib/crc/.

This follows similar changes to lib/crypto/ (except lib/crypto/ doesn't
have an equivalent to CRC_ENABLE_ALL_FOR_KUNIT yet, but we could
consider adding one).

This series applies to v7.0-rc2 and is targeting crc-next.

Eric Biggers (3):
  lib/crc: tests: Make crc_kunit test only the enabled CRC variants
  lib/crc: tests: Add CRC_ENABLE_ALL_FOR_KUNIT
  lib/crc: tests: Add a .kunitconfig file

 lib/crc/.kunitconfig      |  3 +++
 lib/crc/Kconfig           | 17 +++++++++++++----
 lib/crc/tests/crc_kunit.c | 28 ++++++++++++++++++++++------
 3 files changed, 38 insertions(+), 10 deletions(-)
 create mode 100644 lib/crc/.kunitconfig


base-commit: 11439c4635edd669ae435eec308f4ab8a0804808
-- 
2.53.0


