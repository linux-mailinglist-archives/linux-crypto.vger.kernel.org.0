Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E585F3C40
	for <lists+linux-crypto@lfdr.de>; Tue,  4 Oct 2022 06:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbiJDExH (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 4 Oct 2022 00:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbiJDExG (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 4 Oct 2022 00:53:06 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7FA4506B
        for <linux-crypto@vger.kernel.org>; Mon,  3 Oct 2022 21:53:03 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1ofZvN-00BH3A-Es; Tue, 04 Oct 2022 15:52:58 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 04 Oct 2022 12:52:57 +0800
Date:   Tue, 4 Oct 2022 12:52:57 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Taehee Yoo <ap420073@gmail.com>
Cc:     linux-crypto@vger.kernel.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, ebiggers@google.com
Subject: Re: [PATCH] crypto: x86: Do not acquire fpu context for too long
Message-ID: <Yzu8Kd2botr3eegj@gondor.apana.org.au>
References: <20221004044912.24770-1-ap420073@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004044912.24770-1-ap420073@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Oct 04, 2022 at 04:49:12AM +0000, Taehee Yoo wrote:
>
>  #define ECB_WALK_START(req, bsize, fpu_blocks) do {			\
>  	void *ctx = crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));	\
> +	unsigned int walked_bytes = 0;					\
>  	const int __bsize = (bsize);					\
>  	struct skcipher_walk walk;					\
> -	int err = skcipher_walk_virt(&walk, (req), false);		\
> +	int err;							\
> +									\
> +	err = skcipher_walk_virt(&walk, (req), false);			\
>  	while (walk.nbytes > 0) {					\
> -		unsigned int nbytes = walk.nbytes;			\
> -		bool do_fpu = (fpu_blocks) != -1 &&			\
> -			      nbytes >= (fpu_blocks) * __bsize;		\
>  		const u8 *src = walk.src.virt.addr;			\
> -		u8 *dst = walk.dst.virt.addr;				\
>  		u8 __maybe_unused buf[(bsize)];				\
> -		if (do_fpu) kernel_fpu_begin()
> +		u8 *dst = walk.dst.virt.addr;				\
> +		unsigned int nbytes;					\
> +		bool do_fpu;						\
> +									\
> +		if (walk.nbytes - walked_bytes > ECB_CBC_WALK_MAX) {	\
> +			nbytes = ECB_CBC_WALK_MAX;			\
> +			walked_bytes += ECB_CBC_WALK_MAX;		\
> +		} else {						\
> +			nbytes = walk.nbytes - walked_bytes;		\
> +			walked_bytes = walk.nbytes;			\
> +		}							\
> +									\
> +		do_fpu = (fpu_blocks) != -1 &&				\
> +			 nbytes >= (fpu_blocks) * __bsize;		\
> +		if (do_fpu)						\
> +			kernel_fpu_begin()
>  
>  #define CBC_WALK_START(req, bsize, fpu_blocks)				\
>  	ECB_WALK_START(req, bsize, fpu_blocks)
> @@ -65,8 +81,12 @@
>  } while (0)
>  
>  #define ECB_WALK_END()							\
> -		if (do_fpu) kernel_fpu_end();				\
> +		if (do_fpu)						\
> +			kernel_fpu_end();				\
> +		if (walked_bytes < walk.nbytes)				\
> +			continue;					\
>  		err = skcipher_walk_done(&walk, nbytes);		\
> +		walked_bytes = 0;					\
>  	}								\
>  	return err;							\
>  } while (0)

skcipher_walk_* is supposed to return at most a page.  Why is this
necessary?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
