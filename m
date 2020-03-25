Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2FD019299B
	for <lists+linux-crypto@lfdr.de>; Wed, 25 Mar 2020 14:27:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgCYN1r (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 25 Mar 2020 09:27:47 -0400
Received: from foss.arm.com ([217.140.110.172]:48386 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726969AbgCYN1q (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 25 Mar 2020 09:27:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2112231B;
        Wed, 25 Mar 2020 06:27:46 -0700 (PDT)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 970693F71F;
        Wed, 25 Mar 2020 06:27:45 -0700 (PDT)
Date:   Wed, 25 Mar 2020 13:27:44 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 0/3] arm64: Open code .arch_extension
Message-ID: <20200325132744.GF4346@sirena.org.uk>
References: <20200325114110.23491-1-broonie@kernel.org>
 <20200325123157.GA12236@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
Content-Disposition: inline
In-Reply-To: <20200325123157.GA12236@lakrids.cambridge.arm.com>
X-Cookie: Many are called, few volunteer.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2020 at 12:31:59PM +0000, Mark Rutland wrote:

> Is there anything akin to push/pop versions of .arch directitves that we
> can use around the BTI instructions specifically?

Not that I can see.

> ... or could we encode the BTI instructions with a .inst, and wrap those
> in macros so that GAS won't complain (like we do for mrs_s and friends)?

That should work, I think it's a taste thing which is better.  For me
it was a combination of there being a small number of files that were
affected, the fact that even within that small set there was divergence
in how they were doing this and the fact that neither solution is a
thing of great beauty. =20

> ... does asking GCC to use BTI for C code make the default arch v8.5 for
> inline asm, or does it do something special to allow BTI instructions in
> specific locations?

This is only an issue for freestanding assembly files as far as I can
see.

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl57XE8ACgkQJNaLcl1U
h9CH+Qf/cVtVIeViDEeMMgOcmLIGjPf9g50RGv3RqWsX87KPK/LskAvSqQnlk0Ey
z3yiBytux5zOpw6Dh4qjX/neqRYHkzT8zmlSoaBMHk+bVhOOxlcFW3Wl8s5Ij+AP
T78PYxA8mFdSXQ645R/gANtXpri9EhjS9FEh5eDFayCI+6CyZDPxsjytVpHzVCgV
sFUndZ4gSBQGzvYqw3m88g2pbqRkXBWEd1Y48AwuBNnXPDOeyh4OOq663loBomdF
qCMv2lBTOZ0c6gt6Tdnq4Dljqixzp2BWPEs4OFsiOxzBrmGGX53Qsk5vrLgxFJJX
ghlf2ejrD4j1r8/K5xu2kuhH02XkJg==
=gSyn
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--
