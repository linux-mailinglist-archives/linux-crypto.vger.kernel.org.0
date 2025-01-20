Return-Path: <linux-crypto+bounces-9151-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AF7A1730C
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Jan 2025 20:12:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E451888872
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Jan 2025 19:13:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78E71EE7BB;
	Mon, 20 Jan 2025 19:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDPEHSdu"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D1C8479;
	Mon, 20 Jan 2025 19:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737400373; cv=none; b=THRp4TMOZJ2Xi7WaWvA2Y3b9ojFT+Oh/g7WAk8Cjbe6MiS1jEAtZGPb7v3nDHcQMLjrBJAH4x7/ogmxdWQHvbUnLwcrGWSSP40pTXLPn/5TWAtUQRmFuIvwCZ+pmwZjGxx06tMipWuh7OTOtstpAzogmREdRST1t+5a1emOysDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737400373; c=relaxed/simple;
	bh=Kh+DQwLKyClDbQ2S17AysOYPnYbZz9VzwkaJnYw2NEw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H2Ay+GiLfcfSP/lvktwp8jLdey1tmJEChlx5IDxVTZFn/o9ahdESK3T4yJz1rGyyfLfIhUikIZXm658WHS5B13sp9NKj+eLL9Fo1bVKCClX6u/9AjZXqKOhMNMU+AYikXij9GDZrb9n3994Mruc8gWE5aqUfoOjOFrCy1515ffA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDPEHSdu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA7EC4CEDD;
	Mon, 20 Jan 2025 19:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737400372;
	bh=Kh+DQwLKyClDbQ2S17AysOYPnYbZz9VzwkaJnYw2NEw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QDPEHSdu3KTXUtaudpyWdDO47omeskF37v7TUI3r61654dgTZREwK5kkE3QiQ1wtv
	 Xv++u0RBs1QM7StarZtKfbgVEdi+HGtTzjOs3B86lUv81kgICkMryEZ7bW4oeiLz3R
	 TJexhwlQegF74MwXknPzfnlq10JGTVm6bNkL2yeoKju4cNE/RGTn2nGoli2m5DoLK0
	 Kv9CTAkFhJWwp7vAiqtyujSwZx/D3CmbSRI+Ux0MDJ+tOMalmKThSa7LK/TSHkIN91
	 yvwRoSL8HYMQRSwHvT3yQ2++GMkRBFF+uVpLikXETdCSVr8GRfrsXzcVTp1QcTHZFg
	 gWKPADSacovBw==
Date: Mon, 20 Jan 2025 11:12:50 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	"David S. Miller" <davem@davemloft.net>,
	Marc Dionne <marc.dionne@auristor.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
	linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 03/24] crypto: Add 'krb5enc' hash and cipher AEAD
 algorithm
Message-ID: <20250120191250.GA39025@sol.localdomain>
References: <20250120173937.GA2268@sol.localdomain>
 <20250120135754.GX6206@kernel.org>
 <20250117183538.881618-1-dhowells@redhat.com>
 <20250117183538.881618-4-dhowells@redhat.com>
 <1201143.1737383111@warthog.procyon.org.uk>
 <1212970.1737399580@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1212970.1737399580@warthog.procyon.org.uk>

On Mon, Jan 20, 2025 at 06:59:40PM +0000, David Howells wrote:
> Eric Biggers <ebiggers@kernel.org> wrote:
> 
> > Multiple requests in parallel, I think you mean?  No, it doesn't, but it
> > should.
> 
> Not so much.  This bug is on the asynchronous path and not tested by my
> rxrpc/rxgk code which only exercises the synchronous path.  I haven't tried to
> make that asynchronous yet.  I presume testmgr also only tests the sync path.
> 
> David
> 

I'm not sure I understand your question.  Users of the crypto API can exclude
asynchronous algorithms when selecting one, but the self-tests do not do that.

In any case, why would you need anything to do asynchronous at all here?

- Eric

