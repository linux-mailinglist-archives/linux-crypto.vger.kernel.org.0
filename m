Return-Path: <linux-crypto+bounces-223-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23EBD7F315D
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Nov 2023 15:45:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 545C01C20908
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Nov 2023 14:45:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1ACE54FAD
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Nov 2023 14:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="jJND9ivi"
X-Original-To: linux-crypto@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA4AF1A1;
	Tue, 21 Nov 2023 05:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1700572549; x=1732108549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dKe1oiD9X8ZrNYYlEcv1sT0fNffaLYL7IdmhxeRP7V8=;
  b=jJND9iviczFQ/Q/InQOJIuEHO943uk532m8keMhb9fq/F+V8/13BzEeE
   AIz5vK8Njxlf8CZpcsCN1sLCFTHIq86taoNeDVcl9Uyux5/qGb1LXkWh1
   mV6AFdhR7o+k/nvkWGWsQghqYvPJWexG0fdzeKLmL1rkxHYkLDfZwSHUc
   5h/Df+6glJimCHsVf7DABQFKplEI/z3IMzSYaJ0BHLxlfBgJCDs22DbE2
   B1PoMmey4ZbA+8EOgez+2aWeM9tByAkVkWkzbe5IVqoolIepxKmfcelVM
   y8hVTlFiG9gKNEeFsmVig4XDXPURKTwb27StxVGrmGpvuwQt6pTlbrJJw
   Q==;
X-CSE-ConnectionGUID: 7RKlFjUZS0C2mOVLDV6Cog==
X-CSE-MsgGUID: TCilXAtDSmaRejXBZO/DsQ==
X-ThreatScanner-Verdict: Negative
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="asc'?scan'208";a="12316433"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 21 Nov 2023 06:15:48 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Tue, 21 Nov 2023 06:15:18 -0700
Received: from wendy (10.10.85.11) by chn-vm-ex02.mchp-main.com (10.10.85.144)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Tue, 21 Nov 2023 06:15:15 -0700
Date: Tue, 21 Nov 2023 13:14:47 +0000
From: Conor Dooley <conor.dooley@microchip.com>
To: Jerry Shih <jerry.shih@sifive.com>
CC: Eric Biggers <ebiggers@kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <andy.chiu@sifive.com>, <greentime.hu@sifive.com>,
	<guoren@kernel.org>, <bjorn@rivosinc.com>, <heiko@sntech.de>,
	<ardb@kernel.org>, <phoebe.chen@sifive.com>, <hongrong.hsu@sifive.com>,
	<linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 12/12] RISC-V: crypto: add Zvkb accelerated ChaCha20
 implementation
Message-ID: <20231121-knelt-resource-5d71c9246015@wendy>
References: <20231025183644.8735-1-jerry.shih@sifive.com>
 <20231025183644.8735-13-jerry.shih@sifive.com>
 <20231102054327.GH1498@sol.localdomain>
 <90E2B1B4-ACC1-4316-81CD-E919D3BD03BA@sifive.com>
 <20231120191856.GA964@sol.localdomain>
 <9724E3A5-F43C-4239-9031-2B33B72C4EF4@sifive.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FNeg8t0GItiNFb8F"
Content-Disposition: inline
In-Reply-To: <9724E3A5-F43C-4239-9031-2B33B72C4EF4@sifive.com>

--FNeg8t0GItiNFb8F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 06:55:07PM +0800, Jerry Shih wrote:
> On Nov 21, 2023, at 03:18, Eric Biggers <ebiggers@kernel.org> wrote:
> > First, I can see your updated patchset at branch
> > "dev/jerrys/vector-crypto-upstream-v2" of https://github.com/JerryShih/=
linux,
> > but I haven't seen it on the mailing list yet.  Are you planning to sen=
d it out?
>=20
> I will send it out soon.
>=20
> > Second, with your updated patchset, I'm not seeing any of the RISC-V op=
timized
> > algorithms be registered when I boot the kernel in QEMU.  This is cause=
d by the
> > new check 'riscv_isa_extension_available(NULL, ZICCLSM)' not passing.  =
Is
> > checking for "Zicclsm" the correct way to determine whether unaligned m=
emory
> > accesses are supported?
> >=20
> > I'm using 'qemu-system-riscv64 -cpu max -machine virt', with the very l=
atest
> > QEMU commit (af9264da80073435), so it should have all the CPU features.
> >=20
> > - Eric
>=20
> Sorry, I just use my `internal` qemu with vector-crypto and rva22 patches.
>=20
> The public qemu haven't supported rva22 profiles. Here is the qemu patch[=
1] for
> that. But here is the discussion why the qemu doesn't export these
> `named extensions`(e.g. Zicclsm).
> I try to add Zicclsm in DT in the v2 patch set. Maybe we will have more d=
iscussion
> about the rva22 profiles in kernel DT.

Please do, that'll be fun! Please take some time to read what the
profiles spec actually defines Zicclsm fore before you send those patches
though. I think you might come to find you have misunderstood what it
means - certainly I did the first time I saw it!

> [1]
> LINK: https://lore.kernel.org/all/d1d6f2dc-55b2-4dce-a48a-4afbbf6df526@ve=
ntanamicro.com/#t
>=20
> I don't know whether it's a good practice to check unaligned access using
> `Zicclsm`.=20
>=20
> Here is another related cpu feature for unaligned access:
> RISCV_HWPROBE_MISALIGNED_*
> But it looks like it always be initialized with `RISCV_HWPROBE_MISALIGNED=
_SLOW`[2].
> It implies that linux kernel always supports unaligned access. But we hav=
e the
> actual HW which doesn't support unaligned access for vector unit.

https://docs.kernel.org/arch/riscv/uabi.html#misaligned-accesses

Misaligned accesses are part of the user ABI & the hwprobe stuff for
that allows userspace to figure out whether they're fast (likely
implemented in hardware), slow (likely emulated in firmware) or emulated
in the kernel.

Cheers,
Conor.

>=20
> [2]
> LINK: https://github.com/torvalds/linux/blob/98b1cc82c4affc16f5598d4fa14b=
1858671b2263/arch/riscv/kernel/cpufeature.c#L575
>=20
> I will still use `Zicclsm` checking in this stage for reviewing. And I wi=
ll create qemu
> branch with Zicclsm enabled feature for testing.
>=20
> -Jerry

--FNeg8t0GItiNFb8F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVytRwAKCRB4tDGHoIJi
0viAAQCm6torPYuop5E8J3sRPB3YDXMGHN9Gh2sazUdwj0zlUwEAxM05T+vdP99R
n2EWjF1PVPMc7VvyvoGGBnXDNYZ8GQE=
=cEix
-----END PGP SIGNATURE-----

--FNeg8t0GItiNFb8F--

