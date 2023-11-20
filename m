Return-Path: <linux-crypto+bounces-199-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 594437F0B69
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Nov 2023 05:32:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BB15280C03
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Nov 2023 04:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60C65221
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Nov 2023 04:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="HN9XWban"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A95E7129
	for <linux-crypto@vger.kernel.org>; Sun, 19 Nov 2023 18:53:37 -0800 (PST)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-58a7d13b00bso2469043eaf.1
        for <linux-crypto@vger.kernel.org>; Sun, 19 Nov 2023 18:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700448817; x=1701053617; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zgw7AKOcjzQj/Rejwnwc+8bVuVEALNE76ynoPJrneqk=;
        b=HN9XWbancERDBuWD8+NNCswphmQH7UZ/k6GH905FMI0U9dpeUh8J9zqysNeZSiKWT7
         9gpOyfscceQ4gmcHCYhzko/8hgNFJJBGKiJ3tuF7K8MIhlM+4GmBZjkEjWi02PTCa6f1
         HZqkukBoC0uJslL+7ridetg7AUP6FaJWBxhDhgdNJFR2ok05xwyesya5+M5McKzf9KJh
         o8TdcJFTGkXL2W5KwZ1GrcNvRGxsDh0NXaO7agLf1WjifD7/4U7fxraxDM/EDawG+pm9
         7M3CumpsyJyBTzsdUmuCmld4i2HFzPv8ohkWdhXBmbvPZlS4Ye6Ptu+qaEJXKOL7TpMH
         SZ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700448817; x=1701053617;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zgw7AKOcjzQj/Rejwnwc+8bVuVEALNE76ynoPJrneqk=;
        b=gTnlT6WWKfYr7hM22wfyX3GuRN/tFHOStWDKsA7255w6NmHaybaod73TeWwCtgNjlp
         QyUYfPIL8DQ5k9tfaBr5bKZKnYjq/YzW2qxTCQPM1XqOHl6PfjQXXKieuY8ls/fPQlZ7
         YHUhj/IqFBtFMf6L9a5FQM2ia6/lTZd2nmzCLkgCLvEeLRddEYw3hqYfMBjt0VOwg4k3
         886TS/xYZs1lGI9+ipZQ1WIUTDNttBhuUceVAJJe9A2eJ4GOqnLVjYB4pOQ2vbJaO4ig
         2iFpelNjsENFTa4sqlbp45ac7eeSmKz2dObm3znqkAMYk+3PliR6hqrHsnfxj0eo71Ss
         M6qQ==
X-Gm-Message-State: AOJu0YzOpR/HTz07Nc176Q/fMtNx4E6QO+r7bV5wMUuOcLTNkLSaIK0e
	TYYo1UoaCG9YnX7TqUAXrh4bcg==
X-Google-Smtp-Source: AGHT+IG8+zVUvIfaj6M56TYlUd2Q7PRlGTniaXvKvPTlRS7k2ULTLBqGIip0cGvEtuCSCawFt277vg==
X-Received: by 2002:a05:6358:63a9:b0:16b:fa63:4f44 with SMTP id k41-20020a05635863a900b0016bfa634f44mr6528197rwh.10.1700448816832;
        Sun, 19 Nov 2023 18:53:36 -0800 (PST)
Received: from ?IPv6:2402:7500:5d5:bc21:3420:fefa:20d4:2a2f? ([2402:7500:5d5:bc21:3420:fefa:20d4:2a2f])
        by smtp.gmail.com with ESMTPSA id u31-20020a63471f000000b0058c1383fa8bsm4979080pga.0.2023.11.19.18.53.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Nov 2023 18:53:36 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH 04/12] RISC-V: crypto: add Zvkned accelerated AES
 implementation
From: Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20231102045154.GE1498@sol.localdomain>
Date: Mon, 20 Nov 2023 10:53:30 +0800
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
Message-Id: <4C199F94-3797-4163-9EAD-D3A4EF6D2C41@sifive.com>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
 <20231025183644.8735-5-jerry.shih@sifive.com>
 <20231102045154.GE1498@sol.localdomain>
To: Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3445.9.7)

