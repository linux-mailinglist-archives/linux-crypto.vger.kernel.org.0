Return-Path: <linux-crypto+bounces-25252-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oNmTK0g0NGqiRQYAu9opvQ
	(envelope-from <linux-crypto+bounces-25252-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 18 Jun 2026 20:09:12 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 192F66A20E4
	for <lists+linux-crypto@lfdr.de>; Thu, 18 Jun 2026 20:09:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=alien8.de header.s=alien8 header.b=BDhRLYFR;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25252-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25252-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=alien8.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5527302DFBD
	for <lists+linux-crypto@lfdr.de>; Thu, 18 Jun 2026 18:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975A33563F6;
	Thu, 18 Jun 2026 18:09:07 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A6B3546FD;
	Thu, 18 Jun 2026 18:09:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781806147; cv=none; b=XILC2T1jzyoVb1VvG3Acgqoe+mLhMpODpl2BmP4SMTyFLsj4G5C6uXWiy1vM9BAfRnH8K1QVg9vdpWjI9BvIIw27oQrF+01RBvuNTJfkbNQuzMq76zpZ/q2+UwBUjKwBNkm+C8U+nPYIu/+wP0YfFO3KAcwJIty0ZLFJ8BSMPgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781806147; c=relaxed/simple;
	bh=rAa8LEQvk+1s+hFT3N+GAcQefqp86NaczF4HhGpoMbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XNgQ4u31lAp3jFjvFxtW/7FOhkOeHp923M2neJNmfmBFkaOfQVaGcR2gQvfc2IvfPWtg7XW0w0qi5MadUSbE0iZPNcVbCkksqyA3PpIDtpT7crPvAkeZnjM8J21oDl8gWBvy6Cr77HP2TC0uGRZG/BiWy75Xj/Qro1cFYUQmDNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=BDhRLYFR; arc=none smtp.client-ip=65.109.113.108
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 7A70F40E02A1;
	Thu, 18 Jun 2026 18:09:03 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id fYI6Wz8iLQBu; Thu, 18 Jun 2026 18:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1781806132; bh=AbUUknJ8mkdCJrlkEr1r8m9QQjKgmoQkDiKU2zcLEG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BDhRLYFR+EXuFe+zt79BtJIqnB4DWwSA1KUtL6OVBUYeFnsBdMcC79eXB4EWLVZD6
	 7TBZd0ePwSGThwpyvAAcmou8UEAV8s6nMLieE13u7OLUE19axUbp8tnPIpeTOpJ1wu
	 9IkfpKnySMFniT1opMExZgo4nae8ThMSPv3BongLmN1u/KucQJ0Zxrj2Jav+aZFjYE
	 RqAafnKxyBT8t+q8ll9qmPAWe8xnAkfd/zjVJmoooBPdwlrvzK6YSdEYdExpAr717b
	 hvUgCKwt+yrobqY2ISbZvgSe6hkZQoAcs1Z3vK1BhMdxjiIZEN5rKuWW2Zg1lRPH29
	 1LmO3PGn6thhlbwM3J3yq6Q03c7q7R3dRKqtHYzigOshFRjwJfWRkllU4xx1/vyRZB
	 8PLGeCIo7ffBGKFubjtb51Ufy2MEDTYJg7Uz2YZ4K/JP2ymzeb6fEUvkdJyLGSJ9SY
	 Ra0kCF6fF+CxN31GawqO0Crjws5NZwUcpaks5qqovtR56LvK/WAbfPrTRXBHf3BBRj
	 cOwxa+xzX+y5j0MZ8UFJtD0iLox2XI/GTlYmTLEeWijTiGlBDJyHlidOolCkESCbWY
	 zaIaOU+0mnjpIKh4X3b/IxjU2Pi0deelPRVd22e16TxDPUziygLpJpd9/9617RLsnw
	 PiY9MNK5KkQKAaqnrO/POelY=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2B5D740E01D8;
	Thu, 18 Jun 2026 18:08:17 +0000 (UTC)
Date: Thu, 18 Jun 2026 11:08:14 -0700
From: Borislav Petkov <bp@alien8.de>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: tglx@kernel.org, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, seanjc@google.com,
	peterz@infradead.org, thomas.lendacky@amd.com,
	herbert@gondor.apana.org.au, davem@davemloft.net, ardb@kernel.org,
	pbonzini@redhat.com, aik@amd.com, Michael.Roth@amd.com,
	KPrateek.Nayak@amd.com, Tycho.Andersen@amd.com,
	Nathan.Fontenot@amd.com, ackerleytng@google.com, jackyli@google.com,
	pgonda@google.com, rientjes@google.com, jacobhxu@google.com,
	xin@zytor.com, pawan.kumar.gupta@linux.intel.com,
	babu.moger@amd.com, dyoung@redhat.com, nikunj@amd.com,
	john.allen@amd.com, darwi@linutronix.de,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	kvm@vger.kernel.org, linux-coco@lists.linux.dev
Subject: Re: [PATCH v8 7/7] x86/sev: Add debugfs support for RMPOPT
Message-ID: <20260618180814.GCajQ0Dv0CoRMJxbP0@fat_crate.local>
References: <cover.1781419998.git.ashish.kalra@amd.com>
 <cc9aa9b6cfa2ce826f2ad53f8a13d3b7bf0790b6.1781419998.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cc9aa9b6cfa2ce826f2ad53f8a13d3b7bf0790b6.1781419998.git.ashish.kalra@amd.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[alien8.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[alien8.de:s=alien8];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25252-lists,linux-crypto=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[bp@alien8.de,linux-crypto@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[34];
	FORGED_RECIPIENTS(0.00)[m:Ashish.Kalra@amd.com,m:tglx@kernel.org,m:mingo@redhat.com,m:dave.hansen@linux.intel.com,m:x86@kernel.org,m:hpa@zytor.com,m:seanjc@google.com,m:peterz@infradead.org,m:thomas.lendacky@amd.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:ardb@kernel.org,m:pbonzini@redhat.com,m:aik@amd.com,m:Michael.Roth@amd.com,m:KPrateek.Nayak@amd.com,m:Tycho.Andersen@amd.com,m:Nathan.Fontenot@amd.com,m:ackerleytng@google.com,m:jackyli@google.com,m:pgonda@google.com,m:rientjes@google.com,m:jacobhxu@google.com,m:xin@zytor.com,m:pawan.kumar.gupta@linux.intel.com,m:babu.moger@amd.com,m:dyoung@redhat.com,m:nikunj@amd.com,m:john.allen@amd.com,m:darwi@linutronix.de,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:kvm@vger.kernel.org,m:linux-coco@lists.linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[alien8.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bp@alien8.de,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 192F66A20E4

On Mon, Jun 15, 2026 at 07:50:56PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> Add a debugfs interface to report per-CPU RMPOPT status across all
> system RAM.
> 
> To dump the per-CPU RMPOPT status for all system RAM:
> 
> /sys/kernel/debug/rmpopt# cat rmpopt-table
> 
> Memory @  0GB: CPU(s): none
> Memory @  1GB: CPU(s): none
> Memory @  2GB: CPU(s): 0-1023
> Memory @  3GB: CPU(s): 0-1023
> Memory @  4GB: CPU(s): none
> Memory @  5GB: CPU(s): 0-1023
> Memory @  6GB: CPU(s): 0-1023
> Memory @  7GB: CPU(s): 0-1023
> ...
> Memory @1025GB: CPU(s): 0-1023
> Memory @1026GB: CPU(s): 0-1023
> Memory @1027GB: CPU(s): 0-1023
> Memory @1028GB: CPU(s): 0-1023
> Memory @1029GB: CPU(s): 0-1023
> Memory @1030GB: CPU(s): 0-1023
> Memory @1031GB: CPU(s): 0-1023
> Memory @1032GB: CPU(s): 0-1023
> Memory @1033GB: CPU(s): 0-1023
> Memory @1034GB: CPU(s): 0-1023
> Memory @1035GB: CPU(s): 0-1023
> Memory @1036GB: CPU(s): 0-1023
> Memory @1037GB: CPU(s): 0-1023
> Memory @1038GB: CPU(s): none
> 
> Suggested-by: Thomas Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
> ---
>  arch/x86/virt/svm/sev.c | 128 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 128 insertions(+)

https://lwn.net/Articles/309298/

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

