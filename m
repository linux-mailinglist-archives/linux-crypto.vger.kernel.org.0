Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D669C3D0441
	for <lists+linux-crypto@lfdr.de>; Wed, 21 Jul 2021 00:08:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbhGTV1C (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 20 Jul 2021 17:27:02 -0400
Received: from gate.crashing.org ([63.228.1.57]:54531 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230123AbhGTV0l (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 20 Jul 2021 17:26:41 -0400
Received: from ip6-localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 16KM2gSN032638;
        Tue, 20 Jul 2021 17:02:43 -0500
Message-ID: <e494866f38e9dcd2834971d3867244fb1d7e6ceb.camel@kernel.crashing.org>
Subject: Re: [PATCH v2] hwrng: Add Arm SMCCC TRNG based driver
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Andre Przywara <andre.przywara@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>
Cc:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>, Will Deacon <will@kernel.org>,
        Ali Saidi <alisaidi@amazon.com>,
        Jon Nettleton <jon@solid-run.com>
Date:   Wed, 21 Jul 2021 08:02:42 +1000
In-Reply-To: <20210720171631.071f84f5@slackpad.fritz.box>
References: <20210720152158.31804-1-andre.przywara@arm.com>
         <CAMj1kXEW7DT3P3FuV+poFykf6wwm4FTJuV6emGSWabCp7UZX9A@mail.gmail.com>
         <20210720171631.071f84f5@slackpad.fritz.box>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, 2021-07-20 at 17:16 +0100, Andre Przywara wrote:
> Yes, a similar idea was already brought up before. I think there is even
> the potential for something like an artificial SMCCC "bus", where those
> services presentable as devices could be auto-detected (by checking
> known function IDs), the respective drivers would then probe
> automatically?

Sounds like a boot time killer... can we instead describe them in DT
and/or ACPI ?

Cheers,
Ben.


