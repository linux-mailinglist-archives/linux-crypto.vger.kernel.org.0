Return-Path: <linux-crypto+bounces-24918-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hkS3EtqtImoycAEAu9opvQ
	(envelope-from <linux-crypto+bounces-24918-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 05 Jun 2026 13:07:06 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 361706479DC
	for <lists+linux-crypto@lfdr.de>; Fri, 05 Jun 2026 13:07:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gondor.apana.org.au header.s=h01 header.b=nQidnNEl;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24918-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24918-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=apana.org.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E1A3301E6FE
	for <lists+linux-crypto@lfdr.de>; Fri,  5 Jun 2026 10:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959084C8FEB;
	Fri,  5 Jun 2026 10:59:41 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD524C77D3;
	Fri,  5 Jun 2026 10:59:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780657181; cv=none; b=tQqfxFFDMp6tk4umGa5uszX/lgkt7dXydm/+oeQUd5rgYpnn+AgdzvWg7aQYCOHF4jCkrBEgwTX0D40hUmsWKeZss+1b44+nc7OJ265aYyNOwcUl9A6iFDftldn7FoJQ5vWUTAj+Ut3zFJEqR+Cxu2fDrrVFr+ELFmIvTGxWVOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780657181; c=relaxed/simple;
	bh=PXb5JSuwGumLdCnZZP8fzBzDnTLRIq2SGiNizRd03YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSc/3NV/jSq8Ctu0MV097Jl20RsT+W7lKvgQ3Yqpn5DQAbkN89ZMNi6EffTXro2EIIkLuJx0sZmH640cVKnjJVh4D8N9PxT0DAKOOC5rkoGHC33b4KRF2gQwugWwjzrkHZCTUoVD61IHXvewBYABt1LKXBNCn9IYum6JERLG8Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=nQidnNEl; arc=none smtp.client-ip=180.181.231.80
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:cc:to:subject:message-id:date:
	from:content-type:reply-to; bh=XcDjXzBgSOCqOqLOATz57mfoHuQf9L1/ma18NCcbBRg=; 
	b=nQidnNEldXLWW62lg8p9JNr6WIQvRLJ0UfJ13lPKQ8TrSLw+Wkbdmq3i4ncafCY9VlV+NXr4yex
	/pLYAwZgA0PgLoOQ/lAsNuOTa3P6av7f4YhxQrfv+BtvQFWEh366kNi6IgAZ2zVC94KlcE2drCELU
	R9YUlgo4vISsd5Xpoi+kt+HrwOFsvkb010bm6h4MeMab9/B3wrsbWKJduJkBNJakn1ZHJSMwsfulb
	wFwG9X5VsZsQ0b1CkWyTjsgk3itYW/NUKna+BW5Ci5MzvYQ3Q5fNimFMLd8+G/BVc4HKhZV3vFU4r
	KR2vw5Bqn9T4W2kkMpCGwIPOYgfPyM4ejrsA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1wVSGy-002o4x-20;
	Fri, 05 Jun 2026 18:59:33 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Jun 2026 18:59:32 +0800
Date: Fri, 5 Jun 2026 18:59:32 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: T Pratham <t-pratham@ti.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Manorit Chawdhry <m-chawdhry@ti.com>,
	Kamlesh Gurudasani <kamlesh@ti.com>,
	Shiva Tripathi <s-tripathi1@ti.com>,
	Kavitha Malarvizhi <k-malarvizhi@ti.com>,
	Vishal Mahaveer <vishalm@ti.com>,
	Praneeth Bajjuri <praneeth@ti.com>, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH v4 1/3] crypto: ti - Add support for SHA224/256/384/512
 in DTHEv2 driver
Message-ID: <aiKsFNoXryzWul0y@gondor.apana.org.au>
References: <20260526094355.555712-1-t-pratham@ti.com>
 <20260526094355.555712-2-t-pratham@ti.com>
 <aiKgs8ipDLPlz6c4@gondor.apana.org.au>
 <e0aec964-3303-4ca2-8d96-6a5d8f5ec9e5@ti.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0aec964-3303-4ca2-8d96-6a5d8f5ec9e5@ti.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[apana.org.au,quarantine];
	R_DKIM_ALLOW(-0.20)[gondor.apana.org.au:s=h01];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24918-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:t-pratham@ti.com,m:davem@davemloft.net,m:m-chawdhry@ti.com,m:kamlesh@ti.com,m:s-tripathi1@ti.com,m:k-malarvizhi@ti.com,m:vishalm@ti.com,m:praneeth@ti.com,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gondor.apana.org.au:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,gondor.apana.org.au:mid,gondor.apana.org.au:from_mime,gondor.apana.org.au:dkim,vger.kernel.org:from_smtp,apana.org.au:url,apana.org.au:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 361706479DC

On Fri, Jun 05, 2026 at 04:11:49PM +0530, T Pratham wrote:
>
> .cra_flags sets CRYPTO_AHASH_ALG_BLOCK_ONLY and
> CRYPTO_AHASH_ALG_FINAL_NONZERO flags. An update of 64 bytes will do an
> update of block size and carry over at least one byte to final. We
> always go into this if block when there is non-zero data coming into update.

For AHASH_BLOCK_ONLY algorithms, the export format must be identical
between different implementations.

Therefore FINAL_NONZERO cannot be used for only one implementation
since the user can import the partial state from a different
implementation which does not have FINAL_NONZERO set.

For sha you cannot use FINAL_NONZERO since the generic implementation
doesn't use it.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

