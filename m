Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5942F2F722
	for <lists+linux-crypto@lfdr.de>; Thu, 30 May 2019 07:38:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726744AbfE3FiU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 30 May 2019 01:38:20 -0400
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.216]:30298 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3FiU (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 30 May 2019 01:38:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1559194698;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=yV8lw8f6zbb7iuew9TOhzkbGwph9gIV0wc6/nNoPPk4=;
        b=M3vp8yaYf2cu6UoGQ/92HJ2QEjle8SUr5no0K3zkXxfLtFr7gwzvm4/PrJd+E593/6
        LHwHwOORG068qZNckpvvtF2kz76HyquAkdj25LNISXYAGyrBtFzHJ4tWvSbAc0p+qQ7V
        WAZWCmbktQT1cmVmk5VnzLmEiHWd0tBLs17w9puN81k7WF1UVWm8qaehQPZNmPaWDBTp
        tsQnFViDfnaoo+Nh8R6CmzRSnodbVYYbVLCRHSu264fATab5SHSPVfjCzSIQoBI4T8Z5
        0wL/mJtobXaq/b9RxattFoNkpxgHqaBfTzt7WYf2ZLVJahOeBE1eTRNzQtsHTbLoStje
        t5Rg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPbJPSczlti"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 44.18 DYNA|AUTH)
        with ESMTPSA id R0373fv4U5cIyik
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Thu, 30 May 2019 07:38:18 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     Richard Weinberger <richard@nod.at>
Cc:     david <david@sigma-star.at>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Can an ahash driver be used through shash API?
Date:   Thu, 30 May 2019 07:38:17 +0200
Message-ID: <2929069.psKOHZKy1K@tauon.chronox.de>
In-Reply-To: <1331220190.73461.1559161310462.JavaMail.zimbra@nod.at>
References: <729A4150-93A0-456B-B7AB-6D3A446E600E@sigma-star.at> <4256916.YlTHG9RRyR@tauon.chronox.de> <1331220190.73461.1559161310462.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Am Mittwoch, 29. Mai 2019, 22:21:50 CEST schrieb Richard Weinberger:

Hi Richard,

> Stephan,
>=20
> ----- Urspr=FCngliche Mail -----
>=20
> >> I've seen that it does actually work the other way around, since
> >> crypto_init_shash_ops_async() in crypto/shash.c takes care of translat=
ing
> >> calls from ahash to shash and that's how the *-generic drivers are usa=
ble
> >> through the ahash API.
> >=20
> > The crypto_alloc_shash will only identify cipher implementations that w=
ere
> > registered with the CRYPTO_ALG_TYPE_SHASH flag. That flag is set when a
> > cipher is registered using crypto_register_shash.
> >=20
> > Thus, ciphers registered with crypto_register_ahash will not bear this
> > flag
> > and thus will not be found by the allocation function.
>=20
> is there a reason why we don't emulate the synchronous functionality
> in the crypto API layer if a driver implements only the async interface?
>=20
> Or is it just a matter of -ENOPATCH? :)

How can that be done in the first place? SHASH is intended and is used with=
=20
stack variables. An AHASH will have to be expected to sleep inbetween. Thus=
,=20
it cannot be used as SHASH.

Ciao
Stephan


