Return-Path: <linux-crypto+bounces-23025-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Je9Df7M32lwZAAAu9opvQ
	(envelope-from <linux-crypto+bounces-23025-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 15 Apr 2026 19:38:06 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A027E406D92
	for <lists+linux-crypto@lfdr.de>; Wed, 15 Apr 2026 19:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1752930269C0
	for <lists+linux-crypto@lfdr.de>; Wed, 15 Apr 2026 17:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD6A3D5662;
	Wed, 15 Apr 2026 17:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s7Fy+usv"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6F12D8378;
	Wed, 15 Apr 2026 17:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776274682; cv=none; b=J5hytXeic8HYhFNtUInRA3/D9mCRihqaX8o3g1X2dX4I1Ra53bQJuM4gxgEqxKbV9cNYO3qB7FuqsrTwMZ833UH+s4LYwa63JwDWvTU44B9kowcXvidp9Aj1JnAQYQg6c+MDO4qbHgOXj2VaelxDwDddMOoPtWiEF/+miluKDz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776274682; c=relaxed/simple;
	bh=2KMp76R+YAU47hvbp8LhYCLMLqrHNI3b4c5D3iZ6Wm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fg6j/0hwt+qzrFAhukNfmmetysqdSSAN/ZRRqMSp+Q789IhgDtzvhqZptIPQZbon89/PoLDcnssK+tuWqFwqcX1pvabkT7qtVktwxunzrnjG0rdnYwlQK9jodL41xYPTzZ9qk+J0+6zBQ8NcXJhfjXAq5z4ry67Arrnuds7Mp/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s7Fy+usv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81153C19424;
	Wed, 15 Apr 2026 17:38:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776274681;
	bh=2KMp76R+YAU47hvbp8LhYCLMLqrHNI3b4c5D3iZ6Wm8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s7Fy+usvlT57gJhPHo03Rr9aZqkPth+Ox/fINGo/p6fy6C0oujj9rI3aSU1M0b5tn
	 D5cpoPPEeMAn8TDkXk+oM9dfUE8wtZS/wsDH0c09S+uGg+hhqdx60+re76x40ik6xy
	 aGeR6w/9+m/9vfN9Oo6j05IucVcsDzbipG6HEICwi1MBgB6mnwoeAH2J7ZsU0xS6UC
	 qyeMjcCtr1nlX2o0oQAYAAT3PA2fiqCWfWLnG+Rc9bcqPCKZUf3Cinr2YFgR6/ufbQ
	 f7SWOSxFNxgwpPeri80QgTrFmE9b8ddeSe3+4QbsvHsu1/LUuXBMckTijxD36zoQIy
	 E3vWYAc5klaJg==
Date: Wed, 15 Apr 2026 10:37:59 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] crypto: blake2s - use memcpy_and_pad in
 __blake2s_init
Message-ID: <20260415173759.GA3142@quark>
References: <20260414154902.344182-3-thorsten.blum@linux.dev>
 <20260414154902.344182-4-thorsten.blum@linux.dev>
 <20260414173915.GB24456@quark>
 <ad-K6-ohL0AZoOQk@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad-K6-ohL0AZoOQk@linux.dev>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23025-lists,linux-crypto=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A027E406D92
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 02:56:11PM +0200, Thorsten Blum wrote:
> On Tue, Apr 14, 2026 at 10:39:15AM -0700, Eric Biggers wrote:
> > On Tue, Apr 14, 2026 at 05:49:04PM +0200, Thorsten Blum wrote:
> > > Use memcpy_and_pad() instead of memcpy() followed by memset() to
> > > simplify __blake2s_init(). Use sizeof(ctx->buf) instead of the macro
> > > BLAKE2S_BLOCK_SIZE.
> > > 
> > > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > > ---
> > >  include/crypto/blake2s.h | 5 ++---
> > >  1 file changed, 2 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/include/crypto/blake2s.h b/include/crypto/blake2s.h
> > > index 648cb7824358..f0e0ce0b30a5 100644
> > > --- a/include/crypto/blake2s.h
> > > +++ b/include/crypto/blake2s.h
> > > @@ -70,9 +70,8 @@ static inline void __blake2s_init(struct blake2s_ctx *ctx, size_t outlen,
> > >  	ctx->buflen = 0;
> > >  	ctx->outlen = outlen;
> > >  	if (keylen) {
> > > -		memcpy(ctx->buf, key, keylen);
> > > -		memset(&ctx->buf[keylen], 0, BLAKE2S_BLOCK_SIZE - keylen);
> > > -		ctx->buflen = BLAKE2S_BLOCK_SIZE;
> > > +		memcpy_and_pad(ctx->buf, sizeof(ctx->buf), key, keylen, 0);
> > > +		ctx->buflen = sizeof(ctx->buf);
> > 
> > I'm wondering if this is actually better.  It's another helper function
> > to remember.  Also 'keylen' can be a compile-time constant here, and
> > compilers know what memcpy() and memset() do, so they will optimize the
> > code accordingly.  The helper function takes away the compiler's ability
> > to perform this optimization.  If this was already an out-of-line
> > function, it would be a bit more convincing.
> 
> My motivation was readability/maintainability and avoiding the manual
> tail-size arithmetic.  memcpy_and_pad() is just a thin wrapper around
> memcpy()/memset(), with an additional safety check to prevent integer
> wraparound.
> 
> Currently, nothing stops __blake2s_init() or blake2s_init_key() from
> being called with keylen > BLAKE2S_BLOCK_SIZE. The WARN_ON() in
> blake2s_init_key() is only available in DEBUG builds.
> 
> That said, happy to drop the patch if the explicit version is preferred
> for performance reasons.

I think the memcpy_and_pad() variant is *less* readable for most people.
memcpy_and_pad() isn't widely known, so people have to jump to the
definition to understand what it does.

Of course, we do create helper functions all the time when they are
helpful.  This one just doesn't seem all that helpful here, I'm afraid.

As for keylen > BLAKE2S_KEY_SIZE, that would be a usage error, which
would need to be found and fixed.  It certainly shouldn't be silently
truncated.  It looks like if this were to happen (currently it doesn't),
the current code would do memcpy with an underflowed value, which would
crash, similar to a BUG_ON().  That's actually better than the silent
truncation you're proposing, as it allows the problem to be found and
fixed.  If we add the truncation, it should at least be noisy:

        if (WARN_ON(keylen > BLAKE2S_KEY_SIZE))                                  
                keylen = BLAKE2S_KEY_SIZE;

- Eric

