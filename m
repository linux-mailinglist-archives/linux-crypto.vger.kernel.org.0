Return-Path: <linux-crypto+bounces-25716-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id T+DrKXerTWqz8gEAu9opvQ
	(envelope-from <linux-crypto+bounces-25716-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 08 Jul 2026 03:44:23 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 044C5720E68
	for <lists+linux-crypto@lfdr.de>; Wed, 08 Jul 2026 03:44:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XJgDXEzh;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25716-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25716-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63DC93007AFE
	for <lists+linux-crypto@lfdr.de>; Wed,  8 Jul 2026 01:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAFA3B14B4;
	Wed,  8 Jul 2026 01:43:18 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9741D3AEF44;
	Wed,  8 Jul 2026 01:43:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783474997; cv=none; b=t17iFmNrppBv6SNbYmZMuxsYMxvJNa4X0+WExYCv3TB5PSjVzk6i/oTIgPg4siAylRqLYWMQLGyxvZ6YVXLUTsAUy1vHwp2ObE+v2b6DkNauxTSxe+yAt3nkETnK4c5GKo2lGwGI+dcMOFoaLhqaPjerhhokXQoEfVKLXk19YU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783474997; c=relaxed/simple;
	bh=Q7vOAQhGthhBaYjg4wwCSrYWjM7y9kEKPuHFOkkMvpA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N8AW20S3s0iWVRYrN/CiOUg6Mob7RJjTZVWXKHHr7BFKe3AtY0SHxr6stNaYJpyngEgbcSCyBYzAS5rwIOja0QlnARmB1WUxRR/Ylun2lt3zEguFS2t/roA/yg/mzEmc4TRW0ecdOFauoQmEelu+Tx0v+XDm1EjD7h497QPmSrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJgDXEzh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 232A11F00A3A;
	Wed,  8 Jul 2026 01:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783474995;
	bh=WWR75EqCPyn5f745AC6XnzbRG/SWIB6PaCiEcPoriy8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XJgDXEzh8CVyTD/Z03RX3QyKd/xF/fYLcQKwRRlwwCV5d8PDWACBVAP21d2a9yHyj
	 GjSI3lavy3/6qBkhVohMA1AYG4ElZ+0SLILPubNT/Wn6Nh30XapGaVAdDnFC7YdMUW
	 zEsaPBum0iy87uN6MbzMBDmtjPStupLDdX+P/7Lensy+FtB93a1nbuNk+OYu8T8CEH
	 z5zBAoV2n39Dh8/zEDnneemxC4+hPIiLtdftMeF1EMkhbeDuSCqkaulojxhLSS2Bkb
	 PWYoVJv5hekXK2OGS1bRDOPrfpWxMgnM6j0l34sGm5HeMZszTSv9oK3q3TsBEQRtKS
	 QOV7h79+G6jcA==
Date: Tue, 7 Jul 2026 18:43:13 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Milan Broz <gmazyland@gmail.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH] crypto: af_alg - Allow additional ciphers for cryptsetup
Message-ID: <20260708014313.GA1949@quark>
References: <20260705184419.40762-1-ebiggers@kernel.org>
 <276a4c4e-bbe4-4f6f-9f9a-c1e195e06c86@gmail.com>
 <20260706202445.GA283366@quark>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706202445.GA283366@quark>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gmazyland@gmail.com,m:herbert@gondor.apana.org.au,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-hardening@vger.kernel.org,s:lists@lfdr.de];
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
	TAGGED_FROM(0.00)[bounces-25716-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,quark:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 044C5720E68

On Mon, Jul 06, 2026 at 01:24:45PM -0700, Eric Biggers wrote:
> On Mon, Jul 06, 2026 at 08:20:10PM +0200, Milan Broz wrote:
> > On 7/5/26 8:44 PM, Eric Biggers wrote:
> > > Add "xts(camellia)", "xts(serpent)", and "xts(twofish)" to the allowlist
> > > for af_alg_restrict=1.  These niche AES alternatives have continued to
> > > see rare but persistent use via cryptsetup, which has historically
> > > relied on the AF_ALG support for these ciphers in XTS mode for
> > > performing the keyslot encryption.  (cryptsetup v2.8.7 and later fall
> > > back to a temporary dm-crypt mapping, but that requires root.)
> > > 
> > > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > > ---
> > >   crypto/algif_skcipher.c | 3 +++
> > >   1 file changed, 3 insertions(+)
> > > 
> > > diff --git a/crypto/algif_skcipher.c b/crypto/algif_skcipher.c
> > > index 2b8069667974..49ae779b3b6b 100644
> > > --- a/crypto/algif_skcipher.c
> > > +++ b/crypto/algif_skcipher.c
> > > @@ -45,6 +45,9 @@ static const struct af_alg_allowlist_entry skcipher_allowlist[] = {
> > >   	{ "ecb(des)", true }, /* iwd */
> > >   	{ "hctr2(aes)", false }, /* cryptsetup */
> > >   	{ "xts(aes)", false }, /* cryptsetup benchmark */
> > > +	{ "xts(camellia)", false }, /* cryptsetup */
> > > +	{ "xts(serpent)", false }, /* cryptsetup */
> > > +	{ "xts(twofish)", false }, /* cryptsetup */
> > >   	{},
> > 
> > Well, if we are going this way, I would also add Aria and SM4
> > (currently usable only in cryptsetup main branch).
> 
> I'm adding these three because they seem to have a history of occasional
> use, as can be seen by web search results including their mentions in
> various forums, documentation, etc.  So I worry about breaking users of
> them who upgrade their kernel and still have cryptsetup < 2.8.7.
> 
> It doesn't seem like the same as true of aria-xts or sm4-xts.  And as
> you said they are usable only on the cryptsetup main branch -- which I
> understand now consistently uses the fallback to a temporary dm-crypt
> mapping (at least when run as root).  So perhaps we don't actually need
> to allow "xts(aria)" and "xts(sm4)" as well?
> 
> The point isn't to add things that could theoretically be used, but
> rather add the minimum set that's needed to keep actual existing users
> working.

Do we need to add cbc(...) for these algorithms as well?

- Eric

