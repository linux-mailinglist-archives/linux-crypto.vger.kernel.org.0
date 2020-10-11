Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5CED28A6E6
	for <lists+linux-crypto@lfdr.de>; Sun, 11 Oct 2020 12:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbgJKKTT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 11 Oct 2020 06:19:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:47250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727035AbgJKKTS (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 11 Oct 2020 06:19:18 -0400
Received: from localhost (pop.92-184-102-180.mobile.abo.orange.fr [92.184.102.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 95343207F7;
        Sun, 11 Oct 2020 10:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602411558;
        bh=E80FqfqRXRL4++0Ml+FlpdDwAKsno997KrBJ1rNmCSQ=;
        h=In-Reply-To:References:Subject:Cc:To:From:Date:From;
        b=Hmeuo20eDt1ccuObCbtaRLqtUJtZ/RSoYdy9vMnE+wboS/MLVi47ODeEVkxHWZETU
         PUctPHQxfaGFZ0NDz/W7dy/0QLd34JPyCW+a69WPdzSP1cOKFWf60+gOmaVEw8WrO2
         isz6sz/KNqijdMoGBVUkBTqUW/hdC03BmtxdHEaw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20201010164736.12871-1-colin.king@canonical.com>
References: <20201010164736.12871-1-colin.king@canonical.com>
Subject: Re: [PATCH] crypto: inside-secure: Fix sizeof() mismatch
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
To:     "David S . Miller" <davem@davemloft.net>,
        Colin King <colin.king@canonical.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Ofer Heifetz <oferh@marvell.com>, linux-crypto@vger.kernel.org
From:   Antoine Tenart <atenart@kernel.org>
Message-ID: <160241154768.6233.86808650362778908@surface>
Date:   Sun, 11 Oct 2020 12:19:12 +0200
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hello,

Quoting Colin King (2020-10-10 18:47:36)
> From: Colin Ian King <colin.king@canonical.com>
>=20
> An incorrect sizeof() is being used, sizeof(priv->ring[i].rdr_req) is
> not correct, it should be sizeof(*priv->ring[i].rdr_req). Note that
> since the size of ** is the same size as * this is not causing any
> issues.
>=20
> Addresses-Coverity: ("Sizeof not portable (SIZEOF_MISMATCH)")
> Fixes: 9744fec95f06 ("crypto: inside-secure - remove request list to impr=
ove performance")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-by: Antoine Tenart <atenart@kernel.org>

Thanks!
Antoine

> ---
>  drivers/crypto/inside-secure/safexcel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/ins=
ide-secure/safexcel.c
> index eb2418450f12..2e1562108a85 100644
> --- a/drivers/crypto/inside-secure/safexcel.c
> +++ b/drivers/crypto/inside-secure/safexcel.c
> @@ -1639,7 +1639,7 @@ static int safexcel_probe_generic(void *pdev,
> =20
>                 priv->ring[i].rdr_req =3D devm_kcalloc(dev,
>                         EIP197_DEFAULT_RING_SIZE,
> -                       sizeof(priv->ring[i].rdr_req),
> +                       sizeof(*priv->ring[i].rdr_req),
>                         GFP_KERNEL);
>                 if (!priv->ring[i].rdr_req)
>                         return -ENOMEM;
> --=20
> 2.27.0
>=20
