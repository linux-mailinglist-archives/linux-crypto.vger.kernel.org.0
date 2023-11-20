Return-Path: <linux-crypto+bounces-198-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C5A7F0B68
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Nov 2023 05:32:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E83E1F21444
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Nov 2023 04:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3595242
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Nov 2023 04:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="IvNZV5hv"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-oa1-x36.google.com (mail-oa1-x36.google.com [IPv6:2001:4860:4864:20::36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86873129
	for <linux-crypto@vger.kernel.org>; Sun, 19 Nov 2023 18:47:37 -0800 (PST)
Received: by mail-oa1-x36.google.com with SMTP id 586e51a60fabf-1eb39505ba4so2545040fac.0
        for <linux-crypto@vger.kernel.org>; Sun, 19 Nov 2023 18:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700448456; x=1701053256; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VU/ggVYx2HP9QVrpc118lNpu44S80Eqnc57DemebZM8=;
        b=IvNZV5hvWH27eBiylGbNVGBn3y7Gz1MOW635NJaQzcL9ctIHpISTrA2zqtIbt5MslB
         fDtJAZG70Yiddbs/bGvHzuxflkpM5E4Ynx6iqM1JOaTJotWtS4SlSphbRQStusjftW2X
         VtIGQzzUaRwN1aXk48yR+pUEL/0ermGkKLj2MUsB2gULhvXGTM8JbaDlng4moCZ+dU/c
         1JbK9JRC2W/1ZzIaaLfOiJKrN76hcVEPzQgp8QZwwkKk9JkA2tV8qggBgiUtNrk+e8hF
         AwakG49LWdp5xbk8tySeUD4TNEqY7OWvp6gwP5M8/O78MmlbWnlhNqLMTcenmZhkSBKB
         FlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700448456; x=1701053256;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VU/ggVYx2HP9QVrpc118lNpu44S80Eqnc57DemebZM8=;
        b=tGzXpWgK75B8fVBm0wgBjwHZnDD6iiCICENP0ArG+TWe9dpiv5LveFU01hmsCZTZ9b
         KTt+COAx2TdRoOik7g2GsfQf8+5B1mxTHycMB7SLSOn1BIfkOWHyDOPf46vlWFvh21XX
         jsymEZgn9paWfT9Vu2HTwPYhE999zpEqH0bmi8j9SO42k7kaH2HZ4NOBR2s06p2Tarn3
         X8iz/U7aXckjXREJTGyBGhUfUIzVGztfwk/uuWnXZcP3eJgh4M1uJNzOz4Z4ZktPazul
         8WL3y0P7UdJDuVU0Bv2mn5+d20IINnQsnIQVoMd8KGaoHhKVXMQPfaReCX6zXIU1U1iX
         0vMA==
X-Gm-Message-State: AOJu0Yw/1u0W8XGpwReasL+nQJECT9oUHzKA552NKfk9SO7JeVIDvOBO
	RW6GmUErJQTP7blaXNuIH7HQGw==
X-Google-Smtp-Source: AGHT+IG2yVOZskv7kdmEs8Y1YsZ/XPgdjGJmM54ZpbOJcfIJtiwxdqNWPxS3wLqNO1ObFLA2tMXR5Q==
X-Received: by 2002:a05:6870:a489:b0:1ef:b16f:d294 with SMTP id j9-20020a056870a48900b001efb16fd294mr7688617oal.38.1700448456607;
        Sun, 19 Nov 2023 18:47:36 -0800 (PST)
Received: from ?IPv6:2402:7500:5d5:bc21:3420:fefa:20d4:2a2f? ([2402:7500:5d5:bc21:3420:fefa:20d4:2a2f])
        by smtp.gmail.com with ESMTPSA id j2-20020a056a00234200b006cb638ba1aasm2599324pfj.49.2023.11.19.18.47.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Nov 2023 18:47:36 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH 06/12] RISC-V: crypto: add accelerated AES-CBC/CTR/ECB/XTS
 implementations
From: Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20231102051639.GF1498@sol.localdomain>
Date: Mon, 20 Nov 2023 10:47:29 +0800
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
 palmer@dabbelt.com,
 Albert Ou <aou@eecs.berkeley.edu>,
 herbert@gondor.apana.org.au,
 davem@davemloft.net,
 andy.chiu@sifive.com,
 greentime.hu@sifive.com,
 conor.dooley@microchip.com,
 guoren@kernel.org,
 bjorn@rivosinc.com,
 heiko@sntech.de,
 ardb@kernel.org,
 phoebe.chen@sifive.com,
 hongrong.hsu@sifive.com,
 linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-crypto@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <267FDF51-7720-40AC-9416-B5361C45393B@sifive.com>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
 <20231025183644.8735-7-jerry.shih@sifive.com>
 <20231102051639.GF1498@sol.localdomain>
To: Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3445.9.7)

