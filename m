Return-Path: <linux-crypto+bounces-25349-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FSCpOUTjOmqjKAgAu9opvQ
	(envelope-from <linux-crypto+bounces-25349-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Jun 2026 21:49:24 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBE46B9C47
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Jun 2026 21:49:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ta4u2KYK;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25349-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25349-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D2E54303F283
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Jun 2026 19:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1112393DF3;
	Tue, 23 Jun 2026 19:49:15 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7366961FFE;
	Tue, 23 Jun 2026 19:49:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782244155; cv=none; b=rywaspoO+6zGmbCzEVwZlFglYOM1bDynR+YI2ceOlKjY605c/zWt04ZFTTyYEsE/Rezq6jYR3fM7FEo2spRf+efoVhBhKZi+8E/sdFq+FBr5/pPUK45aZ5MDqRBjhf9QqifYH/OXgiBQYFSaqFrETu5Yfb5BI61VXtlYg6tEvko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782244155; c=relaxed/simple;
	bh=qjg7dM88HrlR4rd4lGOIfxQF31RbwEFozOT8//6VvjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVJrJeecW9AaW4Um+uA6JvH81NoHhlhAcUH9fNWb5PrjF1Rfe5CVk0tuH/sXDEbMp7CSn1PmTcDa3A8/re4TebxvxlrKXdK8m7aILyxhQkEZrWBG6AtAtuLLmiNoPxMDusDr2/qbqj0Aa/7a/o/C3JijbwU1aSy1Czsn3LTa/7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ta4u2KYK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B57761F000E9;
	Tue, 23 Jun 2026 19:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782244154;
	bh=MHznzdcjBxW520xOh9I+dR4E26WZfg+IqKFo0GZavHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ta4u2KYKJ1l71cK3Ua0CZLWpEQ2GU2ZcH/P2z2yw8Jc9q/gT7WELTIJJL4d81GB88
	 uOjffgJFhZj/7GEuhRMdxh7fjzWPNABXFNiypLsD81yvAB4DQ0iTpGpUe8bSzwKJpn
	 s2Ng2vyhLYOnE23Ejpzngi85V7Iv3lVMD0Emy/efiqevMVTmyEG3YNoK/NJR9jkDHN
	 YUIR+jg5cYxcwdIobJY66AUo2QucvZUUL/WQVmQtQtqYaFyqNS4zL3qkK9csU3GJ5N
	 B06LJQoRjfm79KLG5T2vlAs/f7ZrCZdkRaZTeFvPMCkQ38ZrhexlY1eSYxd0qN6pDk
	 l602ovmX/Qlig==
Date: Tue, 23 Jun 2026 19:49:12 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-crypto@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, iwd@lists.linux.dev,
	linux-hardening@vger.kernel.org, Milan Broz <gmazyland@gmail.com>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Andy Lutomirski <luto@amacapital.net>
Subject: Re: [PATCH] crypto: af_alg - Add af_alg_restrict sysctl, defaulting
 to 1
Message-ID: <20260623194912.GF1850517@google.com>
References: <20260622234803.6982-1-ebiggers@kernel.org>
 <202606231216.14A774833@keescook>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202606231216.14A774833@keescook>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25349-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,gondor.apana.org.au,lists.linux.dev,gmail.com,amacapital.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:kees@kernel.org,m:linux-crypto@vger.kernel.org,m:herbert@gondor.apana.org.au,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:linux-bluetooth@vger.kernel.org,m:iwd@lists.linux.dev,m:linux-hardening@vger.kernel.org,m:gmazyland@gmail.com,m:demiobenour@gmail.com,m:luto@amacapital.net,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8BBE46B9C47

On Tue, Jun 23, 2026 at 12:24:28PM -0700, Kees Cook wrote:
> On Mon, Jun 22, 2026 at 04:48:03PM -0700, Eric Biggers wrote:
> > AF_ALG is a frequent source of vulnerabilities and a maintenance
> > nightmare.  It exposes far more functionality to userspace than ever
> > should have been exposed, especially to unprivileged processes.  Recent
> > exploits have targeted kernel internal implementation details like
> > "authencesn" that have zero use case for userspace access.
> 
> I absolutely want to see this attack surface reduction.
> 
> > Add a sysctl /proc/sys/crypto/af_alg_restrict with meaning:
> > [...]
> > Note that the list may be tweaked in the future.  However, the common
> > use cases such as iwd and bluez are taken into account already.  I've
> > tested that iwd still works with the default value of 1.
> 
> I wince at this bit, though. This is a "security policy in the kernel"
> which we try to avoid, and it's could be done already in userspace with
> modprobe blacklist.
> 
> But, as you say, AF_ALG is deprecated. I understand that to mean that
> the alg list is only ever going to *shrink* in the future.
> 
> Using a sysctl means monolithic kernels are protected, but wouldn't
> those systems just compile AF_ALG out?
> 
> So, I guess, I would want a more clear rationale for why we do it this
> way instead of via modprobe blacklist. I see a few reasons, but they
> don't really convince me that we should ignore the "no security policy
> in the kernel" rule to do it this way.

As we saw when distros tried to mitigate copy.fail, a lot of distros
have CONFIG_CRYPTO_USER_API_* set to 'y', so algif_aead.ko couldn't be
blacklisted.  (Ironically because of FIPS 140, which is yet another
example of how FIPS 140 harms real-world security.)

But even when 'm', the module blacklist is just a binary choice for each
algorithm type: aead, skcipher, hash, and rng.  Loading algif_aead.ko
allows not just "ccm(aes)" that bluez needs, but also bizarre things
like "authencesn(hmac(sha256),cbc(aes))" that are used only in exploits.

And sure, userspace could theoretically gather the complete list of
algorithm modules (e.g. authencesn.ko) and blacklist them individually.
But no one does that, and many are built-in anyway -- and this time not
just because of FIPS.

So we need an allowlist at the algorithm level, not just the algorithm
type level.  Putting the allowlist in the kernel, taking into account
the real use cases like iwd and bluez, and having a simple tristate
sysctl similar to some of the existing ones, is the simplest and most
practical way to achieve this by default across Linux distros.

If we did something like delegate the algorithm allowlist to LSMs, I
think that in practice it's just going to be almost never used.

- Eric

