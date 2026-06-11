Return-Path: <linux-crypto+bounces-25039-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wkk2IqJfKmptoQMAu9opvQ
	(envelope-from <linux-crypto+bounces-25039-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 09:11:30 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BDC466F45C
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 09:11:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linaro.org header.s=google header.b="wE3yK/b0";
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25039-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25039-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linaro.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 83EA93008682
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 07:11:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F92F3B47E5;
	Thu, 11 Jun 2026 07:11:22 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F3032BF4B
	for <linux-crypto@vger.kernel.org>; Thu, 11 Jun 2026 07:11:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781161882; cv=pass; b=rpSMfkmCTPskQaeYpxG9IJxyaBQNmnWOnJI4oWY4swP+Fe8BmWev7ac2uQ3IofEKnTTJlzpHM1qEwO+SEtH60SWjqVoquEk1TmTfYdzSlxd/EcEetwl6i9tH1wkItFV47yU3sK7iw9qQoZZSJJe6wVT7RWEny8LXfxamCVEXZJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781161882; c=relaxed/simple;
	bh=A+vjY9UePGm++PcxVZs5XDA+KliAt9XGKyHV2kvhaX8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uYZOKIKFbSKtf/H86i+qm43IfiL3nsGeNgcxsEZStINZYYvsmeKfcAht8d8LG5JSXeY+B5Z3/dEzeeQKw1+9Cy+bGRwx5UWwYoqesIhRr638ccjNcKGMxmnfCtR2eXEy10Qk54ZN3ZWsqcSB9aRpBZLDdeV2AEeh44YhFILWh/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wE3yK/b0; arc=pass smtp.client-ip=209.85.208.52
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-691c5776f35so6196022a12.3
        for <linux-crypto@vger.kernel.org>; Thu, 11 Jun 2026 00:11:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781161879; cv=none;
        d=google.com; s=arc-20240605;
        b=cULXW1pPRbWkjjRmNDLmGMp8zofecYtM5RdRL1Zjicm2Fe1L+Dy8TRilR6AQk5pMlj
         CGwC9sLtU+FrrHc1RBw5PQ/cv1zplDfIxba0eHQjMI23jbm4J7u0fgFJxIjJmcMneTGp
         fTz8zQkm/xRIFljJiPcET5m6EKfPJ8ZylLq8JTdsKe2uG+3B+6FMvOAlUy9q042oNvKb
         dTrwST1IN6QwF02ucn/Nh9SDHGAhUXolRD9WK55OhYB1RuHlrbxSdqKcJgIrju7nmafX
         aqq8Do61lYy71/6+FBdgjh75SLStyHf+Ryjp1ILA+UMCOnTm12+o5ATkb8DKIOVz6yyP
         sATQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=f/de9C39QdWQLV5Q6hT47S1phWBZwegbTCNZx8KIleQ=;
        fh=oXnSoDMGtUoFSMQtW/r2TZJsxklgBHwj8EaW97sOaJM=;
        b=i8ZTQnyc3z+GMWKiKfrtwGxyCWT4F+3lpadxNASVon8qGN/OZrVJq1UfYjaDPP56vm
         JK9tjuuAG8hlXsYaxKB1gYtfX3gnlSGYAUmyVXXLavYyAeQ3eXUBXWHPc87yW2TskfGv
         CCkgPu+MRcu3bGbxKnf5HvKuzAyd7saHuaALZwzqhpTxNwiWtHFWDJsb4CH5BOi85ZTu
         pmD9B8WEQhgt+x4RST8QnwcK+RRHXQGF2Usg6jb8D8eofiy7QJ1xQ75nbYDguu3a9aq3
         47wUkS8fYZloMLF/2HjhpRpuq+xyH3kCU1le5QOeP5SQnMZwz18nX6VB7zDLooxCYYoV
         oXkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781161879; x=1781766679; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=f/de9C39QdWQLV5Q6hT47S1phWBZwegbTCNZx8KIleQ=;
        b=wE3yK/b0YoexmPEmKXgpFzlJcsfRs3aITD+EWWRh2bt2RPjzi5bqo2qjU/5dCTRRv+
         L1mvmhmN9eF6xctowNtD6Qv+8qX3XP9Yi5XYLJ6ADW3aP6SATT5Xlqk2u+iXh6gsYK89
         i67FI6iyM84EUceCD0SUpa9/pXYE82dMJSgNXEdEDXbDP79m8oYouDt2u6XCWoeU4KbJ
         ZLljcWg3oHa+Lr3rPVn3OE8NVmWizJ8xNr/KZIOxAqhE5eZ8PKpIp5EL5zUFguFHo7/T
         XnKrbAAh6lOi+fUEfEi01nFcIC4AgkRIMFryGzz7wM5xAwbNKYWnCWumGNWEo3AjlEg3
         DTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781161879; x=1781766679;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f/de9C39QdWQLV5Q6hT47S1phWBZwegbTCNZx8KIleQ=;
        b=fC/XDJyEcGZ0ljUgWiuuXEbFCdAjwHuEC3dNbN6DE6XlNm8XtI1ZySKOK8QaQ2CtD0
         bhnkNKKgvb0Dw0shMhqVbDMC3gREOqIaPuYv8I9bsIwnv5+SCn38oL03gdIZTWHgMkUY
         nyrW+GqR1UOsI9Pr21wxWY1dIymNt8YZRMgfFPFuqf+F7oC7BUieOZZMmcT4EL1hIAB/
         ttHrCaI5oMJHC65fm4FfEJcEZb06xS2LGbA1M4PpWGMi9GmV0fgG2trGiGYYOeZhot0g
         76tzgeC9NxzlQTcB7NcuT16t6APPi6NDROTm1x/xYimOwN2odBAR0HZqr2iQMwmxTx6b
         ctTw==
X-Gm-Message-State: AOJu0YzcSXcgtYrQoAst0DyQESMCVEe29isMzvuT0fb2WC+hrWyoJ9Io
	dqrNZ70e7SgnQI8qf3Nd/y79S8V8cLnHoi0mR7Yekv0k6mYGLCZdaN4O77dpVAfj3W5dQ4jg18A
	8KTBz8NRkze/q9s1u7wxATM6/UAXAWwHDmjL38cKiwQ==
X-Gm-Gg: Acq92OGPZDHH+4qO6rget31BSKNA2Ly3hCGQt1v4sKVQ16cS0uerKcDlSM1Pr6wHNZJ
	1q3q7a93HKIlrW7Ozc3yQPE/hYFm6BhSpSsJMeH6+ESc4rZa1FrIs4WvirkeM+631fgmV2Q2XbR
	ZOkOy1a4tFZLTd8DkiKIf8HiAFtTiftbyeVeii5XNQAYr6WE+LYwr3SMzTbrcjdzKQkyYatfEWP
	hMojD+nwcNWHHrKUOCQA6p54Yr5L/A819daRUkWVJb+hxmE7FMFn+x2q56nLCWiDYdkwTlg6V6R
	001fbFb4/iORJjLDw6jIMkWX0Hhlin4fUOIZOcA5VS8EktZyE9oV
X-Received: by 2002:a05:6402:520d:b0:689:c099:ef99 with SMTP id
 4fb4d7f45d1cf-6930e2e85ddmr662846a12.22.1781161879564; Thu, 11 Jun 2026
 00:11:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531175932.32171-1-ebiggers@kernel.org> <CADrjBPo3BpSk49oasf_9g06xrBMkw+NiKo10xDKjWr8sJ+Zc-Q@mail.gmail.com>
 <20260610183902.GA1158828@google.com>
In-Reply-To: <20260610183902.GA1158828@google.com>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 11 Jun 2026 08:11:06 +0100
X-Gm-Features: AVVi8CdK6eYIPK8G4aFqD8lMifZVhDYEkmKnIKOnCa2_bel3Ygx-BiVfzt5sLyg
Message-ID: <CADrjBPoVFCb4rTze4mQhdQ0=FJmhpFiET0GCRBx9FaGs9DsrDA@mail.gmail.com>
Subject: Re: [PATCH] crypto: exynos-rng - Remove exynos-rng driver
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>, 
	linux-samsung-soc@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, 
	Alim Akhtar <alim.akhtar@samsung.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25039-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[peter.griffin@linaro.org,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:linux-crypto@vger.kernel.org,m:herbert@gondor.apana.org.au,m:linux-samsung-soc@vger.kernel.org,m:krzk@kernel.org,m:alim.akhtar@samsung.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linaro.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peter.griffin@linaro.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp,linaro.org:dkim,linaro.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7BDC466F45C

Hi Eric,

On Wed, 10 Jun 2026 at 19:39, Eric Biggers <ebiggers@kernel.org> wrote:
>
> On Wed, Jun 10, 2026 at 03:46:54PM +0100, Peter Griffin wrote:
> > Hi Eric,
> >
> > On Sun, 31 May 2026 at 19:02, Eric Biggers <ebiggers@kernel.org> wrote:
> > >
> > > This driver has no purpose.  It doesn't feed into the Linux RNG, nor
> > > does it implement the hwrng interface.  It is accessible only via the
> > > "rng" algorithm type of AF_ALG, which isn't used in practice.  Everyone
> > > uses either the Linux RNG, or rarely /dev/hwrng.
> > >
> > > Moreover, this is a PRNG whose only source of entropy is the 160-bit
> > > seed the user passes in.  So this can be used only by a user who already
> > > has a source of cryptographically secure random numbers, such as
> > > /dev/random.  Which they can, and do, just use in the first place.
> > >
> > > Just remove this driver.  There's no need to keep useless code around.
> > >
> > > Note that the other crypto_rng drivers in drivers/crypto/ are similarly
> > > unused and are being removed too.  This commit just handles exynos-rng.
> > >
> > > Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> > > ---
> >
> > If the driver is being removed, should the binding documentation for
> > this driver not also be deleted (see
> > Documentation/devicetree/bindings/rng/samsung,exynos4-rng.yaml)?
> >
> > Peter
>
> In other discussions I've been told that devicetree bindings are
> hardware descriptions that should still exist even if there is no
> driver.  It doesn't make a lot of sense, but it seems to be what the
> devicetree people want.  I expect there would be objections to removing
> this binding.

Ok thanks for confirming.

Peter.

