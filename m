Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67968AD808
	for <lists+linux-crypto@lfdr.de>; Mon,  9 Sep 2019 13:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbfIILim (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 9 Sep 2019 07:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:42588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730796AbfIILim (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 9 Sep 2019 07:38:42 -0400
Received: from localhost (lfbn-1-17395-211.w86-250.abo.wanadoo.fr [86.250.200.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 370F0218AF;
        Mon,  9 Sep 2019 11:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568029120;
        bh=UFMbefcfELrImJjjjp+pNPWcwhOYfso5uA4l6+5knIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=prBQv/ZJp7aZE+3gbBs22/CNQV5h2Eeo/yPAwPFclBs1NnaQhNTTYJ4Zqyvv8oDVT
         Rh3RIrHQqCeVxXwSDBb1yS8+7Q71tmyxEHXazjRU8mR/D/6T2ZuEctuGc6daeQCdCU
         gIS5iVt0ukD3ZhRzgA9X14ExdtRmtkTuKSzxPUIE=
Date:   Mon, 9 Sep 2019 13:38:37 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     davem@davemloft.net, herbert@gondor.apana.org.au,
        linux@armlinux.org.uk, mark.rutland@arm.com, robh+dt@kernel.org,
        wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 2/9] crypto: Add Allwinner sun8i-ce Crypto Engine
Message-ID: <20190909113837.vrnqdfgzhsiymfpm@flea>
References: <20190906184551.17858-1-clabbe.montjoie@gmail.com>
 <20190906184551.17858-3-clabbe.montjoie@gmail.com>
 <20190907081951.v2huvhm44jfprfop@flea>
 <20190907190408.GE2628@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190907190408.GE2628@Red>
User-Agent: NeoMutt/20180716
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Sep 07, 2019 at 09:04:08PM +0200, Corentin Labbe wrote:
> > Also, I'm not sure what is the point of having the clocks names be
> > parameters there as well. It's constant across all the compatibles,
> > the only thing that isn't is the number of clocks and the module clock
> > rate. It's what you should have in there.
>
> Since the datasheet give some max frequency, I think I will add a
> max_freq and add a check to verify if the clock is in the right
> range

It's a bit pointless. What are you going to do if it's not correct?
What are you trying to fix / report with this?

> > > +		}
> > > +};
> > > +
> > > +static const struct ce_variant ce_h5_variant = {
> > > +	.alg_cipher = { CE_ID_NOTSUPP, CE_ALG_AES, CE_ALG_DES, CE_ALG_3DES,
> > > +		CE_ID_NOTSUPP,
> > > +	},
> > > +	.op_mode = { CE_ID_NOTSUPP, CE_OP_ECB, CE_OP_CBC
> > > +	},
> > > +	.intreg = CE_ISR,
> > > +	.maxflow = 4,
> > > +	.ce_clks = {
> > > +		{ "ahb", 200000000 },
> > > +		{ "mod", 300000000 },
> > > +		}
> > > +};
> > > +
> > > +static const struct ce_variant ce_h6_variant = {
> > > +	.alg_cipher = { CE_ID_NOTSUPP, CE_ALG_AES, CE_ALG_DES, CE_ALG_3DES,
> > > +		CE_ALG_RAES,
> > > +	},
> > > +	.op_mode = { CE_ID_NOTSUPP, CE_OP_ECB, CE_OP_CBC
> > > +	},
> > > +	.model = CE_v2,
> >
> > Can't that be derived from the version register and / or the
> > compatible? This seems to be redundant with each.
>
> I could use the compatible, but I want to avoid a string comparison
> on each request.

Well, this is specifically what this structure is for then, right? So
instead of having the model, just add the information that you want
there.

> > > +int sun8i_ce_get_engine_number(struct sun8i_ce_dev *ce)
> > > +{
> > > +	return atomic_inc_return(&ce->flow) % ce->variant->maxflow;
> > > +}
> >
> > I'm not sure what this is supposed to be doing, but that mod there
> > seems pretty dangerous.
> >
> > ...
>
> This mod do a round robin on each channel.
> I dont see why it is dangerous.

Well, you're using the atomic API here which is most commonly used for
refcounting, while you're using a mod.

Plus, while the increment is atomic, the modulo isn't, so you can end
up in a case where you would be preempted between the
atomic_inc_return and the mod, which is dangerous.

Again, I'm not sure what this function is doing (which is also a
problem in itself). I guess you should just make it clearer what it
does, and then we can discuss it properly.

> > > +			err = clk_set_rate(ce->ceclks[i], ce->variant->ce_clks[i].freq);
> > > +			if (err)
> > > +				dev_err(&pdev->dev, "Fail to set %s clk speed to %lu\n",
> > > +					ce->variant->ce_clks[i].name,
> > > +					ce->variant->ce_clks[i].freq);
> > > +		} else {
> > > +			dev_info(&pdev->dev, "%s run at %lu\n",
> > > +				 ce->variant->ce_clks[i].name, cr);
> >
> > Ditto.
> >
> > > +		}
> > > +		err = clk_prepare_enable(ce->ceclks[i]);
> >
> > Do you really need this right now though?
>
> Not sure to understand, why I shouldnt do it now ?
> Does it is related to your pm_runtime remark below ?
>
> My feeling was to submit the driver without PM and convert it after.

