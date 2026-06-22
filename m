Return-Path: <linux-crypto+bounces-25312-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id keQDM99OOWqHqQcAu9opvQ
	(envelope-from <linux-crypto+bounces-25312-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 22 Jun 2026 17:03:59 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B8166B0941
	for <lists+linux-crypto@lfdr.de>; Mon, 22 Jun 2026 17:03:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IihDIC4+;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25312-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25312-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96A013004C0E
	for <lists+linux-crypto@lfdr.de>; Mon, 22 Jun 2026 14:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7E33101A5;
	Mon, 22 Jun 2026 14:56:17 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A11A30F958;
	Mon, 22 Jun 2026 14:56:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140177; cv=none; b=IyQYUi+cFAz+xGa0SnY49FlBZL4pORWR/nHP1HspeL0+Dn2gGPRcCo8yD70jeHltigNGVkP2zL5Hxwe8Hf3Mmg18w3HQ0WQ26eDa2ROyUNSOAhNkaD5s8LD0Q/IA7xp0kBh6kiQgR4YrVbMDrYg3MnYzJtJT7DbGfrRzZlhZK8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140177; c=relaxed/simple;
	bh=Q8cnKTr5Gh+ig4y7XghOSKCucx5F1OW3eLFRGxBdlLc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoeq5pXBe8kX9Y3h8Wzoe7lK+VSWP49Pkch9HkybfHy588+cktmCvgfDYQ/YefvWC5PKm3c+gPWZtbMnCLNAbQG4g8tBpjAqu+ZvzEvXdoS66lnb50bzWrB3ZiGlgpvgyMeSc/lgvjb9jZEfOVnYBILBh36OEIJSVAvA6NtNw/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IihDIC4+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6047D1F000E9;
	Mon, 22 Jun 2026 14:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782140175;
	bh=7+xd5/DgJYlCExSOQuRhC1KD3huRFMoCoOulZj4XDjQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=IihDIC4++KdDUXuTnvp5AEW5NknSpDvcZJHhB587L6oJB9fmkKd4xlUKTS5au+gm2
	 sD32z5LLUzXrXh6gc0r7e7gcJ9O7L91SOtGB44LTdqF9JB7eYhFkeOcQb38bFglbb7
	 hGk6uyRl8XmkAf3AvxTKId6MetM23KPxRougzaxE41CiDdBXGZIgGwh45zU0KelZPI
	 KDmkCup23wast1juNCETYR388CwcGs7i4qKj8P/AlHSA79HVvCY0dtOtdjxSRZERxS
	 vIwxAla9uLbxdsFvosKOEcm5kRj2Kn11V1EIKKlt0zaFngdM1nLbitG9+XIE0axonE
	 e7+GSSMd5bbfA==
Date: Mon, 22 Jun 2026 17:56:11 +0300
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Weiming Shi <bestswngs@gmail.com>, David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>, Ignat Korchagin <ignat@linux.win>,
	"David S . Miller" <davem@davemloft.net>, keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH v2] asymmetric_keys: check asymmetric_key_ids() for NULL
 before dereference
Message-ID: <ajlNCxltXkuWfIw-@kernel.org>
References: <20260502163328.696098-2-bestswngs@gmail.com>
 <aji3B9a72VEAOu03@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aji3B9a72VEAOu03@gondor.apana.org.au>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25312-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:bestswngs@gmail.com,m:dhowells@redhat.com,m:lukas@wunner.de,m:ignat@linux.win,m:davem@davemloft.net,m:keyrings@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:xmei5@asu.edu,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jarkko@kernel.org,linux-crypto@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,wunner.de,linux.win,davemloft.net,vger.kernel.org,asu.edu];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jarkko@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7B8166B0941

On Mon, Jun 22, 2026 at 12:16:07PM +0800, Herbert Xu wrote:
> On Sat, May 02, 2026 at 09:33:29AM -0700, Weiming Shi wrote:
> >
> > diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
> > index 16a7ae16593c..22f04656d529 100644
> > --- a/crypto/asymmetric_keys/asymmetric_type.c
> > +++ b/crypto/asymmetric_keys/asymmetric_type.c
> > @@ -109,6 +109,8 @@ struct key *find_asymmetric_key(struct key *keyring,
> >  	if (id_0 && id_1) {
> >  		const struct asymmetric_key_ids *kids = asymmetric_key_ids(key);
> >  
> > +		if (!kids)
> > +			goto reject;
> 
> This check is actually unnecessary because we've already matched
> the key against the kid so it must be present.
> 
> I'd get rid of this check or perhaps add a comment instead.

+1

> 
> >  		if (!kids->id[1]) {
> >  			pr_debug("First ID matches, but second is missing\n");
> >  			goto reject;
> > diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
> > index 86292965f493..ccf1084f720e 100644
> > --- a/crypto/asymmetric_keys/restrict.c
> > +++ b/crypto/asymmetric_keys/restrict.c
> > @@ -243,10 +243,14 @@ static int key_or_keyring_common(struct key *dest_keyring,
> >  			if (IS_ERR(key))
> >  				key = NULL;
> >  		} else if (trusted->type == &key_type_asymmetric) {
> > +			const struct asymmetric_key_ids *kids;
> >  			const struct asymmetric_key_id **signer_ids;
> >  
> > -			signer_ids = (const struct asymmetric_key_id **)
> > -				asymmetric_key_ids(trusted)->id;
> > +			kids = asymmetric_key_ids(trusted);
> > +			if (!kids)
> > +				goto skip_trusted;
> 
> Yes this is definitely buggy.
> 
> I think it was introduced by these two commits:
> 
> commit 3c58b2362ba828ee2970c66c6a6fd7b04fde4413
> Author: David Howells <dhowells@redhat.com>
> Date:   Tue Oct 9 17:47:46 2018 +0100
> 
>     KEYS: Implement PKCS#8 RSA Private Key parser [ver #2]
> 
> and
> 
> commit 7e3c4d22083f6e7316c5229b6197ca2d5335aa35
> Author: Mat Martineau <martineau@kernel.org>
> Date:   Mon Jun 27 16:45:16 2016 -0700
> 
>     KEYS: Restrict asymmetric key linkage using a specific keychain
> 
> So the Fixes header should point to them.

+1

> 
> > @@ -290,6 +294,7 @@ static int key_or_keyring_common(struct key *dest_keyring,
> >  		}
> >  	}
> >  
> > +skip_trusted:
> >  	if (check_dest && !key) {
> >  		/* See if the destination has a key that signed this one. */
> >  		key = find_asymmetric_key(dest_keyring, sig->auth_ids[0],
> 
> I'm not sure continuing here is a good idea.  Having a private key
> here makes no sense whatsoever and we should just bail out right
> away.
> 
> I would recommend returning an error of some sort if kids is NULL.
> 
> David/Lukas/Ignat, any opinions?

I think with a quick skim that you are right. I'll work on this area
for the next version.

> 
> Thanks,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

Thanks for the review!

BR, Jarkko


