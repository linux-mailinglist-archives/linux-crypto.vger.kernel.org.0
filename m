Return-Path: <linux-crypto+bounces-345-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 837F37FB0F4
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Nov 2023 05:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E290281BD6
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Nov 2023 04:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB5410A0A
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Nov 2023 04:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Szevbdpq"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626E9883E
	for <linux-crypto@vger.kernel.org>; Tue, 28 Nov 2023 03:58:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 808A6C433C9;
	Tue, 28 Nov 2023 03:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701143896;
	bh=klY2qd5BBTUFI2nKApEyF/o8Si9A4Wtb/ZgzMzwBObU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SzevbdpqhmhpmwTwMiKkHq1bskohNUwuQfXQeOf7Ch/TVNVhZeVRK1CT1GjSQOmoF
	 C6bhekI0ZJVb1FVTvBskim8XI7ZODFyyf8iuS9eeCnyBMmkcu6VE3HnRAoAE2TH7UZ
	 KI7oVZ+kXnp8gby6MaWucK8q7ZgmwCim2keIlGrl1Dsknz9XJTTDbEJ7gWc/puMijd
	 9q4ekHg9SVrHHlIiSPuty/WEaZ94iY0t6L7lU3fe+8Bfkn6FnNxVFpZKnpXnbDh2Q/
	 4W0BjIlI4QU7x0Mt+wRtDzeFPZ8ka7d7mEsacC6BpgevdejvAbOXC9Kheb/q5UpD2O
	 LQi7JQFnaXHAw==
Date: Mon, 27 Nov 2023 19:58:14 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Jerry Shih <jerry.shih@sifive.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	conor.dooley@microchip.com, ardb@kernel.org, heiko@sntech.de,
	phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 05/13] crypto: simd - Update `walksize` in simd
 skcipher
Message-ID: <20231128035814.GH1463@sol.localdomain>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-6-jerry.shih@sifive.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127070703.1697-6-jerry.shih@sifive.com>

On Mon, Nov 27, 2023 at 03:06:55PM +0800, Jerry Shih wrote:
> The `walksize` assignment is missed in simd skcipher.
> 
> Signed-off-by: Jerry Shih <jerry.shih@sifive.com>
> ---
>  crypto/cryptd.c | 1 +
>  crypto/simd.c   | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/crypto/cryptd.c b/crypto/cryptd.c
> index bbcc368b6a55..253d13504ccb 100644
> --- a/crypto/cryptd.c
> +++ b/crypto/cryptd.c
> @@ -405,6 +405,7 @@ static int cryptd_create_skcipher(struct crypto_template *tmpl,
>  		(alg->base.cra_flags & CRYPTO_ALG_INTERNAL);
>  	inst->alg.ivsize = crypto_skcipher_alg_ivsize(alg);
>  	inst->alg.chunksize = crypto_skcipher_alg_chunksize(alg);
> +	inst->alg.walksize = crypto_skcipher_alg_walksize(alg);
>  	inst->alg.min_keysize = crypto_skcipher_alg_min_keysize(alg);
>  	inst->alg.max_keysize = crypto_skcipher_alg_max_keysize(alg);
>  
> diff --git a/crypto/simd.c b/crypto/simd.c
> index edaa479a1ec5..ea0caabf90f1 100644
> --- a/crypto/simd.c
> +++ b/crypto/simd.c
> @@ -181,6 +181,7 @@ struct simd_skcipher_alg *simd_skcipher_create_compat(const char *algname,
>  
>  	alg->ivsize = ialg->ivsize;
>  	alg->chunksize = ialg->chunksize;
> +	alg->walksize = ialg->walksize;
>  	alg->min_keysize = ialg->min_keysize;
>  	alg->max_keysize = ialg->max_keysize;

What are the consequences of this bug?  I wonder if it actually matters?  The
"inner" algorithm is the one that actually gets used for the "walk", right?

- Eric

