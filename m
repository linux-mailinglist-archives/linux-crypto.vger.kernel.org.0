Return-Path: <linux-crypto+bounces-232-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F098A7F3AC2
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Nov 2023 01:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAECA2819F8
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Nov 2023 00:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A62F1C3D
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Nov 2023 00:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Viv7M/P9"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073C52BAF7
	for <linux-crypto@vger.kernel.org>; Tue, 21 Nov 2023 23:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02D1BC433C7;
	Tue, 21 Nov 2023 23:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700610671;
	bh=3dyir6hn+yCj4QQvn9hjT6LOtunjwshoOwuVacKmLPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Viv7M/P9qyRl2VwZUlURi91OfI/4U9msYDGubL5WGF0EsH8lrLL5mLBzZ6NGtsz8o
	 qAe1Cx6Zn20b3qNeSML9ESPa19ZjTNqAhUFQRc29WWBTMHkoaMNqp4dm6bU34MeR98
	 N54rNvtavGdNtCKw9I06lWeDnm3ES/Ly8r8uY22ETe69Nagxnph64vPyauJmyrHBuk
	 Bh9uf0yHvfQGk+jvq3HweYu40XpicTDFszLX1ZTuVjWDhrYr4TFcgfvMuAQ68s1xzC
	 A8dBQkpI/Rrfn3nIhxxF/SQJoptq17e2/Pm+pfc7W9rsDrp72UFaiUATXVXZmj9RM1
	 BeBaMD+UQIC/w==
Date: Tue, 21 Nov 2023 15:51:09 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Jerry Shih <jerry.shih@sifive.com>
Cc: Charlie Jenkins <charlie@rivosinc.com>,
	Heiko Stuebner <heiko@sntech.de>, palmer@dabbelt.com,
	paul.walmsley@sifive.com, aou@eecs.berkeley.edu,
	herbert@gondor.apana.org.au, davem@davemloft.net,
	conor.dooley@microchip.com, linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
	christoph.muellner@vrull.eu,
	Heiko Stuebner <heiko.stuebner@vrull.eu>
Subject: Re: [PATCH v4 00/12] RISC-V: support some cryptography accelerations
Message-ID: <20231121235109.GE2172@sol.localdomain>
References: <20230711153743.1970625-1-heiko@sntech.de>
 <20230914001144.GA924@sol.localdomain>
 <ZQJdnCwf99Glggin@ghost>
 <3A0F6A71-C521-44A5-A56C-076AF3E13897@gmail.com>
 <DD3113B1-AB9F-4D6D-BD6E-8F75A83DA45D@sifive.com>
 <20231006194741.GA68531@google.com>
 <AB98E114-A8DE-492E-B078-7394EE4FA83E@sifive.com>
 <20231102040333.GC1498@sol.localdomain>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102040333.GC1498@sol.localdomain>

On Wed, Nov 01, 2023 at 09:03:33PM -0700, Eric Biggers wrote:
> > 
> > There is no public assembler supports the vector-crypto asm mnemonics.
> > We should still use `opcode` for vector-crypto instructions. But we might
> > use asm for standard rvv parts.
> > In order to reuse the codes in OpenSSL as much as possible,  we still use
> > the `riscv.pm` for all standard rvv and vector-crypto instructions. If the asm
> > mnemonic is still a better approach,  I will `rewrite` all standard rvv parts
> > with asm mnemonics in next patch.
> 
> Tip-of-tree gcc + binutils seems to support them.  Building some of the sample
> code from the riscv-crypto repository:
> 
>     $ riscv64-linux-gnu-as --version
>     GNU assembler (GNU Binutils) 2.41.50.20231021
>     $ riscv64-linux-gnu-gcc --version
>     riscv64-linux-gnu-gcc (GCC) 14.0.0 20231021 (experimental)
>     $ riscv64-linux-gnu-gcc -march=rv64ivzvkned -c riscv-crypto/doc/vector/code-samples/zvkned.s
> 
> And tip-of-tree clang supports them experimentally:
> 
>     $ clang --version
>     clang version 18.0.0 (https://github.com/llvm/llvm-project 30416f39be326b403e19f23da387009736483119)
>     $ clang -menable-experimental-extensions -target riscv64-linux-gnu -march=rv64ivzvkned1 -c riscv-crypto/doc/vector/code-samples/zvkned.s
> 
> It would be nice to use a real assembler, so that people won't have to worry
> about potential mistakes or inconsistencies in the perl-based "assembler".  Also
> keep in mind that if we allow people to compile this code without the real
> assembler support from the beginning, it might end up staying that way for quite
> a while in order to avoid breaking the build for people.
> 
> Ultimately it's up to you though; I think that you and others who have been
> working on RISC-V crypto can make the best decision about what to do here.  I
> also don't want this patchset to be delayed waiting for other projects, so maybe
> that indeed means the perl-based "assembler" needs to be used for now.
> 

Just wanted to bump up this discussion again.  In binutils, the vector crypto
v1.0.0 support was released 4 months ago in 2.41.  See the NEWS file at
https://sourceware.org/git/gitweb.cgi?p=binutils-gdb.git;a=blob_plain;f=binutils/NEWS;hb=refs/heads/binutils-2_41-branch

    * The RISC-V port now supports the following new standard extensions:
      - Zicond (conditional zero instructions)
      - Zfa (additional floating-point instructions)
      - Zvbb, Zvbc, Zvkg, Zvkned, Zvknh[ab], Zvksed, Zvksh, Zvkn, Zvknc, Zvkng,
        Zvks, Zvksc, Zvkg, Zvkt (vector crypto instructions)

That's every extension listed in the vector crypto v1.0.0 specification
(https://github.com/riscv/riscv-crypto/releases/download/v1.0.0/riscv-crypto-spec-vector.pdf).

LLVM still has the vector crypto extensions marked as "experimental" extensions.
However, there is an open pull request to mark them non-experimental:
https://github.com/llvm/llvm-project/pull/69000

Could we just go ahead and remove riscv.pm, develop with binutils for now, and
prioritize getting the LLVM support finished?

- Eric

