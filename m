Return-Path: <linux-crypto+bounces-1593-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B991F83B472
	for <lists+linux-crypto@lfdr.de>; Wed, 24 Jan 2024 23:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B433B1C20B35
	for <lists+linux-crypto@lfdr.de>; Wed, 24 Jan 2024 22:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ECE1353F5;
	Wed, 24 Jan 2024 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUEx4VCi"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA4E7C091;
	Wed, 24 Jan 2024 22:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706133899; cv=none; b=RUH3Q79SM27ZbV/CBov9qXGFAHltDcPa7w8ogRFOMm31sTlm2zF2v1MHSKh01u/9mPRBzQcKmXQRzrxYYOV3HTRWXZ1d5x/2IJtkdngDuwgY9Md50xwmmfxFUiLk3FZyTO7VIHwafQdU/mArO8YiEX87t0TPYQQW0EoCzU4W500=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706133899; c=relaxed/simple;
	bh=9zUcVp2ujzaeHfxPkzuhcekSZufyO5TtKSBCw+uG7bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/YS8H1SSIJdyBHgPdq8hMI9ARlYEUGRwcogolJzTkhY6fY4wd5ABh3UKGGZlqDs5Pp4jVZiqaFd9nViJx02ZztPcn5Ms+N8swGzt2pOcf/JFYj5BqqJ6yYmlSsajIpsfmpp1yi+3CNK3foxE9Qn93npH+ro50tQH2ZWe7OGGk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUEx4VCi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5378C433C7;
	Wed, 24 Jan 2024 22:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706133899;
	bh=9zUcVp2ujzaeHfxPkzuhcekSZufyO5TtKSBCw+uG7bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NUEx4VCiHh7exFUAlS5vMvV8z1f+EN+LnVMA5BbLiiZ80ldsdWzRxI9LQxNvDLgQd
	 R+HWVb9Y44U1pzmIVkNRp1VBIa2vK8kpuReL1PBeHD33vJ7yjP3ONu/f9y/VZ9TD+Y
	 SM/Vb3x+5+1BRuObUuuGNQXpKKWVjnVpLVGgf1d0YdNnnJ68JzWuVkvXa49+5WEiAR
	 gDEjcYb8Z1fGs0Gs3Vi9y5LfQs5u7CQDaH7Hiw1GjiNNQmDcafW6uaS8L2yb9zLo8n
	 T3R5oOSBOqhTLNUBwQNq66TbzJNwZdEonq5k0TRmwEQbptVr5tOxMHK39Am9swu0ra
	 pDAPzfptHuBlg==
Date: Wed, 24 Jan 2024 14:04:57 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Gaurav Jain <gaurav.jain@nxp.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S . Miller" <davem@davemloft.net>,
	Horia Geanta <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>, Varun Sethi <V.Sethi@nxp.com>,
	Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
	Aisheng Dong <aisheng.dong@nxp.com>,
	Silvano Di Ninno <silvano.dininno@nxp.com>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-imx@nxp.com
Subject: Re: [PATCH v2] crypto: caam: fix asynchronous hash
Message-ID: <20240124220457.GC1088@sol.localdomain>
References: <20240118092557.1891120-1-gaurav.jain@nxp.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240118092557.1891120-1-gaurav.jain@nxp.com>

On Thu, Jan 18, 2024 at 02:55:57PM +0530, Gaurav Jain wrote:
> ahash_alg->setkey is updated to ahash_nosetkey in ahash.c
> so checking setkey() function to determine hmac algorithm is not valid.
> 
> to fix this added is_hmac variable in structure caam_hash_alg to determine
> whether the algorithm is hmac or not.
> 
> Fixes: 2f1f34c1bf7b ("crypto: ahash - optimize performance when wrapping shash")
> Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
> ---
> changes in v2:
> 	- remove if condition based on crypto_hash_alg_has_setkey() funcion.
> 	- added is_hmac variable in caam_hash_alg and updated the if
> 	  condition for checking hmac algorithm.
> 
>  drivers/crypto/caam/caamalg_qi2.c | 7 +++++--
>  drivers/crypto/caam/caamhash.c    | 7 +++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric

