Return-Path: <linux-crypto+bounces-22163-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ABTKxOovWkAAAMAu9opvQ
	(envelope-from <linux-crypto+bounces-22163-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Mar 2026 21:03:31 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3514F2E0B35
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Mar 2026 21:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C4D1E3065731
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Mar 2026 20:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122A73563E8;
	Fri, 20 Mar 2026 20:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uz5g6Ie2"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA57E3009E2;
	Fri, 20 Mar 2026 20:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774036842; cv=none; b=QvBW2V4Pwazw+e9R4i0j7MBAMxutUJuRZXfiq22qcmjKVEOx5HdPXUonXlooWjXgpUnl0I+lBzh9+bobjnKoFC91K+vRay4AeSm9DJgsx0iX7qACGejRIcnUs6irBMff0BcZih7l2Tkkx7ddV89kIP8QQYlg13WiQRQEAvg0UXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774036842; c=relaxed/simple;
	bh=eK0trTYiH90eggnQVPJYHF7o+KvabGkWfYgRnJsxDKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mFooplY5zMXj1TImQ53/BaW4iqssEt/oFNzSgyUNh0domTcUVPci6ox/O1sYCEArGOrfRMP9azu5xMdIl4AaaYs+ZXPzHKXd9qYDC3esToXyMkX9EDof+4ZrgDoByvpjSEx5z0H0xXTvqbbi08Pmu2HqlYNMzTBBbPWVqVj3jqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uz5g6Ie2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39359C4CEF7;
	Fri, 20 Mar 2026 20:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774036842;
	bh=eK0trTYiH90eggnQVPJYHF7o+KvabGkWfYgRnJsxDKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uz5g6Ie2HWB3PbQkifelAKZU6d+2UYS+o2EPxbgtdm23smV5cBZSUFTRDPk57McEe
	 V2AYcAQlKwGyHQMAYlPwuF76T4yYcmSc7pHHPqaelv6JhdRZWGVxO8Oe3OrS0KiikN
	 O3tgHWUO1H29AGnlEXxE0JjBmgR1GygwG0bAk+CRWS9m+PhdqAmG6jCElAguG4giG6
	 GC+4FNYDuNIcW00L/FlOSkRL/5FdUepYTZ/4QCJD7l+WXK+u7JhD4uSrxPe4JUlDsf
	 9aB/iF9pAyLS/NLgCrLUeLsaKYOw/zl8w5RYF4brsF3ETM1HgPbfxmb/t5VULNf67u
	 rfWCMg4R7mi3A==
Date: Fri, 20 Mar 2026 13:00:39 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Demian Shulhan <demyansh@gmail.com>, ardb@kernel.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/crc: arm64: add NEON accelerated CRC64-NVMe
 implementation
Message-ID: <20260320200039.GA2085@quark>
References: <20260317065425.2684093-1-demyansh@gmail.com>
 <20260319190908.GB10208@quark>
 <20260320103624.0e13d26f@pumpkin>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320103624.0e13d26f@pumpkin>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22163-lists,linux-crypto=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3514F2E0B35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 20, 2026 at 10:36:24AM +0000, David Laight wrote:
> I'm also pretty sure that the same loop will process 32bit and 16bit CRC
> (just needs the high bits of the constant multiplier set to zero).
> There are fewer bits to correct for at the end (I think it is always
> the size of the CRC) but that may not be worth worrying about.

Again, see lib/crc/x86/ and lib/crc/riscv/ which do basically this.

> It might be better to write some C that required the architecture provide
> the functions required for doing a CRC with 128bit registers that hold
> two 64bit values (etc) and give them sane names.
>
> Then common C code can be used provided the required instructions exist.

While it would be great to share more CRC code between architectures by
using a C "template" combined with some arch-dependent inline asm
blocks, there's actually a lot of variation in what instructions and
register widths the different architectures have.

lib/crc/riscv/crc-clmul-template.h actually has something very similar
to this already: it's written in C, and there are just three
single-instruction inline asm blocks to access RISC-V's clmul
instructions.  Unfortunately, the carryless multiplication instructions
on the other architectures are not compatible with these.  So, it's hard
to make it anything more than RISC-V specific code.

There might be enough similarity between arm, arm64, and x86_64 for them
to share code using a similar "template".  However, consider that for
x86_64 we need to support different register widths.  See
lib/crc/x86/crc-pclmul-template.S.

> I'm pretty sure the loop is effectively:
> 	for (; p < limit; p++)
> 		p[N] ^= low(*p) * const_a ^ high(*p) * const_b;
> where N is at least one and you don't actually want to write into the buffer.
> Making N > 1 should improve performance - just needs care.

Well, you're welcome to read the actual code and not just speculate.

But again, maybe best to not get too sidetracked for now, unless you or
Demian are actually planning to work on the more general version.

- Eric

