Return-Path: <linux-crypto+bounces-25238-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HYHhGuDWMmpB6AUAu9opvQ
	(envelope-from <linux-crypto+bounces-25238-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jun 2026 19:18:24 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC7C69BA06
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jun 2026 19:18:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=lGjKtV47;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25238-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25238-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7293430A0122
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jun 2026 17:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9CC33A9FF;
	Wed, 17 Jun 2026 17:18:17 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5C333A6E0;
	Wed, 17 Jun 2026 17:18:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781716696; cv=none; b=oTHuLJJ+dJfyeAmPzBp0wEjXnQL51HYA95bNN+9LHEl9gLofeSANV+IhISyhbw9JDUnINaybMepmoCwcogtV7H52NipfuC0SH1OHdEcYoU2uvAVSozIkCbD3rVEdlrlTE07uvrklpb6ZNO9iUzD3drZFs0hlf8n3b9Y9p9PvAoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781716696; c=relaxed/simple;
	bh=l8hcPdpn9AMbyB99DvePSyEqaE1eyDAHze7o2OkGcyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TgqMbPaQLnh63G3945YwBuvRFaqeah1TFLuHZJMamMdW9cMmmAK/j/te0IXAUhx5v4a0vTyhaZThmoYxL+/XantXKtQVAliVTAbrEZ1ajan58P0egw0UJAex31e3TUGgrkEoZb4rk1KOnqKkI9pSg/hWaB33gmXOBslhADOFnhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGjKtV47; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72911F000E9;
	Wed, 17 Jun 2026 17:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781716694;
	bh=/f4xE4u+ffk1oOCvjwpeDXHL3oZ9vgO7YB9e19Vu9+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lGjKtV47NvY+G1P9uYXp+4/gyMgLgDQrduLqzC88KWb/cELicXoS4/uYfna+omLzA
	 kTHHIct7/E2IiozpSqUUXbTi0AVd24bRx7SBTtA3lHZSjIUIla+rki3EISH2x79xLE
	 CZUMDLUK7L9IaS4nt4AJcFcZOKp7PMVIBfV/yCOLJB0rS0RncSbTAIVo9CxmbK/Z8c
	 oQ5G8jwL3wjVVS4VFuozCCk5p8svSa1boqDf+QX5jj0Vgc0TOXUVQHzxUGMRBuH8/8
	 bNfs3awYHQHSiqXNUlqME9aeWEplWjUluKIFhib0XNuqoTUoh7Hj5pjz6T7DyKwkwA
	 rUHiH9wBR2reg==
Date: Wed, 17 Jun 2026 17:18:12 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Mike Lothian <mike@fireburn.co.uk>
Cc: rust-for-linux@vger.kernel.org, linux-crypto@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
	Asahi Lina <lina+kernel@asahilina.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Alexandre Courbot <acourbot@nvidia.com>,
	FUJITA Tomonori <fujita.tomonori@gmail.com>,
	Krishna Ketan Rai <prafulrai522@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] rust: crypto: add library AES-128 / SHA-256 /
 HMAC-SHA256 bindings
Message-ID: <20260617171812.GE785086@google.com>
References: <20260617150143.2152-1-mike@fireburn.co.uk>
 <20260617150143.2152-2-mike@fireburn.co.uk>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617150143.2152-2-mike@fireburn.co.uk>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25238-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mike@fireburn.co.uk,m:rust-for-linux@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:lossin@kernel.org,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:dakr@kernel.org,m:daniel.almeida@collabora.com,m:gregkh@linuxfoundation.org,m:yury.norov@gmail.com,m:lina+kernel@asahilina.net,m:ljs@kernel.org,m:joelagnelf@nvidia.com,m:acourbot@nvidia.com,m:fujita.tomonori@gmail.com,m:prafulrai522@gmail.com,m:linux-kernel@vger.kernel.org,m:yurynorov@gmail.com,m:lina@asahilina.net,m:fujitatomonori@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[22];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,collabora.com,linuxfoundation.org,gmail.com,asahilina.net,nvidia.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto,kernel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6AC7C69BA06

On Wed, Jun 17, 2026 at 04:01:32PM +0100, Mike Lothian wrote:
> +/*
> + * AES-128 single-block ECB encryption: out = AES(key, in).
> + *
> + * A helper because aes_encrypt() takes a transparent union (aes_encrypt_arg)
> + * that bindgen cannot express. SHA-256 and HMAC-SHA256 are plain extern
> + * functions and are bound directly.
> + */
> +__rust_helper int
> +rust_helper_aes128_encrypt_block(const u8 *key, const u8 *in, u8 *out)
> +{
> +	struct aes_enckey enckey;
> +	int ret;
> +
> +	ret = aes_prepareenckey(&enckey, key, AES_KEYSIZE_128);
> +	if (ret)
> +		return ret;
> +	aes_encrypt(&enckey, out, in);
> +	memzero_explicit(&enckey, sizeof(enckey));
> +	return 0;
> +}

This is kind of an anti-pattern, both in expanding the key for every
block and also exposing bare AES instead of AES modes of operation.
It's true that lib/crypto/ is missing a lot of AES modes (I'm working on
that), but AES-CMAC is there already which is one of the two you need.

- Eric

