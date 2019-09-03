Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFE1A5EDF
	for <lists+linux-crypto@lfdr.de>; Tue,  3 Sep 2019 03:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725854AbfICBdA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 2 Sep 2019 21:33:00 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38014 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbfICBc7 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 2 Sep 2019 21:32:59 -0400
Received: by mail-wr1-f68.google.com with SMTP id l11so6759232wrx.5
        for <linux-crypto@vger.kernel.org>; Mon, 02 Sep 2019 18:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uFS2gOcYr8n/ORpATsI1tuRB3yF1KuNhjqNeg1CIjrE=;
        b=R1Lpt51wO+GzINS3yWChj0BXJMJqkMP9mu6bSaU5xh7eK2U7gKQYnWPZixECbB7E2z
         Qf0Rd22TO25rNh/j6ZmaqL3NQXKxSydxgAZClM6F4+xFQzMurJ4pR08CINMOu9KE0wby
         +U9N+RQHPY9nCCjZ+/t65IkRtr18tQ+0Vg1jpCk5xIRu2cBgBut9+qtvZ3U1MXykbeIJ
         +La4378jP6SneFiirqWrq/MI8Xfeq2Px3oyDErIsGA7P08U2ETtUMZDeO5MrkM1lZ+ye
         Wm/kjvarMmzB572BllROeT5Zd+d9r989UwjmNkmxE/pQRLfjeHx2tHRYJQSgobS9URj/
         eVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uFS2gOcYr8n/ORpATsI1tuRB3yF1KuNhjqNeg1CIjrE=;
        b=ry4C3NR5RtquIkzbv95Ni4oqXG0q6z1UMLOAyxuwCYm7iswHZUgNuD682SNkt2KsYS
         UreQfMNDFrDnNrPvGis+Bbyvnbhdzvz1P4/puM30JK/fCHS2SshRwCx4FNK0j+FuwqiV
         23wPx36FhAJYOsx1esCX0e/58wZHNRI5tf0gulfMXxj3W4qxvIwISdfifaQhzwjtpR5n
         n97oCQmzPKiuZBpGg4PrUvTOzjKbowFvea1gkKMzbJsQQ2UYVzMK3TxWJ2U76fDj7ndr
         WD7s05uWH1gfVIrIrAefDLhOwfo9IvllmrCDWKTLxjhFpJMRado3RxkvBdJf3kTwKy4A
         cSJw==
X-Gm-Message-State: APjAAAUpKlVTt77G0PFX+7g2krCYHFS0CVIWBLb8t+xWwiy9qlpLDXn4
        4SjsGwlup9/+y+G7X57kgCmiR57eUs/FPFVUdJE88A==
X-Google-Smtp-Source: APXvYqywEhSAzEzmZtouqsNLkCC21lslmkYtGd0pJB5YXkRwe5tytIQ1eMiVj7rGRvIQoLguHC7TQ2mmRCWTSeERGPw=
X-Received: by 2002:a05:6000:128d:: with SMTP id f13mr40375615wrx.241.1567474377709;
 Mon, 02 Sep 2019 18:32:57 -0700 (PDT)
MIME-Version: 1.0
References: <20190902141910.1080-1-yuehaibing@huawei.com>
In-Reply-To: <20190902141910.1080-1-yuehaibing@huawei.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 2 Sep 2019 18:32:45 -0700
Message-ID: <CAKv+Gu-KFp13gnx=cnVRrU4_sD8qLLXFcTOK8zuc7MC+B+GmcQ@mail.gmail.com>
Subject: Re: [PATCH -next] crypto: inside-secure - Fix build error without CONFIG_PCI
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Pascal Van Leeuwen <pvanleeuwen@insidesecure.com>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, 2 Sep 2019 at 07:19, YueHaibing <yuehaibing@huawei.com> wrote:
>
> If CONFIG_PCI is not set, building fails:
>
> rivers/crypto/inside-secure/safexcel.c: In function safexcel_request_ring_irq:
> drivers/crypto/inside-secure/safexcel.c:944:9: error: implicit declaration of function pci_irq_vector;
>  did you mean rcu_irq_enter? [-Werror=implicit-function-declaration]
>    irq = pci_irq_vector(pci_pdev, irqid);
>          ^~~~~~~~~~~~~~
>
> Use #ifdef block to guard this.
>
> Fixes: 625f269a5a7a ("crypto: inside-secure - add support for PCI based FPGA development board")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/crypto/inside-secure/safexcel.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/crypto/inside-secure/safexcel.c b/drivers/crypto/inside-secure/safexcel.c
> index e12a2a3..c23fe34 100644
> --- a/drivers/crypto/inside-secure/safexcel.c
> +++ b/drivers/crypto/inside-secure/safexcel.c
> @@ -937,7 +937,8 @@ static int safexcel_request_ring_irq(void *pdev, int irqid,
>         int ret, irq;
>         struct device *dev;
>
> -       if (IS_ENABLED(CONFIG_PCI) && is_pci_dev) {
> +#if IS_ENABLED(CONFIG_PCI)

please don't use IS_ENABLED() with preprocessor conditionals - just
use #ifdef CONFIG_PCI instead

> +       if (is_pci_dev) {
>                 struct pci_dev *pci_pdev = pdev;
>
>                 dev = &pci_pdev->dev;
> @@ -947,7 +948,10 @@ static int safexcel_request_ring_irq(void *pdev, int irqid,
>                                 irqid, irq);
>                         return irq;
>                 }
> -       } else if (IS_ENABLED(CONFIG_OF)) {
> +       } else
> +#endif
> +       {
> +#if IS_ENABLED(CONFIG_OF)
>                 struct platform_device *plf_pdev = pdev;
>                 char irq_name[6] = {0}; /* "ringX\0" */
>
> @@ -960,6 +964,7 @@ static int safexcel_request_ring_irq(void *pdev, int irqid,
>                                 irq_name, irq);
>                         return irq;
>                 }
> +#endif
>         }
>
>         ret = devm_request_threaded_irq(dev, irq, handler,
> @@ -1137,7 +1142,8 @@ static int safexcel_probe_generic(void *pdev,
>
>         safexcel_configure(priv);
>
> -       if (IS_ENABLED(CONFIG_PCI) && priv->version == EIP197_DEVBRD) {
> +#if IS_ENABLED(CONFIG_PCI)
> +       if (priv->version == EIP197_DEVBRD) {
>                 /*
>                  * Request MSI vectors for global + 1 per ring -
>                  * or just 1 for older dev images
> @@ -1153,6 +1159,7 @@ static int safexcel_probe_generic(void *pdev,
>                         return ret;
>                 }
>         }
> +#endif
>
>         /* Register the ring IRQ handlers and configure the rings */
>         priv->ring = devm_kcalloc(dev, priv->config.rings,
> --
> 2.7.4
>
>
