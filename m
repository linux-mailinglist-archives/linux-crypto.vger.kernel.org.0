Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3C92310FE
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Jul 2020 19:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731779AbgG1RgF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 28 Jul 2020 13:36:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:47580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731684AbgG1RgF (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 28 Jul 2020 13:36:05 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7276206D7;
        Tue, 28 Jul 2020 17:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595957764;
        bh=BTOCpojOCLuXUDVPp1v9NRmtj+YIHQG4pJIbRGyKLxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CtaWYfjummTTszmXEMD2OjkkfbQnwnyghknQzVWM39b6nbHQv3Qlw2OLarPJ0AsKk
         K8rtae2o3u0qxc0aC2pZlKQa0KQy8VsWIf3k1vRN7LEbukgphTK85vJjcM4TwRpHi4
         Fte3WgTujMUR6OjnephSwp5Zanl5ufqTda1chlFk=
Date:   Tue, 28 Jul 2020 10:36:03 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Elena Petrova <lenaptr@google.com>
Cc:     linux-crypto@vger.kernel.org,
        Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jeffrey Vander Stoep <jeffv@google.com>
Subject: Re: [PATCH v3] crypto: af_alg - add extra parameters for DRBG
 interface
Message-ID: <20200728173603.GD4053562@gmail.com>
References: <20200722155905.GA789@sol.localdomain>
 <20200728155159.2156480-1-lenaptr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728155159.2156480-1-lenaptr@google.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jul 28, 2020 at 04:51:59PM +0100, Elena Petrova wrote:
> +static int rng_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
> +{
> +	int err;
> +	struct alg_sock *ask = alg_sk(sock->sk);
> +	struct rng_ctx *ctx = ask->private;
> +
> +	lock_sock(sock->sk);
> +	if (len > MAXSIZE)
> +		len = MAXSIZE;
> +
> +	rng_reset_addtl(ctx);
> +	ctx->addtl = kmalloc(len, GFP_KERNEL);
> +	if (!ctx->addtl) {
> +		err = -ENOMEM;
> +		goto unlock;

This error code isn't actually returned.

> +	}
> +
> +	err = memcpy_from_msg(ctx->addtl, msg, len);
> +	if (err) {
> +		rng_reset_addtl(ctx);
> +		goto unlock;

Likewise.

> +#ifdef CONFIG_CRYPTO_USER_API_CAVP_DRBG
> +static int rng_setentropy(void *private, const u8 *entropy, unsigned int len)
> +{
> +	struct rng_parent_ctx *pctx = private;
> +	u8 *kentropy = NULL;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;

This should be EACCES, not EPERM.  EACCES means the operation will succeed if
you acquire the needed privileges.  EPERM means it will never succeed.

> +	if (len > MAXSIZE)
> +		len = MAXSIZE;

Truncating the length is error prone.  Shouldn't this instead return an error
(EMSGSIZE?) if the length is too long, and 0 on success?  Remember this is
setsockopt(), not write().

- Eric
