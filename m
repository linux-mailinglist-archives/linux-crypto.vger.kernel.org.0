Return-Path: <linux-crypto+bounces-23605-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMuJJ9PW9GmQFQIAu9opvQ
	(envelope-from <linux-crypto+bounces-23605-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 01 May 2026 18:37:39 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F25514AE1E5
	for <lists+linux-crypto@lfdr.de>; Fri, 01 May 2026 18:37:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 998A430078FA
	for <lists+linux-crypto@lfdr.de>; Fri,  1 May 2026 16:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA369413247;
	Fri,  1 May 2026 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dzBpD3s8"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31173F7ABE
	for <linux-crypto@vger.kernel.org>; Fri,  1 May 2026 16:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777653447; cv=pass; b=rI2LnPhC8i2rWqpe2AQzybVgu67zpu4elt3w3ZiAW6gH/5l2/h9kX7htRtMCcitbD+qfGhypOJATfzB72Erxj3fsLaa1EQ3Np66fshRshCC+9wh8JDs3eNcoyFzyB/4bjZ0J9C/Y6CQ/sN1dtLGofCca4OCNTstgmlzwpHYPzVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777653447; c=relaxed/simple;
	bh=w9ooVH2aWTdqsPWomPiWr/2emsHoCr0nSyf2HqpKRiA=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OB7UHR18DzsHcHrFK9bnbP8deV8WG7LQE/bPXgagDiRcO7FF3jkT/uZjni87HIFtMjm9vYv7i3M1FTQFBU0W0fFYhVtlE9rUZ18PuMLgAiEaU1aiBL4fjsm4M1cSdAeRq3b6Rbsg4a1wOYPCeFpXLsaTWhVz1WvjUMSwNpq42A8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dzBpD3s8; arc=pass smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-628086439b6so1774835137.2
        for <linux-crypto@vger.kernel.org>; Fri, 01 May 2026 09:37:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777653431; cv=none;
        d=google.com; s=arc-20240605;
        b=I/EDMLl5QjAfpYjJzLjqfOuV6N+/K4uwAyuTDJXViFxX4Oq1GRPVXGgk43VytTN21J
         VCvuMI3mWBCUs5zjPPpJDzD94KyJwJVtIIlvYkzt4c4cP0irMaNCCujNVQZFJm5ACQGd
         pK8l/GmQFxIjUvwTuZwfnqePo544PbL6TR31ybvqFMwQhH5X6xLszbI1qYb3N1iOwsYX
         PAO43cIhWAfWI4suP5vEnWuR6sDUgsUTkk8STvjJw2uQQ3XAf3OyNn8c784g6hvrXKoW
         eHu0wDDkbbUZryxwZpHBpNaESL05Dm3QQrw46TXR5dyn9EyatZGFHnnSqTFtbVIiErlL
         i71w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=nLFs9eB4QSuzMXlNmTajx3twQGrJqXq6Mmw1sgch1Dc=;
        fh=qZAELftNfF6b9c78fP6chey/cnFgizoCXTpeC1UuSWY=;
        b=cKQFUz6pyu0PCaafTRurrPblrRrRsRj75Xp9jE/CB4PXuOg8hrw73FjoUWS313Wn3p
         ffEoB8PSgTOYyfSIjl5sJrBUtz7nkPdx1OFNdbooB/otngOWe5TsqSk4xygY3MCE5Slg
         Gc86nbwAWkvxo1oNQbIRV12yOwC/1tSMHBWpAWV1P+IrJEZw5pEDB6ZOMH5X6Rm+dpiw
         mhWji+jk21+V/NmN5Ieh5sEA6WOr2jT7VrZg4sstuYZsU67N9uUVOdNldOTT66HGOSnm
         itPnHmgDQbAq/MagRvvEJyC2UHdU6M+7BWyiJWk8n9bB6mY7JCU4wPUBOfYQYLv59aVB
         ns1g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777653431; x=1778258231; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nLFs9eB4QSuzMXlNmTajx3twQGrJqXq6Mmw1sgch1Dc=;
        b=dzBpD3s8S9heQZQqYydWwH8DRb//MDRDU0VdMAX6F+suExplLhSUN7mbnfJdOr3WJ7
         V/NV8hUvklwHsI/AIRirPiMFkTQJeFehw9r+KIbn8KfgmZqzKx1uDYLe8a7cXjqjuryc
         urwhoYpx1cpmUApuOv6H6tcY6DD6+pPYZeH9iYuzMr4Ry/br34NHXIjiuPn0KYmrQxcM
         ZAgrSNqxKiuUrKxShE5+VjPMHzBSxNdxBAVAfhA+hJwoqS+1L0sgLooWgcJJBojH8fp8
         7Fg8SCh0POxu/WbFHeIg3w6/1V8eipzSsBGqGMhSeHwuypVWFMUz0VpKbdwz5aptnNB4
         s6uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777653431; x=1778258231;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nLFs9eB4QSuzMXlNmTajx3twQGrJqXq6Mmw1sgch1Dc=;
        b=LaQJ2wRUCLjujYhtwgN5jX/7KnxLgTWo9bVt5WGyz4H7F/ol64vSzWPxer6KCS4cn3
         7243Gt54ZH1pS83woEiaRZ7ovEJgamR4bmBm2Gzc/dvY5HkkTZ85+Bnxh1YdMXFHFqzT
         vcWU5A27XNDB0/9+Gvxb8wk29nu9lMhlwKctxKFGqr22VXv1NAnSZfDbZAVa0keXA2mU
         rcl23gSJ+pGes1sRFR9NDfNNpFi5gfisyc1b6gYLqlYgi3FOAEdHpEi4SeZG3HN1GBCa
         /deqPlrFUTnyw/XMUziPMmRMXRsGiLDpr4FgD4VO9wVVvSZfWhXFXC3S/TRrJdfP8P/f
         TRkw==
X-Forwarded-Encrypted: i=1; AFNElJ+N6gcXnhXXissDcRjDrXd753COwBsKbnF2VdCwwtj2zUIwpgQnMs3tNDgJ3o9U+X5pA86KDHIpvyqI47s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjfUbUJjcNfIzzkk8eItZ0T5pGguGdgwdCY1gv6Ik67cabu+o5
	RGOGXHSviM2UZ37KsaStqat3OwWyh2g9kbO+1FywCBDBuMJ17p1a4vjLlOJHvuHcFY582QzBzIH
	ap36HjGGv7QEMNWBEhPUhVGfXqMeypnvLDwRuywxp
X-Gm-Gg: AeBDietlONiImQmphrJKBGYoX9TaWwFgTR3dgi8LBUlsD5BcymtSYeK3sHQ/tDQ63hF
	1O2GCVUzSK+0En2GjiC7O4yckQnxyjjjjL+j6zG5P+GD+0L8NH2zjjrpnNyqQfNE7FlHlksaiGK
	fHPEgchiS/STSi4MuKMA5zoevmXcB+F+3d0P1tLzDcZ5lOPnmBPUqYISd2BvFXvf55mYQgMFjPt
	iEZVG9Y2nQBNTZnUxAmh6T5bCBiSeAoTg4CTE+rILNnIZL/J6r0SrOo0LMfADXFGBU0SACIk1g6
	la4g23Kqse4wYIgMhzyE0zULBCDiiC083l+rP4CRrSh6teZqDBzA6qstXjZ6H86H1S3vj+jIgnt
	4essFlcaAhDrHHzU=
X-Received: by 2002:a05:6102:598d:b0:608:ad9c:4c36 with SMTP id
 ada2fe7eead31-62ad2b40002mr5011640137.11.1777653431060; Fri, 01 May 2026
 09:37:11 -0700 (PDT)
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 May 2026 09:37:10 -0700
Received: from 176938342045 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 1 May 2026 09:37:10 -0700
From: Ackerley Tng <ackerleytng@google.com>
In-Reply-To: <77153c889934972efcfc3d210251564f29abcf51.1775874970.git.ashish.kalra@amd.com>
References: <cover.1775874970.git.ashish.kalra@amd.com> <77153c889934972efcfc3d210251564f29abcf51.1775874970.git.ashish.kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 1 May 2026 09:37:10 -0700
X-Gm-Features: AVHnY4IpT6Ecp0MRFZmqXjB5U2fV7hCMXRHDBLJWh2_PysSn9Xai8a1NAPY71Vw
Message-ID: <CAEvNRgGrdA8opRuvBncgmsyzZTo6JaP+gSKuK4ioFvnZBSKjiA@mail.gmail.com>
Subject: Re: [PATCH v4 1/7] x86/cpufeatures: Add X86_FEATURE_AMD_RMPOPT
 feature flag
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@kernel.org, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, seanjc@google.com, 
	peterz@infradead.org, thomas.lendacky@amd.com, herbert@gondor.apana.org.au, 
	davem@davemloft.net, ardb@kernel.org
Cc: pbonzini@redhat.com, aik@amd.com, Michael.Roth@amd.com, 
	KPrateek.Nayak@amd.com, Tycho.Andersen@amd.com, Nathan.Fontenot@amd.com, 
	jackyli@google.com, pgonda@google.com, rientjes@google.com, 
	jacobhxu@google.com, xin@zytor.com, pawan.kumar.gupta@linux.intel.com, 
	babu.moger@amd.com, dyoung@redhat.com, nikunj@amd.com, john.allen@amd.com, 
	darwi@linutronix.de, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, kvm@vger.kernel.org, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: F25514AE1E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23605-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[34];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ackerleytng@google.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-crypto];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email]

