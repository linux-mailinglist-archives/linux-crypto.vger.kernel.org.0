Return-Path: <linux-crypto+bounces-22487-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AO0LAj1XxmmMIwUAu9opvQ
	(envelope-from <linux-crypto+bounces-22487-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Mar 2026 11:09:01 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F24C1342324
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Mar 2026 11:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ACE28301CC57
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Mar 2026 10:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B763A7835;
	Fri, 27 Mar 2026 10:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="nXM6NYqD"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED9A3A6B6C;
	Fri, 27 Mar 2026 10:06:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774605996; cv=none; b=LRVmdmteZ1rc6DhUGGuQhlVMPmHpIZLfN9GWI99I8PAn/hbiVUg4CycxJCR9hMZ8G3lgrMAOFzvbMsGU4pC9fKy9p5/GRpe6cHEdRKExZ7xzE1jIWXMb4FSm9NWlcVSu3IfQnr1appgKv6htPsE2puk4XX3Ekwziyi90Q8cBh4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774605996; c=relaxed/simple;
	bh=zgogzunzZcX6DKdzenpH/ZG9zxsoo51A0yxt41mpKc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+npNemJwFZmUJJDP3VfLhYGNKFxx2PAKAauk0K0qTVZh1lNGnkEJ8WpDFplspB8rQgwG47ESUv/c17HDB0Di+7teWO07voifF2/AsV2+Bt3wMwIY8djkMNPGeilJSX21DA+gtQEBoWksoD5vJdthRv3CaQPkP44O3yjIgAc6x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=nXM6NYqD; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=LOyXg9H270P1bQHj7985dPQaPCALrgmaL3wqV9ON7sc=; 
	b=nXM6NYqDmqG76a7m4HXCnY5uS/bM+AeJ5mqtubGX+vvlYa3VMwpmy707W5PhtzFqvI0bURDXzGk
	5YsWQTpsrRZltZwsqbLIZ47x7bqH+axIdZcIXD6/kT9X2o0DVeQfrdBGe7tZKSlvJyHditlqfs+K2
	mcH4AshpzIa8RbMGg1QKk+jf5XcArtsM+Skcu3NsVWgtwpNXyfW9TvEahsm5PE+k6bpKniNe5uPPX
	ZfwYUl+/cCG+/WsqKe95z7dYFTGsNLrZrmaq2ExlWdsmp6gapjDgy2K+Kg9kat3e+Q5n96+AK6WCQ
	iUkNCu3iKoxeukq50/AGM45isI0xDoJinp4w==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1w63ff-001bmJ-34;
	Fri, 27 Mar 2026 18:06:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Mar 2026 19:06:22 +0900
Date: Fri, 27 Mar 2026 19:06:22 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: marvell/cesa - use memcpy_and_pad in
 mv_cesa_ahash_export
Message-ID: <acZWnmc9IOO-ZyjU@gondor.apana.org.au>
References: <20260317165258.1304521-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317165258.1304521-2-thorsten.blum@linux.dev>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22487-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,apana.org.au:email,apana.org.au:url,gondor.apana.org.au:dkim,gondor.apana.org.au:mid,linux.dev:email]
X-Rspamd-Queue-Id: F24C1342324
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 05:52:57PM +0100, Thorsten Blum wrote:
> Replace memset() followed by memcpy() with memcpy_and_pad() to simplify
> the code and to write to 'cache' only once.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/crypto/marvell/cesa/hash.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

