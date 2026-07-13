Return-Path: <linux-crypto+bounces-25893-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UPq5DGpfVGr9lAMAu9opvQ
	(envelope-from <linux-crypto+bounces-25893-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 05:45:46 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE5C5746FD3
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 05:45:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=NxHs58vN;
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25893-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25893-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2BCF5300362D
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2026 03:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041A8285CB9;
	Mon, 13 Jul 2026 03:45:44 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D1A22ACFA;
	Mon, 13 Jul 2026 03:45:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783914343; cv=none; b=hfv2NjQTlQYra8MSu5In2ipeIBkaIVfxnLPLGalfxaS5XFwwH7k0caIr2Ij1KCWGesMYL3XHQrgzJL3snGqJI1RFFytU+wQ6FdfnubBJ8zsZJ8Drhu1v8eCjhlp5pAAGPGlUsyuNA6siGhqlnaBMVhhtRu+dXCkU3Limm5bDjJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783914343; c=relaxed/simple;
	bh=k6JJMv9ZdblAAOzYVjv7o58ONlat5Dcwod+X52UeHgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dzN0/rO/XYja2ZJJz9G7ZUxFSo0DarbohymmR7RLn8vwtzKSwJ22m2sGzsA8mfZ3TEku6OVvzyUUsF+Wo6oEhudiDO15VgBeuB+7dvA9nbT3NUuR/VftY3on/W4G/Eo/x0+jqRaxmp9YmbS6z6d9sFCCuJhfsQ3AXql+0BZp8fU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=NxHs58vN; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=93GTo6Gum5smd+5liiS3l4OWy5HTAvTAnR4D+xSApcc=; 
	b=NxHs58vNyH1N2Q97Pl7x797VT6EDS4xhpMl9sEOpxX2h1ookNuTk1uTfRCtCkoHPWIc5vXoGd25
	sZRzntp99r+w2MiNr+6OCrb/Sy07ZNyEeHisGvaGObhM38bRQ8v59zmjMp8jo0WbohX7+btyZ2C9q
	Qreesg8/6pyi8uVABd71yHeDEKULriSIZtYGUv5YsB1lWshPG+9H8sF/SJhMt0nPPl70CRKsUqfqj
	0we0oQkdltUePOCw+z2qV2JLNjobDkcAkueR7vtxhIPjNB8LeRJFQqXMp9arsRRkI4a9j0xPQtyEk
	KoAwLL+89J8POeZZiZAruNfCqh0JekrJjrJw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.98.2 #2 (Debian))
	id 1wj7bm-0000000CyHG-44fC;
	Mon, 13 Jul 2026 11:45:32 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 13 Jul 2026 13:45:30 +1000
Date: Mon, 13 Jul 2026 13:45:30 +1000
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Mark Gross <markgross@kernel.org>,
	Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
	linux-edac@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
	Tony Luck <tony.luck@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-kernel@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3] MAINTAINERS: Drop Mark Gross
Message-ID: <alRfWpuiEiRC72u3@gondor.apana.org.au>
References: <20260703173803.3589003-2-ukleinek@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260703173803.3589003-2-ukleinek@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25893-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ukleinek@kernel.org,m:akpm@linux-foundation.org,m:markgross@kernel.org,m:konstantin@linuxfoundation.org,m:linux-edac@vger.kernel.org,m:bp@alien8.de,m:tony.luck@intel.com,m:davem@davemloft.net,m:linux-crypto@vger.kernel.org,m:arnd@arndb.de,m:gregkh@linuxfoundation.org,m:linux-kernel@vger.kernel.org,m:andriy.shevchenko@linux.intel.com,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,apana.org.au:url,apana.org.au:email,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,gondor.apana.org.au:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE5C5746FD3

On Fri, Jul 03, 2026 at 07:38:03PM +0200, Uwe Kleine-König wrote:
> Sending mail to Mark's Intel address results in the intel mail
> server rejecting the mail. Dave Hansen confirmed he left Intel.
> The kernel.org address seems to work, but there was no reply from Mark
> on the discussion about broken email settings and his maintainer
> entries.
> 
> So drop him from all maintainer entries.
> 
> Signed-off-by: Uwe Kleine-König <ukleinek@kernel.org>
> ---
> Hello,
> 
> this patch was already send end of May (v1 @
> https://lore.kernel.org/all/20260526173806.3227828-2-ukleinek@kernel.org).
> Konstantin then suggested to change the maintainer contacts to the
> kernel.org address as at least one of the forward-addresses for the
> kernel.org account didn't bounce. This v2
> (https://lore.kernel.org/all/20260526193238.3622176-2-ukleinek@kernel.org)
> wasn't picked up yet, but given the continued silence I think removing
> Mark completely is the saner choice now.
> 
> If someone has a better contact, please make him react. If he returns
> later, the entries can easily get restored.
> 
> Best regards
> Uwe
> 
>  MAINTAINERS | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

