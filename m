Return-Path: <linux-crypto+bounces-22213-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +I/CCgglv2nlwQMAu9opvQ
	(envelope-from <linux-crypto+bounces-22213-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 22 Mar 2026 00:08:56 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BB22E7939
	for <lists+linux-crypto@lfdr.de>; Sun, 22 Mar 2026 00:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B9EF3016532
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 23:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284C72F6562;
	Sat, 21 Mar 2026 23:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WXQVOJop"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED1314AD20;
	Sat, 21 Mar 2026 23:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774134497; cv=none; b=lt+4L0+ljqhxJXIi8MJePXmhaU0WroaKjbwr7IBBOFuIF6AeJ7ehJRh1ald3RN7zhJfpTW686cGGu0A4ACt85GYHSRTgVcT484BAXMASqWZCYHKZ31FpVi5SRQKo629H9wcIr2XPo/Bt9sf3IE5bjIpfURAFLH7ptbKN9dKnMu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774134497; c=relaxed/simple;
	bh=Q+UxJ8y0OIew0cFPIsir5O3E8qXeRaINwla8pZMpFKo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k3xWnfVNP02KD3W6mti55gYrBSJYqoEgv1QLdwofLIWugocJWEXZUNbi/q6sqgTB+gHjpVBqRkKufwLD83hMsgBvAiZaXbo+dyLarrekC85TaPYZb0KEI53Ek3ygPAAQy/4ITRWWV+Mu8qCAuDsDckOZuD7b8D6BlDNMttUh+Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WXQVOJop; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41C8EC19421;
	Sat, 21 Mar 2026 23:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774134496;
	bh=Q+UxJ8y0OIew0cFPIsir5O3E8qXeRaINwla8pZMpFKo=;
	h=From:To:Cc:Subject:Date:From;
	b=WXQVOJopk4EGJsXzw5kvAkWSoNxCQs9SO4IM6F7xQ6K9Li7obs+dDuc+jW8UiGDAG
	 oqyeRelo1JyhvU8HpBNArjipvoQ9+dMGISp9HZlRdkOeJg8LiJtrWmh/SomJycU1cr
	 vzbP5o09xKWkBudxcJjV0kBRvVMPfQSBRzfasXz6ttSQVsHjDX/Rg2kpvNHaYV1QHD
	 77QwLeys0hjXVqaKGL5Eh3BTOEUCv5SrCl7pQBC+drnr8S3I2xOp7fYvMJhS1mwRdk
	 mKR8xBzoVRlMBYqGUKymAUI1PtQAqX018lSS1zpN5DCtB11BXYJt44Tw6/b2wuDaF7
	 utINoZTRITMpw==
From: Eric Biggers <ebiggers@kernel.org>
To: dm-devel@lists.linux.dev
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 0/2] dm-crypt: Reimplement elephant diffuser using AES library
Date: Sat, 21 Mar 2026 16:06:49 -0700
Message-ID: <20260321230651.89081-1-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22213-lists,linux-crypto=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1BB22E7939
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series simplifies and optimizes dm-crypt's implementation of
Bitlocker's "elephant diffuser" to use the AES library instead of an
"ecb(aes)" crypto_skcipher.

This series is targeting linux-dm/for-next

Eric Biggers (2):
  dm-crypt: Reimplement elephant diffuser using AES library
  dm-crypt: Make crypt_iv_operations::wipe return void

 drivers/md/Kconfig    |   1 +
 drivers/md/dm-crypt.c | 103 ++++++++++++++----------------------------
 2 files changed, 36 insertions(+), 68 deletions(-)


base-commit: 23e6e57a93bcabe86d5f0eab1df0c44706ab18f3
-- 
2.53.0


