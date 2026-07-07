Return-Path: <linux-crypto+bounces-25713-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4E6QNe6ITWoq1wEAu9opvQ
	(envelope-from <linux-crypto+bounces-25713-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 08 Jul 2026 01:17:02 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5287205B7
	for <lists+linux-crypto@lfdr.de>; Wed, 08 Jul 2026 01:17:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SIjTl0Qr;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25713-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25713-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5697F3008D03
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Jul 2026 23:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E15FE31A7E4;
	Tue,  7 Jul 2026 23:16:55 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EFE42087C;
	Tue,  7 Jul 2026 23:16:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783466215; cv=none; b=fXcIpBANk6bcCz0XCtUjGin9okbuwYgOYvAlFXNuw645pVsuTE5yrLRFvKYhqZ9N2re3ZCJPoAiDHA3HGYP0xEyKbik4WmW+L/YIuD3UxpdbvRxPp6tywgG0p7OdR/MX5jnWd0j5mdyRV2fy61AofT6FYoYnmgJAwSf1UpNRTJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783466215; c=relaxed/simple;
	bh=wthU+LDSXxv0cmhMsmKWTUc9MccmOLfsHSJemEijgTc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nD6um1/hxgGBg3EiZaBaDfX2qHihj5BvVe/bTxQUJCkfY6xeBNW90kPfvEbbB4Qd2CF+0m45G9/Rxev6g3hfPOnIOb3QusgQSQ9pWPvcxmQcedsseqZhM6jbIr4y46Ix67v473R+sXrYANC9Kx9oAjJmNg+wLlrBUz2kgLFXvVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIjTl0Qr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A6771F000E9;
	Tue,  7 Jul 2026 23:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783466214;
	bh=ouySJp4PTPWTHvPnwqW1vIzSFsOuSkVDaiPP8I2u+Vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SIjTl0QrH4C0s1T74xhE5e/8Rr6gDKqmjLlMcb4R86o1GsPDhfQsBaUmYsGATDhaS
	 lkEtUScBjlunSUluNClKqQRAusX6J3CCqz9sTRnd1DjPtVaCrWdWhayLyIJ/BvIghB
	 ORnhILsTpz7f3DKOOOLoBPnzvAD/MWpFn7fuyD/IDUHt3RSMHcI/aKFZBU1Yg7KvqK
	 vQQkEPal5M/HHPfXfY2bcq/xI8K5hoiEpEsaRYa/oJavIkT+l+XPXnJ8Qssxu1edTW
	 /m5LVcbB2QRCbk23xOg+eI4XEdfk1gNTZjXrN5AlAHm+WwUbH0rm5w1CaDtkIfwuR3
	 1F0D9kwmF8mYA==
Date: Tue, 7 Jul 2026 23:16:52 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH 29/33] bpf: crypto: Use AES-CBC and AES-ECB libraries
Message-ID: <20260707231652.GA2264445@google.com>
References: <20260707053503.209874-1-ebiggers@kernel.org>
 <20260707053503.209874-30-ebiggers@kernel.org>
 <10eafa42-1142-4ed2-a485-f46c496bddfb@linux.dev>
 <20260707182049.GA2238@quark>
 <d1cdfc23-b336-49a9-8833-29f05b5b9fec@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d1cdfc23-b336-49a9-8833-29f05b5b9fec@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25713-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:vadim.fedorenko@linux.dev,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0C5287205B7

On Tue, Jul 07, 2026 at 11:50:33PM +0100, Vadim Fedorenko wrote:
> > Does this mean the AES-ECB support is unnecessary and can be dropped?
> 
> Let's keep it if it doesn't hurt.

It kind of does.  It is "bad" crypto that would have to continue to be
maintained, and someone might start using it accidentally.

- Eric

