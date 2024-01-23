Return-Path: <linux-crypto+bounces-1551-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD9D83920D
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Jan 2024 16:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7ED1F28E74
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Jan 2024 15:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90945FDDC;
	Tue, 23 Jan 2024 15:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="PG84TjTS"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBD85FDD7
	for <linux-crypto@vger.kernel.org>; Tue, 23 Jan 2024 15:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022417; cv=none; b=gxb2DkpxU39JtnjEARiS7LfBTZ9pppN4wrxyaWxHPbvUwUuQEYCVEiCZKV3p8IyVZPwQpGt7QScmf6kskLS//OB7NmPoWbDSZmoBhYB+WwYV7VDs/0XFSQDCRq5szca+uriGZjIAYh0buR3h3wJqafhb/Sp9HtA2HUCwkG/vhVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022417; c=relaxed/simple;
	bh=NTmyNsrucXKY9cw+aWmnWoco1HoM9ZMyvI4AhLzmiek=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sYeLIEFbHjZTP/Xoxp4HJx8jgVmCl3G0fyrAd6npcViMGuaT6xLCA4pwt2k3Mz4y66ORKVhZsdwsh5M3aSX6CXCoXpLFLWCU/ZbycFUGvAapcvwrY/lfkSGXj0jBzCOCYnACA11/AV3NUZxEIFWoh0wB19kmcj9szfPgjpwwSoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=PG84TjTS; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d5f252411aso24009065ad.2
        for <linux-crypto@vger.kernel.org>; Tue, 23 Jan 2024 07:06:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1706022415; x=1706627215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1tjKV2GUrSP7LFhHsJ97x90ExpcYsvB+JBmXfLVyyFI=;
        b=PG84TjTSJg3ERaFtnJ8DCLDWqDoNrpdTVJJTYtXnKuIvx/PGVyxp6si+0fZCI0L1/s
         fMMYIsoWUhRyT8XJGj1r1HCk5oJRK9d19pumhm7P2iL+wv7/kpMKh8LjG9HGZMjyEjSN
         cCYIk+RSYJdysHL1Y2dMM574md4/owg5BOyuf1fnsTSKUhuqoK5LW9RHy3CzGfsncWkF
         Twwwx1uyBFUVcz09Scz2ZlHm941nN6IbMAKP1WRrdKfWtxc47vGqUfgZJmpqxEu+pv8b
         4yYWyNp+jApMhZ6knfnADk1WSl2v2IfvpiIi0KLZCT76T859x1gyW+56n7r/iFIMKTVo
         SdSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706022415; x=1706627215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1tjKV2GUrSP7LFhHsJ97x90ExpcYsvB+JBmXfLVyyFI=;
        b=ROxbyeg5oloNa7/rbXrHWlBCy0yuMxIE6zzckXY74woKXDOq9Ts2YmZjYU63TZEDdK
         C6W5jzwo1A4NTXYiu1SAmMKJQhpcwcsYuaCXI0iaivZnjcMsvrRU2y6qh5PPWEh5BSxN
         DKjTMvHcLTHiMhd9bf6MA5GoKt0P45xahwyj0YrvB+FyARdRm64fRVhd/dtT/WwJK1FH
         0x7+q7SMs9BPuPfjUsdbaqFJT6sMPJ2UtVQrH/AmEL7QK/4lrmag8yKclaa+bSfTzoB5
         XkLvNyqi1U3dY4RyJukRKZD6ysQ4GUgso6xCm1T0v9KMIY+fpPRX8WOpCYrCWi1cR1Iw
         5rsg==
X-Gm-Message-State: AOJu0YxLXbxxwvg8yosCZf5p2nKORnXY7CVLkrK19B+s0ipwoCnJx73s
	x9LC4SilgNKRenOAw+ncpcfloYdR2c5gs2sGoUqlyCbGIaAWlGTX5wJ3sYC9AXKvcl3lb6BZga3
	z2mf4+Sc45QMsenOrtqC9hVgSrYR+ONqk9rqRHw==
