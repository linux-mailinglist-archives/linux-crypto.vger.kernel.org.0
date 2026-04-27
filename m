Return-Path: <linux-crypto+bounces-23443-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2GuuIR/M72knGAEAu9opvQ
	(envelope-from <linux-crypto+bounces-23443-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Apr 2026 22:50:39 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7096547A44E
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Apr 2026 22:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B9FF7300E01A
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Apr 2026 20:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293B539282F;
	Mon, 27 Apr 2026 20:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AR5nK28r"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E25BF38E12B;
	Mon, 27 Apr 2026 20:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777323032; cv=none; b=WTl3S0lJPh8rfZQQCuktxv0FtKSptpALTRNBujNjJ/I4Tf1hYy8NcdfVcayvpNXi1KBJcQQT5xM6yGN1SjnmeMnUGj5p/kqKcF3aGxeKKsbjytv0vfYNrJjT9Es9VaRdj8YQcnjPKpGKImw8zf+LaGF5kRh2HGwls0fFJcymViM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777323032; c=relaxed/simple;
	bh=YcplgUGNh+6uS8l7gywBwx3+pe3RpQeIFHEmlCROLmQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oN0kOr0VDTqGX8vzzUGXBrjm+uTlo7Kd9w4w5scxSLMqMHWY9Igcu1d2gJyjel6Ta08GR5CcWXoLQvKLjX3o9WmLekN/+AJWxP+/+fgxt1VX1WrD82ZXayy9/3fkcadiy3/Q65jTdl9QgwoBcyyau6PckYME3F3/L1pbPjFCaIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AR5nK28r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F32C2BCB6;
	Mon, 27 Apr 2026 20:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777323030;
	bh=YcplgUGNh+6uS8l7gywBwx3+pe3RpQeIFHEmlCROLmQ=;
	h=From:To:Cc:Subject:Date:From;
	b=AR5nK28rneLZfiRZ/H81AA03VfzqOgBmqVslVQY6OlOQ7kr7/i5yfBuOzfvmc/xvH
	 yDGuir2sbON9pXZ6Mf8w5mpnIGhGmj7515yZTHVEm2WAnbwVz1UKx27J3TT41rI6Hr
	 j2komLlcXrSu153KET90JatLHBLSj/dQOyg/XiY+oRgmHlnlKSi/zOgDZGpwQ6XEn6
	 PwgkqE7V6grOkuASdRqArsOnDHZt0Mr+OO2gqrHPr0c2dZfyHmAPpnmC1Y54ZgWBOI
	 s2I3HQPGYRqNkqEDIuevJJpMoHTiU3hz4joLW7LdbEoyFCkJxLvdVEw3G6EsvL49SJ
	 ZwSEcVTVCcNMQ==
From: Tycho Andersen <tycho@kernel.org>
To: Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	John Allen <john.allen@amd.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Shuah Khan <shuah@kernel.org>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kim Phillips <kim.phillips@amd.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	"Tycho Andersen (AMD)" <tycho@kernel.org>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Dapeng Mi <dapeng1.mi@linux.intel.com>,
	Kees Cook <kees@kernel.org>,
	Marco Elver <elver@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Li RongQing <lirongqing@baidu.com>,
	Eric Biggers <ebiggers@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v2 0/4] Allow disabling RAPL during SNP initialization
Date: Mon, 27 Apr 2026 14:48:43 -0600
Message-ID: <20260427204847.112899-1-tycho@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7096547A44E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23443-lists,linux-crypto=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[34];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tycho@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

From: "Tycho Andersen (AMD)" <tycho@kernel.org>

The PLATYPUS (https://platypusattack.com/platypus.pdf) attack paper
offers method for exfiltration via a low-resolution side channel using
Running Average Power Limit. Newer versions of the SEV firmware offer a
way to freeze these counters while initialized, so export this as an
option.

Changes from v1:
* add a blurb from the platypus attack paper about the side channel
* move the kernel parameter from the ccp driver to kvm_amd to make it
  more obvious
* split off the SEV-ES feature detection into its own series:
  https://lore.kernel.org/all/20260416232329.3408497-1-seanjc@google.com/

v1 is here: https://lore.kernel.org/all/20260223162900.772669-1-tycho@kernel.org/

Tycho Andersen (AMD) (4):
  crypto/ccp: Pass init_args to __sev_snp_init_locked()
  crypto/ccp: Support setting RAPL_DIS in SNP_INIT_EX
  KVM: SEV: Add the kvm-amd.rapl_disable module parameter
  KVM: selftests: Add a smoke test support for RAPL_DIS

 .../admin-guide/kernel-parameters.txt         |  5 +++
 arch/x86/kvm/svm/sev.c                        |  8 +++++
 drivers/crypto/ccp/sev-dev.c                  | 35 +++++++++++++------
 include/linux/psp-sev.h                       |  2 ++
 tools/testing/selftests/kvm/include/x86/sev.h |  1 +
 .../selftests/kvm/x86/sev_smoke_test.c        | 24 ++++++++++++-
 6 files changed, 63 insertions(+), 12 deletions(-)


base-commit: 39f1c201b93f4ff71631bac72cff6eb155f976a4
-- 
2.53.0


