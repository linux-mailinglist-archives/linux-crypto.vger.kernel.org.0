Return-Path: <linux-crypto+bounces-249-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 115B17F51CA
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Nov 2023 21:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85932B20C58
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Nov 2023 20:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F38171BF
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Nov 2023 20:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="Pb+Z69JI"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33181BF
	for <linux-crypto@vger.kernel.org>; Wed, 22 Nov 2023 11:05:14 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b83fc26e4cso95940b6e.2
        for <linux-crypto@vger.kernel.org>; Wed, 22 Nov 2023 11:05:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1700679914; x=1701284714; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MuJGRVvO4OS7CQfe7JcJEn858y+yVTsL6CvDtncuukM=;
        b=Pb+Z69JITdKpaiJpYB2reWfgbnQSk3xTPBs7xdvwR8D/FFTo5DBEQyvTmhysZTf28Q
         DDf0wtiwH/+t2fd5AD0IYfvpMnhxVhgVS8KErWe0/Iy5qXfMgQluoDQAcNmfUBnnZ27C
         F7m6L2HZc81GA5M8VZlIEG6fFHol1lLJDMXhZmD36Hr3lXYlxQIFnY+7LLe1Pk4Larzd
         EEgjTo4Epx29NjgOwFhHfgBoDBzEeGTSQMXpP+P6bxNiw2DuN4Z+cZX4EkqM7azF1AoX
         qq9c9eigSsNLghgyUnOLwAlIwVbs77jj+xbnZ+p/EMzkqtdXS1eBfXXNY0jNpUBoVTM2
         0/0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700679914; x=1701284714;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MuJGRVvO4OS7CQfe7JcJEn858y+yVTsL6CvDtncuukM=;
        b=F/E/mW5JySgVzen30OQS1HkvZgKhSqu3ChvP4TEZ4cEZ0SptfZxdQmIPdLSRPuwiAv
         DEiUN+J9t/r9917oR2xQtpusBj1NIDQjIwNMoBHszhC1fbUsg/OdvHNaYgl2CY2tKP+v
         vbxGc/JRFurg7wkGO0qQ8mLRz8ezgBuaj4bVjqVAqCv6SbVhsT0opyaQ1er8DdWCCskw
         qAqUDxc/cf2WeaiVhjKDpC19BWtB/vFSs8Qv9zNTXJau0NAkFyhauBUCECv+tilEpHi2
         a/ZPJ8aoWveXeZ9b2c6pBo7D2TW7pIff0vt97hfY0Ye6PdgZ0sdEF+2A0qc0xhhL7FqF
         AgJQ==
X-Gm-Message-State: AOJu0Yx6J623GHchslO3iiAm2ZeyEd3pNjRmDNvmGzQCfaGToSIFDIRY
	IblOcwCWwWUnMb+VXu1N9BBhiA==
X-Google-Smtp-Source: AGHT+IGruwK2GNXmEbQcHsSkn1Aod/UdP0wMp9Y99w3YdMkYQYsKJLfOyZllXsUogOKE0nzb8+4/vg==
X-Received: by 2002:a05:6808:10c6:b0:3a9:bb4f:9efd with SMTP id s6-20020a05680810c600b003a9bb4f9efdmr4439068ois.29.1700679914013;
        Wed, 22 Nov 2023 11:05:14 -0800 (PST)
