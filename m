Return-Path: <linux-crypto+bounces-22733-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNLjGYP5zmn7sAYAu9opvQ
	(envelope-from <linux-crypto+bounces-22733-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 03 Apr 2026 01:19:31 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC8C38F20D
	for <lists+linux-crypto@lfdr.de>; Fri, 03 Apr 2026 01:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BB656309A0A9
	for <lists+linux-crypto@lfdr.de>; Thu,  2 Apr 2026 23:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F713FF8B5;
	Thu,  2 Apr 2026 23:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ITqaaOmD"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9BA3F074A;
	Thu,  2 Apr 2026 23:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775171473; cv=none; b=GXRKHT2ezZ8Ca3y7xNA9nvL9xf582GmfRS2TfuthE0baXvjqVDmPhyHhyVks2JHVWkftn9VW0QX3bOKiXZRwEX8g/YS5QmF7Ox7AloYbBfloQkB4vPRVrUVZLCJynslPLVGuedk/8Ai+O9GCG/920WdiRcnTsFbR61cr3pIIUU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775171473; c=relaxed/simple;
	bh=PDiluXam2B4DxUfNTSH/dFwP/LrIwMeMOpdJEFxE6L8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klb/ZwZlgEpMTihMyreBxRN5Eu5soQxzy1HIhBJ4h2PZRVrh6A13DfNUrO/HWxrjmGxdmRJ/q7BpC7bwpKeLmCFjh70v0ThpU6L5nig155lsP+NfVbPGoWp+Ojmn/wIwZWxfxlAacwZ9RfdDPlfB9mjg8YxQwYbWcapAmzqau+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ITqaaOmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DF6FC116C6;
	Thu,  2 Apr 2026 23:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775171473;
	bh=PDiluXam2B4DxUfNTSH/dFwP/LrIwMeMOpdJEFxE6L8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ITqaaOmD3HRTT+SHRGmbpVDHIPCyNvXABtZvCHhEk8QBrYryDUuTuj2BEEdI6stmM
	 w/+ZJ/BqQJj/8m1YO8EuUE92cagDYBpN4M5qJ0usz/MquYN9v9SDcCsmdk8V9n6ANI
	 kB5qzuf2MYIvx22BJ6fwivcBSM7KGQjJyxM/uUSQUbMU7slPNGAD4gpVh/l2NcQQyJ
	 iyOB6DtFiNCA8VJxf5icRPdj23PrbxSJ53aDnAlYDoUVCbqFaBiXJJ3Hue4noP3OH5
	 ZIFvi1pt57NXEjipmjVb1xRlrtbGWgiLUJ2T3sjtcfHdeBVJMuJuHtfs8fKFX4nXuO
	 ri0aZcZFOC1kQ==
Date: Thu, 2 Apr 2026 16:11:08 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: Re: [PATCH] lib/crypto: aesgcm: Don't disable IRQs during AES block
 encryption
Message-ID: <20260402230959.GB2910@quark>
References: <20260331024430.51755-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331024430.51755-1-ebiggers@kernel.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22733-lists,linux-crypto=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BBC8C38F20D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 30, 2026 at 07:44:30PM -0700, Eric Biggers wrote:
> aes_encrypt() now uses AES instructions when available instead of always
> using table-based code.  AES instructions are constant-time and don't
> benefit from disabling IRQs as a constant-time hardening measure.
> 
> In fact, on two architectures (arm and riscv) disabling IRQs is
> counterproductive because it prevents the AES instructions from being
> used.  (See the may_use_simd() implementation on those architectures.)
> 
> Therefore, let's remove the IRQ disabling/enabling and leave the choice
> of constant-time hardening measures to the AES library code.
> 
> Note that currently the arm table-based AES code (which runs on arm
> kernels that don't have ARMv8 CE) disables IRQs, while the generic
> table-based AES code does not.  So this does technically regress in
> constant-time hardening when that generic code is used.  But as
> discussed in commit a22fd0e3c495 ("lib/crypto: aes: Introduce improved
> AES library") I think just leaving IRQs enabled is the right choice.
> Disabling them is slow and can cause problems, and AES instructions
> (which modern CPUs have) solve the problem in a much better way anyway.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  lib/crypto/aesgcm.c | 25 +++----------------------
>  1 file changed, 3 insertions(+), 22 deletions(-)

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-next

- Eric

