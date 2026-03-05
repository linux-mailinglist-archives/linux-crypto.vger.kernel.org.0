Return-Path: <linux-crypto+bounces-21623-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKkQKl3RqWmYFgEAu9opvQ
	(envelope-from <linux-crypto+bounces-21623-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 05 Mar 2026 19:54:21 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0328721726C
	for <lists+linux-crypto@lfdr.de>; Thu, 05 Mar 2026 19:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7258B310A6FE
	for <lists+linux-crypto@lfdr.de>; Thu,  5 Mar 2026 18:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FA92D9ECD;
	Thu,  5 Mar 2026 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6GTZefc"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB192D0603
	for <linux-crypto@vger.kernel.org>; Thu,  5 Mar 2026 18:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772736718; cv=none; b=DxImBzDzKFcFJNZ+pbp9xruwS02flP/ewTW1y4sE67RzMEF2MgUxYbK7uwge2Q2PaDC3u4vJ4g0pqaiEW6Lc7HnJEdxVUdX94BA0lqwt8v7KcmM9nnXeBngiOIaj9X5bFBpXE4Zsh1+xpEEPPkr6HkI3/3UiWMGdg0KDQwYEzUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772736718; c=relaxed/simple;
	bh=JqEgc6a1cs+nj+ck/t9SCDhtRFcvyOJetV94MLsJRL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7gul1vkK0kCkDuWoLMYKZZ/nEBE02Uov54tLPBxcALF6xMD+WDwazdqyrf/qXhlhXTceRFrUvWunRGlHt3wLNvL8yWpouS7NNftsNFmm58T7CAQFgnn9znmQ0AE4VI22/8jMhuGx1ccuN3jeXhwpqO4N651+ymmQD3Gp7wO49A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6GTZefc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E36B6C116C6;
	Thu,  5 Mar 2026 18:51:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772736718;
	bh=JqEgc6a1cs+nj+ck/t9SCDhtRFcvyOJetV94MLsJRL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X6GTZefcsxdd40zJcb85Awqh0+CTZ5LGTO+kENHKPaiffQuqB5PLc5OZgZDFx4hhB
	 GYIiB/rwB/ZmTp8/L/g453gzZmRSX7zrtitXOlopKQ/7JGfS9fhkIyYbFEziv5zJjV
	 jI2jOdiHdrs9HhHr5WPbl8yFltSQh9cJSCO7mWXjoRlwZ5fj1WxAYzz2L4tUJWwKee
	 d/ulwS9G35Sgw/aUXqtsMkBdltHNZhKe7ohwtyQDkYLRWQXf/CTtDZS/wmnSEa1DvW
	 MHPbIeTU4ike3oCknVblesODZcZnkEeIDzqUZUFGjRCzW9ugDhY2yBuMTBX90zmRJb
	 hP9yujb7hHO5g==
Date: Thu, 5 Mar 2026 10:51:56 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-crypto@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Subject: Re: [PATCH v3 0/5] pkcs7: better handling of signed attributes
Message-ID: <20260305185156.GD2796@quark>
References: <20260225211907.7368-1-James.Bottomley@HansenPartnership.com>
 <20260226021331.GA55502@quark>
 <3900433c727c1e7ab6e131003de7ca53bb0d23d1.camel@HansenPartnership.com>
 <20260305075511.GA155793@sol>
 <ba545f3db317ba3410b8fb9f5bab9e72be1854b6.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ba545f3db317ba3410b8fb9f5bab9e72be1854b6.camel@HansenPartnership.com>
X-Rspamd-Queue-Id: 0328721726C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21623-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 09:46:42AM -0500, James Bottomley wrote:
> On Wed, 2026-03-04 at 23:55 -0800, Eric Biggers wrote:
> > On Thu, Feb 26, 2026 at 07:43:54AM -0500, James Bottomley wrote:
> > > > If this is for some out-of-tree module, we don't do that.
> > > > 
> > > > I'll also note that we should generally be aiming to simplify the
> > > > PKCS#7 signature verification code, not making it even more
> > > > complex.
> > > 
> > > I'm fine with the general goal, but since the current code verifies
> > > the signature, pulls out the message hash and other attributes,
> > > compares the message against the MessageDigest one and then frees
> > > the whole structure it's a bit hard to see how the current goal can
> > > be achieved without extracting at least the first part of that ...
> > > but if you have   suggestion, I'm happy to implement.
> > 
> > Sure, just incorporate your auxiliary data into the actual message
> > being signed and verified.  Something like:
> >     
> >     program_len || program || hash*
> 
> We can't do that because the second hash is for the LSM.  If there's no
> LSM then we need the signature to pass the current eBPF signature check
> because the second hash will be verified by the loader, which means the
> program hash and nothing else must be in the messageDigest attr.
> 

Why does the loader need to verify the signature if the kernel has to do
it anyway, and why does the loader need to skip verifying the maps?

- Eric

