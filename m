Return-Path: <linux-crypto+bounces-379-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1937FD124
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Nov 2023 09:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A779B2820B6
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Nov 2023 08:41:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F929125C0
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Nov 2023 08:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="g9i8FJK8"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AE83171D
	for <linux-crypto@vger.kernel.org>; Tue, 28 Nov 2023 23:57:31 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6cbe716b511so4912635b3a.3
        for <linux-crypto@vger.kernel.org>; Tue, 28 Nov 2023 23:57:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1701244651; x=1701849451; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFsbRvr1vOPA+ZRf+5P8m2yK/OJ4On0HVxmuOdxj8N8=;
        b=g9i8FJK8pkB2HgMljNAI5WQQO4KZny32Pw8wIHrsFl8fbg7TvwmWaUadecQAOAveue
         m88Q1JtbxTYfAIML//KyKCrSVihLCV0uTEOFOY30+EUbrxFScJJbmCgmeDh8kJGTwqXR
         RDlIQkZ8ipfcVNiqwDV69mNfRpujv7ghXkaz3cYtgpOBYPrkdoBKsMlon1FBBGZnMaQm
         7UMiHlWB16pUvrBV2eF8KxLtG7bOfqf/puYyaTMZX24fLGeA3RbcRuwdMjpmqtYsg8aL
         pR88niKtNHSWty0sWE2Wo+QG2YUniaC4FQFumfpoyGbfd3Yuuro1HxdSl9bt1IGuCRMU
         Z89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701244651; x=1701849451;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iFsbRvr1vOPA+ZRf+5P8m2yK/OJ4On0HVxmuOdxj8N8=;
        b=Y8HamQlU9PnXwXls94xxCi2w+xb/WpWq/vgoUaeqFEvi1+ZDlWkY5hojDJJqtRFCK7
         ObrCnEPkMyjDLmDkUlquaPg1hn5jDbjK5ka7t29OVX3M9HXp0I0tkkKgJXu39mmbqM/Z
         OL5hdfyZMV93VMI6Fl53wv3N0Di6vBL0HLY+4Pe9GjtQJnCS7gzGJcx4sgxUZxvZlyft
         MabpwTVF5aFtPjD6DSeJ46UVs5JxhP1px3tAK2X7TtBybFfYHICT7r36uKsEPwHAOtqx
         msbKfqLZDAe//8/5oqRrPUtmiPDlSgmBjesp8/LmZBvO345vfb881UrAY2dB32kGiLYz
         M3/w==
X-Gm-Message-State: AOJu0YwTi/+JEQQd69EoT778KpTTi7MTJrg8cmpn8/xbgZh8Fnj4p2Sx
	UboomrfJWamn41ubvPq9b9h1bA==
X-Google-Smtp-Source: AGHT+IFK4o7xUXoWtsBPJh1GLeZc4kKnL2/MBs6AJBx/ToMjyQ9ACg9+9TEtywTSU4pBWYPIrKdNTA==
X-Received: by 2002:a05:6a00:1914:b0:68f:f38d:f76c with SMTP id y20-20020a056a00191400b0068ff38df76cmr19199016pfi.6.1701244650952;
        Tue, 28 Nov 2023 23:57:30 -0800 (PST)
Received: from ?IPv6:2402:7500:4ce:5a34:455:7149:7e47:1d5b? ([2402:7500:4ce:5a34:455:7149:7e47:1d5b])
        by smtp.gmail.com with ESMTPSA id f44-20020a056a000b2c00b006c4d1bb81d6sm10096862pfu.67.2023.11.28.23.57.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Nov 2023 23:57:30 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH v2 07/13] RISC-V: crypto: add accelerated
 AES-CBC/CTR/ECB/XTS implementations
From: Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20231128040716.GI1463@sol.localdomain>
Date: Wed, 29 Nov 2023 15:57:25 +0800
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 palmer@dabbelt.com,
 Albert Ou <aou@eecs.berkeley.edu>,
 herbert@gondor.apana.org.au,
 davem@davemloft.net,
 conor.dooley@microchip.com,
 ardb@kernel.org,
 heiko@sntech.de,
 phoebe.chen@sifive.com,
 hongrong.hsu@sifive.com,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7DFBB20D-B8D4-409B-8562-4C60E67FD279@sifive.com>
References: <20231127070703.1697-1-jerry.shih@sifive.com>
 <20231127070703.1697-8-jerry.shih@sifive.com>
 <20231128040716.GI1463@sol.localdomain>