Ashish Kalra <Ashish.Kalra@amd.com> writes:

>
> [...snip...]
>
> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
> index dbe104df339b..bce1b2e2a35c 100644
> --- a/arch/x86/include/asm/cpufeatures.h
> +++ b/arch/x86/include/asm/cpufeatures.h
> @@ -76,7 +76,7 @@
>  #define X86_FEATURE_K8			( 3*32+ 4) /* Opteron, Athlon64 */
>  #define X86_FEATURE_ZEN5		( 3*32+ 5) /* CPU based on Zen5 microarchitecture */
>  #define X86_FEATURE_ZEN6		( 3*32+ 6) /* CPU based on Zen6 microarchitecture */
> -/* Free                                 ( 3*32+ 7) */
> +#define X86_FEATURE_RMPOPT		( 3*32+ 7) /* Support for AMD RMPOPT instruction */
>  #define X86_FEATURE_CONSTANT_TSC	( 3*32+ 8) /* "constant_tsc" TSC ticks at a constant rate */
>  #define X86_FEATURE_UP			( 3*32+ 9) /* "up" SMP kernel running on UP */
>  #define X86_FEATURE_ART			( 3*32+10) /* "art" Always running timer (ART) */
> diff --git a/arch/x86/kernel/cpu/scattered.c b/arch/x86/kernel/cpu/scattered.c
> index 42c7eac0c387..7ac3818c4502 100644
> --- a/arch/x86/kernel/cpu/scattered.c
> +++ b/arch/x86/kernel/cpu/scattered.c
> @@ -65,6 +65,7 @@ static const struct cpuid_bit cpuid_bits[] = {
>  	{ X86_FEATURE_PERFMON_V2,		CPUID_EAX,  0, 0x80000022, 0 },
>  	{ X86_FEATURE_AMD_LBR_V2,		CPUID_EAX,  1, 0x80000022, 0 },
>  	{ X86_FEATURE_AMD_LBR_PMC_FREEZE,	CPUID_EAX,  2, 0x80000022, 0 },
> +	{ X86_FEATURE_RMPOPT,			CPUID_EDX,  0, 0x80000025, 0 },
>  	{ X86_FEATURE_AMD_HTR_CORES,		CPUID_EAX, 30, 0x80000026, 0 },
>  	{ 0, 0, 0, 0, 0 }
>  };

Reviewed-by: Ackerley Tng <ackerleytng@google.com>

