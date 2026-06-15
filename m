Return-Path: <linux-crypto+bounces-25173-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V07gC1tcMGpmSAUAu9opvQ
	(envelope-from <linux-crypto+bounces-25173-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 15 Jun 2026 22:11:07 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DCA689B2C
	for <lists+linux-crypto@lfdr.de>; Mon, 15 Jun 2026 22:11:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="NtW5sn2/";
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25173-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25173-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 55DBD302D0AA
	for <lists+linux-crypto@lfdr.de>; Mon, 15 Jun 2026 20:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E09B3B6366;
	Mon, 15 Jun 2026 20:10:53 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF9E3B2FCE;
	Mon, 15 Jun 2026 20:10:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781554252; cv=none; b=rRc5lN06BvYfjtdtt7NkUo+zO5XcFQut4LkPDMd1KO5mMazWi8UmwpkfCB+C/ukuNyfabPK4OZaWw+r+qN0E9ZnlesUG63toJq7RpmlPWkyZAhUOsbAjSZwCCxozkgP49D/d6Ml9ppgWg/VSdNDtpWCilJRwnIAIvvNcl2Mn8C4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781554252; c=relaxed/simple;
	bh=aoGF+UAgCACv4wkcUSvfAbWl6T+6AFnDpi2Ez7n/Wus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rDI8jzrSVjtAcQpOdf5IlxG/l4cYW+jqi86Nyvgx6M07TsSrb4Y2djz0xWiInaftEgDukDrJ3Nju+MI219GKjbWZr7NtL/PZ+sWz+n2Qs2bT3AJegrz2BQb8sMlpHHu7IKmIJ9KCT+MNxZt8CBynrX3r1xZOaFSRtM5Z272MyVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtW5sn2/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 536EA1F000E9;
	Mon, 15 Jun 2026 20:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781554251;
	bh=T38ht8LUdfYFZ9jgYuBsYJO5B1Yg5v/mWG6HajglajA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NtW5sn2/eTi/e42oElqvFFDC7sdgHCYXv8JE8Xfb/y0b7ytWqCYjIMWR3kdsFj9te
	 lO5+3bjpLEpr+n7jUcHGVwIGe06a6Fk68qC9BmIOu7J4Sw/Oh1JftyVIHSwqXiXGEP
	 vPliBFmFvKmWHQRbpCmMGWsyu84+WJubkH1UD5eZ2FyPUWMwvtpiVt7E0NcbRPJgyZ
	 roPGcY9t8rFQQxTgRX51p/K0ehbcS8QMLXqkw7IQdIIqjUFRJ6UAtJSRCnFQvu9nPD
	 KlwcXODwd9kg7Hnsy5U/GyxiIGEsh3yW1tEgjZNsZoo5J1990h5MFctBrZrqIICG7+
	 L41dgHE594qlA==
Date: Mon, 15 Jun 2026 13:10:50 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: Christoph Hellwig <hch@lst.de>, linux-crypto@vger.kernel.org,
	David Laight <david.laight.linux@gmail.com>,
	linux-raid@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] lib/raid/xor: x86: Add AVX-512 optimized xor_gen()
Message-ID: <20260615201050.GB1764@quark>
References: <20260615190338.26581-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615190338.26581-1-ebiggers@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25173-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:x86@kernel.org,m:hch@lst.de,m:linux-crypto@vger.kernel.org,m:david.laight.linux@gmail.com,m:linux-raid@vger.kernel.org,m:akpm@linux-foundation.org,m:linux-kernel@vger.kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lst.de,vger.kernel.org,gmail.com,linux-foundation.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,quark:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 94DCA689B2C

On Mon, Jun 15, 2026 at 12:03:38PM -0700, Eric Biggers wrote:
> Note: for now I omitted the cpu_has_xfeatures() check that the AVX-512
> optimized crypto and CRC code does, since it's not implemented on
> User-Mode Linux and it's never been present in the RAID6 code either.

By the way, Sashiko keeps complaining about this decision.

Maybe the x86 maintainers have some advice here?

For context: on x86 processors, executing AVX or AVX512 instructions
requires not just that the CPU supports the feature, but also that the
operating system has set certain bits in XCR0.  For example all EVEX
coded instructions (i.e. AVX-512) require XCR0=111xx111b.  (See Intel
manual "2.6.11.1 State Dependent #UD".)

Therefore most of the kernel's AVX and AVX512 optimized code checks not
just X86_FEATURE_AVX* but also calls cpu_has_xfeatures() to check XCR0.

But "most" isn't all.  The RAID6 code for example doesn't check
cpu_has_xfeatures().  So if you e.g. boot a kernel in QEMU using
"-cpu max,xsave=off", it already crashes when the RAID6 code does its
boot-time benchmark.

Part of the reason for that omission probably is that UML doesn't
provide an implementation of cpu_has_xfeatures().  And the x86 RAID (XOR
and RAID6) code is enabled on UML.

It could be implemented for UML by using the xgetbv instruction, like
what userspace programs do.  (We'd also need to copy the XFEATURE_MASK_*
constants, as UML can't include arch/x86/include/asm/fpu/types.h)

But I wanted to ask: do we really care about the case where features are
"supported" but their XCR0 bits aren't set?  Perhaps the kernel just
doesn't/shouldn't support weird cases like "-cpu max,xsave=off"?

If this case indeed needs to be handled, could we make things easier for
the kernel's AVX and AVX-512 optimized code?  Currently AVX-512 needs:

        if (boot_cpu_has(X86_FEATURE_AVX512F) &&
            cpu_has_xfeatures(XFEATURE_MASK_FP | XFEATURE_MASK_SSE |
                              XFEATURE_MASK_YMM | XFEATURE_MASK_AVX512, NULL))

How about we make X86_FEATURE_AVX512F depend on XCR0=111xx111, and
X86_FEATURE_AVX depend on XCR0=xxxxx111?  Then the cpu_has_xfeatures()
check wouldn't be needed.  Is there any reason not to do that?

- Eric

