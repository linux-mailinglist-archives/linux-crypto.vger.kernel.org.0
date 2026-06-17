Return-Path: <linux-crypto+bounces-25210-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id fRWNNTw3MmqTwwUAu9opvQ
	(envelope-from <linux-crypto+bounces-25210-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jun 2026 07:57:16 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A517696B20
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jun 2026 07:57:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=lst.de (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25210-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25210-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D72E2305A959
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jun 2026 05:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51903B0ACE;
	Wed, 17 Jun 2026 05:56:58 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7786E24E4A1;
	Wed, 17 Jun 2026 05:56:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781675818; cv=none; b=Zv1/AScNK7NbEnVUvYdOYsEZ4dNR96arDIjkyE2n606v14qbAlh5LHXeGMqXv1Eflo58d1p4TjU0JMGsNYVxbk1kkmrsm2VM5JD5v0CBeqzKr9s/tSNkxPu5j8vhLPjJ9exZ5EZkK5QjgpYV0UIU9hNS5Xkl2+Vfe7CCG/N2xCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781675818; c=relaxed/simple;
	bh=AlxlUmcTFzCEcSUgIUeo8Ciqtxn3tGl46YqUMpD6NOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qRWuR1Q9YlgfZFn3AQ8HnbzFzXfM3z74e7COe7EpozTT20pKD6J21wsuDDTu75RZRpVR+5dANlrDHbJB3A05Rp0szvG8RzRDewlf26tIuFd3p8oOqRkAMmbFp6T2yRBpD1H3iAk5KweZ426Jv7H3OHJldpGhrIllFQZvco3fkvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4784E68AFE; Wed, 17 Jun 2026 07:56:54 +0200 (CEST)
Date: Wed, 17 Jun 2026 07:56:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>, linux-crypto@vger.kernel.org,
	x86@kernel.org, David Laight <david.laight.linux@gmail.com>,
	linux-raid@vger.kernel.org
Subject: Re: [PATCH v3] lib/raid/xor: x86: Add AVX-512 optimized xor_gen()
Message-ID: <20260617055653.GB19218@lst.de>
References: <20260615190338.26581-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260615190338.26581-1-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[lst.de : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25210-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ebiggers@kernel.org,m:akpm@linux-foundation.org,m:linux-kernel@vger.kernel.org,m:hch@lst.de,m:linux-crypto@vger.kernel.org,m:x86@kernel.org,m:david.laight.linux@gmail.com,m:linux-raid@vger.kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[hch@lst.de,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,lst.de,kernel.org,gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@lst.de,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lst.de:mid,lst.de:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A517696B20

Can use the xor: prefix used for all other commits to lib/raid/xor?

> Benchmark on AMD Ryzen 9 9950X (Zen 5):
> 
>     src_cnt    avx          avx512       Improvement
>     =======    ==========   ==========   ===========
>     1          56353 MB/s   75388 MB/s   33%
>     2          54274 MB/s   68409 MB/s   26%
>     3          44649 MB/s   64042 MB/s   43%
>     4          41315 MB/s   55002 MB/s   33%

On my Zen 5 mobile (AMD Ryzen AI 7 PRO 350) both the existing
AVX2 and this AVX512 code give numbers in the 200+ GB/s range.  Not
sure if is just the different benchmarking or something else going on.

FYI, one or 2 sources are basically useless as they RAID5 configs
that have no benefits over simple mirroring and thus the numbers
aren't too interesting.

> +DO_XOR_BLOCKS(avx512_inner, xor_avx512_2, xor_avx512_3, xor_avx512_4,
> +	      xor_avx512_5);

Is there really much of a benefit of doing the historic DO_XOR_BLOCKS
vs doing the loop manually?  Especially as the common cases for a
modern RAID will usually loop over more disks than this was built
for.  I.e., in practice one or two source buffers only happen at the
end of a loop over more disks.


