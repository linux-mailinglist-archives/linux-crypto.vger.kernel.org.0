Return-Path: <linux-crypto+bounces-3826-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B58848B126F
	for <lists+linux-crypto@lfdr.de>; Wed, 24 Apr 2024 20:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 543C11F22D53
	for <lists+linux-crypto@lfdr.de>; Wed, 24 Apr 2024 18:33:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAF81D53C;
	Wed, 24 Apr 2024 18:33:52 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 346561CF9A
	for <linux-crypto@vger.kernel.org>; Wed, 24 Apr 2024 18:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713983632; cv=none; b=f6Vl0ShRSl3dE6B5Kno4jBHbg/9Qa4bthJevwvUix2aO3DR03KlWLHMZN+EqkStPmUHk96D/g15nyOiQFC2QaCwY8i35cQ7hxCzqb8RSuJyjmkdLy7NKCRKRL9Fl90UVm9VO/IdHUIqctDSlM1At9UJEDlXc+8KJfnr3j7Vc+4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713983632; c=relaxed/simple;
	bh=lXPwk1l5R4TU4c5qE/qPwPMB0kYhCMN4XzpdXEceGtc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S3b3dMdpPZ+84HCB33O7uJTxh56VJx2ITJtafmqkSQzec9yzD+bVAtJmwfi15NSZsDphBjY8d0DhpJz2L0IoJmT8Lvpjv9TsF585qm+c0WT57WAOUBbMnGJMlGpHHVrcK29zxa/e2CeJVUq0nU0t5A2azNJ91j2joC04YqhHisA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: jWoQJ2OfQ2eB8rYjwpcHxw==
X-CSE-MsgGUID: IgJDjMShTxqcRN9Hk3CqQg==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="32126197"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="32126197"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:33:51 -0700
X-CSE-ConnectionGUID: tyxhSyVeQVe56rlsmUI8Qw==
X-CSE-MsgGUID: ANZZIUuBQgGxZ19tESR6/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="24874373"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 11:33:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1rzhRA-00000000kY5-3iAc;
	Wed, 24 Apr 2024 21:33:44 +0300
Date: Wed, 24 Apr 2024 21:33:44 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>,
	Arnd Bergmann <arnd@arndb.de>, soc@kernel.org, arm@kernel.org,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-crypto@vger.kernel.org
Subject: Re: [PATCH v7 6/9] platform: cznic: turris-omnia-mcu: Add support
 for MCU provided TRNG
Message-ID: <ZilQiHLLj1eQxP2L@smile.fi.intel.com>
References: <20240424173809.7214-1-kabel@kernel.org>
 <20240424173809.7214-7-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240424173809.7214-7-kabel@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 24, 2024 at 07:38:05PM +0200, Marek Beh�n wrote:
> Add support for true random number generator provided by the MCU.
> New Omnia boards come without the Atmel SHA204-A chip. Instead the
> crypto functionality is provided by new microcontroller, which has
> a TRNG peripheral.

...

> +static void omnia_irq_mapping_drop(void *res)
> +{
> +	irq_dispose_mapping((unsigned int)(unsigned long)res);
> +}

Leftover?

> +int omnia_mcu_register_trng(struct omnia_mcu *mcu)
> +{
> +	struct device *dev = &mcu->client->dev;
> +	u8 irq_idx, dummy;
> +	int irq, err;
> +
> +	if (!(mcu->features & FEAT_TRNG))
> +		return 0;
> +
> +	irq_idx = omnia_int_to_gpio_idx[__bf_shf(INT_TRNG)];
> +	irq = gpiod_to_irq(gpiochip_get_desc(&mcu->gc, irq_idx));
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq, "Cannot get TRNG IRQ\n");

> +	err = devm_add_action_or_reset(dev, omnia_irq_mapping_drop,
> +				       (void *)(unsigned long)irq);
> +	if (err)
> +		return err;

Are you sure it's correct now?

> +	/* If someone else cleared the TRNG interrupt but did not read the
> +	 * entropy, a new interrupt won't be generated, and entropy collection
> +	 * will be stuck. Ensure an interrupt will be generated by executing
> +	 * the collect entropy command (and discarding the result).
> +	 */
> +	err = omnia_cmd_read(mcu->client, CMD_TRNG_COLLECT_ENTROPY, &dummy, 1);
> +	if (err)
> +		return err;
> +
> +	init_completion(&mcu->trng_completion);
> +
> +	err = devm_request_threaded_irq(dev, irq, NULL, omnia_trng_irq_handler,
> +					IRQF_ONESHOT, "turris-omnia-mcu-trng",
> +					mcu);
> +	if (err)
> +		return dev_err_probe(dev, err, "Cannot request TRNG IRQ\n");
> +
> +	mcu->trng.name = "turris-omnia-mcu-trng";
> +	mcu->trng.read = omnia_trng_read;
> +	mcu->trng.priv = (unsigned long)mcu;
> +
> +	err = devm_hwrng_register(dev, &mcu->trng);
> +	if (err)
> +		return dev_err_probe(dev, err, "Cannot register TRNG\n");
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



