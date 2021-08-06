Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4D13E2A6C
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Aug 2021 14:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343635AbhHFMPU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 6 Aug 2021 08:15:20 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51754 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343589AbhHFMPU (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 6 Aug 2021 08:15:20 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mBykc-0003hl-Nt; Fri, 06 Aug 2021 20:14:58 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mBykW-0006fS-4A; Fri, 06 Aug 2021 20:14:52 +0800
Date:   Fri, 6 Aug 2021 20:14:52 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Matt Mackall <mpm@selenic.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Ali Saidi <alisaidi@amazon.com>,
        Jon Nettleton <jon@solid-run.com>
Subject: Re: [PATCH v4 0/2] hwrng: Add Arm SMCCC TRNG based driver
Message-ID: <20210806121452.GC25554@gondor.apana.org.au>
References: <20210731204845.21196-1-andre.przywara@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210731204845.21196-1-andre.przywara@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Jul 31, 2021 at 09:48:43PM +0100, Andre Przywara wrote:
> The "Arm True Random Number Generator Firmware Interface"[1] provides
> an SMCCC based interface to a true hardware random number generator.
> So far we are using that in arch_get_random_seed(), but it might be
> useful to expose the entropy through the /dev/hwrng device as well. This
> allows to assess the quality of the implementation, by using "rngtest"
> from the rng-tools package, for example.
> 
> Patch 1 creates a platform device, triggered by the previous discovery
> of the SMCCC TRNG service.
> Patch 2 implements a hw_random platform driver, which is instantiated
> through this said platform device.
> 
> The driver can be loaded as module, or built into the kernel.
> 
> [1] https://developer.arm.com/documentation/den0098/latest/
> 
> Changelog v3 ... v4:
> - drop pointless driver loading message
> - drop unneeded init() routine
> 
> Changelog v2 ... v3:
> - split platform device and driver
> 
> Changelog v1 ... v2:
> - fix building as a module
> - de-register device upon exit
> - mention module name in Kconfig
> 
> Andre Przywara (2):
>   firmware: smccc: Register smccc_trng platform device
>   hwrng: Add Arm SMCCC TRNG based driver
> 
>  drivers/char/hw_random/Kconfig          |  14 +++
>  drivers/char/hw_random/Makefile         |   1 +
>  drivers/char/hw_random/arm_smccc_trng.c | 123 ++++++++++++++++++++++++
>  drivers/firmware/smccc/smccc.c          |  17 ++++
>  4 files changed, 155 insertions(+)
>  create mode 100644 drivers/char/hw_random/arm_smccc_trng.c

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
