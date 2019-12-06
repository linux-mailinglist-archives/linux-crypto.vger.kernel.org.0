Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B81F31158DF
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Dec 2019 22:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfLFV6X (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 6 Dec 2019 16:58:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726352AbfLFV6X (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 6 Dec 2019 16:58:23 -0500
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0235720867;
        Fri,  6 Dec 2019 21:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575669503;
        bh=tO/nM3pzqGeEqs3oiYVmlND2qsA5/58Aimpsk/HOdN4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q4nbTS9LvuHoBAzasKgN4zp7qnFT1CqlwmSCzle3Wk6w4xRFzgJPTZENeSSPeXvWd
         Ydj0O6xcI6TWB60tn15GBobG9tvcWT0mxUymaCbtLpBrC9Wl2ixRAh3F/JUpyGqDDp
         jW8MsK60RB4WICIb8UwIk2z9LOR7HlrejtnphiyY=
Date:   Fri, 6 Dec 2019 13:58:21 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 3/3] crypto: hmac - Use init_tfm/exit_tfm interface
Message-ID: <20191206215821.GC246840@gmail.com>
References: <20191206023527.k4kxngcsb7rpq2rz@gondor.apana.org.au>
 <E1id3Th-00078C-7M@gondobar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1id3Th-00078C-7M@gondobar>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Dec 06, 2019 at 10:36:21AM +0800, Herbert Xu wrote:
> diff --git a/include/crypto/internal/hash.h b/include/crypto/internal/hash.h
> index bfc9db7b100d..7bf4181c7abb 100644
> --- a/include/crypto/internal/hash.h
> +++ b/include/crypto/internal/hash.h
> @@ -214,6 +214,12 @@ static inline struct shash_instance *shash_instance(
>  			    struct shash_instance, alg);
>  }
>  
> +static inline struct shash_instance *shash_alg_instance(	
> +	struct crypto_shash *shash)
> +{
> +	return shash_instance(crypto_tfm_alg_instance(&shash->base));
> +}
> +
>  static inline void *shash_instance_ctx(struct shash_instance *inst)
>  {
>  	return crypto_instance_ctx(shash_crypto_instance(inst));

Please run checkpatch:

ERROR: trailing whitespace
#86: FILE: include/crypto/internal/hash.h:223:
+static inline struct shash_instance *shash_alg_instance(^I$

- Eric
