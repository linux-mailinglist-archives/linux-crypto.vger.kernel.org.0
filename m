Return-Path: <linux-crypto+bounces-21951-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNF3MT/wtGm/uQAAu9opvQ
	(envelope-from <linux-crypto+bounces-21951-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 14 Mar 2026 06:21:03 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A29128BCAB
	for <lists+linux-crypto@lfdr.de>; Sat, 14 Mar 2026 06:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1152301DB94
	for <lists+linux-crypto@lfdr.de>; Sat, 14 Mar 2026 05:17:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5832C33BBBD;
	Sat, 14 Mar 2026 05:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="f7jUk8ct"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D521A9FAB
	for <linux-crypto@vger.kernel.org>; Sat, 14 Mar 2026 05:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773465430; cv=none; b=RKYKhiFQCxShJFigHbu/WVbJ7kJEXQfuua8kbAbbxlvNwksg4Koaj6FGVwuuas3Qetd3p69mLJCmtqgNFlBZabVJo+Jq47XjgnZfapKAmtAFJguHDNZI0ZST7bqNyy/ZQWjdKLf+3t0AAvRRGt6JRVO/Cgx74aaMdzZMb3t51tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773465430; c=relaxed/simple;
	bh=33XheISWLI9LqRsA19WHt4y11/b7N5kMneaALbLibkQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiI1ncNF0ircH8/MahXFTUyBgjmsx/l1jiOw9Ja1l76W0HP0g5yCDqDL0IU6pgkj9Oq9d1WGFvIKvRviqSRlubtvU+mv+KQjs9hywws56sVbSf1gub8cbfNOeYOYXEeF7zQi9QzTYhr+PW9qgKvjLxdIeP419AN3hzxA3sE4fQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=f7jUk8ct; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=gFR87mztTmSDIGS5N63SXoeqjUfGwZ7fN+0nfaHqJpE=; 
	b=f7jUk8ctVWBSehDHg9Qb0bfXWIthZ7NFBs0mVH9nZeMirTaeGsCbLGTPjhOuR7bvSq0vzOuqPPS
	Wzx4SiqjXwSAF1eB9VyvWjVZPwO3XwZyeKClmob8XPAsF0vYwBea8/l+3C0rlW0UGR62l1/2nDH9L
	lXAjmpzYMjaT1tWnSPxKO1vnDc908md2zYsrb3/utHq9ledT3h7U9kXrZuW5yd+RwBtebF9rO9ge9
	quV5xQCKrGZLzdQaFPyc6Z+aV70owOYXd6Yd2ixpUifmb6l03/zFpo99UEJhwpkBoWEQEqTnq7+KR
	HPtdeYfQjCp5KuyDh5LrBhA+mncRnVfr+MxA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w1HN2-00ELBh-0z;
	Sat, 14 Mar 2026 13:17:05 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 14 Mar 2026 14:17:04 +0900
Date: Sat, 14 Mar 2026 14:17:04 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, "Jason A . Donenfeld" <Jason@zx2c4.com>,
	Neil Horman <nhorman@tuxdriver.com>
Subject: Re: [PATCH] MAINTAINERS: remove outdated entry for crypto/rng.c
Message-ID: <abTvUJamCqmIxmTQ@gondor.apana.org.au>
References: <20260306041915.286379-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306041915.286379-1-ebiggers@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21951-lists,linux-crypto=lfdr.de];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 4A29128BCAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 05, 2026 at 08:19:15PM -0800, Eric Biggers wrote:
> Lore shows no emails from Neil on linux-crypto since 2020.  Without the
> listed person being active, this MAINTAINERS entry provides no value,
> and actually is a bit confusing because while it is called the
> "CRYPTOGRAPHIC RANDOM NUMBER GENERATOR", it is not the CRNG that is
> normally used (drivers/char/random.c) which has a separate entry.
> Remove this entry, so crypto/rng.c will just be covered by "CRYPTO API".
> 
> Cc: Neil Horman <nhorman@tuxdriver.com>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
> 
> This patch is targeting cryptodev/master
> 
>  MAINTAINERS | 6 ------
>  1 file changed, 6 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

