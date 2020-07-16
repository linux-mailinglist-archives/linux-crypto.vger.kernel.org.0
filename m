Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 265B9221D44
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Jul 2020 09:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728281AbgGPHX0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Jul 2020 03:23:26 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:39596 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728277AbgGPHX0 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Jul 2020 03:23:26 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jvyEi-0003S3-Kq; Thu, 16 Jul 2020 17:23:21 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 16 Jul 2020 17:23:20 +1000
Date:   Thu, 16 Jul 2020 17:23:20 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sven Auhagen <sven.auhagen@voleatech.de>
Cc:     linux-crypto@vger.kernel.org, boris.brezillon@free-electrons.com,
        arno@natisbad.org
Subject: Re: [PATCH 1/1] marvell cesa irq balance
Message-ID: <20200716072320.GA28092@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709085329.z6rdmpi3i7yf7b6p@SvensMacBookAir.hq.voleatech.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Sven Auhagen <sven.auhagen@voleatech.de> wrote:
> Balance the irqs of the marvell cesa driver over all
> available cpus.
> Currently all interrupts are handled by the first CPU.
> 
> From my testing with IPSec AES 256 SHA256
> on my clearfog base with 2 Cores I get a 2x speed increase:
> 
> Before the patch: 26.74 Kpps
> With the patch: 56.11 Kpps
> 
> Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
> ---
> drivers/crypto/marvell/cesa/cesa.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/crypto/marvell/cesa/cesa.c b/drivers/crypto/marvell/cesa/cesa.c
> index 8a5f0b0bdf77..bf1bda2e904a 100644
> --- a/drivers/crypto/marvell/cesa/cesa.c
> +++ b/drivers/crypto/marvell/cesa/cesa.c
> @@ -438,7 +438,7 @@ static int mv_cesa_probe(struct platform_device *pdev)
>        struct mv_cesa_dev *cesa;
>        struct mv_cesa_engine *engines;
>        struct resource *res;
> -       int irq, ret, i;
> +       int irq, ret, i, cpu;
>        u32 sram_size;
> 
>        if (cesa_dev) {
> @@ -548,6 +548,10 @@ static int mv_cesa_probe(struct platform_device *pdev)
>                if (ret)
>                        goto err_cleanup;
> 
> +               // Set affinity
> +               cpu = engine->id % num_online_cpus();
> +               irq_set_affinity_hint(irq, get_cpu_mask(cpu));
> +

Same issue as the inside-secure patch.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