To: Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3445.9.7)

On Nov 28, 2023, at 12:07, Eric Biggers <ebiggers@kernel.org> wrote:
> On Mon, Nov 27, 2023 at 03:06:57PM +0800, Jerry Shih wrote:
>> +typedef void (*aes_xts_func)(const u8 *in, u8 *out, size_t length,
>> +			     const struct crypto_aes_ctx *key, u8 *iv,
>> +			     int update_iv);
>=20
> There's no need for this indirection, because the function pointer can =
only have
> one value.
>=20
> Note also that when Control Flow Integrity is enabled, assembly =
functions can
> only be called indirectly when they use SYM_TYPED_FUNC_START.  That's =
another
> reason to avoid indirect calls that aren't actually necessary.

We have two function pointers for encryption and decryption.
	static int xts_encrypt(struct skcipher_request *req)
	{
		return xts_crypt(req, =
rv64i_zvbb_zvkg_zvkned_aes_xts_encrypt);
	}

	static int xts_decrypt(struct skcipher_request *req)
	{
		return xts_crypt(req, =
rv64i_zvbb_zvkg_zvkned_aes_xts_decrypt);
	}
The enc and dec path could be folded together into `xts_crypt()`, but we =
will have
additional branches for enc/decryption path if we don't want to have the =
indirect calls.
Use `SYM_TYPED_FUNC_START` in asm might be better.

>> +			nbytes &=3D (~(AES_BLOCK_SIZE - 1));
>=20
> Expressions like ~(n - 1) should not have another set of parentheses =
around them

Fixed.

>> +static int xts_crypt(struct skcipher_request *req, aes_xts_func =
func)
>> +{
>> +	struct crypto_skcipher *tfm =3D crypto_skcipher_reqtfm(req);
>> +	const struct riscv64_aes_xts_ctx *ctx =3D =
crypto_skcipher_ctx(tfm);
>> +	struct skcipher_request sub_req;
>> +	struct scatterlist sg_src[2], sg_dst[2];
>> +	struct scatterlist *src, *dst;
>> +	struct skcipher_walk walk;
>> +	unsigned int walk_size =3D crypto_skcipher_walksize(tfm);
>> +	unsigned int tail_bytes;
>> +	unsigned int head_bytes;
>> +	unsigned int nbytes;
>> +	unsigned int update_iv =3D 1;
>> +	int err;
>> +
>> +	/* xts input size should be bigger than AES_BLOCK_SIZE */
>> +	if (req->cryptlen < AES_BLOCK_SIZE)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * We split xts-aes cryption into `head` and `tail` parts.
>> +	 * The head block contains the input from the beginning which =
doesn't need
>> +	 * `ciphertext stealing` method.
>> +	 * The tail block contains at least two AES blocks including =
ciphertext
>> +	 * stealing data from the end.
>> +	 */
>> +	if (req->cryptlen <=3D walk_size) {
>> +		/*
>> +		 * All data is in one `walk`. We could handle it within =
one AES-XTS call in
>> +		 * the end.
>> +		 */
>> +		tail_bytes =3D req->cryptlen;
>> +		head_bytes =3D 0;
>> +	} else {
>> +		if (req->cryptlen & (AES_BLOCK_SIZE - 1)) {
>> +			/*
>> +			 * with ciphertext stealing
>> +			 *
>> +			 * Find the largest tail size which is small =
than `walk` size while the
>> +			 * head part still fits AES block boundary.
>> +			 */
>> +			tail_bytes =3D req->cryptlen & (AES_BLOCK_SIZE - =
1);
>> +			tail_bytes =3D walk_size + tail_bytes - =
AES_BLOCK_SIZE;
>> +			head_bytes =3D req->cryptlen - tail_bytes;
>> +		} else {
>> +			/* no ciphertext stealing */
>> +			tail_bytes =3D 0;
>> +			head_bytes =3D req->cryptlen;
>> +		}
>> +	}
>> +
>> +	riscv64_aes_encrypt_zvkned(&ctx->ctx2, req->iv, req->iv);
>> +
>> +	if (head_bytes && tail_bytes) {
>> +		/* If we have to parts, setup new request for head part =
only. */
>> +		skcipher_request_set_tfm(&sub_req, tfm);
>> +		skcipher_request_set_callback(
>> +			&sub_req, skcipher_request_flags(req), NULL, =
NULL);
>> +		skcipher_request_set_crypt(&sub_req, req->src, req->dst,
>> +					   head_bytes, req->iv);
>> +		req =3D &sub_req;
>> +	}
>> +
>> +	if (head_bytes) {
>> +		err =3D skcipher_walk_virt(&walk, req, false);
>> +		while ((nbytes =3D walk.nbytes)) {
>> +			if (nbytes =3D=3D walk.total)
>> +				update_iv =3D (tail_bytes > 0);
>> +
>> +			nbytes &=3D (~(AES_BLOCK_SIZE - 1));
>> +			kernel_vector_begin();
>> +			func(walk.src.virt.addr, walk.dst.virt.addr, =
nbytes,
>> +			     &ctx->ctx1, req->iv, update_iv);
>> +			kernel_vector_end();
>> +
>> +			err =3D skcipher_walk_done(&walk, walk.nbytes - =
nbytes);
>> +		}
>> +		if (err || !tail_bytes)
>> +			return err;
>> +
>> +		/*
>> +		 * Setup new request for tail part.
>> +		 * We use `scatterwalk_next()` to find the next =
scatterlist from last
>> +		 * walk instead of iterating from the beginning.
>> +		 */
>> +		dst =3D src =3D scatterwalk_next(sg_src, &walk.in);
>> +		if (req->dst !=3D req->src)
>> +			dst =3D scatterwalk_next(sg_dst, &walk.out);
>> +		skcipher_request_set_crypt(req, src, dst, tail_bytes, =
req->iv);
>> +	}
>> +
>> +	/* tail */
>> +	err =3D skcipher_walk_virt(&walk, req, false);
>> +	if (err)
>> +		return err;
>> +	if (walk.nbytes !=3D tail_bytes)
>> +		return -EINVAL;
>> +	kernel_vector_begin();
>> +	func(walk.src.virt.addr, walk.dst.virt.addr, walk.nbytes, =
&ctx->ctx1,
>> +	     req->iv, 0);
>> +	kernel_vector_end();
>> +
>> +	return skcipher_walk_done(&walk, 0);
>> +}
>=20
> Did you consider writing xts_crypt() the way that arm64 and x86 do it? =
 The
