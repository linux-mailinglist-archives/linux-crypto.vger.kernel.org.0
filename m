Return-Path: <linux-crypto+bounces-346-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 165727FB0F5
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Nov 2023 05:36:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0531C20ABC
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Nov 2023 04:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F85F10A2A
	for <lists+linux-crypto@lfdr.de>; Tue, 28 Nov 2023 04:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czIQF659"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753D6D29A
	for <linux-crypto@vger.kernel.org>; Tue, 28 Nov 2023 04:07:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C2B1C433C7;
	Tue, 28 Nov 2023 04:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701144439;
	bh=V2rKuLTlh3qLJnd3xvBBMHtL+0fSAxw4uf0Z7xUqYvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=czIQF659i35wLPWZtbxx5n6+JFL9eXiHD6OAuVN/mbgn8XW6v+5P5y1PMeIjASfTV
	 s0zyWtW9BM21cQLAN7NClQvzbCaIj7DKkD4eglqDDcLVCC20qxd6ChG2Y89ql8GZae
	 vOPZMUlFJBLIF/q1OKOCxB5VEeIVJPHbNBcEuaTPQWHFPyYsKz075OFX4IUUaUR2GE
	 qqRJftkRLSHhE1xJ33cjoaMlb4t5jnly1PTxyNztXtr63zMtJ81ytmFZMa/UO4z6dw
	 MJKD59fZ98Z6zDcKn3AQKoTOhdJx4Iwa7tqoplMSXlWjsf4dvVd3koEdNWXC9xS5Lb
	 WqnnmqDVzGFLg==
Date: Mon, 27 Nov 2023 20:07:16 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Jerry Shih <jerry.shih@sifive.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	conor.dooley@microchip.com, ardb@kernel.org, heiko@sntech.de,
	phoebe.chen@sifive.com, hongrong.hsu@sifive.com,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 07/13] RISC-V: crypto: add accelerated
 AES-CBC/CTR/ECB/XTS implementations
Message-ID: <20231128040716.GI1463@sol.localdomain>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-8-jerry.shih@sifive.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127070703.1697-8-jerry.shih@sifive.com>

On Mon, Nov 27, 2023 at 03:06:57PM +0800, Jerry Shih wrote:
> +typedef void (*aes_xts_func)(const u8 *in, u8 *out, size_t length,
> +			     const struct crypto_aes_ctx *key, u8 *iv,
> +			     int update_iv);

There's no need for this indirection, because the function pointer can only have
one value.

Note also that when Control Flow Integrity is enabled, assembly functions can
only be called indirectly when they use SYM_TYPED_FUNC_START.  That's another
reason to avoid indirect calls that aren't actually necessary.

> +			nbytes &= (~(AES_BLOCK_SIZE - 1));

Expressions like ~(n - 1) should not have another set of parentheses around them

