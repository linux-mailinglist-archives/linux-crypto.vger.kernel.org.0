Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB4C32346E6
	for <lists+linux-crypto@lfdr.de>; Fri, 31 Jul 2020 15:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731345AbgGaNaY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 31 Jul 2020 09:30:24 -0400
Received: from [216.24.177.18] ([216.24.177.18]:40510 "EHLO fornost.hmeau.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1731517AbgGaNaW (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 31 Jul 2020 09:30:22 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k1V6S-00016F-OX; Fri, 31 Jul 2020 23:29:41 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 31 Jul 2020 23:29:40 +1000
Date:   Fri, 31 Jul 2020 23:29:40 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sven Auhagen <Sven.Auhagen@voleatech.de>
Cc:     linux-crypto@vger.kernel.org, pvanleeuwen@rambus.com,
        antoine.tenart@bootlin.com, ardb@kernel.org
Subject: Re: [PATCH 1/1 v3] inside-secure irq balance
Message-ID: <20200731132940.GB14360@gondor.apana.org.au>
References: <20200721043759.4tpgtxjohnhx3yuv@SvensMacBookAir.sven.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721043759.4tpgtxjohnhx3yuv@SvensMacBookAir.sven.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jul 21, 2020 at 06:37:59AM +0200, Sven Auhagen wrote:
> Balance the irqs of the inside secure driver over all
> available cpus.
> Currently all interrupts are handled by the first CPU.
> 
> >From my testing with IPSec AES-GCM 256
> on my MCbin with 4 Cores I get a 50% speed increase:
> 
> Before the patch: 99.73 Kpps
> With the patch: 151.25 Kpps
> 
> Signed-off-by: Sven Auhagen <sven.auhagen@voleatech.de>
> ---
> v3:
> * use NUMA_NO_NODE constant
> 
> v2:
> * use cpumask_local_spread and remove affinity on
>   module remove
> 
>  drivers/crypto/inside-secure/safexcel.c | 13 +++++++++++--
>  drivers/crypto/inside-secure/safexcel.h |  3 +++
>  2 files changed, 14 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
