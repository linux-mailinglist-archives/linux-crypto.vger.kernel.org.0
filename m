Return-Path: <linux-crypto+bounces-22825-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBZMNZpD1WmE3wcAu9opvQ
	(envelope-from <linux-crypto+bounces-22825-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 07 Apr 2026 19:49:14 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3713B291B
	for <lists+linux-crypto@lfdr.de>; Tue, 07 Apr 2026 19:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C71E5300A25A
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Apr 2026 17:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6DA034A3B1;
	Tue,  7 Apr 2026 17:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRjbX9+W"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944E033C52F;
	Tue,  7 Apr 2026 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775584145; cv=none; b=NVs1cqCD6oOr0AYGDjKvuBwNzyTTS1B5FmQXINZvu6cOeI8P06vY90s2w8ePeqzvYrvQpveP2F/J6/Xq5R/u9LAw9J5wiKrNURXCJ4yq1fobmpcbMLGvY4Sl9n6B4D98iCxDJewU8+BdPm8VNeyWofhJ18eyvMWHtw1qiJuKxOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775584145; c=relaxed/simple;
	bh=FoRWT1w51xl6bRtE0JavfCiLUQUXEkZHllhk85PFQYM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k7kdthNnrYEzc2cOSPn8o3BNcupx8OiA76k/mAz8rQknPCma72CdL98J44C8eHmBDeIc77DVp6jvWZTUJ8AYWDCssTfLiyJM4BKc9xNSUYp+LRUKFXCW7Oc339Dm8VJ2RPKVaRUpNsLK8KHCjYNDBtTSK+1xk5PJ3hagPz/X8DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRjbX9+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980ACC116C6;
	Tue,  7 Apr 2026 17:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775584144;
	bh=FoRWT1w51xl6bRtE0JavfCiLUQUXEkZHllhk85PFQYM=;
	h=From:To:Cc:Subject:Date:From;
	b=sRjbX9+W25DVc5weQUQLcqh2uwYP37Kp5nA0G7HfoTbXLGS7l41WFzFADtSRzzjQj
	 fDYnQGrxUTGjdv7alGTd9q7UeQuhKoD50b69LClx8iHsZYaJJTKOUXgd1K0Sd0SQCD
	 jQPdhwlRIR2arPU1SfhcpQoN3VNF9kRWoagV7+cuQ0q2ybgzvNZAkbi4S/zDT7wLHn
	 ohFmUm1EgOVPEUPJI8hecPtGq6hMFbe1j3/Orvdw2UN5VQjMwmSt0iuXdbLoMZ75Qd
	 3sXWWYHOAAVF7BgEbg/DkY2EWMUuufC3xnk9+xs8EyNxvpaH27huOOd/3RzyFGYxSY
	 97tX8tGFJoxOg==
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
Subject: [PATCH v2 0/2] Skip SNP initialization if CPUs are offlined
Date: Tue,  7 Apr 2026 11:47:11 -0600
Message-ID: <20260407174713.439474-1-tycho@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22825-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tycho@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD3713B291B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Tycho Andersen (AMD)" <tycho@kernel.org>

Here's a v2 of the series. Changes are:

* propagate the error from snp_prepare() through __sev_snp_init_locked()
* use cpus_present_mask instead of cpus_possible_mask to reason about
  the set of available CPUs
* print the CPU masks for easier debugging

It turns out that CONFIG_INIT_ALL_POSSIBLE is not user-settable, and
only parisc selects it, so it shouldn't be a problem here.

v1 is here: https://lore.kernel.org/all/20260401143552.3038979-1-tycho@kernel.org/

Tycho Andersen (AMD) (2):
  x86/sev: Do not initialize SNP if missing CPUs
  crypto/ccp: Skip SNP_INIT if preparation fails

 arch/x86/include/asm/sev.h   |  4 ++--
 arch/x86/virt/svm/sev.c      | 15 +++++++++++++--
 drivers/crypto/ccp/sev-dev.c |  4 +++-
 3 files changed, 18 insertions(+), 5 deletions(-)


base-commit: 6c927e5ca9d238f8ae40b453a8382eb9cf4ee855
-- 
2.53.0