> +static int xts_crypt(struct skcipher_request *req, aes_xts_func func)
> +{
> +	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> +	const struct riscv64_aes_xts_ctx *ctx = crypto_skcipher_ctx(tfm);
> +	struct skcipher_request sub_req;
> +	struct scatterlist sg_src[2], sg_dst[2];
> +	struct scatterlist *src, *dst;
> +	struct skcipher_walk walk;
> +	unsigned int walk_size = crypto_skcipher_walksize(tfm);
> +	unsigned int tail_bytes;
> +	unsigned int head_bytes;
> +	unsigned int nbytes;
> +	unsigned int update_iv = 1;
> +	int err;
> +
> +	/* xts input size should be bigger than AES_BLOCK_SIZE */
> +	if (req->cryptlen < AES_BLOCK_SIZE)
> +		return -EINVAL;
> +
> +	/*
> +	 * We split xts-aes cryption into `head` and `tail` parts.
> +	 * The head block contains the input from the beginning which doesn't need
> +	 * `ciphertext stealing` method.
> +	 * The tail block contains at least two AES blocks including ciphertext
> +	 * stealing data from the end.
> +	 */
> +	if (req->cryptlen <= walk_size) {
> +		/*
> +		 * All data is in one `walk`. We could handle it within one AES-XTS call in
> +		 * the end.
> +		 */
> +		tail_bytes = req->cryptlen;
> +		head_bytes = 0;
> +	} else {
> +		if (req->cryptlen & (AES_BLOCK_SIZE - 1)) {
> +			/*
> +			 * with ciphertext stealing
> +			 *
> +			 * Find the largest tail size which is small than `walk` size while the
> +			 * head part still fits AES block boundary.
> +			 */
> +			tail_bytes = req->cryptlen & (AES_BLOCK_SIZE - 1);
> +			tail_bytes = walk_size + tail_bytes - AES_BLOCK_SIZE;
> +			head_bytes = req->cryptlen - tail_bytes;
> +		} else {
> +			/* no ciphertext stealing */
> +			tail_bytes = 0;
> +			head_bytes = req->cryptlen;
> +		}
> +	}
> +
> +	riscv64_aes_encrypt_zvkned(&ctx->ctx2, req->iv, req->iv);
> +
> +	if (head_bytes && tail_bytes) {
> +		/* If we have to parts, setup new request for head part only. */
> +		skcipher_request_set_tfm(&sub_req, tfm);
> +		skcipher_request_set_callback(
> +			&sub_req, skcipher_request_flags(req), NULL, NULL);
> +		skcipher_request_set_crypt(&sub_req, req->src, req->dst,
> +					   head_bytes, req->iv);
> +		req = &sub_req;
> +	}
> +
> +	if (head_bytes) {
> +		err = skcipher_walk_virt(&walk, req, false);
> +		while ((nbytes = walk.nbytes)) {
> +			if (nbytes == walk.total)
> +				update_iv = (tail_bytes > 0);
> +
> +			nbytes &= (~(AES_BLOCK_SIZE - 1));
> +			kernel_vector_begin();
> +			func(walk.src.virt.addr, walk.dst.virt.addr, nbytes,
> +			     &ctx->ctx1, req->iv, update_iv);
> +			kernel_vector_end();
> +
> +			err = skcipher_walk_done(&walk, walk.nbytes - nbytes);
> +		}
> +		if (err || !tail_bytes)
> +			return err;
> +
> +		/*
> +		 * Setup new request for tail part.
> +		 * We use `scatterwalk_next()` to find the next scatterlist from last
> +		 * walk instead of iterating from the beginning.
> +		 */
> +		dst = src = scatterwalk_next(sg_src, &walk.in);
> +		if (req->dst != req->src)
> +			dst = scatterwalk_next(sg_dst, &walk.out);
> +		skcipher_request_set_crypt(req, src, dst, tail_bytes, req->iv);
> +	}
> +
> +	/* tail */
> +	err = skcipher_walk_virt(&walk, req, false);
> +	if (err)
> +		return err;
> +	if (walk.nbytes != tail_bytes)
> +		return -EINVAL;
> +	kernel_vector_begin();
> +	func(walk.src.virt.addr, walk.dst.virt.addr, walk.nbytes, &ctx->ctx1,
> +	     req->iv, 0);
> +	kernel_vector_end();
> +
> +	return skcipher_walk_done(&walk, 0);
> +}

Did you consider writing xts_crypt() the way that arm64 and x86 do it?  The
above seems to reinvent sort of the same thing from first principles.  I'm
wondering if you should just copy the existing approach for now.  Then there
would be no need to add the scatterwalk_next() function, and also the handling
of inputs that don't need ciphertext stealing would be a bit more streamlined.

> +static int __init riscv64_aes_block_mod_init(void)
> +{
> +	int ret = -ENODEV;
> +
> +	if (riscv_isa_extension_available(NULL, ZVKNED) &&
> +	    riscv_vector_vlen() >= 128 && riscv_vector_vlen() <= 2048) {
> +		ret = simd_register_skciphers_compat(
> +			riscv64_aes_algs_zvkned,
> +			ARRAY_SIZE(riscv64_aes_algs_zvkned),
> +			riscv64_aes_simd_algs_zvkned);
> +		if (ret)
> +			return ret;
> +
> +		if (riscv_isa_extension_available(NULL, ZVBB)) {
> +			ret = simd_register_skciphers_compat(
> +				riscv64_aes_alg_zvkned_zvkb,
> +				ARRAY_SIZE(riscv64_aes_alg_zvkned_zvkb),
> +				riscv64_aes_simd_alg_zvkned_zvkb);
> +			if (ret)
> +				goto unregister_zvkned;

This makes the registration of the zvkned-zvkb algorithm conditional on zvbb,
not zvkb.  Shouldn't the extension checks actually look like:

    ZVKNED
        ZVKB
            ZVBB && ZVKG
        
- Eric

