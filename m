Return-Path: <linux-crypto+bounces-25227-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id enqdGffAMmp45AUAu9opvQ
	(envelope-from <linux-crypto+bounces-25227-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jun 2026 17:44:55 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C4E69B1A5
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jun 2026 17:44:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VSgEFcI1;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25227-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25227-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEDF43025C34
	for <lists+linux-crypto@lfdr.de>; Wed, 17 Jun 2026 15:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8562930F927;
	Wed, 17 Jun 2026 15:44:51 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5976546AED1;
	Wed, 17 Jun 2026 15:44:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781711090; cv=none; b=oRR/kqxODh/dgwkzreooWTTOoBdZZDEWeUmi3MWShH4BxL0/fZyUbRUbG9TvNGEcsJcQtTBfoIQY/sUm7CMnQSBR9QX6LrFh8tPByjeJ+9moUwXnyW+iVS+XlliJS7x99CXw/NBYXO5/v43iOoL3n3hxFePd2uJ58o8XV81V1zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781711090; c=relaxed/simple;
	bh=4S0UWPILAMGBGqSK/AkKKQaNp7Bo0uXLfUCf3cxeIAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XLK6Wm+i2zhHpssr43XSt+YAKoMk1GFrAYX+7mcCZ1H/z+9AbkRhkpqHdWsz8hg8Dr+yfjpPn56pyOcLmv9o4OhyM8rRbRKvRFPaqFU5juCoW5nKe41bnA9szwqjINHFkhOttlUhTfQyPVF0r2mT5LueWhVnyPtg3DiXiCD28vQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VSgEFcI1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D84781F000E9;
	Wed, 17 Jun 2026 15:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781711079;
	bh=56zkV2FI32PUgFPNHl6CKzoaFkHSn8AYn0QleL/MYuk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VSgEFcI13vlc7f4sZAWTYxN89E7PivuQSSPrm/CnhFwsEVty4hRp2/NN/O01UhaXM
	 cAEjmJtQkcXgnTZ+b1IXsy9vQ+x1ty3+H3+nLsb6NzAlAAcz7lbi7GCMtKYd+eMtv3
	 JT5iHR+SSfeavTD4PzUY/IAQHcPmDDJmobtxTH1XoWFtqtFuYJ6BvVAdQcGDOXle5E
	 mbnheOXJYo9OG4U5urw4zlKgs8Q6AQ1PaqGCEXHMYO7Km0Mbj6UpJdwjiIL09KTQt5
	 ITeJazwzWIndPjaiy9HKoP7raUbFUxpO1L6vvkcd4N0Mrv4EBs3issdFwT6F8s1EPa
	 0g6ODPtshln6A==
Date: Wed, 17 Jun 2026 15:44:37 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org, x86@kernel.org,
	David Laight <david.laight.linux@gmail.com>,
	linux-raid@vger.kernel.org
Subject: Re: [PATCH v3] lib/raid/xor: x86: Add AVX-512 optimized xor_gen()
Message-ID: <20260617154437.GA785086@google.com>
References: <20260615190338.26581-1-ebiggers@kernel.org>
 <20260617055653.GB19218@lst.de>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260617055653.GB19218@lst.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-25227-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[linux-foundation.org,vger.kernel.org,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hch@lst.de,m:akpm@linux-foundation.org,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,m:x86@kernel.org,m:david.laight.linux@gmail.com,m:linux-raid@vger.kernel.org,m:davidlaightlinux@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D4C4E69B1A5

On Wed, Jun 17, 2026 at 07:56:53AM +0200, Christoph Hellwig wrote:
> Can use the xor: prefix used for all other commits to lib/raid/xor?
> 
> > Benchmark on AMD Ryzen 9 9950X (Zen 5):
> > 
> >     src_cnt    avx          avx512       Improvement
> >     =======    ==========   ==========   ===========
> >     1          56353 MB/s   75388 MB/s   33%
> >     2          54274 MB/s   68409 MB/s   26%
> >     3          44649 MB/s   64042 MB/s   43%
> >     4          41315 MB/s   55002 MB/s   33%
> 
> On my Zen 5 mobile (AMD Ryzen AI 7 PRO 350) both the existing
> AVX2 and this AVX512 code give numbers in the 200+ GB/s range.  Not
> sure if is just the different benchmarking or something else going on.

I used lib/raid/xor/xor-core.c which measures the throughput of parity
data generated, whereas your proposed xor_benchmark() in xor_kunit
measures the throughput of source data consumed.  I don't know which
makes more sense, but we should make them consistent with each other.

> FYI, one or 2 sources are basically useless as they RAID5 configs
> that have no benefits over simple mirroring and thus the numbers
> aren't too interesting.
> 
> > +DO_XOR_BLOCKS(avx512_inner, xor_avx512_2, xor_avx512_3, xor_avx512_4,
> > +	      xor_avx512_5);
> 
> Is there really much of a benefit of doing the historic DO_XOR_BLOCKS
> vs doing the loop manually?  Especially as the common cases for a
> modern RAID will usually loop over more disks than this was built
> for.  I.e., in practice one or two source buffers only happen at the
> end of a loop over more disks.

There's not really a way out of unrolling by source buffer count, as
otherwise the pointers would continuously have to be reloaded into
registers.  That's why your proposal was so slow (see the numbers I gave
in https://lore.kernel.org/linux-crypto/20260612055933.GA6675@sol/ ).
It could be something different from 2-5 specifically, or open-coded
instead of using the macro if that's all you're asking for, but at a
high level the unrolling by source buffer count does seem to be needed.

- Eric

