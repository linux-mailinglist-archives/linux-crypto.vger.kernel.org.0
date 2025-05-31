Return-Path: <linux-crypto+bounces-13552-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA54FAC9C2F
	for <lists+linux-crypto@lfdr.de>; Sat, 31 May 2025 20:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD0A33B6227
	for <lists+linux-crypto@lfdr.de>; Sat, 31 May 2025 18:08:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B87E7DA6D;
	Sat, 31 May 2025 18:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uDjIaGTl"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C907928371;
	Sat, 31 May 2025 18:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748714925; cv=none; b=SgaBSkj6pUD7f3UFBUPyEU9vpNkNcJ/KeOa9vVU2A+EMgnI1YWVMIThVJIxRdMrGcigZeRgFodWIeTrzo62juSeOyTdkmYwWBX287QigyATYr0G1D+tjXerEtBLxZF7Qvs3oIVTsqgMDvkjr0yLbazT417uTA+bl/jzihYKAZ1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748714925; c=relaxed/simple;
	bh=X+Md5IzRRo0ZXMh/hz3sUlwNFPlQ9YC8sd7qODiBw20=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gfu5HJK8YQb8YorOv/3qROMWNChcanTlibuftS5cIPRQaQry3F9wUyDC4Ykg4AyHofg0ZgHnxPndrwPFy7NUriN3dcHUCPOLNCRYh56JIs8cGhSKufqRXJlAB07zrHTi75mhsOJR6ss+ULxaaG/Ke4TQ9YxYq6t3qoCJby24iwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uDjIaGTl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1583EC4CEE3;
	Sat, 31 May 2025 18:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748714925;
	bh=X+Md5IzRRo0ZXMh/hz3sUlwNFPlQ9YC8sd7qODiBw20=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uDjIaGTlYE7bPSZQL+5IaB/XE5QnHBheqotizP1HCLyaHktZXx0llqjeYbrWfNtOO
	 FxQxTdapKznG5X1oKyj5vpy1PFRa6COELDoMPljNYH46rfHnCu1bsqnYCRhvIJvFSF
	 eYx2yxxysO0YFQW+cDdzGCivvWyGrk5jQjKPUhsnIAOCGakgeSfVLPvwUOIhYmSbgL
	 mMwo1pAYAM8QXFMgo2O7V/VFtFXtuYvQe0bi4Gxs6dhkZPrLXWL1WrUnivL0PfNOjT
	 kN8uhtACbV247wNmzCqMlLircvEXH+N88mcA8xz7NhW8d7ZJ1qtIZsp12XbGsdfNt6
	 iupU2z6XeSwGg==
Date: Sat, 31 May 2025 11:08:43 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	ardb@kernel.org
Subject: Re: [PATCH] crypto/crc32: register only one shash_alg
Message-ID: <20250531180843.GA5482@quark>
References: <20250530160940.12761-1-ebiggers@kernel.org>
 <aDqrMb7U18DcMSRl@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aDqrMb7U18DcMSRl@gondor.apana.org.au>

On Sat, May 31, 2025 at 03:09:37PM +0800, Herbert Xu wrote:
> Eric Biggers <ebiggers@kernel.org> wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Stop unnecessarily registering a "crc32-generic" shash_alg when a
> > "crc32-$(ARCH)" shash_alg is registered too.
> > 
> > While every algorithm does need to have a generic implementation to
> > ensure uniformity of support across platforms, that doesn't mean that we
> > need to make the generic implementation available through crypto_shash
> > when an optimized implementation is also available.
> > 
> > Registering the generic shash_alg did allow users of the crypto_shash or
> > crypto_ahash APIs to request the generic implementation specifically,
> > instead of an optimized one.  However, the only known use case for that
> > was the differential fuzz tests in crypto/testmgr.c.  Equivalent test
> > coverage is now provided by crc_kunit.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> > 
> > I'm planning to take this through the crc tree.
> > 
> > crypto/crc32.c | 69 ++++++++------------------------------------------
> > 1 file changed, 11 insertions(+), 58 deletions(-)
> 
> Please don't do this without first removing all drivers providing
> "crc32" as otherwise their test coverge will be reduced.
> 
> Cheers,

Yes, I'll do that.  It's time to do that anyway.

For other algorithms like sha256 where it's unlikely that all the drivers can be
removed, testmgr.c should just compare against the library implementation, not
the "generic" implementation specifically.

Ideally we'll just stop pretending that cra_driver_name actually matters, and
just name the software algorithms *-lib or *-software.

- Eric

