Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94BF2346E4
	for <lists+linux-crypto@lfdr.de>; Fri, 31 Jul 2020 15:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbgGaNaQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 31 Jul 2020 09:30:16 -0400
Received: from [216.24.177.18] ([216.24.177.18]:40518 "EHLO fornost.hmeau.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1731521AbgGaNaQ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 31 Jul 2020 09:30:16 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k1V6a-00016J-I7; Fri, 31 Jul 2020 23:29:49 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 31 Jul 2020 23:29:48 +1000
Date:   Fri, 31 Jul 2020 23:29:48 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sven Auhagen <Sven.Auhagen@voleatech.de>
Cc:     linux-crypto@vger.kernel.org, ardb@kernel.org,
        bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com
Subject: Re: [PATCH 1/1 v3] marvell cesa irq balance
Message-ID: <20200731132948.GC14360@gondor.apana.org.au>
References: <20200721044027.6r3l6ef23fqyg3qn@SvensMacBookAir.sven.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721044027.6r3l6ef23fqyg3qn@SvensMacBookAir.sven.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jul 21, 2020 at 06:40:27AM +0200, Sven Auhagen wrote:
> Balance the irqs of the marvell cesa driver over all
> available cpus.
> Currently all interrupts are handled by the first CPU.
> 
> >From my testing with IPSec AES 256 SHA256
> on my clearfog base with 2 Cores I get a 2x speed increase:
> 
> Before the patch: 26.74 Kpps
> With the patch: 56.11 Kpps
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
>  drivers/crypto/marvell/cesa/cesa.c | 11 ++++++++++-
>  drivers/crypto/marvell/cesa/cesa.h |  1 +
>  2 files changed, 11 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
