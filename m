Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2CFE27EB0B
	for <lists+linux-crypto@lfdr.de>; Wed, 30 Sep 2020 16:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbgI3OgK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 30 Sep 2020 10:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgI3OgK (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 30 Sep 2020 10:36:10 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119DDC061755;
        Wed, 30 Sep 2020 07:36:10 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id j11so3220891ejk.0;
        Wed, 30 Sep 2020 07:36:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=UyvBbqPAylsOXzoE7eSfTMTzw/jzRB0rwtJKUUhHdlY=;
        b=ESEgjt3xCE2u8z2U0erqEZrfTfvAGlF7S8/x471LhukCaWs9cRIi00bpZMzs6OeWJe
         7qJqyrTv5RIwKbAyEVcQh0QDJT4W2GZoEQiBRXxPnpuddXlufGLTCGYYRITFh8e/AxT0
         BKMZxrxEnLg7c0055t2//8pR2kYamhnffi5DOgyXXg5tRL/dQm5GoYX3S24ShbgObw7r
         gX0ercG3yKXn3CYBZwrqr4g5rvTlzlCGPUNnxMqL43bq00qJ8rihIZuP810J4+CS00FR
         fsQY0zTl3xZvw9HZ+/RxXmnok8GoOl5q+8JtWkF8EbnwB4aV+f6wzxl050kqqC+OzsNH
         yw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=UyvBbqPAylsOXzoE7eSfTMTzw/jzRB0rwtJKUUhHdlY=;
        b=iYG01KugKcVibY7vRiqKZPLYHFgvyoq+m+CYaungIp0ALPm2JPoYQkt8NVeiHKfH0v
         aVwVMItzPQrDP0C4F+CXaSfE11aM6ORgExGZu3AK4IZ8FG3ZwwLO2iIW/e3jzmqr098+
         UZ7+aA/0j8YNjTLWmltc6Ah+jtjy0gM38QhKIuoiJ7heeX2UfZRspgaTaldoJzHzwTL3
         zQRxbnvbDiSeOhjqzb3ECC1AU+UxSEChI8qYQ3lOKbDdH7nZnOd0Y/WLrE0fJJJ3uHt7
         NHDHm70rO4+VPK34RlB3P8R1cBWwVFUWEmpOLT9uklPsPOeyqP2C2X0nJ+mNIvuxFQF+
         CLSw==
X-Gm-Message-State: AOAM531dwnvG+noIgv6j6BMxZmitzweqBtv4ZkVv7cgzisJm36/TQHKO
        EBXCsx+2M2uw0D6KNAXQio0yGgIXZyFD3bqQtro=
X-Google-Smtp-Source: ABdhPJwXDa1PhhObSO8t83CkU406nnzd2eJgOeaMVgaJq1IqzqLp9Li9fphF/lHj326arrP17XMs6XeHWwa6FY6D+Ho=
X-Received: by 2002:a17:906:3aca:: with SMTP id z10mr3057802ejd.419.1601476568734;
 Wed, 30 Sep 2020 07:36:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200930130123.8064-1-colin.king@canonical.com>
In-Reply-To: <20200930130123.8064-1-colin.king@canonical.com>
From:   =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>
Date:   Wed, 30 Sep 2020 16:35:57 +0200
Message-ID: <CAAUqJDuDsgLZ_7i=knqFNkqWJn+G3FqE3Yv=RBLr27mBMJk1Cg@mail.gmail.com>
Subject: Re: [PATCH][next][resend] lib/mpi: fix off-by-one check on index "no"
To:     Colin King <colin.king@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tianjia Zhang <tianjia.zhang@linux.alibaba.com>,
        Waiman Long <longman@redhat.com>,
        kernel-janitors@vger.kernel.org, linux-crypto@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

st 30. 9. 2020 o 15:04 Colin King <colin.king@canonical.com> nap=C3=ADsal(a=
):
>
> From: Colin Ian King <colin.king@canonical.com>
>
> There is an off-by-one range check on the upper limit of
> index "no".  Fix this by changing the > comparison to >=3D

Note that this doesn't completely fix the bug though... (see below)

>
> Addresses-Coverity: ("Out-of-bounds read")
> Fixes: a8ea8bdd9df9 ("lib/mpi: Extend the MPI library")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>
> resend to Cc linux-crypto
>
> ---
>  lib/mpi/mpiutil.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/lib/mpi/mpiutil.c b/lib/mpi/mpiutil.c
> index 3c63710c20c6..632d0a4bf93f 100644
> --- a/lib/mpi/mpiutil.c
> +++ b/lib/mpi/mpiutil.c
> @@ -69,7 +69,7 @@ postcore_initcall(mpi_init);
>   */
>  MPI mpi_const(enum gcry_mpi_constants no)
>  {
> -       if ((int)no < 0 || no > MPI_NUMBER_OF_CONSTANTS)
> +       if ((int)no < 0 || no >=3D MPI_NUMBER_OF_CONSTANTS)
>                 pr_err("MPI: invalid mpi_const selector %d\n", no);

What the code does is it just logs an error if the value is out of
range, but then it happily continues dereferencing the array anyway...
In the original libgcrypt code [1] (which BTW needs this patch, too),
there is log_bug() instead of pr_err(), which doesn't just log the
error, but also abort()'s the program. BUG() would be the correct
kernel equivalent for log_bug(). It seems the whole kernel's MPI
library clone should be re-audited for other instances of pr_*()'s
that should in fact be BUG()'s (or even better, WARN_ONCE()'s with
proper error handling, but that might diverge the code from libgcrypt
too much...).

[1] https://github.com/gpg/libgcrypt/blob/9cd92ebae21900e54cc3d8b607c8ed1af=
bf2eb9b/mpi/mpiutil.c#L773

>         if (!constants[no])
>                 pr_err("MPI: MPI subsystem not initialized\n");
> --
> 2.27.0
>
