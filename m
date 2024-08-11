Return-Path: <linux-crypto+bounces-5903-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F83894DFDC
	for <lists+linux-crypto@lfdr.de>; Sun, 11 Aug 2024 05:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C857AB21175
	for <lists+linux-crypto@lfdr.de>; Sun, 11 Aug 2024 03:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85D15E56A;
	Sun, 11 Aug 2024 03:41:29 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C7D1113;
	Sun, 11 Aug 2024 03:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723347689; cv=none; b=QZ8uU3HMaPftm12B8sDa9cY9E4OS8AJuao2oeVVJiPHSu7O1pZd81yreKjm3lUmfVZyQzrZYZJGjSB/id/PuYB/9lVKDVHq3mJkmNkEpCR314pZT0mcr+xYdXEzU9CVnhga/BEcpxxuplzp2lRTvgSHZUM2WTJFmvlwwz0sA8y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723347689; c=relaxed/simple;
	bh=9yZoZOD/TAdyLQcf99aJk89tZhrPHiAI7Uwq2zosgGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwEkk+daIiPt30F69i9tEO+yD37HURYSSJBhSWqE+u23gVlVqQ3v9ATyu1SHh0nXTTUOCbbOVs+cwWxMqzkcGafg6EB9i1bMjAWM92V/OvLBYCkxw4Qgtwva6VDlPvek1F8C5+xR5Opu2VbEzziIBP+Y6smdXit5MjqzEkEYXhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1sczJg-003r2S-1V;
	Sun, 11 Aug 2024 11:41:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 11 Aug 2024 11:41:09 +0800
Date: Sun, 11 Aug 2024 11:41:09 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Waiman Long <longman@redhat.com>
Cc: steffen.klassert@secunet.com, daniel.m.jordan@oracle.com,
	akpm@linux-foundation.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] padata: Fix possible divide-by-0 panic in
 padata_mt_helper()
Message-ID: <Zrgy1TDikPSkzaYP@gondor.apana.org.au>
References: <Zrbm--AxRXgfHUek@gondor.apana.org.au>
 <e752f094-adb4-4448-8bc8-e2460330eaec@redhat.com>
 <ZrgXtLI1R5zJ9GFG@gondor.apana.org.au>
 <91d29649-ca88-4f6c-bf1d-19e49c9555df@redhat.com>
 <ZrgsU-1PdxvUVMOW@gondor.apana.org.au>
 <88c188dc-3664-45db-b54a-11feca59d7d2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88c188dc-3664-45db-b54a-11feca59d7d2@redhat.com>

On Sat, Aug 10, 2024 at 11:27:55PM -0400, Waiman Long wrote:
>
> Now I see what you mean. Yes, we can probably change that to a DIV_ROUND_UP
> operation to make sure that chunk_size is at least one unless job->size is
> 0. I still think the current patch is a bit more fail-safe.

The very first thing the function does is check that job->size is
not zero.  So this should be all that is necessary.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

