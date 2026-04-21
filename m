Return-Path: <linux-crypto+bounces-23309-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +GZTL6vr52ljCwIAu9opvQ
	(envelope-from <linux-crypto+bounces-23309-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Apr 2026 23:27:07 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 276B143FBC4
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Apr 2026 23:27:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C99A53058099
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Apr 2026 21:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525DB39A818;
	Tue, 21 Apr 2026 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWi9sPJi"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1654F359A90
	for <linux-crypto@vger.kernel.org>; Tue, 21 Apr 2026 21:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776806825; cv=none; b=HsHPuQoYOQU+PnDO0kIVj06yXhOM2kLD0DL8tOKreP+lJN7ewaxSVS7vr/Mi00q955WCS5FYNe7Etuugcnsit1CfJqvJaP+VS1mtZGSv9q0PHzq2TyfXt3HtHOTy+jWG8YfjAWnP3xhiDmnu4o6N3/97VAgds5njs28xomdyb24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776806825; c=relaxed/simple;
	bh=g9tLlWXToaYb9ToizB8ZRA3waTp4yCz8Brvd7xZBe/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoYrL0+15+qtWq5SlehtHK81o4qW+TZXBBpzbnavTRZ37IcqrKurwoqsmadk9zBkjAhsI72KZjrsAQfbk9qHI3ESS4Kae3bkhJl/XskQXnJRFubBG3JNxEcEGjZ0nwAL6Nprc5YjrnlCASAqi1Rji4U7rTNomh5zxTVMXicuuOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWi9sPJi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6B3C2BCB0;
	Tue, 21 Apr 2026 21:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776806824;
	bh=g9tLlWXToaYb9ToizB8ZRA3waTp4yCz8Brvd7xZBe/M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kWi9sPJim4LGY520wI2aKUYmGG5I938y1TNnZWSqXbKQSTj8uEFZboCdBsGkgyRJ9
	 r5ARqot0FnOUjS7FmKWGMFA87cyB5H5JnFxTzldDr5QlFEdOMJGS23FA9vhs5XKiTz
	 akqch9PN745HmdTOu9Brt/QCV32kOWZAIgN0xjL/zIefXKIyEm8Q4fnlib5e+3pzUl
	 HRKtEi65Wg30BBCV+jYwC9oFDIm1cjZg0+GQnrvU0veg6AEWlS09WQIn1dWUPvZwDH
	 iV91gDS6vdxbRI/sA/RnaaB/hIRLIlNGuaME+RQnhSyhnhPicwKaGsiy183TpYCGbF
	 3DXE4edb7IRrw==
Date: Tue, 21 Apr 2026 14:27:01 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ren Wei <n05ec@lzu.edu.cn>, linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>, davem@davemloft.net,
	yuantan098@gmail.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
	bird@lzu.edu.cn, z1652074432@gmail.com, kanolyc@gmail.com
Subject: Re: [PATCH 1/1] crypto: authencesn: reject short ahash digests
 during instance creation
Message-ID: <20260421212701.GA37143@quark>
References: <cover.1775217403.git.kanolyc@gmail.com>
 <cb1188757edab9b056961d4d2441be009ac73ce8.1775217403.git.kanolyc@gmail.com>
 <fd3a1c5d-8ebf-48de-91a0-019b05f1dc41@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fd3a1c5d-8ebf-48de-91a0-019b05f1dc41@app.fastmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lzu.edu.cn,vger.kernel.org,gondor.apana.org.au,davemloft.net,gmail.com];
	TAGGED_FROM(0.00)[bounces-23309-lists,linux-crypto=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 276B143FBC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 11:21:54AM +0200, Ard Biesheuvel wrote:
> > diff --git a/crypto/authencesn.c b/crypto/authencesn.c
> > index 542a978663b9..bf44f035f7f8 100644
> > --- a/crypto/authencesn.c
> > +++ b/crypto/authencesn.c
> > @@ -384,6 +384,11 @@ static int crypto_authenc_esn_create(struct 
> > crypto_template *tmpl,
> >  		goto err_free_inst;
> >  	enc = crypto_spawn_skcipher_alg_common(&ctx->enc);
> > 
> > +	if (auth->digestsize > 0 && auth->digestsize < 4) {
> > +		err = -EINVAL;
> > +		goto err_free_inst;
> > +	}
> > +
> 
> Is this the best place for this check?

I probably would have put it a few lines earlier, right after the line
'auth_base = &auth->base;'.  But this works too.

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

Of course, while this patch needs to be applied, this also doesn't go
nearly far enough.
https://lore.kernel.org/linux-crypto/20260420094120.5167-1-ardb@kernel.org/
removes the so-called "cipher_null", which has no reason to exist.

But "authencesn" itself should not be exposed to AF_ALG, let alone exist
in its current form at all.  The IPsec sequence numbers should just be
handled internally in the IPsec code itself.  That would be simpler and
more efficient, with much less UAPI surface as well.

- Eric

