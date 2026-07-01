Return-Path: <linux-crypto+bounces-25510-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rhwMNUqBRGrcvwoAu9opvQ
	(envelope-from <linux-crypto+bounces-25510-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 01 Jul 2026 04:54:02 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B7A6E9531
	for <lists+linux-crypto@lfdr.de>; Wed, 01 Jul 2026 04:54:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25510-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25510-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 749E43055330
	for <lists+linux-crypto@lfdr.de>; Wed,  1 Jul 2026 02:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5156E3655E7;
	Wed,  1 Jul 2026 02:53:35 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AAD3655CE;
	Wed,  1 Jul 2026 02:53:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782874415; cv=none; b=qPN8ES/OixtoTrlFtXcX2MhemWpOuay4/WYl2gA/poHkyC7jTDIqugeJIN6I1KWMNgNkK4kZX6mSQ/BHVbLfRgwLI+T0r4SvffwjgowDDCo7/2lmQjua1/SXXQ3w8jljPE4dVwMawkCNpLfr9z+0yU3xqper7AdXzmj1+G5imy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782874415; c=relaxed/simple;
	bh=kQjb6s8eSqpZaTAs2ZaSHN/LuWoun0cjyTvFL4/2ePs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ocL3ZUyfb/G2Dcd6DsGvaooOZRwa4IRUUkgMV7t82AbED+R7EIZym5cP1lEXjgicvN3MCUsw2mXtLpN03Tza/jzRJbwIKOaNiSSG5H4kta9bcNLRSIs8ZMae5KVnrFhCn0Vv2URFMfZJwBhdkPy7/0Ub5eyZNZfSssSAxNJuSZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Received: from [192.168.10.90] (unknown [39.110.247.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 054133F07B;
	Wed,  1 Jul 2026 04:53:20 +0200 (CEST)
Message-ID: <d96594ba-4ad5-4541-9660-2469875db9b7@hogyros.de>
Date: Wed, 1 Jul 2026 11:53:16 +0900
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: af_alg - Add af_alg_restrict sysctl, defaulting
 to 1
To: Demi Marie Obenour <demiobenour@gmail.com>,
 Eric Biggers <ebiggers@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, linux-crypto@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 iwd@lists.linux.dev, linux-hardening@vger.kernel.org,
 Milan Broz <gmazyland@gmail.com>
References: <20260622234803.6982-1-ebiggers@kernel.org>
 <CALCETrXPj0u=FZ=aFcZAHk3fFZa7rCuPEjx6cOMXmT3sdkC7SA@mail.gmail.com>
 <20260623192715.GE1850517@google.com>
 <c7cb79ce-48f9-4433-ab4f-88b4c4df996c@gmail.com>
 <20260628185404.GA2292@quark>
 <641f0391-dd4b-4b25-88f5-5298fa6bf823@hogyros.de>
 <8c24ad17-8295-47be-a562-44c23538c4cb@gmail.com>
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <8c24ad17-8295-47be-a562-44c23538c4cb@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[hogyros.de];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-25510-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:demiobenour@gmail.com,m:ebiggers@kernel.org,m:luto@amacapital.net,m:linux-crypto@vger.kernel.org,m:herbert@gondor.apana.org.au,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:iwd@lists.linux.dev,m:linux-hardening@vger.kernel.org,m:gmazyland@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[Simon.Richter@hogyros.de,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[amacapital.net,vger.kernel.org,gondor.apana.org.au,lists.linux.dev,gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Simon.Richter@hogyros.de,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hogyros.de:mid,hogyros.de:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 24B7A6E9531

Hi,

On 7/1/26 12:54 AM, Demi Marie Obenour wrote:

> That said, if the crypto_rng support is to remain, should it have a
> non-empty allowlist for privileged processes?  Otherwise, it's dead code
> with the default sysctl value.

For desktop users, it is indeed dead, but only if we can guarantee that 
they will never change the sysctl value to allow all algorithms.

So I'd probably do an enabled-by-default configuration option that takes 
away the option to enable all algorithms, and the RNG code in AF_ALG 
becomes conditional on that option.

I think that embedded systems will still use this code until a better 
alternative exists, so it's not entirely dead, and the best way to get 
rid of it is to build something better.

I'd love to see a vDSO based interface for all crypto operations that 
allows reusing the code in the kernel from userspace, avoids the system 
call overhead in the likely case that the CPU based implementation is 
also the most efficient, and allows for more flexibility with hardware 
interfaces (quite a few allow submission directly from unprivileged 
processes).

    Simon

