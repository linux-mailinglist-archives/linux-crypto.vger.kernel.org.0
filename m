Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3308395DC6
	for <lists+linux-crypto@lfdr.de>; Tue, 20 Aug 2019 13:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729827AbfHTLtF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 20 Aug 2019 07:49:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:48506 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729421AbfHTLtF (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 20 Aug 2019 07:49:05 -0400
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9112A22DCC;
        Tue, 20 Aug 2019 11:49:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566301743;
        bh=0KpTsWcb0dkbJwJinibwYWvwKro8mAVjXeRX97ogQbM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Gpj26vqTLPqEOtmRR10zSDqrgy7WXts9oCk3/mtPnsWYCAzHKA/Bl2RCclCpQQ2uS
         zja0eu6CRV/O2iIAUJZyXapDkC1IBqcopJPrkUH8MBrxNTPOYqLWKAyiCC24V4X8ae
         8WKQmSOK1HvliQtn+Ms4X89Mtd0kpaXuzyzaATrQ=
Received: by mail-lf1-f52.google.com with SMTP id j17so3880584lfp.3;
        Tue, 20 Aug 2019 04:49:03 -0700 (PDT)
X-Gm-Message-State: APjAAAUhiaFFWz+6xr6ijYaR5s4U9txghMf4oqU52rQvxpo0FFdiL+8N
        K5BSrcZEQXC6Zu7Ly3R0UfKuDx8+T/ueUb9jEs0=
X-Google-Smtp-Source: APXvYqwWlroCLQX/9oQKDS0Vidu3cpVwx1AEFjiXbpFKBey6ch7OyOqN5DywvMAOA/x0Wn9PfsLBWDdYP3E3dnJrZs0=
X-Received: by 2002:ac2:44ac:: with SMTP id c12mr7436815lfm.33.1566301741719;
 Tue, 20 Aug 2019 04:49:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190819142226.1703-1-ard.biesheuvel@linaro.org>
 <20190819142226.1703-3-ard.biesheuvel@linaro.org> <CGME20190820102425epcas2p219b7cac45290fbc87bb62bf446fec345@epcas2p2.samsung.com>
 <CAJKOXPevJjBuRJjUX=6BfuMZSLUyqP3fpi7_eWDF170RfPvL+g@mail.gmail.com> <1f932022-0335-1d00-b651-83c82d77fa7a@partner.samsung.com>
In-Reply-To: <1f932022-0335-1d00-b651-83c82d77fa7a@partner.samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Tue, 20 Aug 2019 13:48:50 +0200
X-Gmail-Original-Message-ID: <CAJKOXPfR_L4z=sE8ETUB3_6sVV=ab=vntqh-_KvNmsKacEa4qQ@mail.gmail.com>
Message-ID: <CAJKOXPfR_L4z=sE8ETUB3_6sVV=ab=vntqh-_KvNmsKacEa4qQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] crypto: s5p - use correct block size of 1 for ctr(aes)
To:     Kamil Konieczny <k.konieczny@partner.samsung.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org, herbert@gondor.apana.org.au,
        Vladimir Zapolskiy <vz@mleia.com>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, 20 Aug 2019 at 13:39, Kamil Konieczny
<k.konieczny@partner.samsung.com> wrote:
>
>
>
> On 20.08.2019 12:24, Krzysztof Kozlowski wrote:
> > On Mon, 19 Aug 2019 at 16:24, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >>
> >> Align the s5p ctr(aes) implementation with other implementations
> >> of the same mode, by setting the block size to 1.
> >>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>  drivers/crypto/s5p-sss.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/crypto/s5p-sss.c b/drivers/crypto/s5p-sss.c
> >> index ef90c58edb1f..010f1bb20dad 100644
> >> --- a/drivers/crypto/s5p-sss.c
> >> +++ b/drivers/crypto/s5p-sss.c
> >> @@ -2173,7 +2173,7 @@ static struct crypto_alg algs[] = {
> >>                 .cra_flags              = CRYPTO_ALG_TYPE_ABLKCIPHER |
> >>                                           CRYPTO_ALG_ASYNC |
> >>                                           CRYPTO_ALG_KERN_DRIVER_ONLY,
> >> -               .cra_blocksize          = AES_BLOCK_SIZE,
> >> +               .cra_blocksize          = 1,
> >
> > This makes sense but I wonder how does it work later with
> > s5p_aes_crypt() and its check for request length alignment
> > (AES_BLOCK_SIZE). With block size of 1 byte, I understand that
> > req->nbytes can be for example 4 bytes which is not AES block
> > aligned... If my reasoning is correct, then the CTR mode in s5p-sss is
> > not fully working.
>
> As I remember this case there are allocated buffers with len aligned up
> AES_BLOCK_SIZE, source data copy to one buf, hw encrypts full block,
> then nbytes are copy back.

Buffer alignment is different thing and it is defined in cra_alignmask.
I am talking about req->nbytes which should be aligned according to
s5p_aes_crypt(). But if blocksize is 1 byte, then what possible values
for req->nbytes?

Best regards,
Krzysztof
