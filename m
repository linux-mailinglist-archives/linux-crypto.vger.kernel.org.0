Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E3A8412B3F4
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Dec 2019 11:37:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726999AbfL0Khe (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 27 Dec 2019 05:37:34 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:60192 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726354AbfL0Khe (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 27 Dec 2019 05:37:34 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ikmzp-0007Lb-Mh; Fri, 27 Dec 2019 18:37:29 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ikmzo-0005m0-Fl; Fri, 27 Dec 2019 18:37:28 +0800
Date:   Fri, 27 Dec 2019 18:37:28 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     davem@davemloft.net, vkoul@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: img-hash - Use dma_request_chan instead
 dma_request_slave_channel
Message-ID: <20191227103728.whanlkw4gvygp7kb@gondor.apana.org.au>
References: <20191217073305.20492-1-peter.ujfalusi@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217073305.20492-1-peter.ujfalusi@ti.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Dec 17, 2019 at 09:33:05AM +0200, Peter Ujfalusi wrote:
> dma_request_slave_channel() is a wrapper on top of dma_request_chan()
> eating up the error code.
> 
> By using dma_request_chan() directly the driver can support deferred
> probing against DMA.
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  drivers/crypto/img-hash.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
