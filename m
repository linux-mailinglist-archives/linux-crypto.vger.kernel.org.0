Return-Path: <linux-crypto+bounces-25541-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fZerLpyZRmoEZwsAu9opvQ
	(envelope-from <linux-crypto+bounces-25541-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 02 Jul 2026 19:02:20 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 05A736FAE46
	for <lists+linux-crypto@lfdr.de>; Thu, 02 Jul 2026 19:02:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=K6+6tFoU;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25541-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25541-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 991F732296E6
	for <lists+linux-crypto@lfdr.de>; Thu,  2 Jul 2026 16:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BE293A6F04;
	Thu,  2 Jul 2026 16:47:41 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 469703A6B71;
	Thu,  2 Jul 2026 16:47:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783010861; cv=none; b=Su0sMy6JLHUpfF7jish8gTLjkrRTLEUL59qlwAGjJ1Fu96IRlH9bLnnK5fYZJW/8ZTgb02Zlmn5gE5ikpfENMQRozC88wUo3EOVBk6IJ5bOikvX4VbnSHNGuxSs1/VgaHx1GyuPYDHz/xHj3nCADoYnoVW3u9nrWMtdLnrRO3F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783010861; c=relaxed/simple;
	bh=2nppVHCCBnzLgElA1oeSYIoH78jb0KksVNGYbzDEosU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vE67L/hKoW1dpDVuR4kCsG4Io2J5lgHyjnPkT2Id1pGkOIczaF9oHF9I4e608b4GJwPEnuhszQZ5/1o+kX7G+leib41MqovXkjEaveVemki4JWzm73J7zSgWOhjwe+b9+Y3NWGqG/zegD7MByQiIMSZ3MFQPbt7lk4NRn/jd8Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6+6tFoU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05BA1F00A3A;
	Thu,  2 Jul 2026 16:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783010860;
	bh=/tfETPccCkCr5OE+ufJaFZz2wUOvulzcZ2FRJ1gtW2c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=K6+6tFoU925ON+L1jsr/1A3CypG7iRWRMqjgzH+dCBazLbBj7Qutv1e8HDytkTzcH
	 AfexOKxchLvSfXSZS6BJ6mGr2OBr9Md3uGu04ticsKgXHTr7IAMvExIdHzLjlwIeuV
	 n4T8nIbKV4t+vC2kufdHqlq8kyCwxEeFCjL1IylAbVokDKOlyVWPgO/hKiziubKJvU
	 SB1ZQB8DdO0tacRO7FTpyMXKbjTDhwPkmu07Co8FtFGawStt3Sb1ohBVGZJtvqSOVT
	 YwtSMWUhIyJRNfrBWZr4kRE8miRJE6rNqtGrXCgpb2j+SjOBQPAs78iOuz9mM6cVpm
	 ZJ8LnrTZitnUA==
Date: Thu, 2 Jul 2026 09:45:57 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Leonid Ravich <lravich@amazon.com>
Cc: linux-crypto@vger.kernel.org, dm-devel@lists.linux.dev,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	snitzer@kernel.org, mpatocka@redhat.com, axboe@kernel.dk
Subject: Re: [PATCH v5 0/5] crypto: skcipher - multi-data-unit dispatch as a
 template
Message-ID: <20260702164557.GA1768@sol>
References: <20260630083431.2772-1-lravich@amazon.com>
 <20260701071919.GA111652@sol>
 <20260702084534.22846-1-lravich@amazon.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702084534.22846-1-lravich@amazon.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:lravich@amazon.com,m:linux-crypto@vger.kernel.org,m:dm-devel@lists.linux.dev,m:linux-block@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:snitzer@kernel.org,m:mpatocka@redhat.com,m:axboe@kernel.dk,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-25541-lists,linux-crypto=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sol:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 05A736FAE46

On Thu, Jul 02, 2026 at 08:45:34AM +0000, Leonid Ravich wrote:
> On Wed, Jul 01, 2026 at 12:19:19AM -0700, Eric Biggers wrote:
> > No, this didn't address my feedback.  It moved things around but still
> > adds additional overhead for everyone to support an out-of-tree driver,
> > which also hasn't been shown to be any better than just using the CPU.
> 
> Eric, thanks for the fast reply.
> 
> Overhead: for a non-user the only cost is the data_unit_size field plus
> one zeroing store in set_tfm()/ON_STACK; the en/decrypt paths are
> untouched.

Sure, which is still a cost for everyone.

> A dun() user pays one indirect dispatch into the template per
> request plus a scatterwalk step and IV copy per unit -- the same per-DU
> bookkeeping the consumer already open-codes today.

It's not the same at all.  There's now an extra indirect call, more
per-request memory used, additional overhead to create a scatterlist and
then break it up into multiple ones using the fully generalized
scatterlist walker instead of just creating the correct ones in the
first place from the bio_vec, etc.  We need to be simplifying the crypto
APIs, not making them even more complex and adding more overhead.

> On the driver: I agree pushing code optimized for an out-of-tree driver
> is wrong

So don't do it.

> but I don't think that's the case here -- this helps any async
> crypto engine, and there are in-tree async xts(aes) ones dm-crypt is
> eligible to use today: HiSilicon SEC2, TI DTHEv2, Atmel (I don't have any
> to test on).

It helps nothing, as there is no patch and no benchmarks.

> To bound the win, I used cryptd as a pure async carrier and
> moved the per-DU split inside it, then ran dm-crypt + fio: batching cut
> CPU ~30% on 128k I/O (large batch) and had zero impact on 4k -- so the
> saving is dispatch, not crypto.
>
> A real engine that submits a whole
> multi-DU request in one descriptor avoids that per-DU dispatch entirely,
> so it saves at least that.

That is not an equivalent benchmark at all.

> So the question for me is what the bar is: does landing the API and dun()
> template now (with the in-tree consolidation it already buys dm-crypt and
> blk-crypto-fallback), with a throughput demonstration deferred to a real
> async provider, work for you ?

I definitely don't want this for blk-crypto-fallback.
blk-crypto-fallback already only supports CPU-based crypto acceleration.
(As it should, because nothing else is actually worthwhile these days,
other than hardware inline encryption which is separately supported.)
And I'm also planning to switch it from crypto_skcipher to lib/crypto/
to eliminate the remaining API overhead, which will actually accomplish
that, unlike the dun() thing which just makes it worse.

The bar for adding things to the upstream kernel is that it has to
actually be used *and* beneficial in the upstream kernel.

- Eric

