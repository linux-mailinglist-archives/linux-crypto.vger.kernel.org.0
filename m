Return-Path: <linux-crypto+bounces-21945-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OItVMkbutGm/uQAAu9opvQ
	(envelope-from <linux-crypto+bounces-21945-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 14 Mar 2026 06:12:38 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E06D28BB7A
	for <lists+linux-crypto@lfdr.de>; Sat, 14 Mar 2026 06:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EA13304C0B0
	for <lists+linux-crypto@lfdr.de>; Sat, 14 Mar 2026 05:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E143368B1;
	Sat, 14 Mar 2026 05:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="CebeX5Xs"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A65230270;
	Sat, 14 Mar 2026 05:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773465126; cv=none; b=YL6PPnTKbtql8ntmEDbxl1Z0tt2z+5DFnzJlTQcYzBD5lgxKxIWKO1IZO7des2n1TSM2hLHoXRL/5FitlGylHAEsu41A7sVmc25dyKEnlPz20MvBSbwXkrfPChWW5UOau5EKXgp/fU4YJxW6Kc/uw8LNRB1zJlFCsvinJX7D39o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773465126; c=relaxed/simple;
	bh=p06AXyoo1Q/rpTNUqebpnpLgDCWzFv8UA25q24bvcOk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e5+tAumUFcrfP/9eNey2JRyqcGe8XsA1fS0G42Wur6kf+WOx+5ZlDArMPVMSaHtuaTi5RKQYAyKKyugC99pQ06YrhMYNIVw9nzNCUUSg1VC06vC7LM4ENP+MAwBbTsVv4+d+0DHslOtgueasjPAu3fN3dHKZVevkMkNzTFxdkt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=CebeX5Xs; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=/qTAXHbi8wFOK4Xven3Jy2oD3hr9BGnd48GuXiXwDkw=; 
	b=CebeX5XsrXyoZbxNL5JXZtac21WNi/Ii2vit9eIZqq0JkJUp0ENFTW3BDjZH/UfTyQ/0PS6NI/y
	bcQxEEKwC83345K16jO/3Y+G7ZEHufbRabH9UIHWaGKKpDcEfKjxWdBMlY7zDeKAAA8ogq7tvXiu0
	A9Hw31SnXy6BXfXeF/ncsukXYqYrXZwfjv/7hztrmJNmyNnDED4IJ84KTTyQVdVUlKlLgsYbMfkk3
	4vnqRM4NWDhqhqd13Wjayae68QaPQLO2cGR/LyHl6LDqGIo65PIhtIGdtdoz5ly1Ji5Hv1TelwIYl
	3WBntw562CLftSj99zudb6CWCzMDIEY2KTLg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w1HHy-00EL7k-1c;
	Sat, 14 Mar 2026 13:11:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 14 Mar 2026 14:11:50 +0900
Date: Sat, 14 Mar 2026 14:11:50 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Joachim Vandersmissen <git@jvdsn.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-crypto@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: testmgr - block Crypto API xxhash64 in FIPS mode
Message-ID: <abTuFto8Tc3mhRRe@gondor.apana.org.au>
References: <20260303060509.246038-1-git@jvdsn.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303060509.246038-1-git@jvdsn.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FREEMAIL_CC(0.00)[davemloft.net,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-21945-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 2E06D28BB7A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 03, 2026 at 12:05:09AM -0600, Joachim Vandersmissen wrote:
> xxhash64 is not a cryptographic hash algorithm, but is offered in the
> same API (shash) as actual cryptographic hash algorithms such as
> SHA-256. The Cryptographic Module Validation Program (CMVP), managing
> FIPS certification, believes that this could cause confusion. xxhash64
> must therefore be blocked in FIPS mode.
> 
> The only usage of xxhash64 in the kernel is btrfs. Commit fe11ac191ce0
> ("btrfs: switch to library APIs for checksums") recently modified the
> btrfs code to use the lib/crypto API, avoiding the Kernel Cryptographic
> API. Consequently, the removal of xxhash64 from the Crypto API in FIPS
> mode should now have no impact on btrfs usage.
> 
> Signed-off-by: Joachim Vandersmissen <git@jvdsn.com>
> ---
>  crypto/testmgr.c | 1 -
>  1 file changed, 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

