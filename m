Return-Path: <linux-crypto+bounces-24911-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id FjIBBzqaImogawEAu9opvQ
	(envelope-from <linux-crypto+bounces-24911-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Fri, 05 Jun 2026 11:43:22 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C49B646F80
	for <lists+linux-crypto@lfdr.de>; Fri, 05 Jun 2026 11:43:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=pitsidianak.is header.s=mailSelector header.b=g0r3FMom;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-24911-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-24911-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=pitsidianak.is;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2729E3177826
	for <lists+linux-crypto@lfdr.de>; Fri,  5 Jun 2026 09:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA5E2D8DBB;
	Fri,  5 Jun 2026 09:20:35 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail.nessuent.net (mail.nessuent.net [188.245.177.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C00F4183D7;
	Fri,  5 Jun 2026 09:20:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780651235; cv=none; b=ChvZIXbPeTDGZ9lwTKnsI5ddlr4ZXIdqhouvSFs1Xf9XOGiXtfiEVfrOPXH5wk38oPY6aJ9ZJ/BEXb+Nno67Q+GGo9n78zuN596vhF/UdlL1hk13huXwwJ2Uj3JJUqRBepMnKzgNGVFaRrGuLv3oaTnxrh/KWk9hFWSTA17bTiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780651235; c=relaxed/simple;
	bh=9ifA15HK6MfpMtDhujwBeF+YxidKcGB3R9NyD3nCEaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=eLuXc4FGlq3HkD7NrTQUVcZLxns+4Tx9K05RAeNqakLBAkHqNpG1AuFwj+uiTJ5HAGPCVsBvPJbZHVLuMbC3d5/GFz+9ESlWRf+UH2acAldAf/h1pHtBfh+ml96W84IDDiEUEltquQZTa4moqsUs8YIUQn1s8LF8VKiAgHlzZ5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pitsidianak.is; spf=pass smtp.mailfrom=pitsidianak.is; dkim=pass (4096-bit key) header.d=pitsidianak.is header.i=@pitsidianak.is header.b=g0r3FMom; arc=none smtp.client-ip=188.245.177.90
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pitsidianak.is;
	s=mailSelector; t=1780651223;
	bh=9ifA15HK6MfpMtDhujwBeF+YxidKcGB3R9NyD3nCEaI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From:Subject;
	b=g0r3FMomS4w95GPM7zNLzSYGHp0gSiqV0Og3oqVHmU1BMwE2+k64fXQzUm7a7J17a
	 lU9xDNoYpSK2aSqC0wJoFEHG5bD31uV4fKSyC72KKwl1JHcrtBbm8i/fRugZRNs+gO
	 AfgFpZOjrf5alw+QvX6RX7WtMapdtebhqTVyovM5D8gHx1XutSMjvIAML/+HAMN3Al
	 wlFdEMfkBT7JNuwllcCyiQ/zKq0UDXWwXwDMrbKWgNu1M8W1pUzCruw9Ipxum5WIJF
	 wZisr/W5cavGY3bP924OwZC1KHuHW+pMjVI4K25MYGCbPoExFfioxSm9yXeHmHJ4r3
	 TfsNEaSb4PkvhsRxKPXxHp85D/rxfCR7IlgWdvSV+rGV7JIcyrH+a3JuwS0odMAFyZ
	 PCHXmWiHRUCUve72VvPjJ5Yro+giwxMMcCFUwALg6QXZfvfKi+XHDK+CUlDKOCDP3I
	 JskbFkltTaEzc6rtHCxSTcXkjtYoE2Py5IXHlGxKbJG7qzHDi0v3dliKflMwZzwGrF
	 2iBRzrhNRNq9wayTW6dgIsjqt/inEE+0nCQbILCJBorCt/OuvRs2GDxqePQnjZK7vN
	 xzdEhmEQ7PVbY8oP5MZwdj0KsS/p74LC5K3yei2hF8EXiGV/T+Gtzp1VuAp9TprD21
	 b1OQbJoQ0jJKVTrEatBiHj0E=
Date: Fri, 05 Jun 2026 12:18:29 +0300
From: Manos Pitsidianakis <manos@pitsidianak.is>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Olivia Mackall <olivia@selenic.com>, linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Harald Freudenberger <freude@linux.vnet.ibm.com>, PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Subject: Re: [PATCH] hw_random/core: fix rng list on registration error
User-Agent: meli/0.8.13
References: <20260525-hw_random_registration_rng_list-v1-1-ee1c215d544d@pitsidianak.is> <aiKKIdPQzFdH0m9t@gondor.apana.org.au>
In-Reply-To: <aiKKIdPQzFdH0m9t@gondor.apana.org.au>
Message-ID: <tg5j9x.z6yluqyl72so@pitsidianak.is>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[pitsidianak.is,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[pitsidianak.is:s=mailSelector];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-24911-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:olivia@selenic.com,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:freude@linux.vnet.ibm.com,m:prasannatsmkumar@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[manos@pitsidianak.is,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[selenic.com,vger.kernel.org,linux.vnet.ibm.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manos@pitsidianak.is,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[pitsidianak.is:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[apana.org.au:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,pitsidianak.is:mid,pitsidianak.is:dkim,pitsidianak.is:from_mime,pitsidianak.is:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C49B646F80

Hi Herbert,

On Fri, 05 Jun 2026 11:34, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>On Mon, May 25, 2026 at 10:25:39AM +0300, Manos Pitsidianakis wrote:
>> hwrng_register(rng) does the following:
>> 
>> 1. Checks if rng has name and read methods set
>> 2. Checks if the name already exists
>> 3. Adds rng to global rng_list
>> 4. May try to set rng to current_rng
>> 
>> If step 4 fails, it returns an error. However, it does not remove the
>> rng from rng_list, causing a dangling reference which can result in
>> use-after-free if the caller frees rng, since registration failed.
>> 
>> Add a list_del_init() cleanup step.
>> 
>> Signed-off-by: Manos Pitsidianakis <manos@pitsidianak.is>
>> ---
>>  drivers/char/hw_random/core.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>
>Good catch!
>
>Please add a Fixes header for this:
>
>Fixes: 2bbb6983887f ("hwrng: use rng source with best quality")

Would this patch go through your maintainer tree?

If yes, you could add it along with your r-b directly, otherwise I can 
send a new revision when it gets a review.

Thanks,
Manos