On Nov 2, 2023, at 12:51, Eric Biggers <ebiggers@kernel.org> wrote:
> On Thu, Oct 26, 2023 at 02:36:36AM +0800, Jerry Shih wrote:
>> diff --git a/arch/riscv/crypto/Kconfig b/arch/riscv/crypto/Kconfig
>> index 10d60edc0110..500938317e71 100644
>> --- a/arch/riscv/crypto/Kconfig
>> +++ b/arch/riscv/crypto/Kconfig
>> @@ -2,4 +2,16 @@
>>=20
>> menu "Accelerated Cryptographic Algorithms for CPU (riscv)"
>>=20
>> +config CRYPTO_AES_RISCV64
>> +	default y if RISCV_ISA_V
>> +	tristate "Ciphers: AES"
>> +	depends on 64BIT && RISCV_ISA_V
>> +	select CRYPTO_AES
>> +	select CRYPTO_ALGAPI
>> +	help
>> +	  Block ciphers: AES cipher algorithms (FIPS-197)
>> +
>> +	  Architecture: riscv64 using:
>> +	  - Zvkned vector crypto extension
>=20
> kconfig options should default to off.
>=20
> I.e., remove the line "default y if RISCV_ISA_V"

Fixed.

>> + *
>> + * All zvkned-based functions use encryption expending keys for both =
encryption
>> + * and decryption.
>> + */
>=20
> The above comment is a bit confusing.  It's describing the 'key' field =
of struct
> aes_key; maybe there should be a comment there instead:
>=20
>    struct aes_key {
>            u32 key[AES_MAX_KEYLENGTH_U32]; /* round keys in encryption =
order */
>            u32 rounds;
>    };

I have updated the asm implementation to use `crypto_aes_ctx` struct.

>> +int riscv64_aes_setkey(struct riscv64_aes_ctx *ctx, const u8 *key,
>> +		       unsigned int keylen)
>> +{
>> +	/*
>> +	 * The RISC-V AES vector crypto key expending doesn't support =
AES-192.
>> +	 * We just use the generic software key expending here to =
simplify the key
>> +	 * expending flow.
>> +	 */
>=20
> expending =3D> expanding

Thx.
Fixed.

>> +	u32 aes_rounds;
>> +	u32 key_length;
>> +	int ret;
>> +
>> +	ret =3D aes_expandkey(&ctx->fallback_ctx, key, keylen);
>> +	if (ret < 0)
>> +		return -EINVAL;
>> +
>> +	/*
>> +	 * Copy the key from `crypto_aes_ctx` to `aes_key` for =
zvkned-based AES
>> +	 * implementations.
>> +	 */
>> +	aes_rounds =3D aes_round_num(keylen);
>> +	ctx->key.rounds =3D aes_rounds;
>> +	key_length =3D AES_BLOCK_SIZE * (aes_rounds + 1);
>> +	memcpy(ctx->key.key, ctx->fallback_ctx.key_enc, key_length);
>> +
>> +	return 0;
>> +}
>=20
> Ideally this would use the same crypto_aes_ctx for both the fallback =
and the
> assembly code.  I suppose we don't want to diverge from the OpenSSL =
code (unless
> it gets rewritten), though.  So I guess this is fine for now.

I have updated the asm implementation to use `crypto_aes_ctx` struct.

>> void riscv64_aes_encrypt_zvkned(const struct riscv64_aes_ctx *ctx, u8 =
*dst,
>>                               const u8 *src)
>=20
> These functions can be called from a different module =
(aes-block-riscv64), so
> they need EXPORT_SYMBOL_GPL.

Fixed.

>> +static inline bool check_aes_ext(void)
>> +{
>> +	return riscv_isa_extension_available(NULL, ZVKNED) &&
>> +	       riscv_vector_vlen() >=3D 128;
>> +}
>> +
>> +static int __init riscv64_aes_mod_init(void)
>> +{
>> +	if (check_aes_ext())
>> +		return crypto_register_alg(&riscv64_aes_alg_zvkned);
>> +
>> +	return -ENODEV;
>> +}
>> +
>> +static void __exit riscv64_aes_mod_fini(void)
>> +{
>> +	if (check_aes_ext())
>> +		crypto_unregister_alg(&riscv64_aes_alg_zvkned);
>> +}
>> +
>> +module_init(riscv64_aes_mod_init);
>> +module_exit(riscv64_aes_mod_fini);
>=20
> module_exit can only run if module_init succeeded.  So, in cases like =
this it's
> not necessary to check for CPU features before unregistering the =
algorithm.
>=20
> - Eric

Fixed.

-Jerry


