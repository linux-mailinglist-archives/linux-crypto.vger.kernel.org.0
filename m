Return-Path: <linux-crypto+bounces-25122-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PWGAOUH7LWrlnwQAu9opvQ
	(envelope-from <linux-crypto+bounces-25122-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sun, 14 Jun 2026 02:52:17 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 452DC680230
	for <lists+linux-crypto@lfdr.de>; Sun, 14 Jun 2026 02:52:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eI1vQdHg;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25122-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25122-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 08EA1301F33C
	for <lists+linux-crypto@lfdr.de>; Sun, 14 Jun 2026 00:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF6519CCF5;
	Sun, 14 Jun 2026 00:52:14 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014F632C8B;
	Sun, 14 Jun 2026 00:52:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781398333; cv=none; b=Ra2Lgv0pCT9gU+bNFIMiz8YwK28DtuELRsV1A3bx3xSyUsIysPTNTCzGOrjfRk5Ybj1tnzx6rR0oMBCELGMDUPIuQre3nCEfdPF0XF8+8esIWv/85iVZu3thmcXeVFHtgYDDtN6vbsvNkU0oUylFCVbfWJogVqA6E1t/aj4sByI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781398333; c=relaxed/simple;
	bh=9DEn5ejpzmAga2m6evx8wosAoW/fO+6Etf8Ab1GXcRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uurmxVlFKpK+TzdY3Qhqp2p6s8h3kOwCAyR3Rc3s4oY8UiTVjJlvXHmjmyI0ofX41rGk2KDL6S5qRHBqhoB/oCSc78O8t11yP5tnRghuRlgESHUhvBF8VfNzT/KkIbHZKgNWZx9oMlpO4K/T3qtPr2HKkb3exUS3dWHbhh8pvWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eI1vQdHg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AEA81F000E9;
	Sun, 14 Jun 2026 00:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781398332;
	bh=2fGsfUhCefDC1lX80TzrRGJO6WEKwc/biS6KHdLUpro=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eI1vQdHgKIOr1VvyKE8VMDGb3T6NB3xrIE3wUIRRTkU2fWWaye0sNeDhPi5PaglPn
	 NtXpnIZGQVx7oF50f09bgEv+Vl6T0QLOsJ+Yc6zeCkBRjQ8OEVXlzIZgPkz0XGo5vW
	 thUQTfxiQwehJ4ZPSz3r/Kw988bmEw3TYeCnG0tO9hqrwjEB87Uy6sCWExZgirbSiW
	 0J/HP3utYopiHemsj/QgdcqFYRztS165DW3pKYoFfPMVX7B2Dtjvd62EtXS64Yii1o
	 +cnBv4aryMBY8vXFJ6jXe4x5I/8X93xYc4rVHsxTzxME44v289nnDjjHJF316YDvl9
	 OZMq4MFBPC3tQ==
Date: Sat, 13 Jun 2026 17:50:44 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: linux-crypto@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Vladimir Zapolskiy <vz@mleia.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] crypto: s5p-sss - correct CONFIG_CRYPTO_DEV_EXYNOS_RNG
 macro name in comment
Message-ID: <20260614005044.GA1808@sol>
References: <20260613223648.119694-1-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260613223648.119694-1-enelsonmoore@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-25122-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:enelsonmoore@gmail.com,m:linux-crypto@vger.kernel.org,m:linux-samsung-soc@vger.kernel.org,m:krzk@kernel.org,m:vz@mleia.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,s:lists@lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 452DC680230

On Sat, Jun 13, 2026 at 03:36:47PM -0700, Ethan Nelson-Moore wrote:
> A comment in drivers/crypto/s5p-sss.c incorrectly refers to
> CONFIG_EXYNOS_RNG instead of CONFIG_CRYPTO_DEV_EXYNOS_RNG. Correct it.
> 
> Discovered while searching for CONFIG_* symbols referenced in code but
> not defined in any Kconfig file.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  drivers/crypto/s5p-sss.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
> index bdda7b39af85..9bb1b1661174 100644
> --- a/drivers/crypto/s5p-sss.c
> +++ b/drivers/crypto/s5p-sss.c
> @@ -2151,8 +2151,8 @@ static int s5p_aes_probe(struct platform_device *pdev)
>  
>  	/*
>  	 * Note: HASH and PRNG uses the same registers in secss, avoid
> -	 * overwrite each other. This will drop HASH when CONFIG_EXYNOS_RNG
> -	 * is enabled in config. We need larger size for HASH registers in
> +	 * overwrite each other. This will drop HASH when CONFIG_CRYPTO_DEV_EXYNOS_RNG
> +	 * is enabled. We need larger size for HASH registers in
>  	 * secss, current describe only AES/DES
>  	 */
>  	if (IS_ENABLED(CONFIG_CRYPTO_DEV_EXYNOS_HASH)) {

CONFIG_CRYPTO_DEV_EXYNOS_RNG was already removed by
https://lore.kernel.org/linux-crypto/20260531175932.32171-1-ebiggers@kernel.org/

I didn't want to touch this comment which is nonsense anyway.  But if
you're going to try to update it, it should be updated to correctly
explain that the driver is working around broken devicetree bindings.

- Eric