runtime_pm would be pretty cheap to add though judging by what you're
doing there.

> > > +		if (err) {
> > > +			dev_err(&pdev->dev, "Cannot prepare_enable %s\n",
> > > +				ce->variant->ce_clks[i].name);
> > > +			return err;
> > > +		}
> > > +	}
> > > +
> > > +	/* Get Non Secure IRQ */
> > > +	irq = platform_get_irq(pdev, 0);
> > > +	if (irq < 0) {
> > > +		dev_err(ce->dev, "Cannot get NS IRQ\n");
> > > +		return irq;
> > > +	}
> > > +
> > > +	err = devm_request_irq(&pdev->dev, irq, ce_irq_handler, 0,
> > > +			       "sun8i-ce-ns", ce);
> > > +	if (err < 0) {
> > > +		dev_err(ce->dev, "Cannot request NS IRQ\n");
> > > +		return err;
> > > +	}
> > > +
> > > +	ce->reset = devm_reset_control_get_optional(&pdev->dev, "ahb");
> > > +	if (IS_ERR(ce->reset)) {
> > > +		if (PTR_ERR(ce->reset) == -EPROBE_DEFER)
> > > +			return PTR_ERR(ce->reset);
> > > +		dev_info(&pdev->dev, "No reset control found\n");
> >
> > It's not optional though.
>
> I dont understand why.

On all the SoCs, you need that reset line to be deasserted, otherwise
the IP (and therefore the driver) will be non-functional. It's not an
option to run without it.

> > > +		ce->reset = NULL;
> > > +	}
> > > +
> > > +	err = reset_control_deassert(ce->reset);
> > > +	if (err) {
> > > +		dev_err(&pdev->dev, "Cannot deassert reset control\n");
> > > +		goto error_clk;
> > > +	}
> >
> > Again, you don't really need this at this moment. Using runtime_pm
> > would make more sense.
> >
> > > +	v = readl(ce->base + CE_CTR);
> > > +	v >>= 16;
> > > +	v &= 0x07;
> >
> > This should be in a define
> >
>
> Will fix.
>
> > > +	dev_info(&pdev->dev, "CE_NS Die ID %x\n", v);
> >
> > And if that really makes sense to print it, the error message should
> > be made less cryptic.
> >
>
> Will fix.
>
> > > +
> > > +	ce->dev = &pdev->dev;
> > > +	platform_set_drvdata(pdev, ce);
> > > +
> > > +	mutex_init(&ce->mlock);
> > > +
> > > +	ce->chanlist = devm_kcalloc(ce->dev, ce->variant->maxflow,
> > > +				    sizeof(struct sun8i_ce_flow), GFP_KERNEL);
> > > +	if (!ce->chanlist) {
> > > +		err = -ENOMEM;
> > > +		goto error_flow;
> > > +	}
> > > +
> > > +	for (i = 0; i < ce->variant->maxflow; i++) {
> > > +		init_completion(&ce->chanlist[i].complete);
> > > +		mutex_init(&ce->chanlist[i].lock);
> > > +
> > > +		ce->chanlist[i].engine = crypto_engine_alloc_init(ce->dev, true);
> > > +		if (!ce->chanlist[i].engine) {
> > > +			dev_err(ce->dev, "Cannot allocate engine\n");
> > > +			i--;
> > > +			goto error_engine;
> > > +		}
> > > +		err = crypto_engine_start(ce->chanlist[i].engine);
> > > +		if (err) {
> > > +			dev_err(ce->dev, "Cannot start engine\n");
> > > +			goto error_engine;
> > > +		}
> > > +		ce->chanlist[i].tl = dma_alloc_coherent(ce->dev,
> > > +							sizeof(struct ce_task),
> > > +							&ce->chanlist[i].t_phy,
> > > +							GFP_KERNEL);
> > > +		if (!ce->chanlist[i].tl) {
> > > +			dev_err(ce->dev, "Cannot get DMA memory for task %d\n",
> > > +				i);
> > > +			err = -ENOMEM;
> > > +			goto error_engine;
> > > +		}
> > > +	}
> >
> > All this initialization should be done before calling
> > request_irq. You're using some of those fields in your handler.
>
> No interrupt could fire, since algorithms are still not registred.

That's not true. Spurious interrupts are a thing, the engine could
have been left in a weird state by the bootloader / kexec / reboot
with some pending interrupts, etc.

You have registered that handler already, you should expect it to be
called at any point in time.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
