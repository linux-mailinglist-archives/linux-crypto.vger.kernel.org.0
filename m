Return-Path: <linux-crypto+bounces-4912-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E91CA904F53
	for <lists+linux-crypto@lfdr.de>; Wed, 12 Jun 2024 11:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92BDF1F29022
	for <lists+linux-crypto@lfdr.de>; Wed, 12 Jun 2024 09:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072B416DEC0;
	Wed, 12 Jun 2024 09:31:27 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551B616D9D7;
	Wed, 12 Jun 2024 09:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718184686; cv=none; b=WyQNeAtSwXghvqJAZwXPNjhp/CsliyAc3mEVm5bN6ErGq/TeR4ma4eOhiWEHWbslMBR6T3DgXBorVektZn6Ckbv92FVNVbHZNBsoqa91A4JmQGDb9O8rf9fJq+zin9YEe5XbGX7DK6b+9Cnuf2m7NNFOcb/fE19zZJC1TuSSFUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718184686; c=relaxed/simple;
	bh=czj37hS5b9rszt+tPfOCPAknH6MH3W6BEpQDBvEPz2c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BEwyHN4AJl3gmshp6QqcdH1w07iQ9BmJ2Icl30WxUFbzVoxIKHRyzNnPjS3ke4UK8TDfyGWQPlUj18FWb/FGqsjSWCAEKa8rA1a/0FKiIm3BavPdA+/74h6oAIEdEK1SmwuLjaQU4liNRSC6wdZUJaTPtveRkw8OkKC9s5uF/0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sHKK3-008Q3x-05;
	Wed, 12 Jun 2024 17:31:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 12 Jun 2024 17:31:17 +0800
Date: Wed, 12 Jun 2024 17:31:17 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, fsverity@lists.linux.dev,
	dm-devel@lists.linux.dev, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Ard Biesheuvel <ardb@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v5 15/15] dm-verity: improve performance by using
 multibuffer hashing
Message-ID: <Zmlq5Y5MgEAVF42C@gondor.apana.org.au>
References: <20240611034822.36603-1-ebiggers@kernel.org>
 <20240611034822.36603-16-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611034822.36603-16-ebiggers@kernel.org>

On Mon, Jun 10, 2024 at 08:48:22PM -0700, Eric Biggers wrote:
>
> +		if (++io->num_pending == v->mb_max_msgs) {
> +			r = verity_verify_pending_blocks(v, io, bio);
> +			if (unlikely(r))
> +				goto error;
>  		}

What is the overhead if you just let it accumulate as large a
request as possible? We should let the underlying algorithm decide
how to divide this up in the most optimal fashion.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

