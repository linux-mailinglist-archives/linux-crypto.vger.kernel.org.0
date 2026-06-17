Return-Path: <linux-crypto+bounces-25213-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fHcZHltWMmo9ywUAu9opvQ
	(envelope-from <linux-crypto+bounces-25213-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jun 2026 10:10:03 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78360697721
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jun 2026 10:10:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AsGn2v77;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25213-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25213-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 72E9D3050F33
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jun 2026 08:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827753CC32D;
	Wed, 17 Jun 2026 08:08:33 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E863B3C15;
	Wed, 17 Jun 2026 08:08:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781683713; cv=none; b=j4vVcTEXt/s13J5W9Mdvqe5D1TWdGksdxPz9OltCdEzM5gYR+p5VjH7mpD907ZPIKh+V0RleyexdOapw6QDWHjVNUhBNWGCI7YrL8Krxh2kUrsDieCciPWS0Ww4QyeSMYNqlAqJp8piGvCwFVChZYLZrW1SnxWzjl+yMxJVun4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781683713; c=relaxed/simple;
	bh=701pPDeERqE5FZ9UsS8JzuKBuCKsfjtKQlnHvpZQwao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDy+i1IlJPIC6k+ek4I8+a2nF+qdhe7j6oByAmnlASOTsDoHyOk6573wIR6V36h9whYA0JDWpBuyzQxpRCuwbi+d99PlW4QVpWk0PCefd0OQdHzPkCRVgAr2lghdg5LF0zV07zUVeZfHIb5002pdK7FG7Y66LJ5Vjst53jJFsTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AsGn2v77; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 721111F000E9;
	Wed, 17 Jun 2026 08:08:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781683710;
	bh=HoG9/vDOOpXWqnLjwpYAe/pB1CsaDbIahSGPUtC8/X8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AsGn2v77PqE37kTNZD+tWnIof00woDcDxIAu7dib5zI9QgdkqWBcRZmVaJJRnsrCt
	 AJw9V4Xb1MmCNgLEZBCcedqjYHpD235PFbjwqWMfLJSPsBAhZvvKsWxWpdpRn7r6lz
	 mwsG2hm2tA/nmMCI63WvoRtOjchR0jzxkva+kYE7kVZGqRLgbQVg+t0IHF01wsPxqM
	 8dK0aZSh8t45CBHURVNZD9kuVT0EW2MqOwBxaUht2i/w2xVhC2KZnTTtT09MDrkTGC
	 TYqI8i3GeInpIZsGyHaCryURlE4O/A8RkdV8OaoVlbbT2+8MVxBa7wi1e9Q7te9pTo
	 Bua6RvUYddalg==
Date: Wed, 17 Jun 2026 10:08:26 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jad Keskes <inasj268@gmail.com>
Cc: Olivia Mackall <olivia@selenic.com>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Alexander Clouter <alex@digriz.org.uk>, linux-crypto@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] hw_random: timeriomem-rng: add configurable read
 width and data mask
Message-ID: <20260617-grinning-tidy-bandicoot-5a2ef2@quoll>
References: <20260615201339.1264676-1-inasj268@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260615201339.1264676-1-inasj268@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25213-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[krzk@kernel.org,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:inasj268@gmail.com,m:olivia@selenic.com,m:herbert@gondor.apana.org.au,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:alex@digriz.org.uk,m:linux-crypto@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krzk@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-crypto,dt];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[quoll:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78360697721

On Mon, Jun 15, 2026 at 09:13:39PM +0100, Jad Keskes wrote:
> The TODO for supporting read sizes other than 32 bits and masking has
> been sitting in this driver since 2009.  Implement it.
> 
> Add width (8, 16, or 32 bits) and mask properties to the platform data
> and device tree bindings.  The read loop dispatches on width using
> readb/readw/readl so a configured 8-bit access doesn't trigger a bus
> error on hardware that rejects 32-bit reads to that address.  The mask
> is ANDed with the value before storing.
> 
> These are platform properties, not runtime policy -- width depends on
> SoC integration, mask reflects which output bits carry entropy.
> 
> The alignment check in probe is updated to verify the resource is
> aligned to the configured width instead of hardcoding 4-byte alignment.
> 
> Signed-off-by: Jad Keskes <inasj268@gmail.com>
> ---
> 
> v2:
> - Remove old timeriomem_rng.yaml to avoid dt_binding_check conflict
> - Use IS_ALIGNED() instead of modulo for 32-bit PAE safety
> 
> 
>  .../bindings/rng/timeriomem-rng.yaml          | 76 ++++++++++++++++++
>  .../bindings/rng/timeriomem_rng.yaml          | 48 ------------

I don't undetstand this diff... what are you doing exactly? And more
important WHY?

Please run scripts/checkpatch.pl on the patches and fix reported
warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
patches and (probably) fix more warnings. Some warnings can be ignored,
especially from --strict run, but the code here looks like it needs a
fix. Feel free to get in touch if the warning is not clear.


>  drivers/char/hw_random/timeriomem-rng.c       | 78 +++++++++++++++----
>  include/linux/timeriomem-rng.h                | 12 +++
>  4 files changed, 153 insertions(+), 61 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/rng/timeriomem-rng.yaml
>  delete mode 100644 Documentation/devicetree/bindings/rng/timeriomem_rng.yaml

Best regards,
Krzysztof


