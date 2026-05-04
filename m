Return-Path: <linux-crypto+bounces-23675-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QAdzLL7O+GlT1AIAu9opvQ
	(envelope-from <linux-crypto+bounces-23675-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 04 May 2026 18:52:14 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 069864C1985
	for <lists+linux-crypto@lfdr.de>; Mon, 04 May 2026 18:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3220A30265A6
	for <lists+linux-crypto@lfdr.de>; Mon,  4 May 2026 16:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B2A3E3C5D;
	Mon,  4 May 2026 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7QOHsjh"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DEE3783C7;
	Mon,  4 May 2026 16:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777913530; cv=none; b=AswhfJ2MMj/3kC4O2FTf0wpBZlUYaF5f5AA3TLhQbe4VcbHI5djk25Ij3OwZbl+iE8TpWyuB4YmvujSbWEE+Anwi4hJT4C7DT7d/Qe8XwkVSGGyQfoJFgBQD4pOOzyJ+p89+Xz0cX6iJeP7R+QpeU52/2fw+cvc2pJYQaB4zRUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777913530; c=relaxed/simple;
	bh=ZWrFTZDdVscuaXyVwTCApSTSuzmOfw24NQRySmZG/kg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qD5nYlLVpVAbOboUdcSWmzAgfIBozYH/BS3A9virEvPy+FfpDN0capIzBWCs6juGbtYmHj+rRQTsP23ekegtWLqY6vGskaVHPuOLgBdFR5icuBag8vOSiVBtflWERDeFzQnj+Qa6BhXijuFouPLkUoLGIqQjfxQl7hpsWTnKStI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7QOHsjh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67005C2BCB8;
	Mon,  4 May 2026 16:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777913529;
	bh=ZWrFTZDdVscuaXyVwTCApSTSuzmOfw24NQRySmZG/kg=;
	h=From:To:Cc:Subject:Date:From;
	b=j7QOHsjhF3dUEROVqDk975aydxVWD4W4QbJBxFeZT9JdYvHuJc64AtnS+71hnl5oP
	 /UdhNLFEt+dkX3lc1MmGS1a9x8ys827DSS49MI43UcVeE60HMJHTAk6/mPWcJkl3FD
	 ua3YQYUr6X1RXnYTc/umD/xioyZqgf5NUJfRj8kNZt5Qs0v/sflKRYOG2/ZLkbHFFF
	 n5J18cozkt1+vq5NGz22xRpiJOygtSw0JutvX5R4chE+99VOAalBperyOwgKN8fMb5
	 0UuWBu+0miz63VJCxGeLkykPrOa619OYPuSh9grItnMOWsz/K6pqrQ37LpklBOWFAD
	 iur3q3WT0Uqxg==
From: Tycho Andersen <tycho@kernel.org>
To: Tom Lendacky <thomas.lendacky@amd.com>,
	John Allen <john.allen@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Ashish Kalra <ashish.kalra@amd.com>
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Brijesh Singh <brijesh.singh@amd.com>,
	Michael Roth <michael.roth@amd.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	"Tycho Andersen (AMD)" <tycho@kernel.org>
Subject: [PATCH v2 0/4] SEV re-initialization fixes
Date: Mon,  4 May 2026 10:51:43 -0600
Message-ID: <20260504165147.1615643-1-tycho@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 069864C1985
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23675-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tycho@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

From: "Tycho Andersen (AMD)" <tycho@kernel.org>

Here is a v2 of the HSAVE_PA clearing fixes. Changes are:

* return ENODEV instead EINVAL for the re-init cases
* note ABI breakage in patch 3's commit log
* CC stable on all the patches

v1 is here: https://lore.kernel.org/all/20260427161507.32686-1-tycho@kernel.org/

Thanks,

Tycho

Tycho Andersen (AMD) (4):
  crypto/ccp: Do not initialize SNP for SEV ioctls
  crypto/ccp: Do not initialize SNP for ioctl(SNP_COMMIT)
  crypto/ccp: Do not initialize SNP for ioctl(SNP_VLEK_LOAD)
  crypto/ccp: Do not initialize SNP for ioctl(SNP_CONFIG)

 drivers/crypto/ccp/sev-dev.c | 70 ++++++------------------------------
 1 file changed, 11 insertions(+), 59 deletions(-)


base-commit: 7fd2df204f342fc17d1a0bfcd474b24232fb0f32
-- 
2.54.0


