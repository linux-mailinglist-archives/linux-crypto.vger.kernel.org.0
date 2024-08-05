Return-Path: <linux-crypto+bounces-5826-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE149478CA
	for <lists+linux-crypto@lfdr.de>; Mon,  5 Aug 2024 11:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 178A6B22870
	for <lists+linux-crypto@lfdr.de>; Mon,  5 Aug 2024 09:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC3D142E9D;
	Mon,  5 Aug 2024 09:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1L8S+MLQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ANt4COKj"
X-Original-To: linux-crypto@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 771031422CA
	for <linux-crypto@vger.kernel.org>; Mon,  5 Aug 2024 09:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722851784; cv=none; b=dVlLm0yG5WZdvN4+F1bqiZaI8Nqakj27NSHRXSqVIPdcBgQEGMG8SyKg9GTdoifL28u4BBRokPXYqB3XUFQWO87nvjOT6JrB7XdemzYl3ZKz800UaR+//leJOaoWFkX65eCOGWVLFe8e7dlOXDx23h7TB/CleFS8tgjd9bM6IyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722851784; c=relaxed/simple;
	bh=6CQUDd8LJQRQan6HNW41AEY9mHWOQm2dMM9tN4j9NL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qF5MpT9Ig0s++q/U1VqqJ+1mjAzo6Kn1RPUfephZVSOgO5aSCsWvHQfMdiEDRyHyVkFYA3gL05b6gFtq569G0f/sdEicjig7lkio7tteq62Nlg70+/8PiQjWlidr8PUm6T2FLrUHNA13T5I0JCQM0jEHR0WYMNllDPF9HhEm57w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1L8S+MLQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ANt4COKj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 5 Aug 2024 11:56:16 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722851777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gpSIsiiXYGHNuLgueKhua5RzybXnOxk4VP5Tmq8puyk=;
	b=1L8S+MLQLDN57IDYBrKa/zf6as6BXNA7E9uU6VNGgn7OO32k5rXEYteDPDXZ5Ltq2LKsSJ
	3UriWm/PkiCj8kzRo59fsPE4v8F0B/7tyru3oLvMV6eke7fc9VV3K8nM988V6xZbI88jSh
	JYllSNk5peDZxmLrib2azpx/7S+GL37TOV68AgkzUK+jSfehFtEfl8BdrtmboFtxW5npxL
	aH37v4aX8HH0j6H8wmR2ZDsdh5GkrOAeY80ti5WBlJRjWSlnoDerYsAKgLCEzZYmKoOX2Z
	bicmLz7opMHCoD4yPPdyXVQWeYnED0j6GtjnMH32/JVAL7VMO3R8CpbbwTAIOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722851777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gpSIsiiXYGHNuLgueKhua5RzybXnOxk4VP5Tmq8puyk=;
	b=ANt4COKjT+qr0i7so0LXhywzlbFnqh/L3+5M0t2q/xJcWFnvpb9pwPxXEZQORSdATTGH17
	GOm5FYDUjeDgTqAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] crypto: x86/aes-gcm: Disable FPU around
 skcipher_walk_done().
Message-ID: <20240805095616.xM0TxF1n@linutronix.de>
References: <20240802102333.itejxOsJ@linutronix.de>
 <20240802162832.GA1809@sol.localdomain>
 <20240802164904.GB1809@sol.localdomain>
 <ZrCVK91OPHKVNd8a@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZrCVK91OPHKVNd8a@gondor.apana.org.au>

On 2024-08-05 17:02:35 [+0800], Herbert Xu wrote:
> On Fri, Aug 02, 2024 at 09:49:04AM -0700, Eric Biggers wrote:
> >
> > This would work too, I think:
> 
> Yes, and we can go a bit further like this:

Yes,

Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