Received: from ?IPv6:2402:7500:4ce:5a5b:a845:b3e1:8307:922c? ([2402:7500:4ce:5a5b:a845:b3e1:8307:922c])
        by smtp.gmail.com with ESMTPSA id b20-20020a63d314000000b005c215baacc1sm28175pgg.70.2023.11.22.11.05.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Nov 2023 11:05:13 -0800 (PST)
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
In-Reply-To: <20231122-bulldog-deceased-7e3dadf3a833@spud>
Date: Thu, 23 Nov 2023 03:05:08 +0800
Cc: Conor Dooley <conor.dooley@microchip.com>,
 Eric Biggers <ebiggers@kernel.org>,
 Paul Walmsley <paul.walmsley@sifive.com>,
 palmer@dabbelt.com,
 Albert Ou <aou@eecs.berkeley.edu>,
 herbert@gondor.apana.org.au,
 davem@davemloft.net,
 andy.chiu@sifive.com,
 greentime.hu@sifive.com,
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
Message-Id: <EBBC558E-C9FE-4912-BB68-E94624AFD006@sifive.com>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
 <20231025183644.8735-13-jerry.shih@sifive.com>
 <20231102054327.GH1498@sol.localdomain>
 <90E2B1B4-ACC1-4316-81CD-E919D3BD03BA@sifive.com>
 <20231120191856.GA964@sol.localdomain>
 <9724E3A5-F43C-4239-9031-2B33B72C4EF4@sifive.com>
 <20231121-knelt-resource-5d71c9246015@wendy>
 <3BDE7B86-0078-4C77-A383-1C83C88E44DA@sifive.com>
 <20231122-bulldog-deceased-7e3dadf3a833@spud>
To: Conor Dooley <conor@kernel.org>
X-Mailer: Apple Mail (2.3445.9.7)

On Nov 23, 2023, at 02:20, Conor Dooley <conor@kernel.org> wrote:
> On Thu, Nov 23, 2023 at 01:37:33AM +0800, Jerry Shih wrote:
>> On Nov 21, 2023, at 21:14, Conor Dooley <conor.dooley@microchip.com> =
wrote:
>>> On Tue, Nov 21, 2023 at 06:55:07PM +0800, Jerry Shih wrote:
>>>> Sorry, I just use my `internal` qemu with vector-crypto and rva22 =
patches.
>>>>=20
>>>> The public qemu haven't supported rva22 profiles. Here is the qemu =
patch[1] for
>>>> that. But here is the discussion why the qemu doesn't export these
>>>> `named extensions`(e.g. Zicclsm).
>>>> I try to add Zicclsm in DT in the v2 patch set. Maybe we will have =
more discussion
>>>> about the rva22 profiles in kernel DT.
>>>=20
>>> Please do, that'll be fun! Please take some time to read what the
>>> profiles spec actually defines Zicclsm fore before you send those =
patches
>>> though. I think you might come to find you have misunderstood what =
it
>>> means - certainly I did the first time I saw it!
>>=20
>> =46rom the rva22 profile:
>=20
> "rva22" is not a profile. As I pointed out to Eric, this is defined in
> the RVA22U64 profile (and the RVA20U64 one, but that is effectively a
> moot point). The profile descriptions for these only specify "the ISA
> features available to user-mode execution environments", so it is not
> suitable for use in any other context.

I missed that important part: it's for user space.
Thx.

>>  This requires misaligned support for all regular load and store =
instructions (including
>>  scalar and ``vector``)
>>=20
>> The spec includes the explicit `vector` keyword.
>> So, I still think we could use Zicclsm checking for these =
vector-crypto implementations.
>=20
> In userspace, if Zicclsm was exported somewhere, that would be a valid
> argument. Even for userspace, the hwprobe flags probably provide more
> information though, since the firmware emulation is insanely slow.

I agree. It will be more useful to have the flag like =
`VECTOR_MISALIGNED_FAST`
instead.

>> My proposed patch is just a simple patch which only update the DT =
document and
>> update the isa string parser for Zicclsm.
>=20
> Zicclsm has no meaning outside of user mode, so it's not suitable for
> use in that context. Other "features" defined in the profiles spec =
might
> be suitable for inclusion, but it'll be a case-by-case basis.

I will skip the Zicclsm part in my v2 patch.

>> If it's still not recommend to use Zicclsm
>> checking, I will turn to use `RISCV_HWPROBE_MISALIGNED_*` instead.
>=20
> Palmer has commented on the rest, so no need for me :)

All crypto algorithms will assume that the vector supports misaligned =
access in next
v2 patch.
And the algorithms will also not check for `RISCV_HWPROBE_MISALIGNED_*` =
since
it's related to scalar accesses.
Once we have the vector performance related flag, we could go back here =
to use it.

-Jerry


