Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512227D998A
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Oct 2023 15:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345933AbjJ0NRO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 27 Oct 2023 09:17:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345897AbjJ0NRE (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 27 Oct 2023 09:17:04 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41A05C2
        for <linux-crypto@vger.kernel.org>; Fri, 27 Oct 2023 06:17:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8038C433C8;
        Fri, 27 Oct 2023 13:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698412621;
        bh=/P6ZS4aw2e2YDKjeUn7L6BiFoz6/FtSV6EkBIknlpZM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IBX+P4nnHHxIA+wemqFqlV35cy73Kgqt29R+tPmEvRUaxubU2/5iU6zr3vT7jwuyJ
         cSHhB5AW/NFS/lWGg7FfHvraFDpuJ2Xk56Jom2AWliOZN+qaiBooQOZMBl5WtatYQZ
         cN6X74CXqe8MKov8u2hctKaklP6FYNLM02gNekLZkAay6EumEkhO/xI6DQN8hdxlZo
         Medkqm31LsHFbQRAI3mFTwY4nyp1nJX7vR7cAyJzjGiaiYV5AJ/kGA5YFwQPGCLC8r
         lmxccRhOzovNVO8eq4eQyfvkHCxxgZz2cQ+6oTo6xKFyYYVmT31zr1nFe1po8lpXXR
         Z77LKPUOjxd4A==
Date:   Fri, 27 Oct 2023 14:16:57 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, herbert@gondor.apana.org.au,
        linux-crypto@vger.kernel.org, ebiggers@kernel.org,
        linux-riscv@lists.infradead.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, christoph.muellner@vrull.eu,
        heiko.stuebner@vrull.eu
Subject: Re: [PATCH] crypto: riscv/aes - Implement scalar Zkn version for RV32
Message-ID: <20231027-stage-cable-022844c2567d@spud>
References: <CAMj1kXF0e+MKyDJPS7r=LWusEBCaw=t03JC=+Dz0Qk+GmY+uXw@mail.gmail.com>
 <mhng-ff1fe914-36e9-42e8-88ac-44c7f6976e3d@palmer-ri-x1c9>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Vkf5hIo4G8sPXGBA"
Content-Disposition: inline
In-Reply-To: <mhng-ff1fe914-36e9-42e8-88ac-44c7f6976e3d@palmer-ri-x1c9>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org


--Vkf5hIo4G8sPXGBA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2023 at 06:11:40AM -0700, Palmer Dabbelt wrote:
> On Thu, 31 Aug 2023 10:10:21 PDT (-0700), Ard Biesheuvel wrote:
> > On Fri, 4 Aug 2023 at 10:31, Ard Biesheuvel <ardb@kernel.org> wrote:
> > >=20
> > > On Fri, 4 Aug 2023 at 10:21, Herbert Xu <herbert@gondor.apana.org.au>=
 wrote:
> > > >
> > ...
> >=20
> > > > Hi Ard:
> > > >
> > > > Any chance you could postpone this til after I've finished removing
> > > > crypto_cipher?
> > > >
> > >=20
> > > That's fine with me. Do you have an ETA on that? Need any help?
> > >=20
> > > I have implemented the scalar 64-bit counterpart as well in the mean =
time
> >=20
> > Is this still happening?
>=20
> I don't really know much about the crypto stuff, but looks like there's
> still a "struct crypto_cipher" in my trees.  Am I still supposed to be
> waiting on something?

Regardless of crypto_cipher structs, this needs whatever series that
actually implements Zkn detection from DT/ACPI to be merged first,
as otherwise the definitions that iscv_isa_extension_available() depends
on don't exist.

>=20
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
>=20
> In case it's eaiser to take this via some other tree.
>=20
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

--Vkf5hIo4G8sPXGBA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZTu4SQAKCRB4tDGHoIJi
0pLxAQCRFpt/XoFW+XAJHFi+jUDbTYXQm3UWTNXYMP0DlFb2LwD9HTFI+Q0K5nOI
N1pMiBxM+e/Fb+ECNSlITbgK2dnaXgY=
=aCNj
-----END PGP SIGNATURE-----

--Vkf5hIo4G8sPXGBA--
