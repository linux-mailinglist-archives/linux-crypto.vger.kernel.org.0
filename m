Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEE491E1AB2
	for <lists+linux-crypto@lfdr.de>; Tue, 26 May 2020 07:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725875AbgEZFXO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 26 May 2020 01:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725771AbgEZFXO (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 26 May 2020 01:23:14 -0400
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de [IPv6:2a01:238:20a:202:5300::7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0449C061A0E
        for <linux-crypto@vger.kernel.org>; Mon, 25 May 2020 22:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1590470591;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=Xcl0FKQh1/awolO9FW1Fnen3cHjGnxEF6WrUAeIL2GE=;
        b=GaBMGlw1bMSu5Uc6q36ySyCi9wLwDSRMi3xwyjb/hyawEdVEEjadYG0vbAkOIHVhRN
        m+leh0OlMrjqVDXzDU0XDgo0yBJop9wQD5/Pz042AJJW5QxgbkIluabmBM+blRRtbbqH
        ZW6QFogStMYnTNq2kt5xlRRBQkogKwz4rUXSqxgcQEJHp1ARNsQcap1DWGs0IwdqhftO
        9nSHwbp890Tum9oeJ/CJVKT8OLbsqj8//64Q/0+dUy58RyIOpDKrfq3uPnyKPPfOrCAh
        WdZBNtG9j9VvRloEALXQ7b06zOYMQ9Dj3drDPIiPpVE9gLZcdC65MI7GeVxN35KvbLjn
        2tiw==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPZIvSfYao+"
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 46.7.0 DYNA|AUTH)
        with ESMTPSA id k09005w4Q5NBV5R
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Tue, 26 May 2020 07:23:11 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     "Bhat, Jayalakshmi Manjunath" <jayalakshmi.bhat@hp.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: Monte Carlo Test (MCT) for AES
Date:   Tue, 26 May 2020 07:23:11 +0200
Message-ID: <5330121.xyrNXEdPSU@tauon.chronox.de>
In-Reply-To: <CS1PR8401MB0646A38BBFAD7FBABE50CBECF6B00@CS1PR8401MB0646.NAMPRD84.PROD.OUTLOOK.COM>
References: <TU4PR8401MB0544BD5EDA39A5E1E3388940F6B40@TU4PR8401MB0544.NAMPRD84.PROD.OUTLOOK.COM> <12555443.uLZWGnKmhe@positron.chronox.de> <CS1PR8401MB0646A38BBFAD7FBABE50CBECF6B00@CS1PR8401MB0646.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Am Dienstag, 26. Mai 2020, 05:07:15 CEST schrieb Bhat, Jayalakshmi Manjunat=
h:

Hi Jayalakshmi,

> Hi Stephen,
>=20
> I to add the backend support using libkcapi APIs to exercise Kernel CAVP.
> Can you please  confirm if my understanding is correct?

You would need to implement an equivalent to backend_openssl.c or=20
backend_nettle.c=20
>=20
> Regards,
> Jaya
>=20
> From: linux-crypto-owner@vger.kernel.org
> <linux-crypto-owner@vger.kernel.org> On Behalf Of Stephan M=FCller Sent:
> Sunday, May 24, 2020 12:14 AM
> To: Bhat, Jayalakshmi Manjunath <jayalakshmi.bhat@hp.com>; Ard Biesheuvel
> <ardb@kernel.org> Cc: linux-crypto@vger.kernel.org
> Subject: Re: Monte Carlo Test (MCT) for AES
>=20
> Am Samstag, 23. Mai 2020, 00:11:35 CEST schrieb Ard Biesheuvel:
>=20
> Hi Ard,
>=20
> > (+ Stephan)
> >=20
> > On Fri, 22 May 2020 at 05:20, Bhat, Jayalakshmi Manjunath
> >=20
> > <mailto:jayalakshmi.bhat@hp.com> wrote:
> > > Hi All,
> > >=20
> > > We are using libkcapi for CAVS vectors verification on our Linux kern=
el.
> > > Our Linux kernel version is 4.14. Monte Carlo Test (MCT) for SHA work=
ed
> > > fine using libkcapi. We are trying to perform Monte Carlo Test (MCT) =
for
> > > AES using libkcapi. We not able to get the result successfully. Is it
> > > possible to use libkcapi to achieve AES MCT?
>=20
> Yes, it is possible. I have the ACVP testing implemented completely for A=
ES
> (ECB, CBC, CFB8, CFB128, CTR, XTS, GCM internal and external IV generatio=
n,
> CCM), TDES (ECB, CTR, CBC), SHA, HMAC, CMAC (AES and TDES). I did not yet
> try TDES CFB8 and CFB64 through, but it should work out of the box.
>=20
> AES-KW is the only one that cannot be tested through libkcapi as AF_ALG h=
as
> one shortcoming preventing this test.
>=20
> The testing is implemented with [1] but the libkcapi test backend is not
> public. The public code in [1] already implements the MCT. So, if you want
> to use [1], all you need to implement is a libkcapi backend that just
> invokes the ciphers as defined by the API in [1].
>=20
> [1] https://github.com/smuellerDD/acvpparser
>=20
> Ciao
> Stephan


Ciao
Stephan


