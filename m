Return-Path: <linux-crypto+bounces-1218-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 623CC822F0F
	for <lists+linux-crypto@lfdr.de>; Wed,  3 Jan 2024 15:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD361F245AE
	for <lists+linux-crypto@lfdr.de>; Wed,  3 Jan 2024 14:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0244B1A28F;
	Wed,  3 Jan 2024 14:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e8+8fzo/"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E7D1A27F;
	Wed,  3 Jan 2024 14:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38478C433CA;
	Wed,  3 Jan 2024 14:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704290442;
	bh=m+hRsU8k3cdIotU5QEo5682hPjGRN/s/torPvKw5xc4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=e8+8fzo/tGyUtGa42r1wW8UcshyLVXcC9eaLv1nJKCC3z39rHRlrMWaH1rX+FCO5T
	 mMj1eV2owuwEpdVn4xzRFxLn32J3okv2Zob/Io8+rXNEk2XUehrxIJTH41JdwgWE9d
	 zPWbLAs5IOjehDl7jmarOgqVVcpyayjEnjiGiPaU6lZta6+T1NWRw951NFsZs4z3LZ
	 76pR+fWvW+BUs53QwEf7jaTBG6102NdkqtJc9/+1b84BicLRIhLLFC1JniCWjrxrKE
	 U72R1YcudSA+8MTbvdBGMqwacT6Lmpk7baX3UV16ssMR9qJnrqM8QVkzTWe6+jcQyC
	 QmmY0wJLb7Q4A==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cca5e7b390so106043831fa.3;
        Wed, 03 Jan 2024 06:00:42 -0800 (PST)
X-Gm-Message-State: AOJu0Yxi5YXvgpB7jC+9cf5DuyD/fzoUbubiEDrepbAbhfsqr1NHW0cH
	cDQjMGllkQ6xH6fUghn96bM7aoz7z5lLCV0UHtA=
X-Google-Smtp-Source: AGHT+IGKNOFtS5+p0cre5cs3npgO+9b7HPGn0FpCu0WJm8m7k/qpNOryTHSdgcCEdF3eNm0ld8kkfxvXqK4EtHgCAh8=
X-Received: by 2002:a05:6512:1308:b0:50e:84b1:c14 with SMTP id
 x8-20020a056512130800b0050e84b10c14mr6453714lfu.26.1704290440438; Wed, 03 Jan
 2024 06:00:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102064743.220490-1-ebiggers@kernel.org>
In-Reply-To: <20240102064743.220490-1-ebiggers@kernel.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Wed, 3 Jan 2024 15:00:29 +0100
X-Gmail-Original-Message-ID: <CAMj1kXEAqxCZ_PNM9a=CyciSHUzDU_yqemKh51oncHyLbYUKtA@mail.gmail.com>
Message-ID: <CAMj1kXEAqxCZ_PNM9a=CyciSHUzDU_yqemKh51oncHyLbYUKtA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/13] RISC-V crypto with reworked asm files
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-riscv@lists.infradead.org, 
	Jerry Shih <jerry.shih@sifive.com>, linux-kernel@vger.kernel.org, 
	Heiko Stuebner <heiko@sntech.de>, Phoebe Chen <phoebe.chen@sifive.com>, hongrong.hsu@sifive.com, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Andy Chiu <andy.chiu@sifive.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Jan 2024 at 07:50, Eric Biggers <ebiggers@kernel.org> wrote:
