Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3E0342E44
	for <lists+linux-crypto@lfdr.de>; Sat, 20 Mar 2021 17:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbhCTQRY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 20 Mar 2021 12:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229787AbhCTQRQ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 20 Mar 2021 12:17:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400C9C061574;
        Sat, 20 Mar 2021 09:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        References:Message-ID:In-Reply-To:Subject:cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=N4NO8hc0+T0jY4h6nLD8bMmPoT+/SJOmyVlAlER7H/M=; b=zWTt5V/nuE1N1/cO26LcMPkjWW
        rCQ3eqqM30BAmSVdBgDjiqEdFAx1XTe7kcDM1ke7n9ya/Lpo18ya28U7UW2pgZuccslk7ROm7QBN4
        fp/BKUBAbH3e+PA4LKMchSXSyZ04dMjHXo2gxNE94JXfBkmapjShlBhJEM1bvKY1qgPs4p1pFCBuM
        aCMlvLJH25oDvMjAEP+CrHo37GehHan/COoNmYHZ8JOGfV8/34EUVOy1eY+TtL3EJQqSYrwDyHyOd
        HQUoyZyCXgzKoOaQwuBMJ3VqYLJr6KThO+gLal/XkoGGFsZz/SoJi43rIzHwqgYST3CmknEWXFF7V
        SNpuuY0A==;
Received: from rdunlap (helo=localhost)
        by bombadil.infradead.org with local-esmtp (Exim 4.94 #2 (Red Hat Linux))
        id 1lNeHc-001vg2-3s; Sat, 20 Mar 2021 16:17:01 +0000
Date:   Sat, 20 Mar 2021 09:17:00 -0700 (PDT)
From:   Randy Dunlap <rdunlap@bombadil.infradead.org>
To:     Meng Yu <yumeng18@huawei.com>
cc:     herbert@gondor.apana.org.au, davem@davemloft.net,
        linux-crypto@vger.kernel.org, xuzaibo@huawei.com,
        wangzhou1@hisilicon.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: atmel-ecc - fix W=1 "cannot understand"
 warning
In-Reply-To: <1616228113-15169-1-git-send-email-yumeng18@huawei.com>
Message-ID: <ef7317fa-da8-ec31-c6da-bcda1e8aadc@bombadil.infradead.org>
References: <1616228113-15169-1-git-send-email-yumeng18@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: Randy Dunlap <rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210320_091700_177392_EFE86B4E 
X-CRM114-Status: GOOD (  12.51  )
X-Spam-Score: -0.0 (/)
X-Spam-Report: Spam detection software, running on the system "bombadil.infradead.org",
 has NOT identified this incoming email as spam.  The original
 message has been attached to this so you can view it or label
 similar future email.  If you have any questions, see
 the administrator of that system for details.
 Content preview:  On Sat, 20 Mar 2021, Meng Yu wrote: > Fix kernel-doc warnings
    due to missing "struct" keyword. > > The warning likes: > drivers/crypto/atmel-ecc.c:40:
    warning: cannot understand function prototype: 'struct atmel_ecdh_ctx ' >
    > Signed-of [...] 
 Content analysis details:   (-0.0 points, 5.0 required)
  pts rule name              description
 ---- ---------------------- --------------------------------------------------
 -0.0 NO_RELAYS              Informational: message was not relayed via SMTP
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



On Sat, 20 Mar 2021, Meng Yu wrote:

> Fix kernel-doc warnings due to missing "struct" keyword.
>
> The warning likes:
> drivers/crypto/atmel-ecc.c:40: warning: cannot understand function prototype: 'struct atmel_ecdh_ctx '
>
> Signed-off-by: Meng Yu <yumeng18@huawei.com>

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
> drivers/crypto/atmel-ecc.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/crypto/atmel-ecc.c b/drivers/crypto/atmel-ecc.c
> index 515946c..333fbef 100644
> --- a/drivers/crypto/atmel-ecc.c
> +++ b/drivers/crypto/atmel-ecc.c
> @@ -26,7 +26,7 @@
> static struct atmel_ecc_driver_data driver_data;
>
> /**
> - * atmel_ecdh_ctx - transformation context
> + * struct atmel_ecdh_ctx - transformation context
>  * @client     : pointer to i2c client device
>  * @fallback   : used for unsupported curves or when user wants to use its own
>  *               private key.
> -- 
> 2.8.1
>
>
