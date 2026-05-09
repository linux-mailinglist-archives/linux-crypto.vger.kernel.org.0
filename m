Return-Path: <linux-crypto+bounces-23885-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ACNiIvR//2nN7AAAu9opvQ
	(envelope-from <linux-crypto+bounces-23885-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 09 May 2026 20:41:56 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 029D5501075
	for <lists+linux-crypto@lfdr.de>; Sat, 09 May 2026 20:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7819D300E141
	for <lists+linux-crypto@lfdr.de>; Sat,  9 May 2026 18:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5583BED4A;
	Sat,  9 May 2026 18:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyJ5rWZI"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309EB25A642;
	Sat,  9 May 2026 18:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778352113; cv=none; b=XwkXRDXLamyE5GDvnqd26dMdJyXnpTeg4EnRVpYJimhC9RSFDEN+Kv8lcucr3V3175PyhzknfuW/zkud7ncsM7eQYm9yryCAGtum9nmu4Bvt6pKIJNqPznuy9jxQ8VO4ENDRm9r7aaU4yyGCSHiTn/6Za9XuCFotVXXN3W9yVwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778352113; c=relaxed/simple;
	bh=5x6vMZJIgP2JV5U0sf4/3UHVPYatudGhzTthPLFbE1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsjT+N+pTcUsXzF/1YmrJw4rYLJs1ue3KX95VLlK9OpwU6zlcsTGl9+hArlzQKxPxUwMwrxnoTDhaosoIEjkC9/K42Zd1SWSvtcTfeUek/WlEoJV3b7QUYKnP0Yt5haTkDBbNvXf409tkvuXf5g+g4xtadWf90X5p8yZknxbPKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyJ5rWZI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 626DCC2BCB2;
	Sat,  9 May 2026 18:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778352112;
	bh=5x6vMZJIgP2JV5U0sf4/3UHVPYatudGhzTthPLFbE1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AyJ5rWZIJlvuab7tohPZ8gd7mvCmDxDNq/R998ABZKL2siI3NOIG5fVudgG+OtgJY
	 hNTUVyvIvpVN/IQQdxRB0+xP/TMJRVoi4EUtUA9zmVEOnLlC+vDDBS5mNaY7+I/dwr
	 hznqQ4FgC5RYcm8MWrDvOtf/Pkv/CkE/xcb+X86Cdtdz9lUKt4BxTT5TVtiwSMORdC
	 ICxc/QlGkB2kaXTTOyXicZiiO/mwafgH6knNICANk6kNsvg+SIaNU+HmB0pF1Ii/hd
	 e1njZm9xgEXduDH3ASCwWoCuo+GNQ7ZjjCl57klRJMYkkNb3TMaHVz2azJGCgvPWl9
	 6IvHRup/FfYXQ==
Date: Sat, 9 May 2026 11:41:44 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linuxppc-dev@lists.ozlabs.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>
Subject: Re: [PATCH v2] lib/crypto: powerpc/md5: Drop powerpc optimized MD5
 code
Message-ID: <20260509184144.GB11883@quark>
References: <20260506030005.9698-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260506030005.9698-1-ebiggers@kernel.org>
X-Rspamd-Queue-Id: 029D5501075
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,zx2c4.com,gondor.apana.org.au,lists.ozlabs.org,ellerman.id.au,linux.ibm.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-23885-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, May 05, 2026 at 08:00:05PM -0700, Eric Biggers wrote:
> MD5 is obsolete, is vulnerable to collision attacks, and is being
> replaced by SHA-256 in new systems.  It doesn't make sense to continue
> to maintain architecture-optimized implementations of MD5.  Effort
> should be spent on modern algorithms.
> 
> Indeed, architecture-optimized MD5 code remains only for powerpc.  It
> was already removed from mips and sparc, and it never existed for any
> other architecture (e.g. x86, arm, or arm64) in the first place.
> Earlier the decision was made to keep the powerpc MD5 code for a while
> anyway because of someone using it via AF_ALG via libkcapi-hasher
> (https://lore.kernel.org/r/f0d771d5-ed70-444c-957a-ad4c16f6c115@csgroup.eu/)
> 
> However, with AF_ALG itself now being on its way out due to its
> continuous stream of security vulnerabilities
> (https://lore.kernel.org/r/20260430011544.31823-1-ebiggers@kernel.org/),
> it's also time to be a bit more forceful with nudging people towards
> userspace crypto code.  It's always been the better solution anyway, and
> it's much more efficient if properly optimized code is used.
> 
> Note that the md5-asm.S file contains no privileged instructions and
> could be run in userspace just fine.
> 
> Thus, we now have two factors going against keeping the powerpc MD5
> code.  Different people might weigh these two factors differently, but I
> think the two of them together make the removal the clear choice.
> 
> Let's remove it.
> 
> Acked-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
> 
> This patch is intended to be taken via libcrypto-next

Applied to https://git.kernel.org/pub/scm/linux/kernel/git/ebiggers/linux.git/log/?h=libcrypto-next

- Eric

