Return-Path: <linux-crypto+bounces-21729-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cMRoF5oLr2lzMQIAu9opvQ
	(envelope-from <linux-crypto+bounces-21729-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 09 Mar 2026 19:04:10 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB9C23E286
	for <lists+linux-crypto@lfdr.de>; Mon, 09 Mar 2026 19:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5A420300BC75
	for <lists+linux-crypto@lfdr.de>; Mon,  9 Mar 2026 18:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AFB336EE9;
	Mon,  9 Mar 2026 18:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqFC7WcH"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AE42C11D1;
	Mon,  9 Mar 2026 18:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773079272; cv=none; b=azx9p+zie7JZMiqY2wBEBF5wTZvD86sG9+VTB3Ag1vXwo3dvYSZkyVE1CFjQOvxykJ4Z+wBPRojjrwghrMwYbR0VzUVwB9fgEmu0cmZlgHYFAgpXJVy24t2nV4Adme/kp5AhZq+d0siW0yrFjlZASPB9CA+j0/38qR064p9zoSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773079272; c=relaxed/simple;
	bh=omXIrDpdIqi3o5BW4XsJcO58ut9DRxY4c/VDjtGZInY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GNfZ3VH/wNMaBECYuN+QW2pKYNiJsBmsrfzUn60NNMkhOGgdisAWsEuO9n08salxXNetBaYxBRPqap9CzBJ027hQNMwlwPntWLYdRabY3iu2Vxl6AbvHxy7XePAc7upeLuZhcIVChBwN2T1YmaayrkWO1ippU06RHqNtCBcgotQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqFC7WcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D44C4CEF7;
	Mon,  9 Mar 2026 18:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773079272;
	bh=omXIrDpdIqi3o5BW4XsJcO58ut9DRxY4c/VDjtGZInY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LqFC7WcHTw1Uh7UGLlwKPaxmAlRaezI7Oxm1kRcG0aOArrxLtB8OZq+p2r9+9m3G8
	 R5kmcNuNlv1UcQfJkL95J1Q/3fTx8lZuw2lLqqkBGMg/Eg/IgbA0wcx23L60DiRmfX
	 MZb/ZG4yY9lL4mXFiJZtoC03nDGZBYJUqYNZTiIgACxLUysXo0FI846Qncyu7v0lk4
	 /gCz4WuK1SwdNWfQ6f20dtuYA3tiM+pT3szG44bE/JJMxk9/pTYsuD+u7jDY83H6oZ
	 4W9npL7U0vPuTkJznU1P+siU1+nlgmgiuDtLC6k8vp5B9LYS+oV98i/WBpFMHkDppo
	 DdFE6TAV5qVtw==
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
	linux-crypto@vger.kernel.org
Subject: [PATCH v2 00/10] Move SNP initialization to the CCP driver
Date: Mon,  9 Mar 2026 12:00:42 -0600
Message-ID: <20260309180053.2389118-1-tycho@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306153846.GKaar1Bg_1EKm17tXJ@fat_crate.local>
References: <20260306153846.GKaar1Bg_1EKm17tXJ@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8CB9C23E286
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-21729-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[21];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: "Tycho Andersen (AMD)" <tycho@kernel.org>

Here's v2 of the series. Changes are:

* squash MFDM helper into snp_x86_shutdown()
* move MFDM helper to msr_set/clear_bit()
* move SNP bit test during shutdown from ccp into snp_x86_shutdown()
* reorder so that the two code deletion patches come first
* commit message rewrites, carry Tom's reivews as appropriate

Tom Lendacky (3):
  x86/snp: Keep the RMP table bookkeeping area mapped
  x86/snp: Create a function to clear/zero the RMP
  crypto: ccp - Update HV_FIXED page states to allow freeing of memory

Tycho Andersen (AMD) (7):
  x86/snp: drop support for SNP hotplug
  x86/snp: drop WBINVD before setting SNPEn
  x86/snp: create snp_prepare_for_snp_init()
  x86/snp, crypto: move SNP init to ccp driver
  x86/snp, crypto: move HSAVE_PA setup to arch/
  x86/snp: create snp_x86_shutdown()
  crypto: ccp - implement SNP x86 shutdown

 arch/x86/include/asm/sev.h   |   4 +
 arch/x86/virt/svm/sev.c      | 161 +++++++++++++++++++----------------
 drivers/crypto/ccp/sev-dev.c |  62 ++++++++------
 include/linux/psp-sev.h      |   4 +-
 4 files changed, 129 insertions(+), 102 deletions(-)


base-commit: 59f9bfe4641c408c08824a9b52e9f7839bde57d8
-- 
2.53.0