>
> As discussed previously, the proposed use of the so-called perlasm for
> the RISC-V crypto assembly files makes them difficult to read, and these
> files have some other issues such extensively duplicating source code
> for the different AES key lengths and for the unrolled hash functions.
> There is/was a desire to share code with OpenSSL, but many of the files
> have already diverged significantly; also, for most of the algorithms
> the source code can be quite short anyway, due to the native support for
> them in the RISC-V vector crypto extensions combined with the way the
> RISC-V vector extension naturally scales to arbitrary vector lengths.
>
> Since we're still waiting for prerequisite patches to be merged anyway,
> we have a bit more time to get this cleaned up properly.  So I've had a
> go at cleaning up the patchset to use standard .S files, with the code
> duplication fixed.  I also made some tweaks to make the different
> algorithms consistent with each other and with what exists in the kernel
> already for other architectures, and tried to improve comments.
>
> The result is this series, which passes all tests and is about 2400
> lines shorter than the latest version with the perlasm
> (https://lore.kernel.org/linux-crypto/20231231152743.6304-1-jerry.shih@sifive.com/).
> All the same functionality and general optimizations are still included,
> except for some minor optimizations in XTS that I dropped since it's not
> clear they are worth the complexity.  (Note that almost all users of XTS
> in the kernel only use it with block-aligned messages, so it's not very
> important to optimize the ciphertext stealing case.)
>
> I'd appreciate people's thoughts on this series.  Jerry, I hope I'm not
> stepping on your toes too much here, but I think there are some big
> improvements here.
>

As I have indicated before, I fully agree with Eric here that avoiding
perlasm is preferable: sharing code with OpenSSL is great if we can
simply adopt the exact same code (and track OpenSSL as its upstream)
but this never really worked that well for skciphers, due to API
differences. (The SHA transforms can be reused a bit more easily)

I will also note that perlasm is not as useful for RISC-V as it is for
other architectures: in OpenSSL, perlasm is also used to abstract
differences in calling conventions between, e.g., x86_64 on Linux vs
Windows, or to support building with outdated [proprietary]
toolchains.

I do wonder if we could also use .req directives for register aliases
instead of CPP defines? It shouldn't matter for working code, but the
diagnostics tend to be a bit more useful if the aliases are visible to
the assembler.







> This series is based on riscv/for-next
> (https://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git/log/?h=for-next)
> commit f352a28cc2fb4ee8d08c6a6362c9a861fcc84236, and for convenience
> I've included the prerequisite patches too.
>
> Andy Chiu (1):
>   riscv: vector: make Vector always available for softirq context
>
> Eric Biggers (1):
>   RISC-V: add TOOLCHAIN_HAS_VECTOR_CRYPTO
>
> Greentime Hu (1):
>   riscv: Add support for kernel mode vector
>
> Heiko Stuebner (2):
>   RISC-V: add helper function to read the vector VLEN
>   RISC-V: hook new crypto subdir into build-system
>
> Jerry Shih (8):
>   crypto: riscv - add vector crypto accelerated AES
>   crypto: riscv - add vector crypto accelerated AES-{ECB,CBC,CTR,XTS}
>   crypto: riscv - add vector crypto accelerated ChaCha20
>   crypto: riscv - add vector crypto accelerated GHASH
>   crypto: riscv - add vector crypto accelerated SHA-{256,224}
>   crypto: riscv - add vector crypto accelerated SHA-{512,384}
>   crypto: riscv - add vector crypto accelerated SM3
>   crypto: riscv - add vector crypto accelerated SM4
>
>  arch/riscv/Kbuild                             |   1 +
>  arch/riscv/Kconfig                            |   7 +
>  arch/riscv/crypto/Kconfig                     | 108 +++++
>  arch/riscv/crypto/Makefile                    |  28 ++
>  arch/riscv/crypto/aes-macros.S                | 156 +++++++
>  .../crypto/aes-riscv64-block-mode-glue.c      | 435 ++++++++++++++++++
>  arch/riscv/crypto/aes-riscv64-glue.c          | 123 +++++
>  arch/riscv/crypto/aes-riscv64-glue.h          |  15 +
>  .../crypto/aes-riscv64-zvkned-zvbb-zvkg.S     | 300 ++++++++++++
>  arch/riscv/crypto/aes-riscv64-zvkned-zvkb.S   | 146 ++++++
>  arch/riscv/crypto/aes-riscv64-zvkned.S        | 180 ++++++++
>  arch/riscv/crypto/chacha-riscv64-glue.c       | 101 ++++
>  arch/riscv/crypto/chacha-riscv64-zvkb.S       | 294 ++++++++++++
>  arch/riscv/crypto/ghash-riscv64-glue.c        | 170 +++++++
>  arch/riscv/crypto/ghash-riscv64-zvkg.S        |  72 +++
>  arch/riscv/crypto/sha256-riscv64-glue.c       | 137 ++++++
>  .../sha256-riscv64-zvknha_or_zvknhb-zvkb.S    | 225 +++++++++
>  arch/riscv/crypto/sha512-riscv64-glue.c       | 133 ++++++
>  .../riscv/crypto/sha512-riscv64-zvknhb-zvkb.S | 203 ++++++++
>  arch/riscv/crypto/sm3-riscv64-glue.c          | 112 +++++
>  arch/riscv/crypto/sm3-riscv64-zvksh-zvkb.S    | 123 +++++
>  arch/riscv/crypto/sm4-riscv64-glue.c          | 109 +++++
>  arch/riscv/crypto/sm4-riscv64-zvksed-zvkb.S   | 117 +++++
>  arch/riscv/include/asm/processor.h            |  14 +-
>  arch/riscv/include/asm/simd.h                 |  48 ++
>  arch/riscv/include/asm/vector.h               |  20 +
>  arch/riscv/kernel/Makefile                    |   1 +
>  arch/riscv/kernel/kernel_mode_vector.c        | 126 +++++
>  arch/riscv/kernel/process.c                   |   1 +
>  crypto/Kconfig                                |   3 +
>  30 files changed, 3507 insertions(+), 1 deletion(-)
>  create mode 100644 arch/riscv/crypto/Kconfig
>  create mode 100644 arch/riscv/crypto/Makefile
>  create mode 100644 arch/riscv/crypto/aes-macros.S
>  create mode 100644 arch/riscv/crypto/aes-riscv64-block-mode-glue.c
>  create mode 100644 arch/riscv/crypto/aes-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/aes-riscv64-glue.h
>  create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned-zvbb-zvkg.S
>  create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned-zvkb.S
>  create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned.S
>  create mode 100644 arch/riscv/crypto/chacha-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/chacha-riscv64-zvkb.S
>  create mode 100644 arch/riscv/crypto/ghash-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/ghash-riscv64-zvkg.S
>  create mode 100644 arch/riscv/crypto/sha256-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/sha256-riscv64-zvknha_or_zvknhb-zvkb.S
>  create mode 100644 arch/riscv/crypto/sha512-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/sha512-riscv64-zvknhb-zvkb.S
>  create mode 100644 arch/riscv/crypto/sm3-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/sm3-riscv64-zvksh-zvkb.S
>  create mode 100644 arch/riscv/crypto/sm4-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/sm4-riscv64-zvksed-zvkb.S
>  create mode 100644 arch/riscv/include/asm/simd.h
>  create mode 100644 arch/riscv/kernel/kernel_mode_vector.c
>
>
> base-commit: f352a28cc2fb4ee8d08c6a6362c9a861fcc84236
> --
> 2.43.0
>

