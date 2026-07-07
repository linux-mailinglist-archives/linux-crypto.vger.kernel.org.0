Return-Path: <linux-crypto+bounces-25690-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hYBINXqWTGq4mgEAu9opvQ
	(envelope-from <linux-crypto+bounces-25690-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 07 Jul 2026 08:02:34 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEAF717B83
	for <lists+linux-crypto@lfdr.de>; Tue, 07 Jul 2026 08:02:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BkyescGX;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25690-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25690-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DBFA43021140
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Jul 2026 05:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E0B386C3B;
	Tue,  7 Jul 2026 05:59:21 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B896386429;
	Tue,  7 Jul 2026 05:59:20 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783403961; cv=none; b=AceC+zyb1RE2h6O86KcOiSICioq8PWNOWCXoUsL7zOt2aa3IYguuf6hvC8mvalMr8G4+3aNL97G3swsqRxymZwI7CbKMMeffL0K6vxrnSl5Spw+ske0BITvBhJJfEisrxCHANFbzZLYAlAAdYEnl+rtkbtMqbKFIHRkTFDYTJng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783403961; c=relaxed/simple;
	bh=tvp7tO/3/vp2vOMpQ0g7cifsMip31Y9+Y/tn8KvPKdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BwB9nHJ4vmrG3QEsfQYD2kRCa6LD8ljBbkZfS84yPF6gMSSBWeXUGF1NDyei89ZxA0bYyTjZQk58Fv265lBw8rdXi+fDcXYtdeL1LlP2kNwnYuhOpyiRphHcQwqlKAa6FW8HJYcpYI0ZXGPcqnErOnGvTTd0x27NC5ModVcp0wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkyescGX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D331F000E9;
	Tue,  7 Jul 2026 05:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783403960;
	bh=7D/m/W8tzZlfAqTmnTytTOiDe/2TNBGHcK9HiLWgM6Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=BkyescGXXlEUhKfFGug3euJywCIkhDGRElVJujQJxPcwe2MqPeBS72CZszGSkgtAq
	 bpjgr27bKuHrDRKyj8Lsej68e0uxfVAR6aFzW9+C0BA5MsbQb97NlL/IQwzfUAPe56
	 Kdb7YAhGTRv6x7CPt/2g12StlVW/0h72PNTO6o19vCGiS3IIfwJILJimySfH9BpcuI
	 j/9XOOMxO6harw08eetHD9vg9SqQZJ5GL3r6VIUgPVh58edV/Ln3Bevnocn2Dx+0Er
	 hFv5kTN3H/TZ5m8oqWVJ98glJ7uhBOZgE2hyAX+0JhK4QyZhSvTI6ttGmnnT1JYaPW
	 0MLLGm70nS0Lw==
Date: Mon, 6 Jul 2026 22:57:30 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Alexandre Knecht <knecht.alexandre@gmail.com>
Cc: herbert@gondor.apana.org.au, "David S . Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: Re: [PATCH] crypto: ctr - Convert from skcipher to lskcipher
Message-ID: <20260707055730.GB1791@sol>
References: <20260510230901.1772949-1-knecht.alexandre@gmail.com>
 <20260510233237.GA60510@quark>
 <20260510234452.GB60510@quark>
 <CAHAB8Wy1APeCcm7_OfrNYeZFcMXfZ5rUSeDX7-c7WO_rGg2Zig@mail.gmail.com>
 <20260511001935.GC60510@quark>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511001935.GC60510@quark>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:knecht.alexandre@gmail.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,m:knechtalexandre@gmail.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-25690-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sol:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCEAF717B83

On Sun, May 10, 2026 at 05:19:35PM -0700, Eric Biggers wrote:
> On Mon, May 11, 2026 at 02:02:22AM +0200, Alexandre Knecht wrote:
> > Le lun. 11 mai 2026 à 01:44, Eric Biggers <ebiggers@kernel.org> a écrit :
> > > Also note that lskcipher doesn't provide access to the accelerated AES
> > > mode implementations.  Indeed, almost nothing is supported by lskcipher.
> > > The fact that you found something to be missing isn't surprising.
> > >
> > > I think "lskcipher" is kind of a dead end, to be honest.  It's not clear
> > > why it got added.  The path forwards is to get the AES encryption modes
> > > added to lib/crypto/ and to just use that instead.
> > >
> > > - Eric
> > 
> > Hi Eric,
> > 
> > Thanks for the review — you're asking the right questions.
> > 
> > I'm developing a VXLAN/EVPN-based CNI for Kubernetes (releasing in the
> > coming months), and the goal is to implement datapath encryption for
> > overlay traffic in a zero-trust datacenter model. The encryption
> > happens in BPF programs attached via TC on the VXLAN device (encrypt
> > inner frames on egress, decrypt on ingress).
> > 
> > The algorithm I actually need is AES-GCM (authenticated encryption of
> > VXLAN inner frames, with the outer headers as AAD). When I looked at
> > bpf_crypto, I found that:
> > 
> > 1. Only lskcipher ("skcipher" type) was implemented
> > 2. ecb(aes) was the only usable algorithm
> > 3. AEAD support was designed for (authsize field exists in
> >  bpf_crypto_params, setauthsize in bpf_crypto_type) but never
> >  implemented
> > 4. ctr(aes) wasn't available as lskcipher either
> > 
> > I looked at Herbert's history converting ECB and CBC to lskcipher and
> > assumed that was the path forward for CTR. But you're right, the
> > real goal is AEAD, not CTR. CTR alone doesn't give me integrity.
> > 
> > Your point about lib/crypto/ is interesting. If there's a path to
> > expose AES-GCM (or the building blocks) as direct library calls that
> > BPF programs in TC/XDP could use (avoiding the template/instance
> > machinery and getting hardware acceleration) that would be ideal for
> > this use case.
> > 
> > What would that look like? Is there existing lib/crypto/ work for
> > AES-GCM that could be wired up to BPF, or would that need to be
> > built?
> 
> Sure, it makes sense that AES-GCM is what you actually need.  There's
> actually a lot of demand for AES-GCM in lib/crypto/, and I've been
> working on it.
> 
> There's already an existing AES-GCM lib/crypto/ API (see
> include/crypto/gcm.h), and I optimized it a bit in 7.0 and 7.1.  For
> example, it now uses the architecture-optimized single-block AES code.
> 
> You might be able to go ahead and use that right now.
> 
> However, it currently supports only one-shot computation, and it doesn't
> yet take advantage of the fully optimized AES-GCM assembly code that
> interleaves the AES and GHASH computations.  I'm planning to address
> both of those limitations soon.
> 
> Anyway, that seems like the clear way forward.  The lskcipher thing
> seems like a dead end to me.

FYI, the following series adds new library APIs for AES-GCM and other
AES modes:
https://lore.kernel.org/linux-crypto/20260707053503.209874-1-ebiggers@kernel.org/

It also includes proof-of-concept patches to convert BPF crypto to use
the AES-ECB and AES-CBC library APIs, then add AES-GCM support.

I think that is roughly what you're looking for, and also what should
have been implemented in "BPF crypto" in the first place.  (Minus
AES-ECB, which is silly and should never have been supported in BPF
crypto.  And maybe minus AES-CBC too.)  But let me know what you think.

(I didn't Cc that series to everyone just for the proof-of-concept
patches, as I wrote them for lots of kernel subsystems.  For now they're
mainly for informing the API design and preparing for later.)

- Eric

