Return-Path: <linux-crypto+bounces-25035-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 5EEUNlpKKmpkmAMAu9opvQ
	(envelope-from <linux-crypto+bounces-25035-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 07:40:42 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4963E66EB9F
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 07:40:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=c4eeGaJh;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25035-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25035-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D12E63042925
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 05:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E132C15B0;
	Thu, 11 Jun 2026 05:37:59 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AFE2DF144;
	Thu, 11 Jun 2026 05:37:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781156279; cv=none; b=CBCD+EsMCPZ2jbJ9nOEk+TE4COjBh8pTU1ms2q3rw9/GfaNhWLV8Ov2tUr6xw5k0QTmAGefCq4wNCjkECGN/bJgNQzJkUFT7JOVcb+HY/12j/NJFdwxHYW9Dod7KOrNIygdXW50gLOfjaPwYegIIEe5PSHNuukX3ECeP5tA8+wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781156279; c=relaxed/simple;
	bh=JvtTlhA22zr7CMpFpp9VoXOIuRajXbVgPXTJi9C6he8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQxnHP8Ii/cT/xfeGK975ICM5sIR3KBj5Zlx+OnGELM3xmARKDxhvFFwAw6bebesisNxJ0P4+mIe+rRunBCkEGHvjrVTXZHblhzPOSo1hRJKzqivd+Ja21/PK828D5muIeE1OvKmxUCl0dko/3ambzpm3tJd2xwuM0PN5mdwPec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=c4eeGaJh; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=bjrwTRXUJkUzAen+TJe9vUZ83P6S8v0PcW2OfwzccUk=; 
	b=c4eeGaJhwSAO9wou1Y0OXAhvrSFS8xa4vj09NeCCX4spk93f+uuJQJKD/umnI5dkoMTmQRWfRPK
	PmsDyTaf1Uc+LQUzhnwYF7lNGtdOlilpxTucv/oyPY6moM13FE5XNzuu660CTE6HupEK8fwmwioW5
	fVtzujnlsnRL+14NKvJ0qraUH1dinGOU5iSNjYAYvkN41Tl7WYpL8YtZznNUuad9MnXhwYMsKKa9T
	bKz+0OvVGe74W4Bpnssrx8PFkcKh/Cu8htXE9wirpUMktjROpAqE+Wzj1V0Duh78nbOf3SvTI+Q5z
	kFUNUQ3j2npoDzoT9LXSu4XpQc+csvLZE8jA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wXY6z-00000004UKE-0OJf;
	Thu, 11 Jun 2026 13:37:54 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 11 Jun 2026 13:37:53 +0800
Date: Thu, 11 Jun 2026 13:37:53 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: omap - use min3 to simplify omap_crypto_copy_data
Message-ID: <aipJsbxHH9eGE9aD@gondor.apana.org.au>
References: <20260604001035.1256238-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604001035.1256238-3-thorsten.blum@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25035-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:thorsten.blum@linux.dev,m:davem@davemloft.net,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[gondor.apana.org.au:dkim,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,apana.org.au:url,apana.org.au:email,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4963E66EB9F

On Thu, Jun 04, 2026 at 02:10:36AM +0200, Thorsten Blum wrote:
> Replace two consecutive min() calls with min3() to simplify the code.
> 
> Change the function parameters and local variables from int to size_t
> since these represent unsigned values and to prevent a signedness error.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/crypto/omap-crypto.c | 12 ++++++------
>  drivers/crypto/omap-crypto.h |  2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)

Please stop these min3 patches.  It makes the code harder to read
for humans.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

