Return-Path: <linux-crypto+bounces-25293-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id liONOxbmOGpVjwcAu9opvQ
	(envelope-from <linux-crypto+bounces-25293-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 22 Jun 2026 09:36:55 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 80E876AD4A2
	for <lists+linux-crypto@lfdr.de>; Mon, 22 Jun 2026 09:36:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=G7Qip6xv;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25293-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25293-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DDE9A300A4A1
	for <lists+linux-crypto@lfdr.de>; Mon, 22 Jun 2026 07:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7116636F411;
	Mon, 22 Jun 2026 07:36:42 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5528C36E489;
	Mon, 22 Jun 2026 07:36:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782113802; cv=none; b=rfC4o6DFePR44obTuXHDrT9jYixksHGYna51CqJuJDBIqaZvtN7OlDoasqrG1WCv0xSLm/0NdrkTq7htF9aqXXX3LHZyDyOFWFXxkCdmJYBOmkOd7llxixviIjPsoN9QVjVfTDBHb4x4XEu9mN7mF5EwlRtwOXRZq+9rl0hs1wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782113802; c=relaxed/simple;
	bh=NGcfW53OD7hUMG7jk+IL7DLAol0wfrB4eVEwWeRgxlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kh0iekPLPg1Fp/hn8VQMmU0kb+ACgKRfC65XVJet/GUAm6WKjcjc76zjR4raADWoJI38kTRDuEHqYnMtE8IOIKW5I8d7hEo99eqCnM1mxZMkPfvo7OwooWiM8QgpoAmP0eq8yMPSr7MQ20k/gTMLWGcTym9TiNfY6c1U0e3nxJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7Qip6xv; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A181F00A3A;
	Mon, 22 Jun 2026 07:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782113801;
	bh=Do3/3VdIxMtgHjklQ9oNzFDNcBXRA87Y/Bdni4pf3Yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=G7Qip6xvIt1iRuNN7fUwoflCEWhC6bPFFfaISollUjWTFH641KTj0JOlYyXjkDba4
	 VhXZHKR7jF+UzwA3JOupMgb+C8ToR9ao9d294tN+PP98DzvJnlBFNed4+0opaXIlaB
	 oO7yj4sowW9YbSfawND3fRso3tjjIrUM4b5+aGztbD9q9YSone56FwCuYsvcvktWMU
	 RnST0cld8RlGMOlVCaDrJggMJ70E3+Z0gWWS/bsxUXwqZcMmfx/xTXHuZj2o8F79jo
	 CULMq8elD6lMytEg5fN9FnWwLB0V6V69lWgcDqCE40b8mjQuzprwaJgTwygaNWHfPQ
	 5xxfUZpNvv4Tg==
Date: Mon, 22 Jun 2026 09:36:37 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jad Keskes <inasj268@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Alexander Clouter <alex@digriz.org.uk>, devicetree@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: rng: timeriomem_rng: add
 reg-io-width and mask properties
Message-ID: <20260622-inescapable-primitive-horse-48cf65@quoll>
References: <20260618120110.36439-1-inasj268@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618120110.36439-1-inasj268@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25293-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[krzk@kernel.org,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:inasj268@gmail.com,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:olivia@selenic.com,m:herbert@gondor.apana.org.au,m:alex@digriz.org.uk,m:devicetree@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,quoll:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 80E876AD4A2

On Thu, Jun 18, 2026 at 01:01:09PM +0100, Jad Keskes wrote:
> Add optional reg-io-width (1, 2, or 4 bytes) and mask properties.
> reg-io-width selects the bus access size.  mask is ANDed with the raw
> register value to allow only the entropy-bearing bits through.

You should explain here why. Why are you doing this? Why do we want
this?

> 
> Update the example to show a 1-byte configuration.
> 
> Signed-off-by: Jad Keskes <inasj268@gmail.com>
> ---

Best regards,
Krzysztof


