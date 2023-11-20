Return-Path: <linux-crypto+bounces-200-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0597F0B6A
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Nov 2023 05:32:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC381280C15
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Nov 2023 04:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4E39522A
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Nov 2023 04:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="XCfQaYGD"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4DA182
	for <linux-crypto@vger.kernel.org>; Sun, 19 Nov 2023 18:55:21 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cf57430104so5648295ad.1
        for <linux-crypto@vger.kernel.org>; Sun, 19 Nov 2023 18:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700448921; x=1701053721; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yg0x+T7ON9fvA/nzihMoJz0oESLmev7sCZPefVlmBec=;
        b=XCfQaYGD3kim/PryMxmOLrrxKGGu7Y4LoX3vYagam2aQvIUe0ppG46YC8TpxkAJDjp
         vOjA2FkUyTDlm6ovhnd7CnCcXO+0aieBdEYU1GEcCLSmQ18odyrzTRARE/sy+FG1bQ+x
         44TYvwPQxmW1cEBg1eejTF7JLOkX4bc2bshcws0fstFIycDhTou6d9TS/yR8K5Ud4V70
         hmjfZ27S6wohFeeZ46R0nlgMpBgc/yUH2FNWRa0z2olW8BdChWlmn1+4fI33LEHfVvvS
         Vzh6c6ogfSkaxfmP2URVPLi1gefO0/mDc7o+mC8Y0T9sAUi0WLNzPOscA1ZWA41Ox3xC
         wjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700448921; x=1701053721;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yg0x+T7ON9fvA/nzihMoJz0oESLmev7sCZPefVlmBec=;
        b=QtHz66X/FUdF9a/zFcux719DrMTQXYC2z1Q04GaN9Sl6OQnMSQQn5Qd+y3p8gQqFax
         xQDWpnHuAMrEAqLJZfOupTP+Ah5EKs2T8I0czUC8n5oji1D3vHL2xDqHJ2pT6TAhvVmF
         iBZtK9C/Irodf49xSP7jzJyakNGM0nFJK259Ygf3qCzK8MebW1vwKBZelqWnhcyQEpW2
         gytZb1VAYPgz9R+jFbi1VXUFiT+5IBN2ypmDoBZGZ2tFoLdDr+wCpOpwO1rDFyK5+IuS
         UZvZajO1XpIrh6RdRh6/TQQN1A+8uhJ0O3oyVnSzk1K0TpWX+GpWiIqxc+vD66PSiIiA
         FB/w==
X-Gm-Message-State: AOJu0Yy/krQXFDIE9ZNBvzhbRYkcZPB5dxx/xLL9nPtjRkT6UM628BkN
	s85Ts2I3CAnlOYpgOXKadwZarA==
X-Google-Smtp-Source: AGHT+IFuUjPi2Oe7rzisQHOcyNkxqx5t2yhJXAk9a4Ri2HQ4FV08v9d3S1jEA/pZSew+J7asN5OR5A==
X-Received: by 2002:a17:902:8b85:b0:1ca:86b:7ed9 with SMTP id ay5-20020a1709028b8500b001ca086b7ed9mr4657249plb.40.1700448920948;
        Sun, 19 Nov 2023 18:55:20 -0800 (PST)
Received: from ?IPv6:2402:7500:5d5:bc21:3420:fefa:20d4:2a2f? ([2402:7500:5d5:bc21:3420:fefa:20d4:2a2f])
        by smtp.gmail.com with ESMTPSA id y12-20020a170902ed4c00b001cc256ce1besm4928265plb.138.2023.11.19.18.55.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Nov 2023 18:55:20 -0800 (PST)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.7\))
Subject: Re: [PATCH 12/12] RISC-V: crypto: add Zvkb accelerated ChaCha20
 implementation
From: Jerry Shih <jerry.shih@sifive.com>
In-Reply-To: <20231102054327.GH1498@sol.localdomain>
Date: Mon, 20 Nov 2023 10:55:15 +0800
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
Content-Transfer-Encoding: 7bit
Message-Id: <90E2B1B4-ACC1-4316-81CD-E919D3BD03BA@sifive.com>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
 <20231025183644.8735-13-jerry.shih@sifive.com>
 <20231102054327.GH1498@sol.localdomain>
To: Eric Biggers <ebiggers@kernel.org>
X-Mailer: Apple Mail (2.3445.9.7)

On Nov 2, 2023, at 13:43, Eric Biggers <ebiggers@kernel.org> wrote:
> On Thu, Oct 26, 2023 at 02:36:44AM +0800, Jerry Shih wrote:
>> +static struct skcipher_alg riscv64_chacha_alg_zvkb[] = { {
>> +	.base = {
>> +		.cra_name = "chacha20",
>> +		.cra_driver_name = "chacha20-riscv64-zvkb",
>> +		.cra_priority = 300,
>> +		.cra_blocksize = 1,
>> +		.cra_ctxsize = sizeof(struct chacha_ctx),
>> +		.cra_module = THIS_MODULE,
>> +	},
>> +	.min_keysize = CHACHA_KEY_SIZE,
>> +	.max_keysize = CHACHA_KEY_SIZE,
>> +	.ivsize = CHACHA_IV_SIZE,
>> +	.chunksize = CHACHA_BLOCK_SIZE,
>> +	.walksize = CHACHA_BLOCK_SIZE * 4,
>> +	.setkey = chacha20_setkey,
>> +	.encrypt = chacha20_encrypt,
>> +	.decrypt = chacha20_encrypt,
>> +} };
>> +
>> +static inline bool check_chacha20_ext(void)
>> +{
>> +	return riscv_isa_extension_available(NULL, ZVKB) &&
>> +	       riscv_vector_vlen() >= 128;
>> +}
>> +
>> +static int __init riscv64_chacha_mod_init(void)
>> +{
>> +	if (check_chacha20_ext())
>> +		return crypto_register_skciphers(
>> +			riscv64_chacha_alg_zvkb,
>> +			ARRAY_SIZE(riscv64_chacha_alg_zvkb));
>> +
>> +	return -ENODEV;
>> +}
>> +
>> +static void __exit riscv64_chacha_mod_fini(void)
>> +{
>> +	if (check_chacha20_ext())
>> +		crypto_unregister_skciphers(
>> +			riscv64_chacha_alg_zvkb,
>> +			ARRAY_SIZE(riscv64_chacha_alg_zvkb));
>> +}
> 
> When there's just one algorithm being registered/unregistered,
> crypto_register_skcipher() and crypto_unregister_skcipher() can be used.

Fixed.

>> +# - RV64I
>> +# - RISC-V Vector ('V') with VLEN >= 128
>> +# - RISC-V Vector Cryptography Bit-manipulation extension ('Zvkb')
>> +# - RISC-V Zicclsm(Main memory supports misaligned loads/stores)
> 
> How is the presence of the Zicclsm extension guaranteed?
> 
> - Eric

I have the addition extension parser for `Zicclsm` in the v2 patch set.


-Jerry


