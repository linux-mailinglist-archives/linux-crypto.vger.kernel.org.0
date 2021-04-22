Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E033367A4C
	for <lists+linux-crypto@lfdr.de>; Thu, 22 Apr 2021 08:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbhDVG4u (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 22 Apr 2021 02:56:50 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:48246 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230341AbhDVG4r (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 22 Apr 2021 02:56:47 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lZTFv-0002CH-T3; Thu, 22 Apr 2021 16:56:09 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 22 Apr 2021 16:56:07 +1000
Date:   Thu, 22 Apr 2021 16:56:07 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Haren Myneni <haren@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, hbabu@us.ibm.com,
        haren@us.ibm.com
Subject: Re: [V3 PATCH 14/16] crypto/nx: Register and unregister VAS interface
Message-ID: <20210422065607.GB5486@gondor.apana.org.au>
References: <a910e5bd3f3398b4bd430b25a856500735b993c3.camel@linux.ibm.com>
 <875e8d7629cc2281672fc47a97b690b1de0e63d5.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875e8d7629cc2281672fc47a97b690b1de0e63d5.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Apr 17, 2021 at 02:12:12PM -0700, Haren Myneni wrote:
> 
> Changes to create /dev/crypto/nx-gzip interface with VAS register
> and to remove this interface with VAS unregister.
> 
> Signed-off-by: Haren Myneni <haren@linux.ibm.com>
> ---
>  drivers/crypto/nx/Kconfig             | 1 +
>  drivers/crypto/nx/nx-common-pseries.c | 9 +++++++++
>  2 files changed, 10 insertions(+)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
