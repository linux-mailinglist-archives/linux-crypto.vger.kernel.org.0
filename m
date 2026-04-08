Return-Path: <linux-crypto+bounces-22867-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOSoMZ9o1mnIEwgAu9opvQ
	(envelope-from <linux-crypto+bounces-22867-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 08 Apr 2026 16:39:27 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FCC3BDC5A
	for <lists+linux-crypto@lfdr.de>; Wed, 08 Apr 2026 16:39:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6480E3014679
	for <lists+linux-crypto@lfdr.de>; Wed,  8 Apr 2026 14:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE9E93D3CEA;
	Wed,  8 Apr 2026 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzPHwyzM"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C6D3BB9F3;
	Wed,  8 Apr 2026 14:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658843; cv=none; b=HkjLa7O8BwS/+aidJZAQut61kSbnYMbMUQAdcHFlXB9DfO8u1Uxa7dvk75uoah8YWoBqjJx3VkbN2ZKni1trmAdVFGZciXzbDikEkmAHjPgYxZoN9LFGjejGfF9SCeg0MYhCqGEAZjxYZPHFCiIBqLeoPwC8EwlOEp96yFNCuWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658843; c=relaxed/simple;
	bh=K5SIMTCXvgcNydcdRTbdOt/nfNzcHhHraJgw/j2Vvgc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M5BNoyVaNL0To/rJcp6sR+1VZ35gritlwmk/NeK3HKu6DsAILb9s9GPTmI8/y9L2BDFqly5r5n7rkfXQdznqJDmDCZBnNOIGIxjsJhO0CvwksZLUzteEXA5YhMf5sQJMvLooATjWZwupZMieL4xy9tkB9I+WtdtLj1f7ZgxxIHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzPHwyzM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAE35C19421;
	Wed,  8 Apr 2026 14:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775658843;
	bh=K5SIMTCXvgcNydcdRTbdOt/nfNzcHhHraJgw/j2Vvgc=;
	h=From:To:Cc:Subject:Date:From;
	b=VzPHwyzMs/KnYJVB+HZ1din0CDuPwK5x+aZB9+VejW8ixikHIWq3aeO5jEkv0MRyV
	 RP2SHIAkMJa9vNd+M69yaZZcPXhWl82toBABvZA6ZWtxsbkrpNoC8AwdmB8oke4at1
	 15HKMn+wUp7jL4sRgm7NgNKvNklKRRvlvXGIXNdpezPXmKDecv2nA451mjCbKor5w2
	 mfgV5TWcu4P2lIL8hq8/t+JJsA2vKIB0D53p0Hs4IQBsYK4dTgzA5Xp9gTBMlTCwlJ
	 cLozvTcvweB0jN9OnpJJlBCCHeYu3d34+DKVDAW/XzYPM/eKbWF3zHTeCqX3ZofoBG
	 U66SV8zEky0nw==
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
Subject: [PATCH v1 0/4] Fix some bugs in the CCP driver
Date: Wed,  8 Apr 2026 08:32:55 -0600
Message-ID: <20260408143259.602767-1-tycho@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22867-lists,linux-crypto=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26FCC3BDC5A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Tycho Andersen (AMD)" <tycho@kernel.org>

This set of fixes came out of using various AI tools on the SNP shutdown
series:
https://lore.kernel.org/all/20260326161110.1764303-1-tycho@kernel.org/

I'm not quite sure how to cite these tools yet, checkpatch complained a
bit about my citations here. Happy to respin if there's a better way. It
looks like e.g. Assisted-by in the process of being added:
https://lore.kernel.org/all/20260302143659.41882-1-thomas.hellstrom@linux.intel.com/

Thanks,

Tycho

Tycho Andersen (AMD) (4):
  crypto/ccp: Reverse the cleanup order in psp_dev_destroy()
  crypto/ccp: Fix snp_filter_reserved_mem_regions() off-by-one
  crypto/ccp: Check for page allocation failure correctly in TIO
  crypto/ccp: Initialize data during __sev_snp_init_locked()

 drivers/crypto/ccp/psp-dev.c |  8 ++++----
 drivers/crypto/ccp/sev-dev.c | 23 +++++++++++++----------
 2 files changed, 17 insertions(+), 14 deletions(-)


base-commit: 6c927e5ca9d238f8ae40b453a8382eb9cf4ee855
-- 
2.53.0


