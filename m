Return-Path: <linux-crypto+bounces-20223-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wASrIY2McGkEYQAAu9opvQ
	(envelope-from <linux-crypto+bounces-20223-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 21 Jan 2026 09:21:33 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E831536DE
	for <lists+linux-crypto@lfdr.de>; Wed, 21 Jan 2026 09:21:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E16B86A543C
	for <lists+linux-crypto@lfdr.de>; Wed, 21 Jan 2026 08:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B74F477E42;
	Wed, 21 Jan 2026 08:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="KOcjqnQe"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D98392C3D
	for <linux-crypto@vger.kernel.org>; Wed, 21 Jan 2026 08:15:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768983334; cv=pass; b=AYZg5HINK07PN+ChJlg5OArs4z1lAJIwHFktptKDsLfq7q6oG6q0DxecyqJkG0RzjPCHWfJ9+yMRNkGlRFFxgUxdQ2HDOgn1Pby7dqT0sengNkdT6HdRcOL8qW4VgrJOqY+Vgz7lPQk9XYRTO01rbZBTD2z6aLXgeM4nSJCAmr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768983334; c=relaxed/simple;
	bh=4xOSg15Duh0aKIvIiIvJnr5jMlVoah6kN6MUMXL0lQ0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=giUgG9YKuyPl9615CHBRXAhIl7ccMABHXLsq3CaFvvxfzNbZxpBIQ4IZpVYrzrkxCXUFPW3N+dfXkWnTlIIANiXz1sGMw15NJvYrr+faXfZT0CFBBPfL8g6quqF4Vq4GylX/uXeAF02RXRQoROXhfWIG0ZyhPyCl5Ifa7dHW/44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=KOcjqnQe; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-382fb275271so60949001fa.0
        for <linux-crypto@vger.kernel.org>; Wed, 21 Jan 2026 00:15:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768983330; cv=none;
        d=google.com; s=arc-20240605;
        b=b/8IZEgUlElgEHogqio6HYwhNsdHHqXSU6NojNhmt0OhfyU37okFW+cWiJbuoyid/Y
         rA0tyqNapONd24hR1PgxaRaihHxv63/t+eGIAfNhH0cfTjcbU+XEN3BTQOFpHQ0taQ3c
         wltyXB5/2BfjSLDdbFxkfZNq9Th8/hV9dVOl8tp7++H1EMjeYRWusdo41pfyiE1YqvWq
         cQpu6J1K2Xz7zx7ACbZWPSU53nH31qH8lco8nkHOXxa/jO5+FpplnUbj3zFFkHW/9xcs
         gAWUqkpI1wTHJgr1G2Wvi0z8vSaysQfDC95JPlhD172+7LwVhxaUIXdPrFo5kt3+rZ/K
         RaKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Tg331x7QRxaHb4gr7UunKItE+K9JK81l28/Y7k0I0X0=;
        fh=ujyVy1luWZF5iSuBgymGshzZILIrxWUEhcr1BLtWFKw=;
        b=Nf8O9vS6Alt78c/CPVbd5Vm8QVFEyWRV/mhd5Hlui/Nc5CVrzcNWz6wbCH36aTA4xt
         NMWWbHO/msS5D2QxuQOW8JMIj+ElPA0ftFpCHYP4cMwqGu8mnTy9V7nTrz2N+bIoSGqY
         tbFouDoTKNqrUEgWIWhqc6HbFlZhHN2nOXyMZs9Z4UThQIstpzOuSBThYv8Nh9WLeV17
         DOle1FO0MLeUQ+N4yX5qpZF6bfKFaf2up49UBsQVGIcrR/7KPs2ZJGOpNXDanqWJz+L9
         o99LnaTIm12wXXWs35bG/31IyGp1Jb0Ss7dU61DLCRNetbG4uyD4mlFHyicVLrV6fKud
         FJZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768983330; x=1769588130; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tg331x7QRxaHb4gr7UunKItE+K9JK81l28/Y7k0I0X0=;
        b=KOcjqnQeKMZsV8sK8z5YWfCT4H2bFSv+qMW8sSOZ1mkvwrjuWFcfSa9yw50pj9PgaW
         2bMW+iInMn88dHr+Ar0gaT/ZqboBSFbNHomc1aWdGrdMd62fdHQfFLD/XKIT/91Dluel
         ugrK1mtoOTHoc2qtZqN/hRW9Tf2OP3b7+j+sq5TFV8b9TbYiekMfW/ezx51GQw4BuHdu
         9jckbSIqrapFylDzoSJiJLVBg0ZgHo+eeMzDDzCX+2Pwm921QFgGPfKJYviLheXjmswn
         gdhKFQ8R29TMXoBR41TKRzFpcKfW4HTNCqMEDGgceNxNEpJ6PuPJ79T2sd1eFKcwYVVU
         CAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768983330; x=1769588130;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tg331x7QRxaHb4gr7UunKItE+K9JK81l28/Y7k0I0X0=;
        b=WwbE/0Uy9h3Wycgi3NlwH9dmtjNotfq3C0KqihAHt8dzUXtDLVtuIXWmS6ufzjWV5c
         VmpBnf5vtsgoBzQjessyu72enAicBNx1fHb8N61mmg31g0rlMhG5ei8kw0GF2WioeM8/
         hlm4D0KTkx2kMXt/8wVsnMVNXGpXOAqZxSZ1+yaqtXefSRjoA/A/SZeDkSWzJXylNbpi
         YwyRNBviuTt8naDz/y8IwwSY5HARjVEfI227YTcbt7t15Q0ebNq45AIOIYaullvhnFqm
         4FAuUtUAzhaWQlAdrCSCve3KN/8MBcWgmWu46ewUn3HiqAVqyYVL6GSzAT27iZJsNrcN
         lj3g==
X-Forwarded-Encrypted: i=1; AJvYcCWiiEfUYoDCew/aRO2gDDtqDoqjll6SjKYbZ3xjl+LJjkAD5ysxp1NSS9z7dZpbZZ6ysWOUm2MXL9SVLIk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAaFEUnUEkledEi5/IOUGlCM5GQvEyhZMcbv+Yg7+T2IqZJILY
	6ytVWE7ZrEaj4PLPKgeVIsy8x4vNwZgN5LFtWDU0IocFsb7wxWpo0wIyixvxUuiv7EZKpRHdx05
	Nu09Q5ixQKGq9CJ4Dxa2l3faI9CEtX4mCvLBFrz3xxg==
X-Gm-Gg: AZuq6aLiokwJrRJaUXfs8ckF5hkc+r53P5f8qsXdCXZBTTfM3NXtvHP468ltLqsNn2P
	h9PfcRtx8dEfHWdmHmZLqOMoeo5JhNLuMv2sNITwSZnZTAX+YG989ubQxDEMUyaTmkVjzJuqwwt
	ULb1nYFpLUnfyU/QC1qdZIx0x+0JsOw140T/8KQirwitKwY+KVv+4+2sBD4L8IELw+8I3K1Dx0e
	1TxQ5FJYTGeeCqStkk9MU0edIe5+6Wqwdp8rPF1V99gLFZQCWcDov9ARdk13wO8kSBoPMiv2+fK
	/qVM/C/AZgcu/txGhv5M++d8ihHeL5nCkzvW+wU=
X-Received: by 2002:a05:651c:3253:b0:383:5a4f:2605 with SMTP id
 38308e7fff4ca-38386c7911amr59108111fa.44.1768983330420; Wed, 21 Jan 2026
 00:15:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120145103.1176337-1-dhowells@redhat.com> <20260120145103.1176337-8-dhowells@redhat.com>
 <20260120224108.GC6191@quark> <20260121021413.GA998999@google.com>
In-Reply-To: <20260121021413.GA998999@google.com>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Wed, 21 Jan 2026 08:15:19 +0000
X-Gm-Features: AZwV_QibZj8jFhcZpB5co7JZPFE4mwZt4NmmbcLqn7s_BSnM5zg84oYHRH8GoEI
Message-ID: <CALrw=nHLzGjBgvfE9caovw21cpwZkkjLM3Ss47gVZveT1MNRnQ@mail.gmail.com>
Subject: Re: [PATCH v13 07/12] crypto: Add RSASSA-PSS support
To: Eric Biggers <ebiggers@kernel.org>
Cc: David Howells <dhowells@redhat.com>, Lukas Wunner <lukas@wunner.de>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	"Jason A . Donenfeld" <Jason@zx2c4.com>, Ard Biesheuvel <ardb@kernel.org>, Stephan Mueller <smueller@chronox.de>, 
	linux-crypto@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Tadeusz Struk <tadeusz.struk@intel.com>, "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-8.96 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20223-lists,linux-crypto=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[cloudflare.com,reject];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ignat@cloudflare.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlesource.com:url,mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,cloudflare.com:dkim,metzdowd.com:url]
X-Rspamd-Queue-Id: 3E831536DE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 2:14=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> On Tue, Jan 20, 2026 at 02:41:11PM -0800, Eric Biggers wrote:
> > On Tue, Jan 20, 2026 at 02:50:53PM +0000, David Howells wrote:
> > > Add support for RSASSA-PSS [RFC8017 sec 8.1] signature verification s=
upport
> > > to the RSA driver in crypto/.
> >
> > This additional feature significantly increases the scope of your
> > patchset, especially considering that the kernel previously didn't
> > implement RSASSA-PSS at all.  This patchset also doesn't include any

I just wanted to point out that RSASSA-PSS "existed" as supported in
kernel documentation [1] for quite a while now. So it is a matter of
actually fixing "the bug" of it not being implemented as it should
have been from UAPI perspective

> > explanation for why this additional feature is needed.  It might make
> > sense to add this feature, but it needs to be properly explained, and i=
t
> > would be preferable for it to be its own patchset.

This does seems reasonable to separate ML-DSA and RSASSA-PSS into
separate patchsets

> > > The verification function requires an info string formatted as a
> > > space-separated list of key=3Dvalue pairs.  The following parameters =
need to
> > > be provided:
> > >
> > >  (1) sighash=3D<algo>
> > >
> > >      The hash algorithm to be used to digest the data.
> > >
> > >  (2) pss_mask=3D<type>,...
> > >
> > >      The mask generation function (MGF) and its parameters.
> > >
> > >  (3) pss_salt=3D<len>
> > >
> > >      The length of the salt used.
> > >
> > > The only MGF currently supported is "mgf1".  This takes an additional
> > > parameter indicating the mask-generating hash (which need not be the =
same
> > > as the data hash).  E.g.:
> > >
> > >      "sighash=3Dsha256 pss_mask=3Dmgf1,sha256 pss_salt=3D32"
> >
> > One of the issues with RSASSA-PSS is the excessive flexibility in the
> > parameters, which often end up being attacker controlled.  Therefore
> > many implementations of RSASSA-PSS restrict the allowed parameters to
> > something reasonable, e.g. restricting the allowed hash algorithms,
> > requiring the two hash algorithms to be the same, and requiring the sal=
t
> > size to match the digest size.  We should do likewise if possible.
>
> Looking into this a bit more, I'm increasingly skeptical that RSASSA-PSS
> would be a worthwhile addition, especially when integrated into CMS and
> X.509.  It seems that while in theory it's an improvement over PKCS#1
> v1.5 padding, the specifications were messed up and it has way too many
> unnecessary and error-prone parameters.  Here are some references that
> describe some of the issues in RSASSA-PSS:
>
>     * https://boringssl-review.googlesource.com/c/boringssl/+/81656
>     * https://www.metzdowd.com/pipermail/cryptography/2019-November/03544=
9.html
>
> It seems it might not be very widely used either.
>
> I think the fact that this patchset implements RSASSA-PSS verification
> incorrectly (by not verifying that the leading bit is zero) further
> validates these concerns.
>
> With RSA also being two generations behind the current generation of
> signature algorithms (RSA =3D> elliptic curves =3D> lattices), I'm wonder=
ing
> what the motivation for this feature is.
>
> - Eric

[1]: https://docs.kernel.org/security/keys/core.html