On Nov 2, 2023, at 13:16, Eric Biggers <ebiggers@kernel.org> wrote:
> On Thu, Oct 26, 2023 at 02:36:38AM +0800, Jerry Shih wrote:
>> +config CRYPTO_AES_BLOCK_RISCV64
>> +	default y if RISCV_ISA_V
>> +	tristate "Ciphers: AES, modes: ECB/CBC/CTR/XTS"
>> +	depends on 64BIT && RISCV_ISA_V
>> +	select CRYPTO_AES_RISCV64
>> +	select CRYPTO_SKCIPHER
>> +	help
>> +	  Length-preserving ciphers: AES cipher algorithms (FIPS-197)
>> +	  with block cipher modes:
>> +	  - ECB (Electronic Codebook) mode (NIST SP 800-38A)
>> +	  - CBC (Cipher Block Chaining) mode (NIST SP 800-38A)
>> +	  - CTR (Counter) mode (NIST SP 800-38A)
>> +	  - XTS (XOR Encrypt XOR Tweakable Block Cipher with Ciphertext
>> +	    Stealing) mode (NIST SP 800-38E and IEEE 1619)
>> +
>> +	  Architecture: riscv64 using:
>> +	  - Zvbb vector extension (XTS)
>> +	  - Zvkb vector crypto extension (CTR/XTS)
>> +	  - Zvkg vector crypto extension (XTS)
>> +	  - Zvkned vector crypto extension
>=20
> Maybe list Zvkned first since it's the most important one in this =
context.

Fixed.


>> +#define AES_BLOCK_VALID_SIZE_MASK (~(AES_BLOCK_SIZE - 1))
>> +#define AES_BLOCK_REMAINING_SIZE_MASK (AES_BLOCK_SIZE - 1)
>=20
> I think it would be easier to read if these values were just used =
directly.

Fixed.

>> +static int ecb_encrypt(struct skcipher_request *req)
>> +{
>> +	struct crypto_skcipher *tfm =3D crypto_skcipher_reqtfm(req);
>> +	const struct riscv64_aes_ctx *ctx =3D crypto_skcipher_ctx(tfm);
>> +	struct skcipher_walk walk;
>> +	unsigned int nbytes;
>> +	int err;
>> +
>> +	/* If we have error here, the `nbytes` will be zero. */
>> +	err =3D skcipher_walk_virt(&walk, req, false);
>> +	while ((nbytes =3D walk.nbytes)) {
>> +		kernel_vector_begin();
>> +		rv64i_zvkned_ecb_encrypt(walk.src.virt.addr, =
walk.dst.virt.addr,
>> +					 nbytes & =
AES_BLOCK_VALID_SIZE_MASK,
>> +					 &ctx->key);
>> +		kernel_vector_end();
>> +		err =3D skcipher_walk_done(
>> +			&walk, nbytes & AES_BLOCK_REMAINING_SIZE_MASK);
>> +	}
>> +
>> +	return err;
>> +}
>=20
> There's no fallback for !crypto_simd_usable() here.  I really like it =
this way.
> However, for it to work (for skciphers and aeads), RISC-V needs to =
allow the
> vector registers to be used in softirq context.  Is that already the =
case?

I turn to use simd skcipher interface. More details will be in the v2 =
patch set.

