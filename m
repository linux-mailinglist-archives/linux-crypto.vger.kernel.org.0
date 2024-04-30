Return-Path: <linux-crypto+bounces-3945-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4AD8B694E
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Apr 2024 06:07:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9121C217CE
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Apr 2024 04:07:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66977125CC;
	Tue, 30 Apr 2024 04:06:56 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB379101C5;
	Tue, 30 Apr 2024 04:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714450016; cv=none; b=WxjZj/VFqlUv0GXvk/gUQ3nDLIKpcmKfiN8CMvmLocLgHXJGK72jZ9JNjNtOkzYdyHJFVxPERgzopHhutGXdTJ8XWHOPZjjnP46n6Q0bZEHlNaaGZQ/p9xY3QoG8RyTzcgtyN54LNdwP5g+ZN1YvPW1gibS9uM9/IyeeFtTIeqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714450016; c=relaxed/simple;
	bh=E5NxNY4QpwVPWA70BpsvmJLsUnRW+DqxbX/3bLk0K/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fV+zPM9ULiHDHECe1teYc+DSbuvsaf7RsoDMYMFfdt9QTy0XZQFf4jXRgDpvZVrBfJX7KbyEYCX9SH1se9WJxVTYZRIfWOrH486mUnqAjFHKfSG99Ecl4Q4bdyG+OjO3ASN8c6lbnRq/A80as/rEL9uoS+JjgI/fD/MMQXk0E7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1s1elF-008YUO-00;
	Tue, 30 Apr 2024 12:06:34 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 30 Apr 2024 12:06:51 +0800
Date: Tue, 30 Apr 2024 12:06:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Olivia Mackall <olivia@selenic.com>, linux-crypto@vger.kernel.org,
	kernel@pengutronix.de, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] hwrng: mxc-rnga: Drop usage of platform_driver_probe()
Message-ID: <ZjBuW85QpEEaUoyc@gondor.apana.org.au>
References: <20240324103759.228009-2-u.kleine-koenig@pengutronix.de>
 <wu6kc2ctezq476pc3gebgiikml6xvf3ipqawdiiccq4vixdl2r@4qv55vvr4kr5>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <wu6kc2ctezq476pc3gebgiikml6xvf3ipqawdiiccq4vixdl2r@4qv55vvr4kr5>

On Mon, Apr 29, 2024 at 10:16:34PM +0200, Uwe Kleine-K�nig wrote:
>
> Gentle ping?! Who is the one to pick up this patch (or give feedback to
> it)?
> 
> I want to change modpost to emit this type of warning also for W=0
> builds. For that it would be good to have this patch applied first.

It's already in cryptodev as commit

	a9a72140536fe02d98bce72a608ccf3ba9008a71

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

