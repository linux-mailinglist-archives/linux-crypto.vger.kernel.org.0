Return-Path: <linux-crypto+bounces-2997-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CCB988FD7E
	for <lists+linux-crypto@lfdr.de>; Thu, 28 Mar 2024 11:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBE6D29461C
	for <lists+linux-crypto@lfdr.de>; Thu, 28 Mar 2024 10:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310FC7D401;
	Thu, 28 Mar 2024 10:54:32 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1005F7D3FE;
	Thu, 28 Mar 2024 10:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711623272; cv=none; b=iOV16phPJj45uuXtCN9n91MGj1wQn601zOUkEMMmHtSBm8zLkLEDKGC5UFhC8jlHsmG95fhUVW4RHUIhTp6mjV/0dsJmXp1ggIhBsYbG1VJwdBcSdQmTvd4h1PuckpZxzUTokkIexnj2PhnAHnIDUpaIPz7Rho1OAZ7GxfTRRho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711623272; c=relaxed/simple;
	bh=1A5NhaFUjRv630GlR9c5XuqxIXVhAKEHTJdJwUYat0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kMz/R34aEESlhigjSFCeQzl4h0g9L2jvq4e3CeItLFGrMmcbtLSwSCmLSvsXe0ldOfz2fclhPvVO75amCLP1rN5xriKJlHR6pZhQpx2kcs0eOCFqrzbbOsnx6WWq6ACec9yUR6+k2gmz9NwYSR7RwcjSzOdZ0UqJ8uLWfDG0dHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
	id 1rpnOf-00C8PU-8E; Thu, 28 Mar 2024 18:54:14 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 Mar 2024 18:54:29 +0800
Date: Thu, 28 Mar 2024 18:54:29 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Olivia Mackall <olivia@selenic.com>,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH] hwrng: core: Convert sprintf/snprintf to sysfs_emit
Message-ID: <ZgVMZVUcu+05U9Av@gondor.apana.org.au>
References: <20240314084559.1321951-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314084559.1321951-1-lizhijian@fujitsu.com>

On Thu, Mar 14, 2024 at 04:45:59PM +0800, Li Zhijian wrote:
> Per filesystems/sysfs.rst, show() should only use sysfs_emit()
> or sysfs_emit_at() when formatting the value to be returned to user space.
> 
> coccinelle complains that there are still a couple of functions that use
> snprintf(). Convert them to sysfs_emit().
> 
> sprintf() will be converted as weel if they have.
> 
> Generally, this patch is generated by
> make coccicheck M=<path/to/file> MODE=patch \
> COCCI=scripts/coccinelle/api/device_attr_show.cocci
> 
> No functional change intended
> 
> CC: Olivia Mackall <olivia@selenic.com>
> CC: Herbert Xu <herbert@gondor.apana.org.au>
> CC: linux-crypto@vger.kernel.org
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
> This is a part of the work "Fix coccicheck device_attr_show warnings"[1]
> Split them per subsystem so that the maintainer can review it easily
> [1] https://lore.kernel.org/lkml/20240116041129.3937800-1-lizhijian@fujitsu.com/
> ---
>  drivers/char/hw_random/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