X-Google-Smtp-Source: AGHT+IHDBHd0oeNga+xE+kyZKxq8j0hI4802+QZ38jIKhXZ5obf2QepzH8/p7HOdtFVFwKsQoAwztEPl6+jRnYSDxvs=
X-Received: by 2002:a17:90b:606:b0:28f:f849:7c8c with SMTP id
 gb6-20020a17090b060600b0028ff8497c8cmr2681037pjb.34.1706022414987; Tue, 23
 Jan 2024 07:06:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122002024.27477-1-ebiggers@kernel.org>
In-Reply-To: <20240122002024.27477-1-ebiggers@kernel.org>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Tue, 23 Jan 2024 16:06:43 +0100
Message-ID: <CAEg0e7j6x6Fj4CmAGz2qzumVeL4mMK1D3VUT5CaQYTebsyPThg@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] RISC-V crypto with reworked asm files
To: Eric Biggers <ebiggers@kernel.org>
Cc: linux-crypto@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Albert Ou <aou@eecs.berkeley.edu>, 
	Andy Chiu <andy.chiu@sifive.com>, Ard Biesheuvel <ardb@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
	Jerry Shih <jerry.shih@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Phoebe Chen <phoebe.chen@sifive.com>, 
	hongrong.hsu@sifive.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2024 at 1:23=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:
>
> This patchset, which applies to v6.8-rc1, adds cryptographic algorithm
> implementations accelerated using the RISC-V vector crypto extensions
> (https://github.com/riscv/riscv-crypto/releases/download/v1.0.0/riscv-cry=
pto-spec-vector.pdf)
> and RISC-V vector extension
> (https://github.com/riscv/riscv-v-spec/releases/download/v1.0/riscv-v-spe=
c-1.0.pdf).
> The following algorithms are included: AES in ECB, CBC, CTR, and XTS mode=
s;
> ChaCha20; GHASH; SHA-2; SM3; and SM4.
>
> In general, the assembly code requires a 64-bit RISC-V CPU with VLEN >=3D=
 128,
> little endian byte order, and vector unaligned access support.  The ECB, =
CTR,
> XTS, and ChaCha20 code is designed to naturally scale up to larger VLEN v=
alues.
> Building the assembly code requires tip-of-tree binutils (future 2.42) or
> tip-of-tree clang (future 18.x).  All algorithms pass testing in QEMU, us=
ing
> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=3Dy.  Much of the assembly code is deri=
ved from
> OpenSSL code that was added by https://github.com/openssl/openssl/pull/21=
923.
> It's been cleaned up for integration with the kernel, e.g. reducing code
> duplication, eliminating use of .inst and perlasm, and fixing a few bugs.
>
> This patchset incorporates the work of multiple people, including Jerry S=
hih,
> Heiko Stuebner, Christoph M=C3=BCllner, Phoebe Chen, Charalampos Mitrodim=
as, and
> myself.  This patchset went through several versions from Heiko (last ver=
sion
> https://lore.kernel.org/linux-crypto/20230711153743.1970625-1-heiko@sntec=
h.de),
> then several versions from Jerry (last version:
> https://lore.kernel.org/linux-crypto/20231231152743.6304-1-jerry.shih@sif=
ive.com),
> then finally several versions from me.  Thanks to everyone who has contri=
buted
> to this patchset or its prerequisites.  Since v6.8-rc1, all prerequisite =
kernel
> patches are upstream.  I think this is now ready, and I'd like for it to =
be
> applied for 6.9, either to the crypto or riscv tree (at maintainers' choi=
ce).
>
> Below is the changelog for my versions of the patchset.  For the changelo=
g of
> the older versions, see the above links.

For all patches of this series:
Reviewed-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>

Eric, thank you for working on this!

