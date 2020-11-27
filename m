Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15672C6020
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Nov 2020 07:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392634AbgK0G1S (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 27 Nov 2020 01:27:18 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:33496 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392527AbgK0G1S (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 27 Nov 2020 01:27:18 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kiXDq-0000yy-Co; Fri, 27 Nov 2020 17:27:11 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 27 Nov 2020 17:27:10 +1100
Date:   Fri, 27 Nov 2020 17:27:10 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     davem@davemloft.net, gcherian@marvell.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] crypto: cavium - Use dma_set_mask_and_coherent to
 simplify code
Message-ID: <20201127062710.GI11448@gondor.apana.org.au>
References: <20201121075647.1324006-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201121075647.1324006-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Nov 21, 2020 at 08:56:47AM +0100, Christophe JAILLET wrote:
> 'pci_set_dma_mask()' + 'pci_set_consistent_dma_mask()' can be replaced by
> an equivalent 'dma_set_mask_and_coherent()' which is much less verbose.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  drivers/crypto/cavium/cpt/cptpf_main.c | 10 ++--------
>  drivers/crypto/cavium/cpt/cptvf_main.c | 10 ++--------
>  2 files changed, 4 insertions(+), 16 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