> above seems to reinvent sort of the same thing from first principles.  =
I'm
> wondering if you should just copy the existing approach for now.  Then =
there
> would be no need to add the scatterwalk_next() function, and also the =
handling
> of inputs that don't need ciphertext stealing would be a bit more =
streamlined.

I will check the arm and x86's implementations.
But the `scatterwalk_next()` proposed in this series does the same thing =
as the
call `scatterwalk_ffwd()` in arm and x86's implementations.
The scatterwalk_ffwd() iterates from the beginning of scatterlist(O(n)), =
but the=20
scatterwalk_next() is just iterates from the end point of the last used
scatterlist(O(1)).

>> +static int __init riscv64_aes_block_mod_init(void)
>> +{
>> +	int ret =3D -ENODEV;
>> +
>> +	if (riscv_isa_extension_available(NULL, ZVKNED) &&
>> +	    riscv_vector_vlen() >=3D 128 && riscv_vector_vlen() <=3D =
2048) {
>> +		ret =3D simd_register_skciphers_compat(
>> +			riscv64_aes_algs_zvkned,
>> +			ARRAY_SIZE(riscv64_aes_algs_zvkned),
>> +			riscv64_aes_simd_algs_zvkned);
>> +		if (ret)
>> +			return ret;
>> +
>> +		if (riscv_isa_extension_available(NULL, ZVBB)) {
>> +			ret =3D simd_register_skciphers_compat(
>> +				riscv64_aes_alg_zvkned_zvkb,
>> +				ARRAY_SIZE(riscv64_aes_alg_zvkned_zvkb),
>> +				riscv64_aes_simd_alg_zvkned_zvkb);
>> +			if (ret)
>> +				goto unregister_zvkned;
>=20
> This makes the registration of the zvkned-zvkb algorithm conditional =
on zvbb,
> not zvkb.  Shouldn't the extension checks actually look like:
>=20
>    ZVKNED
>        ZVKB
>            ZVBB && ZVKG

Fixed.
But we will have the conditions like:
	if(ZVKNED) {
		reg_cipher_1();
		if(ZVKB) {
			reg_cipher_2();
		}
		if (ZVBB && ZVKG) {
			reg_cipher_3();
		}
	}

> - Eric


