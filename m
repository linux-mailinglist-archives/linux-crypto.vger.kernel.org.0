Return-Path: <linux-crypto+bounces-11327-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC1FAA7934F
	for <lists+linux-crypto@lfdr.de>; Wed,  2 Apr 2025 18:37:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9678816894C
	for <lists+linux-crypto@lfdr.de>; Wed,  2 Apr 2025 16:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09EA419CC31;
	Wed,  2 Apr 2025 16:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jslPh3jj"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A40199FC9
	for <linux-crypto@vger.kernel.org>; Wed,  2 Apr 2025 16:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743611651; cv=none; b=pBrNAiKhsCJdonqdfALmAQ3NHXa3LkZgqnj4l0B5ainDvDThEq0p41DxULQLVu6knk4qxB9c6pqgLIr8dry9e9MgIKfOtFc0BzP5SyjkfpOaJPHYpFlY25x9/o0qtVjKJP5caoyblbQ8QKhYvHmaXAAVjLleA9TO1q4J5Z5GYKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743611651; c=relaxed/simple;
	bh=pPx3LZdR2OtL3rUaftLBV2+csTwjO27dhe8FV4+OB7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LISAMwGSAkZWea92IoMDWlggDBUJGYx+4K8FkwH1WvBfYF85k/MTgiTh6rwnS31eT4oVueS1riDPmG9TOQfkDgwIW969DUeD8gTMacdTXlTcxUCDuDG6cY0/AwLJbNPJIpA5ptRucmzthJ09yCyX2oqhQhR1ndLkxh6aYsY2kgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jslPh3jj; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 2 Apr 2025 12:33:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1743611637;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FyToY08AKANnt6USgoODFI0s6amZeeoly5G60f+SEqU=;
	b=jslPh3jjG9r+MrvJg8kPnGS6lg8vDVcAVbycrytymprDc4UDYlRpuKAPMemwK9puHh5cOc
	enzySaZ+Pqu+CACSuX8Dzap2ChIMqNSyqghSf9GL6l1eHxjgaZX4fBd9jgWvvQSNr3yDyN
	kAJoXfJZEiT2XS1ptPmZi7EQM3xbrQE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-crypto@vger.kernel.org, "Jason A . Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH] bcachefs: use library APIs for ChaCha20 and Poly1305
Message-ID: <264qspa55jt3rzkpfx6g2zx7dpcihsqolkui2ljr5zukpyr6xp@4eds66ahp543>
References: <20250402043333.352723-1-ebiggers@kernel.org>
 <icwysnfc3v7b2hpwvm6ay6567sb5zcmcctmlt44cag6gblaylv@ubrzwcmphci2>
 <20250402162847.GA1235@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250402162847.GA1235@sol.localdomain>
X-Migadu-Flow: FLOW_OUT

On Wed, Apr 02, 2025 at 09:28:47AM -0700, Eric Biggers wrote:
> On Wed, Apr 02, 2025 at 10:01:07AM -0400, Kent Overstreet wrote:
> > On Tue, Apr 01, 2025 at 09:33:33PM -0700, Eric Biggers wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > Just use the ChaCha20 and Poly1305 libraries instead of the clunky
> > > crypto API.  This is much simpler.  It is also slightly faster, since
> > > the libraries provide more direct access to the same
> > > architecture-optimized ChaCha20 and Poly1305 code.
> > > 
> > > I've tested that existing encrypted bcachefs filesystems can be continue
> > > to be accessed with this patch applied.
> > > 
> > > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > 
> > Fantastic!
> > 
> > Applied, and this should go into 6.15 - this should get the strange bugs
> > in the poly1305 path that I wasn't able to reproduce off the dashboard
> > (and if they're still there, they'll be much easier to debug.)
> 
> Thanks!
> 
> If you're referring to
> https://lore.kernel.org/r/CAHOo4gLWAbArwg+w+AqqkxGmOFX6cm8Tvy85tb4igN6V7Z9BZQ@mail.gmail.com/,
> I think bcachefs passed invalid memory to Poly1305 as a result of mounting a
> fuzzed filesystem image.  So it should be unaffected by this patch.

Well, in that case your patch should still get us a backtrace that I can
actually debug :)

