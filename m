Return-Path: <linux-crypto+bounces-22192-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YL1QKIRavmmYNQMAu9opvQ
	(envelope-from <linux-crypto+bounces-22192-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 09:44:52 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 150122E4342
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 09:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 037A7302B832
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Mar 2026 08:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A11B33DEF9;
	Sat, 21 Mar 2026 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="a/vrsT9v"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE137346FDB;
	Sat, 21 Mar 2026 08:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774082684; cv=none; b=dpk+fP018WsvXL+Z24TIe5r0z4fewP8BHallnQ3QF4HAhbxIiTANTucYx0vJXzEvQ2sIGEYnOdRkzU13azvLZ+1sRDFNhzNo5VV7owFcG9d5jAgtgnbgdrcQCasVdaNZzzm3XwRCEsKEXRM47OlYjdsP7fZJAYcs+FmkvaLSGWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774082684; c=relaxed/simple;
	bh=Ox7PtjAooksMblxTqEknOoRFKB6RJmP1/E3fKgadloE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HUkwL3jmXljKx745OwPH1DHywXkQjSliOv6lp+pbMhiKQtsov8/ZL2WwS1Sh/z6LQ06k2s0nFhiXKfPP+HaJRuEn796czECTNo6Z39fJ07TUNzcvjHA2Ion5reyhdgPqnN4tiAHT5+T6w8kMX2sZTy6XXFy+uU9uRNzkGVfQ9zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=a/vrsT9v; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=4LcMthmZq2UlHlX6mq9K9qphF3lSZPiu9ZMzjfT2sh4=; 
	b=a/vrsT9vdUQLXygm1cirTW+9bRZwfdp78sKlVP1vf0cdnjGPVpCA5jdGSsAA1YSEt63OW8OY4qU
	DinaaPizuZbswBGt+CYQPgDhtVp63hVW36oxiMbnSOemSDCCxY2P/gfDcrM5uSvK9MfCYreMpy/Vn
	5scqx6K5LzT60oGSAN8TcLurI1QyS9lqii5LAlakroPUWeZFCpR7L7LG4jXbmOqvyPhlSZB2NNAde
	95NJYwcTp5z9WM5cCgSAwsqL6ZOr2Vc3ELxZ98tHafHL4JYCwBim5o0wVCI4vC7vvjeW88tS1oCpy
	t3+zrk1Vzzcw7DkUg5tOS6W9I8lLhhXPks0g==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w3rwF-00GJ6M-2S;
	Sat, 21 Mar 2026 16:44:08 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 21 Mar 2026 17:44:07 +0900
Date: Sat, 21 Mar 2026 17:44:07 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Tycho Andersen <tycho@kernel.org>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ashish Kalra <ashish.kalra@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	John Allen <john.allen@amd.com>,
	"David S. Miller" <davem@davemloft.net>,
	Ard Biesheuvel <ardb@kernel.org>,
	Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>,
	Kishon Vijay Abraham I <kvijayab@amd.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Kim Phillips <kim.phillips@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3 7/7] crypto: ccp - Update HV_FIXED page states to
 allow freeing of memory
Message-ID: <ab5aV8_BW5jfUDc3@gondor.apana.org.au>
References: <20260317162157.150842-1-tycho@kernel.org>
 <20260317162157.150842-8-tycho@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317162157.150842-8-tycho@kernel.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22192-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,apana.org.au:email,apana.org.au:url]
X-Rspamd-Queue-Id: 150122E4342
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 10:21:57AM -0600, Tycho Andersen wrote:
> From: Tom Lendacky <thomas.lendacky@amd.com>
> 
> After SNP is disabled, any pages allocated as HV_FIXED can now be freed.
> Update the page state of these pages and the snp_leak_hv_fixed_pages()
> function to free pages on SNP_SHUTDOWN.
> 
> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
> Signed-off-by: Tycho Andersen (AMD) <tycho@kernel.org>
> ---
>  drivers/crypto/ccp/sev-dev.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

