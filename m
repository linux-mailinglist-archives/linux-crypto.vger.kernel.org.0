Return-Path: <linux-crypto+bounces-21622-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YB4PGHDQqWmYFgEAu9opvQ
	(envelope-from <linux-crypto+bounces-21622-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 05 Mar 2026 19:50:24 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF622171FB
	for <lists+linux-crypto@lfdr.de>; Thu, 05 Mar 2026 19:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47B41300E191
	for <lists+linux-crypto@lfdr.de>; Thu,  5 Mar 2026 18:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397632D1303;
	Thu,  5 Mar 2026 18:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQhC4PIA"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24A71C68F
	for <linux-crypto@vger.kernel.org>; Thu,  5 Mar 2026 18:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772736618; cv=none; b=Bt/pi44e+GvsL5ubIvvirpUf7cL7Y3HFjzStPmXA+5lkCDV2IMSiIQEAumTeDZJkcqkcCK63edWZJxGXdmfIH9f6i1dhXbuA4+q9l4utQ/hgTt5ljQw5yr5ige5zGkIh2yLmDuIczJoYTQQweMGr1jc/4oQKJitzpgv+SPwZXg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772736618; c=relaxed/simple;
	bh=LurJlOGLaLv3ERNZ1jW49QewAnV1ayjkhtKmH6tq+vg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzOZpynvODcubjZahZVf41hXJ+ungr412wQxIZZ79mCMqUImrg3L8VjVyPDI5zHAIVQHyuQu+kGsmxom2IkmNGfWTYmB7j1FJbKaXgkQGsMDdahbusHKUAbx7fCyb1ARWACUWvMbjAo83465YSQfrXSn2Nmvj8k5XZoiI7SnIkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQhC4PIA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75BA2C116C6;
	Thu,  5 Mar 2026 18:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772736617;
	bh=LurJlOGLaLv3ERNZ1jW49QewAnV1ayjkhtKmH6tq+vg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQhC4PIAjneIg4Cwi7jKaYs5lXDEg8dEwURZQrQJGFBaalZ+8jkhraClJLasp7jqD
	 3lAdjOiIRrkbKZknpDgMMFeX+sjBzkX9/9NMQO5jGl6Z5XpJIjmwux1pxu7nyN2+zW
	 VGXnHx9U5Sp/UrrqvxCaNQms11PlXGSvT3BXQU9DIsKTEzRexL6be0vrr2jLAmPXnN
	 v4x3HATBLnMqt9Y7f6iog5EFOTdCG9wIOT9lb88buV+gQfkjdnUii8TJmiNKY95VlD
	 u+XBlqSS8LPAx3IQtQcPukKCt9PhuiiZJIg4aVJWI2oo+k8CFrYvRe3pvdhR85UyNa
	 c08KegCdVj4lQ==
Date: Thu, 5 Mar 2026 10:50:16 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-crypto@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Subject: Re: [PATCH v3 3/5] crypto: pkcs7: allow pkcs7_digest() to be called
 from pkcs7_trust
Message-ID: <20260305185016.GC2796@quark>
References: <20260225211907.7368-1-James.Bottomley@HansenPartnership.com>
 <20260225211907.7368-4-James.Bottomley@HansenPartnership.com>
 <20260226203133.GB2273@sol>
 <bf8b8c374d4398a677b87246bb426c4cd157e1d0.camel@HansenPartnership.com>
 <20260305075831.GB155793@sol>
 <51cf814b5dd2a126c4b2379c7b7d02ff9d2e17f2.camel@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <51cf814b5dd2a126c4b2379c7b7d02ff9d2e17f2.camel@HansenPartnership.com>
X-Rspamd-Queue-Id: 5EF622171FB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21622-lists,linux-crypto=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, Mar 05, 2026 at 09:53:56AM -0500, James Bottomley wrote:
> On Wed, 2026-03-04 at 23:58 -0800, Eric Biggers wrote:
> > On Thu, Feb 26, 2026 at 10:50:10PM -0500, James Bottomley wrote:
> > > On Thu, 2026-02-26 at 12:31 -0800, Eric Biggers wrote:
> > > > On Wed, Feb 25, 2026 at 04:19:05PM -0500, James Bottomley wrote:
> > > > > +	/*
> > > > > +	 * if we're being called immediately after parse, the
> > > > > +	 * signature won't have a calculated digest yet, so
> > > > > calculate
> > > > > +	 * one.  This function returns immediately if a digest
> > > > > has
> > > > > +	 * already been calculated
> > > > > +	 */
> > > > > +	pkcs7_digest(pkcs7, sinfo);
> > > > 
> > > > pkcs7_digest() can fail, returning an error code and leaving sig-
> > > > >m
> > > > == NULL && sig->m_size == 0.  Here, the error is just being
> > > > ignored.
> > > 
> > > That's right.  Basically I wasn't sure what to return on error
> > > (although -ENOKEY looks about right since it will cause retries on
> > > a
> > > different sig chain).
> > > 
> > > > Doesn't that then cause the signature verification to proceed
> > > > against
> > > > an empty message, rather than anything related to the data
> > > > provided?
> > > 
> > > Not if sig->m is NULL, no, because the verifier will try to reget
> > > the digest in that case (and error out if it fails).
> > 
> > Can you point to where that happens?  It still looks like it just
> > proceeds with an empty message.
> 
> It's the obvious one:
> 
> verify_pkcs7_message_sig->pkcs7_verify->pkcs7_verify_one->pkcs7_digest
> 
> The latter will allocate and calculate the digest if sig->m is null.
> 
> Regards,
> 
> James
> 

But looking at hornet_check_program() from
https://lore.kernel.org/linux-security-module/20251211021257.1208712-9-bboscaccy@linux.microsoft.com/,
it calls:

    pkcs7_parse_message()
    validate_pkcs7_trust()
    pkcs7_get_authattr()

The actual signature check happens in validate_pkcs7_trust(), which
appears to have the issue where it can proceed with an empty message, as
I mentioned.

- Eric

