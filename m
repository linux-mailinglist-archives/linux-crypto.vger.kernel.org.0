Return-Path: <linux-crypto+bounces-25448-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id otCEJ3zkQWpjvgkAu9opvQ
	(envelope-from <linux-crypto+bounces-25448-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 29 Jun 2026 05:20:28 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6E06D5A49
	for <lists+linux-crypto@lfdr.de>; Mon, 29 Jun 2026 05:20:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25448-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25448-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D53373016531
	for <lists+linux-crypto@lfdr.de>; Mon, 29 Jun 2026 03:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F5F37D131;
	Mon, 29 Jun 2026 03:20:15 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from psionic.psi5.com (psionic.psi5.com [185.187.169.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26731A3172;
	Mon, 29 Jun 2026 03:20:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782703215; cv=none; b=fnkElokmddvfbGT/RHqignAEN800PHnS5B6Elx8of8EG9gZem70K21ugQLdmHH4RG187qd03EIx5WeBCQILAlwHD8zPOr09wpa01oSwZJCJHLyv6fIo6f5MCYCEnbnG/7Yu3ASaYoEWqPIcJUK3tnpE03bzChgwbhiPvQHeMOOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782703215; c=relaxed/simple;
	bh=ADXiNB9r584fVcz58aoglRRDDRnHgsGaxlcnPJMrx/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BmDZd4xfTORNiClGbxM4TWmS9G1J7uURMv6uDFs35bFLM6T5HT7vHB/puBUF9+zYaTaUS6kvwNk7czkER6hw9lJdn5fBXxkIRzTgIopqDX9SmzHfHKAvXChqIUYVhwyb79aVObigsGyqfSt4zQT9W4CESUHFXXZb3OLxZaPO+a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hogyros.de; spf=pass smtp.mailfrom=hogyros.de; arc=none smtp.client-ip=185.187.169.70
Received: from [192.168.10.90] (unknown [39.110.247.193])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by psionic.psi5.com (Postfix) with ESMTPSA id 32BDE3F209;
	Mon, 29 Jun 2026 05:11:16 +0200 (CEST)
Message-ID: <641f0391-dd4b-4b25-88f5-5298fa6bf823@hogyros.de>
Date: Mon, 29 Jun 2026 12:11:12 +0900
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] crypto: af_alg - Add af_alg_restrict sysctl, defaulting
 to 1
To: Eric Biggers <ebiggers@kernel.org>,
 Demi Marie Obenour <demiobenour@gmail.com>
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
Content-Language: en-US
From: Simon Richter <Simon.Richter@hogyros.de>
In-Reply-To: <20260628185404.GA2292@quark>
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
	TAGGED_FROM(0.00)[bounces-25448-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:demiobenour@gmail.com,m:luto@amacapital.net,m:linux-crypto@vger.kernel.org,m:herbert@gondor.apana.org.au,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:iwd@lists.linux.dev,m:linux-hardening@vger.kernel.org,m:gmazyland@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[Simon.Richter@hogyros.de,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,hogyros.de:mid,hogyros.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DF6E06D5A49

Hi,

On 6/29/26 3:54 AM, Eric Biggers wrote:

> We could do that if it's what people want.  Just keep in mind that it
> would be much more complex than the single tristate sysctl.  And in
> practice the number of people who are knowledgeable enough to create
> these lists is quite small; we've seen similar things with other "Crypto
> API" configuration knobs that seem to never be touched in practice.

I don't think finer grained control is necessary.

The tristate is the best possible interface for the people running 
precompiled distribution kernels. Ideally, deactivating the restriction 
should also be disallowed in lockdown mode -- and this becomes a lot 
easier to subvert if the list of algorithms is runtime configurable.

I think it is safe to assume that the people using AF_ALG with hardware 
crypto engines are building embedded systems with a custom kernel 
configuration, so the .config is probably the best place for the 
selection of algorithms that should remain available in restricted mode.

    Simon

