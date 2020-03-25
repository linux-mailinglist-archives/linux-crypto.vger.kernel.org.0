Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35680192784
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Mar 2020 12:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgCYLul (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 25 Mar 2020 07:50:41 -0400
Received: from foss.arm.com ([217.140.110.172]:47348 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726313AbgCYLul (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 25 Mar 2020 07:50:41 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E24F531B;
        Wed, 25 Mar 2020 04:50:40 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6749E3F71F;
        Wed, 25 Mar 2020 04:50:40 -0700 (PDT)
Date:   Wed, 25 Mar 2020 11:50:38 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 0/3] arm64: Open code .arch_extension
Message-ID: <20200325115038.GD4346@sirena.org.uk>
References: <20200325114110.23491-1-broonie@kernel.org>
 <CAMj1kXH=g5N4ZtnZeX5N8hf9cnWVam4Htnov6qAmQwD58Wp73Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q9KOos5vDmpwPx9o"
Content-Disposition: inline
In-Reply-To: <CAMj1kXH=g5N4ZtnZeX5N8hf9cnWVam4Htnov6qAmQwD58Wp73Q@mail.gmail.com>
X-Cookie: Many are called, few volunteer.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org


--q9KOos5vDmpwPx9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 25, 2020 at 12:45:11PM +0100, Ard Biesheuvel wrote:

> I don't think this is the right fix. What is wrong with keeping these
> .cpu and .arch directives in the .S files, and simply make
> SYM_FUNC_START() expand to something that includes .arch_extension pac
> or .arch_extension bti when needed? That way, we only use
> .arch_extension when we know the assembler supports it (given that
> .arch_extension support itself should predate BTI or PAC support in
> GAS or Clang)

Since BTI is a mandatory feature of v8.5 there is no BTI arch_extension,
you can only enable it by moving the base architecture to v8.5.  You'd
need to use .arch and that feels likely to find us sharp edges to run
into.

--q9KOos5vDmpwPx9o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl57RY4ACgkQJNaLcl1U
h9B4nAf/b0wrr0PHBnZoPNzDbKQzFypQ+2NB2THqSpE2/cZCN52CnW3RN6ggAwoA
vNECz/I+gVLH4zOCZpMmjORtGpsmprWMUDiRg3Vx4HrxGq603RDDSBFI798+FXP6
C3CsnSt7pq1V4/zY3o85ySAG9KkrY4/xqKkorJiMs7p8P88lTabA/+VFab3Mte+k
iOYR1QljlMw6Dpq7wvlADO8TZnzYN1JTeWQWSZar2M2rmh+DJ92EYDo0ucOb279I
tBZUOVdwrClveUi3fpAFX050nMHKh7x20S+Guu9u8EnX5bGRS/CoXh2GsJD/dAJk
6ZIgAoRDtg1VMIH3eWV5H3U7/sA4iA==
=paWp
-----END PGP SIGNATURE-----

--q9KOos5vDmpwPx9o--
