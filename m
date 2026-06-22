Return-Path: <linux-crypto+bounces-25294-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GzEKLHHmOGpfjwcAu9opvQ
	(envelope-from <linux-crypto+bounces-25294-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 22 Jun 2026 09:38:25 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F756AD4C1
	for <lists+linux-crypto@lfdr.de>; Mon, 22 Jun 2026 09:38:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gyuWmIlz;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25294-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25294-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0CE13030E9B
	for <lists+linux-crypto@lfdr.de>; Mon, 22 Jun 2026 07:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6219036E468;
	Mon, 22 Jun 2026 07:38:01 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3991A36D9EB;
	Mon, 22 Jun 2026 07:37:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782113881; cv=none; b=K6CZWrYAdf0MzdXc0Xp7/LeL5YcR3m0cXTd/J8n1bx7Fl7FYn7i/+mmiuEEO4dm0ao8ctztLNRyzFniMYaYqiaO1S3SCforqJM+SV2RXo0La9mqJ9m8yxIWRWSP3bzylqCDGvInfm4F5CcLIORKWMPwHWWT5RnuIqkRmySjrqFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782113881; c=relaxed/simple;
	bh=2JnZp7M49poI/fSZ0yf26kQj+a0PRFmsz1BVhRR/bks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tNZdQMMhYLG2AGmSLwyRb6UvMF6bwWsuQQu8O9M3mh83q3+NigmKiZL+YLTyMOQqi1uWW+yb2kXkEC5RqHMuOZpVfhLv3mRR16Sq7kHFweOWJXw4RJ04EYXxMlB23glHv1ZxtW0x1xx2MgiR7e2zM/RQaEkS/7XGwAiQET04iTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gyuWmIlz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1F221F000E9;
	Mon, 22 Jun 2026 07:37:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782113879;
	bh=moTbx0RFo+uvT+Pxb32XDw9nJ+Mu1YWJBEYCVjzKA+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gyuWmIlzux+LBkkR4jhe2TAl1Hs2vJWj4OJdIJ3+TcUw0MFBJX5fc2iZobWTqYi+T
	 D8VhnGvQTp9tk+Nl55mE0e60KT+Ph+JO5NOluxLJ84I3tCtFPZCykz9mMqiiZT28pq
	 ziR+ABsRpqibaA8KgpwgzF9r31Fov1L206e4RA0lFkE9LXJVvkyXSrr5O/i57fhtnu
	 GdEWIdVhX8ICzRiM1uA37DW9La0xdpu1LSx8hqxRIHbNL343H6VUdW5rrNVNmVqlVL
	 XR0lZ7M0DLP01Uzvhly5ZeSiYOksBxY3vGELdOc1Cunxdhmg/R5WkHzfDUWo15o/+d
	 gAZQ+/GJ3GwSQ==
Date: Mon, 22 Jun 2026 09:37:55 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jad Keskes <inasj268@gmail.com>
Cc: Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivia Mackall <olivia@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Alexander Clouter <alex@digriz.org.uk>, devicetree@vger.kernel.org, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/2] hw_random: timeriomem-rng: add configurable read
 width and data mask
Message-ID: <20260622-exotic-seagull-from-neptune-bb5f97@quoll>
References: <20260618120110.36439-1-inasj268@gmail.com>
 <20260618120110.36439-2-inasj268@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260618120110.36439-2-inasj268@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25294-lists,linux-crypto=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,quoll:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 03F756AD4C1

On Thu, Jun 18, 2026 at 01:01:10PM +0100, Jad Keskes wrote:
> The TODO for supporting read sizes other than 32 bits and masking has
> been sitting in this driver since 2009.  Implement it.

And who - which driver/platform - uses or needs that? We are not really
doing things because someone wrote TODO in 2009. Quite likely notes
from 2009 are way outdated...

> 
> Add reg-io-width (1, 2, or 4 bytes) and mask support.  The read loop
> dispatches on width using readb/readw/readl so a configured 1-byte
> access does not trigger a bus error on hardware that rejects 32-bit
> reads to that address.  The mask is ANDed with the value before storing.
> 
> These are platform properties, not runtime policy -- width depends on
> SoC integration, mask reflects which output bits carry entropy.
> 
> The alignment check in probe is updated to verify the resource is
> aligned to the configured width instead of hardcoding 4-byte alignment.

Best regards,
Krzysztof


