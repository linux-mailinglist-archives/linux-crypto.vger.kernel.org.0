Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510E821DEA9
	for <lists+linux-crypto@lfdr.de>; Mon, 13 Jul 2020 19:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729681AbgGMRZN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 13 Jul 2020 13:25:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:51816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729644AbgGMRZN (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 13 Jul 2020 13:25:13 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA1352075D;
        Mon, 13 Jul 2020 17:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594661112;
        bh=fxE/tXDpCqHH9v2q1GbJzkhgSDT04hYmYP1D+EePAUk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SjDitS/c5nDNUcgyo2i4wXsCuTSiYAV7O2UkOV3aFo4k4R9U23IK7IYICW3yo0Z7c
         JhF8BHp119lnogzTDjqGlx2tyf/I8gqyIo2bf9PdxV3lHB1zQfupwdwWcGleOv2IIG
         8HNbU6+lAN0RVeeFKOOq7Q9ouhN2LAzlYTv8VpCU=
Date:   Mon, 13 Jul 2020 10:25:11 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Elena Petrova <lenaptr@google.com>
Cc:     linux-crypto@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 1/1] crypto: af_alg - add extra parameters for DRBG
 interface
Message-ID: <20200713172511.GB722906@gmail.com>
References: <20200713164857.1031117-1-lenaptr@google.com>
 <20200713164857.1031117-2-lenaptr@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713164857.1031117-2-lenaptr@google.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jul 13, 2020 at 05:48:57PM +0100, Elena Petrova wrote:
> +static int rng_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
> +{
> +	int err;
> +	struct alg_sock *ask = alg_sk(sock->sk);
> +	struct rng_ctx *ctx = ask->private;
> +
> +	reset_addtl(ctx);
> +	ctx->addtl = kzalloc(len, GFP_KERNEL);
> +	if (!ctx->addtl)
> +		return -ENOMEM;
> +
> +	err = memcpy_from_msg(ctx->addtl, msg, len);
> +	if (err) {
> +		reset_addtl(ctx);
> +		return err;
> +	}
> +	ctx->addtl_len = len;
> +
> +	return 0;
> +}

This is also missing any sort of locking, both between concurrent calls to
rng_sendmsg(), and between rng_sendmsg() and rng_recvmsg().

lock_sock() would solve the former.  I'm not sure what should be done about
rng_recvmsg().  It apparently relies on the crypto_rng doing its own locking,
but maybe it should just use lock_sock() too.

- Eric
