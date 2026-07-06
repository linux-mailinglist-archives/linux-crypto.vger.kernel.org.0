Return-Path: <linux-crypto+bounces-25652-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0CDDNxgPTGp/fgEAu9opvQ
	(envelope-from <linux-crypto+bounces-25652-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 06 Jul 2026 22:24:56 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 423F9715671
	for <lists+linux-crypto@lfdr.de>; Mon, 06 Jul 2026 22:24:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=jX9VjPwb;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25652-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25652-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E79A3002D42
	for <lists+linux-crypto@lfdr.de>; Mon,  6 Jul 2026 20:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE923E00AA;
	Mon,  6 Jul 2026 20:24:48 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A273DC4AB;
	Mon,  6 Jul 2026 20:24:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783369488; cv=none; b=kxygQyLI9cErRqhnglpgB6uapEZS1XIcNL6ZZY5lHee/Ak5cdffDxoa2JrkHSwN6vAr8cKoaABeZ5k9QZhsgOsKJp2ExG86xpJy0tEm/sDbr5G7lu/07+Cs0MRqvTOmZtzLkXrxw2CR4v8DIfCiNp7P8cjxSC0OYxYVBoIvuIP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783369488; c=relaxed/simple;
	bh=C0IdBgwluOdkvoJhUK4YmzgWofAi2f6pxu1H/RBLTkI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q7ihALipcCJcMyBK1BhMIk8rY8Fz1Ej2m5pgB10R/91KEdqTKmxNAKAjeG7/duSaTt+ampN+kduLWihtRtiUhmm5IJ3S0KQmtZDWIYGHOZpmYEIxZaAd0A+Dmp82xNx2VsnsU/rvAxtT6+Rr1pQKCTCsF31G4VB89szzf7OBK1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jX9VjPwb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B987B1F000E9;
	Mon,  6 Jul 2026 20:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783369486;
	bh=5V2MYmXw0IMspTQHOBJTvMJEn+62Lokecxupqj4r6JI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jX9VjPwbhsRJ02+sVOKhGpdCFa//B1cNzRDkCiXnL4+ts1hPSsXp/P4712PS3LgXz
	 oh/ww9IMlCBakAJxyl+LCvw1piLRNo/8sdHnNM55HSeEV4lZggt+iLXr2TyHIeqDFE
	 g1LRULajgRJWVF2Mu71TRMvNnB24rfyK1fu83RRqEOSuLgWxjgcBsEonGklU0Vpbpn
	 DNCqn2OK+OqHVtetw0c45Vjq9vvxQmOwtGopbAyYksdn+16VFEuEndVmKnlxlJdZUi
	 PVkwriu4/obPw0BTFZEUqXGqyp8xeSA7/4xkra//qYmSpB1caUdpZA8CDvDCwHfIk8
	 gWnDm1Z3fRBDQ==
Date: Mon, 6 Jul 2026 13:24:45 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Milan Broz <gmazyland@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] crypto: af_alg - Allow additional ciphers for cryptsetup
Message-ID: <20260706202445.GA283366@quark>
References: <20260705184419.40762-1-ebiggers@kernel.org>
 <276a4c4e-bbe4-4f6f-9f9a-c1e195e06c86@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <276a4c4e-bbe4-4f6f-9f9a-c1e195e06c86@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:gmazyland@gmail.com,m:herbert@gondor.apana.org.au,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-25652-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,quark:mid,sporks.space:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 423F9715671

On Mon, Jul 06, 2026 at 08:20:10PM +0200, Milan Broz wrote:
> On 7/5/26 8:44 PM, Eric Biggers wrote:
> > Add "xts(camellia)", "xts(serpent)", and "xts(twofish)" to the allowlist
> > for af_alg_restrict=1.  These niche AES alternatives have continued to
> > see rare but persistent use via cryptsetup, which has historically
> > relied on the AF_ALG support for these ciphers in XTS mode for
> > performing the keyslot encryption.  (cryptsetup v2.8.7 and later fall
> > back to a temporary dm-crypt mapping, but that requires root.)
> > 
> > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > ---
> >   crypto/algif_skcipher.c | 3 +++
> >   1 file changed, 3 insertions(+)
> > 
> > diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
> > index 2b8069667974..49ae779b3b6b 100644
> > --- a/crypto/algif_skcipher.c
> > +++ b/crypto/algif_skcipher.c
> > @@ -45,6 +45,9 @@ static const struct af_alg_allowlist_entry skcipher_allowlist[] = {
> >   	{ "ecb(des)", true }, /* iwd */
> >   	{ "hctr2(aes)", false }, /* cryptsetup */
> >   	{ "xts(aes)", false }, /* cryptsetup benchmark */
> > +	{ "xts(camellia)", false }, /* cryptsetup */
> > +	{ "xts(serpent)", false }, /* cryptsetup */
> > +	{ "xts(twofish)", false }, /* cryptsetup */
> >   	{},
> 
> Well, if we are going this way, I would also add Aria and SM4
> (currently usable only in cryptsetup main branch).

I'm adding these three because they seem to have a history of occasional
use, as can be seen by web search results including their mentions in
various forums, documentation, etc.  So I worry about breaking users of
them who upgrade their kernel and still have cryptsetup < 2.8.7.

It doesn't seem like the same as true of aria-xts or sm4-xts.  And as
you said they are usable only on the cryptsetup main branch -- which I
understand now consistently uses the fallback to a temporary dm-crypt
mapping (at least when run as root).  So perhaps we don't actually need
to allow "xts(aria)" and "xts(sm4)" as well?

The point isn't to add things that could theoretically be used, but
rather add the minimum set that's needed to keep actual existing users
working.

> There is another user of AF_ALG hash, hardlink in util-linux, see
> https://github.com/util-linux/util-linux/blob/master/lib/fileeq.c

The AF_ALG use in 'hardlink' is unnecessary and has just been causing
problems
(https://sporks.space/2026/05/19/chasing-down-why-installing-the-kernel-segfaulted/).
Fortunately, it's not a hard dependency, as it already has a working
runtime fallback.  This was discussed on the util-linux issue tracker as
well, and I understand the AF_ALG use is planned to be removed.

- Eric

