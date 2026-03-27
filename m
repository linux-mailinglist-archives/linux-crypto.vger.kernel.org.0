Return-Path: <linux-crypto+bounces-22498-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNnwHxZZxmlgJAUAu9opvQ
	(envelope-from <linux-crypto+bounces-22498-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Mar 2026 11:16:54 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB3C34256B
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Mar 2026 11:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECE9C3156EE1
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Mar 2026 10:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31BE035E923;
	Fri, 27 Mar 2026 10:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="pCrAFtDb"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C680132F770
	for <linux-crypto@vger.kernel.org>; Fri, 27 Mar 2026 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774606230; cv=none; b=PjGDapPf8JD7YrP6gl1vdggWdbZGWtFsbJOy19qScVyC2iFjwfPqeh6c0ViG8/ZJjw/QYmfogbExY2BGEaCSYansuVD5DJbTZGf6TeSzRcSJDdds1PZmCm5RFzhoMU5m5/f/t6rZR8nbkq57uiAziG5zq4fg6EIql3Q9WXcKbuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774606230; c=relaxed/simple;
	bh=EymbYgP9mpl4qZv9TD/rGV0bEseFUfayA/soQnR43cY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NII0jc7b91Fk4gajJFW8eqKl65mvosx4xkLvfA/JOK1VP0QDvD9leOIGhnB+FF5Y9rN/DVNE5ZaIyj1RfPgiBe4SnpWClXk+AeDk+/Z9bBweM2v4AOEv1rUtO2s2oivAx3T78kzgvQn3WX5t6Jz6hq+SRyLmI3qJMADaRn2U2js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=pCrAFtDb; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:from:
	content-type:references:reply-to;
	bh=5alsmGBcUUo5sT2oWwlb3nxfbcGfw8lkyKgJ/iCw9fY=; b=pCrAFtDbu95lM1qfKwUuNMhGki
	ESct46XEOPhF6WnrQTcXrWyXZmy4H8qU7LjL5eCBRDLud3R/8nHvHNUP+waX8O8GFDCZNJo0vYPZC
	YhKCVwW1F2MK9h3bAs/aNjnsNpmUp21VXtuIY4tdZSeAJejymOX557PKehiRs3TOfRwPXwKXOsTyh
	Yx8VwRRNZUgiWW/BHAZ4jK8TYcE0PYDJNy70F2AmGBDoGCGgVZcVY9xbK5xiDV1KGolLSeEI1UZm8
	mjoaHBblHZeaziDRaILAXDBEJz3/NPnBaMUU4rFUyBoU6wvThb5cofzdrDlK0G2MiXz7I2zwOyqhr
	UUO3bIrQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w63jZ-001bsm-1S;
	Fri, 27 Mar 2026 18:10:25 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Mar 2026 19:10:24 +0900
Date: Fri, 27 Mar 2026 19:10:24 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2] crypto: inside-secure/eip93 - correct ecb(des-eip93)
 typo
Message-ID: <acZXkNz0BVL8Bbiw@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0090aea-45f9-48b6-99a7-7ad8666dce59@yahoo.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22498-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[yahoo.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,apana.org.au:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gondor.apana.org.au:dkim,gondor.apana.org.au:mid]
X-Rspamd-Queue-Id: BAB3C34256B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Mieczyslaw Nalewaj <namiltd@yahoo.com> wrote:
> Correct the typo in the name "ecb(des-eip93)".
> 
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> ---
> drivers/crypto/inside-secure/eip93/eip93-cipher.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

