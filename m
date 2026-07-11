Return-Path: <linux-crypto+bounces-25841-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oumlLDL4UWrlKwMAu9opvQ
	(envelope-from <linux-crypto+bounces-25841-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 11 Jul 2026 10:00:50 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F44E740D66
	for <lists+linux-crypto@lfdr.de>; Sat, 11 Jul 2026 10:00:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25841-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25841-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0615B3021723
	for <lists+linux-crypto@lfdr.de>; Sat, 11 Jul 2026 08:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FE52857FA;
	Sat, 11 Jul 2026 08:00:39 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954874499B8
	for <linux-crypto@vger.kernel.org>; Sat, 11 Jul 2026 08:00:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783756839; cv=none; b=KIDdhaAfuyHgFirx1S9sM7moP+qLdPj7pBq2MnXlOkYV8q80jMtfL+rKEWHsqNrULnIxMhA8OUEmYy1NiottBPRnUF+c+DXEVvKr32BleiilZhIZtWf/AGN+JyeSHrVmP0IG5b3+y7PBPXSH8cxKeVvragddT8EjAvAz4it23HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783756839; c=relaxed/simple;
	bh=MscGTZTkUv6wn8Wn4fUBW0ZSExMyGE7p6dLLOPPbTBU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PvC78NrHHApijsmD3ws2qxQfpe4Ko/NGWO1JfQw/ycqMCY3dFjVQT2S0x3OOZrySdkHT09mshYdlHAt7wMSAiWcGcLVt2RJYrdtWkh0Hf0rR0FXgHduGx7dzW+GPZZWTbGVj7vGc+yiUrgf2WWOlqhuxCRsBaR2yQ10qQUDWIRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.win; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6989c0ec3c5so3172454a12.2
        for <linux-crypto@vger.kernel.org>; Sat, 11 Jul 2026 01:00:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783756836; x=1784361636;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MscGTZTkUv6wn8Wn4fUBW0ZSExMyGE7p6dLLOPPbTBU=;
        b=WKUVjbhwDRDSPZOroyRNZvW1euMYhScn18YdrUC5dj8huKH1FVudHn/MqUZli1rn93
         78olCyFWwahwMwziwMAOFGHp5Zo2HpN8svi+Y0ERYlSUHPAXdDFYT58vYWUjp7v+uq5W
         F/B+msmgoYsS785+drriXAaUIrrKlz/5dYl0GZOnwLp3qXVr0XGghYmRGppqAEq5d/h+
         jZM/2KCSnvvzwyNVWurG2r+XapEdQk2xmtbosLTLxbFTCJMhC80CGMfHnr7dwDuQ7x2I
         KZSyMeXIdmdV8UwSI3hCrv2zEq3qddnvB7SqL6hbu/lz9f2KWI43kUfdXcBR7v4nF1/G
         pTog==
X-Forwarded-Encrypted: i=1; AHgh+RqBuyoRawDzdDAdIz3odL4778fA6RWwIwgxDw1JTo6Q2E5T33LBEsIOBFNY/nZ5bbHWzJGOcADrjp960UI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyexZo5cCGMt4xHQV1Ok4dhsJ+oTE34+dkpi6A5pdhQLy/tnlo
	ReACYvZ6J9B3IF+U7XhEaRHNe/BOWIw0gceobzOSX+U7/G8u1cJLKTPJZrtLWBbiaiA=
X-Gm-Gg: AfdE7ck3z65qTGzPi3oYwJx/kDAA9FDDy2JAHqeOnTL/2AjFkd8lU/PZZx09/yvW3Tn
	TtSUs2nM0G2wagnjCR6W7jvsLTThRbYOs6A5RHFrV0IcB9/VY2/5lZ4dwL6aBOv1rvzDarKAy3S
	++Z+/5Psrpes3kj4P0Q5v+S2H5q3Ncwc689Aa4Ynfe7qXhWH5Epf8BAJgN9oWJ45q0vrKXT/sIB
	aqZLRU3aSinda1PzHxDplOyfntxacJfKXMMVl6OSbOdaGHpt5przD3zyFrNhe1SXlezj7AqhU9Q
	blOx1SaDO/yPsZ+J1wT29jqxj2/PnYLhuPuBN8iQbpUThXmd4YWlzqoJmOtVmD0eKnU6LohSyOd
	RyPda4ERHOcZyPTUz9SI6+y040lAQ6Xk+69YWXF6H5sqIaf6fJJFXx8+RzaqxhBX37aTPKbSyKY
	VfiQpNEEEi4Sns/Z/SfJkjOcVYw3Q+03zcQYEBDY4Nt/LptAWOirxUAA==
X-Received: by 2002:a17:907:a644:b0:c15:b96f:c3d1 with SMTP id a640c23a62f3a-c161ea1f5bcmr78775266b.41.1783756835756;
        Sat, 11 Jul 2026 01:00:35 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15e1289befsm383213966b.28.2026.07.11.01.00.34
        for <linux-crypto@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 01:00:34 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-c15f6d667bcso210395066b.2
        for <linux-crypto@vger.kernel.org>; Sat, 11 Jul 2026 01:00:34 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrxc9NEC0kwiXWgmZ58o27sgTY1iMvi1xIwmGo9RnSgJnSBsyGvgOAGs50pcF4Tw+3yBi33yC23FbUWOOU=@vger.kernel.org
X-Received: by 2002:a17:907:d1d:b0:c15:ec09:d099 with SMTP id
 a640c23a62f3a-c161e84b50cmr83397566b.3.1783756834345; Sat, 11 Jul 2026
 01:00:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <alEr_e-G0L2nxxv-@fudgebox> <20260710213718.GD1911@quark> <2026071156-masculine-unsold-3567@gregkh>
In-Reply-To: <2026071156-masculine-unsold-3567@gregkh>
From: Ignat Korchagin <ignat@linux.win>
Date: Sat, 11 Jul 2026 09:00:23 +0100
X-Gmail-Original-Message-ID: <CAOs+rJUPQq88D7YwHyrbTFF-G9Lw7cJ9pcaZBpACP89ES9z00w@mail.gmail.com>
X-Gm-Features: AUfX_mxfB9lRyM9aBgF-lmD7co2kMM6ObJOg0FVE2xaT4F56v9KALHh3-mPpr-Y
Message-ID: <CAOs+rJUPQq88D7YwHyrbTFF-G9Lw7cJ9pcaZBpACP89ES9z00w@mail.gmail.com>
Subject: Re: [PATCH] crypto: rsassa-pkcs1: use constant-time comparison for
 digest and signature verification
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Eric Biggers <ebiggers@kernel.org>, 
	"David C.C.M. Gall" <david.ccm.gall@googlemail.com>, Lukas Wunner <lukas@wunner.de>, 
	Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>, 
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25841-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,googlemail.com,wunner.de,gondor.apana.org.au,davemloft.net,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[linux.win];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:ebiggers@kernel.org,m:david.ccm.gall@googlemail.com,m:lukas@wunner.de,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davidccmgall@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ignat@linux.win,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ignat@linux.win,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0F44E740D66

On Sat, Jul 11, 2026 at 6:19=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Fri, Jul 10, 2026 at 05:37:18PM -0400, Eric Biggers wrote:
> > On Fri, Jul 10, 2026 at 07:29:33PM +0200, David C.C.M. Gall wrote:
> > > Replace memcmp() with crypto_memneq() for cryptographic digest and
> > > signature comparisons to prevent timing side-channel attacks.
> > >
> > > crypto/rsassa-pkcs1.c: RSA signature digest verification used memcmp
> > > which can leak valid prefix length via timing analysis, user data
> > > could reach the leaky comparison via the digest argument to verify.
> > >
> > > Assisted-by: gregkh_clanker_t1000
> > > Signed-off-by: David C.C.M. Gall <david.ccm.gall@googlemail.com>
> >
> > While we should use crypto_memneq() on MACs, auth tags, and other secre=
t
> > data, I don't think we should let it creep into domains where it is
> > clearly not needed, like public key signature verification.
>
> But isn't this user-controlled data and so a user could use it to figure
> out the key?

This is signature verification with a public key. So the user knows
the key already.

> thanks,
>
> greg k-h
>

Ignat