>
> Changed in v3:
>   - Fixed a bug in the AES-XTS implementation where it assumed the CPU
>     always set vl to the maximum possible value.  This was okay for
>     QEMU, but the vector spec allows CPUs to have different behavior.
>   - Increased the LMUL for AES-ECB to 8, as the registers are available.
>   - Fixed some license text that I had mistakenly changed when doing a
>     find-and-replace of code.
>   - Addressed a checkpatch warning by not including filename in file.
>   - Rename some labels.
>   - Constify a variable.
>
> Changed in v2:
>   - Merged the AES modules together to prevent a build error.
>   - Only unregister AES algorithms that were registered.
>   - Corrected walksize properties to match the LMUL used by asm code.
>   - Simplified the CTR and XTS glue code slightly.
>   - Minor cleanups.
>
> Changed in v1:
>   - Refer to my cover letter
>     https://lore.kernel.org/linux-crypto/20240102064743.220490-1-ebiggers=
@kernel.org/
>
> Eric Biggers (1):
>   RISC-V: add TOOLCHAIN_HAS_VECTOR_CRYPTO
>
> Heiko Stuebner (2):
>   RISC-V: add helper function to read the vector VLEN
>   RISC-V: hook new crypto subdir into build-system
>
> Jerry Shih (7):
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
>  arch/riscv/crypto/Kconfig                     |  93 +++
>  arch/riscv/crypto/Makefile                    |  23 +
>  arch/riscv/crypto/aes-macros.S                | 156 +++++
>  arch/riscv/crypto/aes-riscv64-glue.c          | 550 ++++++++++++++++++
>  .../crypto/aes-riscv64-zvkned-zvbb-zvkg.S     | 312 ++++++++++
>  arch/riscv/crypto/aes-riscv64-zvkned-zvkb.S   | 146 +++++
>  arch/riscv/crypto/aes-riscv64-zvkned.S        | 180 ++++++
>  arch/riscv/crypto/chacha-riscv64-glue.c       | 101 ++++
>  arch/riscv/crypto/chacha-riscv64-zvkb.S       | 294 ++++++++++
>  arch/riscv/crypto/ghash-riscv64-glue.c        | 168 ++++++
>  arch/riscv/crypto/ghash-riscv64-zvkg.S        |  72 +++
>  arch/riscv/crypto/sha256-riscv64-glue.c       | 137 +++++
>  .../sha256-riscv64-zvknha_or_zvknhb-zvkb.S    | 225 +++++++
>  arch/riscv/crypto/sha512-riscv64-glue.c       | 133 +++++
>  .../riscv/crypto/sha512-riscv64-zvknhb-zvkb.S | 203 +++++++
>  arch/riscv/crypto/sm3-riscv64-glue.c          | 112 ++++
>  arch/riscv/crypto/sm3-riscv64-zvksh-zvkb.S    | 123 ++++
>  arch/riscv/crypto/sm4-riscv64-glue.c          | 107 ++++
>  arch/riscv/crypto/sm4-riscv64-zvksed-zvkb.S   | 117 ++++
>  arch/riscv/include/asm/vector.h               |  11 +
>  crypto/Kconfig                                |   3 +
>  23 files changed, 3274 insertions(+)
>  create mode 100644 arch/riscv/crypto/Kconfig
>  create mode 100644 arch/riscv/crypto/Makefile
>  create mode 100644 arch/riscv/crypto/aes-macros.S
>  create mode 100644 arch/riscv/crypto/aes-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned-zvbb-zvkg.S
>  create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned-zvkb.S
>  create mode 100644 arch/riscv/crypto/aes-riscv64-zvkned.S
>  create mode 100644 arch/riscv/crypto/chacha-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/chacha-riscv64-zvkb.S
>  create mode 100644 arch/riscv/crypto/ghash-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/ghash-riscv64-zvkg.S
>  create mode 100644 arch/riscv/crypto/sha256-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/sha256-riscv64-zvknha_or_zvknhb-zvk=
b.S
>  create mode 100644 arch/riscv/crypto/sha512-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/sha512-riscv64-zvknhb-zvkb.S
>  create mode 100644 arch/riscv/crypto/sm3-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/sm3-riscv64-zvksh-zvkb.S
>  create mode 100644 arch/riscv/crypto/sm4-riscv64-glue.c
>  create mode 100644 arch/riscv/crypto/sm4-riscv64-zvksed-zvkb.S
>
>
> base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
> --
> 2.43.0
>

