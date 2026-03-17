Return-Path: <linux-crypto+bounces-22047-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCTBOdNyuWm8EgIAu9opvQ
	(envelope-from <linux-crypto+bounces-22047-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 16:27:15 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 706962AD026
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 16:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4BE463073D9C
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 15:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8C93E9F8F;
	Tue, 17 Mar 2026 15:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xqcwabCE"
X-Original-To: linux-crypto@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DCE3DCD9B;
	Tue, 17 Mar 2026 15:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773760985; cv=none; b=f52DKhKts1xLrn7ySlK4OsH0OJrIvNPGuvcyGADhKdH5j+fbmGjMoSp3NRnh0kb36YoEUL9pqquiCTAVdqyqc+zBg5HO0knsaWR2I65BMeATweRPsT+Sax3Ikmpkp6BSI/YaQMYDDeU2hByN4gI0SehKC4x5DFWH0hPKy/TdOOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773760985; c=relaxed/simple;
	bh=Fy1htI4UODIx2yytutlDuDgTWi+tpbxGjfBCNjXDPiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u70L1WrXrof8crHAXjUejVnCQQ26v6+Zn5eU8qzNIYYHAbW5pnsvl0t620IL8jVOdueFjtGLdR6KNCHNfTH5SfCcgS8OkyNM5Lno4OqkrKWCcGla97D1q6EmEoZ/88p0Hn+V6Rhwny3SxZ+3m/WATtiNvj2WGWzBhsJIlAuRzhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xqcwabCE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hxZfwk4j7fdh1lLHSbjgNk4ZAr0h0feEpqn4ubU4naE=; b=xqcwabCE69yEIxL7BCd8Kp9Ca9
	w/aDIbFY2rENA6SoyzZMufk7C0Q1f8AxmWO6/ho14KS3q+HoEqkIiKiCSbUu/i4gnB4l08quPbxH3
	VA9aUlbGdDsSSkA5vtxWYuP7WAHtHZjGCF/GQwzPvaYRwf/nR+bwN/IaBVdLvVe6PtdhYNLVrB2hG
	9Sfk3IZHT7j7bNEGL15AgTgNEemlEVgczkPFeshusCZIlHcd+urBs7Mm/9jMRyM5mfIIvrOMAWZXG
	40oEm9sAdyIS9NXc+2mWNJNsDcMDwGmOS1yfLnVyDeghJW37cCvmhDXp8vaRMWsiit87dJEPAap1Z
	ZE+w8ibQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2WG7-00000006jSt-0tEp;
	Tue, 17 Mar 2026 15:23:03 +0000
Date: Tue, 17 Mar 2026 08:23:03 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-arm-kernel@lists.infradead.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH] lib/crypto: arm64: Drop checks for
 CONFIG_KERNEL_MODE_NEON
Message-ID: <ablx17_Fw_CzCqSu@infradead.org>
References: <20260314175049.26931-1-ebiggers@kernel.org>
 <38a37b02-602a-42a4-8974-b8a6cd750c3e@app.fastmail.com>
 <ablpCtKCV5goM_AD@infradead.org>
 <ef71c58d-3950-474e-bddb-fc95f8d18b07@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef71c58d-3950-474e-bddb-fc95f8d18b07@app.fastmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=bombadil.20210309];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-22047-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[infradead.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hch@infradead.org,linux-crypto@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:dkim,infradead.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 706962AD026
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 04:08:24PM +0100, Ard Biesheuvel wrote:
> 
> On Tue, 17 Mar 2026, at 15:45, Christoph Hellwig wrote:
> > On Tue, Mar 17, 2026 at 12:09:34PM +0100, Ard Biesheuvel wrote:
> >> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> >> 
> >> Actually, we should just get rid of CONFIG_KERNEL_MODE_NEON entirely on arm64, although there is some code shared with ARM that would still need some checks. But anything that is arm64-only should never look at this at all.
> >
> > I'll also drop it from the XOR series.
> >
> 
> Ack - mind cc'ing me on the next revision?

Sure.

> 
> > Talking about which (sorry for highjacking this thread), arm32 and arm64
> > have completely different neon XOR implementations, where arm32 uses
> > #pragma GCC optimize "tree-vectorize" or clang auto-vectorization of
> > the generic C implementation, and arm64 uses intrinsics.  Is there any
> > chance those could share a single implementation?
> 
> If we're migrating the XOR arch code to live under lib (if that is what
> you are proposing),

That's what is happening right now:

https://lore.kernel.org/linux-raid/20260311115754.ca2206d1428c49c3bd6e93cf@linux-foundation.org/T/#t


