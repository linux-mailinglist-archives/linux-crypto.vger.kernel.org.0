Return-Path: <linux-crypto+bounces-20474-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GP8pLb89fGkxLgIAu9opvQ
	(envelope-from <linux-crypto+bounces-20474-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 30 Jan 2026 06:12:31 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17710B73A1
	for <lists+linux-crypto@lfdr.de>; Fri, 30 Jan 2026 06:12:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03E1A303C2B2
	for <lists+linux-crypto@lfdr.de>; Fri, 30 Jan 2026 05:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3637333C524;
	Fri, 30 Jan 2026 05:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="KbCMgdHg"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE98D33F8A6;
	Fri, 30 Jan 2026 05:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769749860; cv=none; b=Im4Jg50nha00Gh8vohZ5sScinRaqmOR3GXShDJAV7wJnRMkQDpH7fiJWmV/G/jL2jH7N1rTeU5d792547d1yoxqvGaBNe09ijesTcLlPsRONxkCIG6U+sVvjrJLc+N0i6zPpq8LSUyYmgEvpKV5NFQR2TRC7U6s6PKXU803IEE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769749860; c=relaxed/simple;
	bh=SR9s5oRQ5MdP67G3f7qcWYmtiiNHB8IPJlrsxhRBAus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gsv1En3nn/PxfMWYBn71ehQLQs0SRMmrnB4e2v56L0DcK2Y7m/EWHwGxnr//aJlhWNT5s8TBX01C6WscxAm/uyL7oBt7noZYCJJMazcwPDYPdRvg4jL3jF3tkHJddcMcPy+FUHgILjGUPJS0Nffh5LwEB2muvlUnJQPQZonjK78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=KbCMgdHg; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=aTE635nylV+CsuYnB1QJnswo4PraDvGjNuU6gzG7dWA=; 
	b=KbCMgdHgySXA2ZX3NPkCRe8v2caI9lk3v1POcWrwq2L2gi0EJwxlcFopoUPpSqW9VrAxpvYBX4L
	Qz+bYvXCi6qcFqTvNz0Ki0gafv0dEWbUK7f2mqVrr1UUU/1Hi2UPA6UA86ftBZtSL9F1ZiKviBcGW
	jr5YeIuSxCw0SqCUUc9cjUoDPu15btJoL6JrOSOQvV1vgsDR2mo8m4echVzb1xvG5MZWc9ny6NnZK
	oqifuhdR6H/y3fxsomtkIg1dMeACCBflZDBmcTpslf9Zy5ca+bOdsCl8rFSaOfoFIm7YGjyMjinN6
	tmkSrE+bugwGvD4QNgXKaFwJ92jtutyO5frQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vlgmQ-003DaK-2c;
	Fri, 30 Jan 2026 13:10:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Jan 2026 13:10:50 +0800
Date: Fri, 30 Jan 2026 13:10:50 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: jeffbarnes@linux.microsoft.com
Cc: "David S. Miller" <davem@davemloft.net>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jeff Barnes <jeffbarnes@microsoft.com>
Subject: Re: [PATCH] crypto: aead: add service indicator flag for RFC4106
 AES-GCM
Message-ID: <aXw9Wj19ZX6dpNHW@gondor.apana.org.au>
References: <20260129-fips-gcm-clean-v1-v1-1-43e17dc20a1a@microsoft.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260129-fips-gcm-clean-v1-v1-1-43e17dc20a1a@microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20474-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gondor.apana.org.au:mid,gondor.apana.org.au:dkim,apana.org.au:url,apana.org.au:email]
X-Rspamd-Queue-Id: 17710B73A1
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 04:04:36PM -0500, jeffbarnes@linux.microsoft.com wrote:
> From: Jeff Barnes <jeffbarnes@microsoft.com>
> 
> FIPS 140 validations require a “service indicator” to positively
> identify when an approved cryptographic service is provided. For
> RFC4106 AES‑GCM (used by IPsec), this commit exposes a per‑request
> indicator bit when the IV/nonce construction meets the FIPS uniqueness
> requirement.
> 
> Specifically, the indicator is set when the caller uses the RFC4106
> construction with seqiv (per RFC 4106 §3), where the 32‑bit salt and
> 64‑bit seqiv together guarantee a unique 96‑bit IV per key. This
> meets the SP 800‑38D §8.2 uniqueness requirement for GCM.
> 
> No ABI or uAPI changes. The flag is internal to the crypto API request
> path and may be consumed by in‑tree callers that need to record service
> use in a FIPS context.
> 
> Tests:
> - Verified that gcm(aes) requests never set the service‑indicator bit.
> - Verified that rfc4106(gcm(aes)) requests consistently set the bit.
> - Existing crypto self‑tests continue to pass.
> - checkpatch.pl: no issues.
> 
> Signed-off-by: Jeff Barnes <jeffbarnes@microsoft.com>

Rather than exporting this indicator, I would prefer that we just
forbid non-compliant combinations when FIPS mode is enabled.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

