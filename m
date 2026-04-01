Return-Path: <linux-crypto+bounces-22677-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A9uF6ZjzGnZSgYAu9opvQ
	(envelope-from <linux-crypto+bounces-22677-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 01 Apr 2026 02:15:34 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B46123730CD
	for <lists+linux-crypto@lfdr.de>; Wed, 01 Apr 2026 02:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AF7023011F2E
	for <lists+linux-crypto@lfdr.de>; Wed,  1 Apr 2026 00:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214C0F9E8;
	Wed,  1 Apr 2026 00:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApIPjtg5"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9639E555
	for <linux-crypto@vger.kernel.org>; Wed,  1 Apr 2026 00:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775002164; cv=none; b=BZyWU/6fD/6ki7XKjY2elHMw7katM0piMwlxWwXn4rS6o/eGiKF5YNtK7n2AWAS8E6I0e07UZSq5rE3mQ2w1Akimnr02+lQNXW0htN7f8vfZnNllYSBjh6M7JXVzD1WANgB1d8JZv4wAZc9VqhR7MDUXwDUxSODLhE0FSGktEBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775002164; c=relaxed/simple;
	bh=GCE2Iy2Cf2s4vV7nVwqM/zJG/HopInTkOxOf/7UB944=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fydHozmjXugHHAJMDZPargrw0QZQP+G0Rcw3qHI8p+hGET1LqHhJkbeKmnaj3rnzLxdz/cowTWSyz3IY6vPP/yr1R6aAJZxmqzXZkpv6focpD3sOHow+9jWPvGwCAmImzCHFtSpaP2PsGCYV3Vz+13F67hsLViwc0vBbnxqOSHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApIPjtg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BF9C19423;
	Wed,  1 Apr 2026 00:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775002164;
	bh=GCE2Iy2Cf2s4vV7nVwqM/zJG/HopInTkOxOf/7UB944=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ApIPjtg5DEEu0NfbtsYKAtrvs0IK0oJ3NFlUTbX1V6fVpkKEZ3ikqxMG1pfuFh8Yu
	 MJ2e8KpRMARuZbuAd7AkP4GRvefP4uHxuC0MtETVGNg8nGEHIYQukFcF+G0SIbjAHI
	 RwR7VyqHlwHKybMNolxt0iXzaVhlgAQFcdIPyYX3lHFZ+OCcAudq12ykLG05KNi9ln
	 zg7TbhhSeBe+ujv3tCYyv2sMdgdWsXobA/xnyr8D6mOyH0qUQ4hp9eqKqxXgZtMkhD
	 ZIzZat+80ZK44ZOgjZoMDFPhdBlZHe2gaxRBN3t8AVwg6J1IEgs8vn7kYrAtiHvvpc
	 titUmUquNDnTQ==
Date: Tue, 31 Mar 2026 17:09:22 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Demian Shulhan <demyansh@gmail.com>
Subject: Re: [PATCH 1/5] lib/crc: arm64: Drop unnecessary chunking logic from
 crc64
Message-ID: <20260401000922.GC45047@quark>
References: <20260330144630.33026-7-ardb@kernel.org>
 <20260330144630.33026-8-ardb@kernel.org>
 <20260331223300.GA45047@quark>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260331223300.GA45047@quark>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22677-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B46123730CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 31, 2026 at 03:33:00PM -0700, Eric Biggers wrote:
> On Mon, Mar 30, 2026 at 04:46:32PM +0200, Ard Biesheuvel wrote:
> > On arm64, kernel mode NEON executes with preemption enabled, so there is
> > no need to chunk the input by hand.
> > 
> > Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> 
> There's still similar "chunking" in other arm64 code:
> 
>     $ git grep -E 'SZ_4K|cond_yield' lib/crypto/arm64
>     lib/crypto/arm64/chacha.h:              unsigned int todo = min_t(unsigned int, bytes, SZ_4K);
>     lib/crypto/arm64/poly1305.h:                    unsigned int todo = min_t(unsigned int, len, SZ_4K);
>     lib/crypto/arm64/sha1-ce-core.S:        cond_yield      1f, x5, x6
>     lib/crypto/arm64/sha256-ce.S:   cond_yield      1f, x5, x6
>     lib/crypto/arm64/sha3-ce-core.S:        cond_yield 4f, x8, x9
>     lib/crypto/arm64/sha512-ce-core.S:      cond_yield      3f, x4, x5
> 
> I thought it was still sticking around, despite kernel-mode NEON now
> being preemptible on arm64, because of CONFIG_PREEMPT_VOLUNTARY.
> 
> However, I see that support for CONFIG_PREEMPT_VOLUNTARY was recently
> removed on arm64.  So that's what finally makes this no longer needed,
> and we can now clean up these other cases too, right?
> 
> (Though, I can't find where the voluntary preemption points actually
> were.  So maybe they weren't actually there anyway.)

https://lore.kernel.org/linux-crypto/20260401000548.133151-1-ebiggers@kernel.org/
cleans up all the similar code in lib/crypto/arm64/.

- Eric