>> +/* ctr */
>> +static int ctr_encrypt(struct skcipher_request *req)
>> +{
>> +	struct crypto_skcipher *tfm =3D crypto_skcipher_reqtfm(req);
>> +	const struct riscv64_aes_ctx *ctx =3D crypto_skcipher_ctx(tfm);
>> +	struct skcipher_walk walk;
>> +	unsigned int ctr32;
>> +	unsigned int nbytes;
>> +	unsigned int blocks;
>> +	unsigned int current_blocks;
>> +	unsigned int current_length;
>> +	int err;
>> +
>> +	/* the ctr iv uses big endian */
>> +	ctr32 =3D get_unaligned_be32(req->iv + 12);
>> +	err =3D skcipher_walk_virt(&walk, req, false);
>> +	while ((nbytes =3D walk.nbytes)) {
>> +		if (nbytes !=3D walk.total) {
>> +			nbytes &=3D AES_BLOCK_VALID_SIZE_MASK;
>> +			blocks =3D nbytes / AES_BLOCK_SIZE;
>> +		} else {
>> +			/* This is the last walk. We should handle the =
tail data. */
>> +			blocks =3D (nbytes + (AES_BLOCK_SIZE - 1)) /
>> +				 AES_BLOCK_SIZE;
>=20
> '(nbytes + (AES_BLOCK_SIZE - 1)) / AES_BLOCK_SIZE' can be replaced =
with
> 'DIV_ROUND_UP(nbytes, AES_BLOCK_SIZE)'

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
>> +	 * The tail size should be small than walk_size. Thus, we could =
make sure the
>> +	 * walk size for tail elements could be bigger than =
AES_BLOCK_SIZE.
>> +	 */
>> +	if (req->cryptlen <=3D walk_size) {
>> +		tail_bytes =3D req->cryptlen;
>> +		head_bytes =3D 0;
>> +	} else {
>> +		if (req->cryptlen & AES_BLOCK_REMAINING_SIZE_MASK) {
>> +			tail_bytes =3D req->cryptlen &
>> +				     AES_BLOCK_REMAINING_SIZE_MASK;
>> +			tail_bytes =3D walk_size + tail_bytes - =
AES_BLOCK_SIZE;
>> +			head_bytes =3D req->cryptlen - tail_bytes;
>> +		} else {
>> +			tail_bytes =3D 0;
>> +			head_bytes =3D req->cryptlen;
>> +		}
>> +	}
>> +
>> +	riscv64_aes_encrypt_zvkned(&ctx->ctx2, req->iv, req->iv);
>> +
>> +	if (head_bytes && tail_bytes) {
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
>> +			nbytes &=3D AES_BLOCK_VALID_SIZE_MASK;
>> +			kernel_vector_begin();
>> +			func(walk.src.virt.addr, walk.dst.virt.addr, =
nbytes,
>> +			     &ctx->ctx1.key, req->iv, update_iv);
>> +			kernel_vector_end();
>> +
>> +			err =3D skcipher_walk_done(&walk, walk.nbytes - =
nbytes);
>> +		}
>> +		if (err || !tail_bytes)
>> +			return err;
>> +
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
>> +	func(walk.src.virt.addr, walk.dst.virt.addr, walk.nbytes,
>> +	     &ctx->ctx1.key, req->iv, 0);
>> +	kernel_vector_end();
>> +
>> +	return skcipher_walk_done(&walk, 0);
>> +}
>=20
> This function looks a bit weird.  I see it's also the only caller of =
the
> scatterwalk_next() function that you're adding.  I haven't looked at =
this super
> closely, but I expect that there's a cleaner way of handling the =
"tail" than
> this -- maybe use scatterwalk_map_and_copy() to copy from/to a stack =
buffer?
>=20
> - Eric

I put more comments in v2 patch set. Hope it will be more clear.
Even though we use `scatterwalk_map_and_copy()`, it still use
`scatterwalk_ffwd()` inside. The `scatterwalk_next()` is used
for just `moving the next scatterlist` from from the previous
walk instead of iterating from the head.

-Jerry


