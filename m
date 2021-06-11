Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9E7F3A3CCF
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Jun 2021 09:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFKHTN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Jun 2021 03:19:13 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50546 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230188AbhFKHTM (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Jun 2021 03:19:12 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lrbPi-00057q-HA; Fri, 11 Jun 2021 15:17:10 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lrbPX-000812-Tj; Fri, 11 Jun 2021 15:16:59 +0800
Date:   Fri, 11 Jun 2021 15:16:59 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crypto: nitrox - fix unchecked variable in
 nitrox_register_interrupts
Message-ID: <20210611071659.GA23016@gondor.apana.org.au>
References: <20210601100155.69681-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210601100155.69681-1-tongtiangen@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jun 01, 2021 at 06:01:55PM +0800, Tong Tiangen wrote:
> Function nitrox_register_interrupts leaves variable 'nr_vecs' unchecked, which
> would be use as kcalloc parameter later.
> 
> Fixes: 5155e118dda9 ("crypto: cavium/nitrox - use pci_alloc_irq_vectors() while enabling MSI-X.")
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> ---
>  drivers/crypto/cavium/nitrox/nitrox_isr.c | 4 ++++
>  1 file changed, 4 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
