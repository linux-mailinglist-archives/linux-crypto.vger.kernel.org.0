Return-Path: <linux-crypto+bounces-22426-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB8NF2pcxWkk9gQAu9opvQ
	(envelope-from <linux-crypto+bounces-22426-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 17:18:50 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C53FF3383D2
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 17:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E2EB1305043B
	for <lists+linux-crypto@lfdr.de>; Thu, 26 Mar 2026 16:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91769405AC9;
	Thu, 26 Mar 2026 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="edAuSkWd"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521B03FD145;
	Thu, 26 Mar 2026 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774541493; cv=none; b=r1oQLDqQdE4nXhhkVkY1vbTG5f2JgNfPdFf52+pzyYjLQ/0nTRNv0Tx2tMKnzZjr3EuA1fSMPL9aO61H8OIfibCOZ5W8mhfdQ2S0UMG3ZpVPQuAAfKDtmBiQpP150z72GYujyWoYoKSFBk162Lt/3AaRl6bJvo/jJQsGRYodJoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774541493; c=relaxed/simple;
	bh=pkHTwRFyGNsFd4p90+p/vdU1PYwXFRrGlPHvWZ/L1sA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=av5fQ3bQVe9oINslPcwRxc3JgR/jN22b5q8jZg6uCaLUc9zM5DHjmcUeaPYbebsoEr8QLhBSpRvKWvwOcGlrgTVmnIcvwPsOaJ8XRos5gTK/ymxMu/qbZ17DwcXlMyY/7hMzpcZMEC68wU03BqRfIHoxGUjlT6M7XYdOR5x6XCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=edAuSkWd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A021C116C6;
	Thu, 26 Mar 2026 16:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774541492;
	bh=pkHTwRFyGNsFd4p90+p/vdU1PYwXFRrGlPHvWZ/L1sA=;
	h=From:To:Cc:Subject:Date:From;
	b=edAuSkWdfLtX+rorPdrGxEh6Uy0E2DGoFj9Eu8GqRIqXufFA8oP4mlQ1aoz+orhBt
	 Vaio5pkB81E6vGql3A83apMdG74Wr7k0Y2ewqF2I8MBir/u0rFkiJvcfGIKASprsMs
	 1YQ3zCjwReUOOxPyWU6CNEaZQ/elc4rSINvGj3xLAvjA8OwnpjQRP6Qv38e5CIxKnt
	 PkIW2rldMZHkBpVRkSjMUTM6oorTn3G0s9qyAtkfB3jmZ4dLBLEpcDYkW1kRc0k4CF
	 Zg7KTX+uEwFFoaFgh4YUaQQCxXPGpXUGpqmLqfs08Cnz444rWjM97u4H3W1rCGimSM
	 roY8yLrddKUOg==
From: Tycho Andersen <tycho@kernel.org>
To: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	John Allen <john.allen@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Ard Biesheuvel <ardb@kernel.org>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Kishon Vijay Abraham I <kvijayab@amd.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Kim Phillips <kim.phillips@amd.com>,
	Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	"Tycho Andersen (AMD)" <tycho@kernel.org>
Subject: [PATCH v5 0/7] Move SNP initialization to the CCP driver
Date: Thu, 26 Mar 2026 10:11:03 -0600
Message-ID: <20260326161110.1764303-1-tycho@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22426-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MAILSPIKE_FAIL(0.00)[172.105.105.114:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tycho@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C53FF3383D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Tycho Andersen (AMD)" <tycho@kernel.org>

The sole change is to add a cpus_read_lock/unlock() to snp_prepare().

v4 is here: https://lore.kernel.org/all/20260324161301.1353976-1-tycho@kernel.org/

Thanks,

Tycho

Tom Lendacky (2):
  x86/sev: Create a function to clear/zero the RMP
  crypto/ccp: Update HV_FIXED page states to allow freeing of memory

Tycho Andersen (AMD) (5):
  x86/sev: Create snp_prepare()
  x86/sev: Create snp_shutdown()
  x86/sev, crypto/ccp: Move SNP init to ccp driver
  x86/sev, crypto/ccp: Move HSAVE_PA setup to arch/x86/
  crypto/ccp: Implement SNP x86 shutdown

 arch/x86/include/asm/sev.h   |   4 ++
 arch/x86/virt/svm/sev.c      | 113 ++++++++++++++++++++++++-----------
 drivers/crypto/ccp/sev-dev.c |  62 ++++++++++---------
 include/linux/psp-sev.h      |   5 +-
 4 files changed, 122 insertions(+), 62 deletions(-)


base-commit: 2ca26dad836fb4cd18694ef85af7a71d2878b239
-- 
2.53.0


