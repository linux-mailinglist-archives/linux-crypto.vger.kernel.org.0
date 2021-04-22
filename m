Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDFD367A4D
	for <lists+linux-crypto@lfdr.de>; Thu, 22 Apr 2021 08:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbhDVG5E (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 22 Apr 2021 02:57:04 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:48256 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230341AbhDVG5D (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 22 Apr 2021 02:57:03 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lZTGD-0002FX-2x; Thu, 22 Apr 2021 16:56:26 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 22 Apr 2021 16:56:24 +1000
Date:   Thu, 22 Apr 2021 16:56:24 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Haren Myneni <haren@linux.ibm.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-crypto@vger.kernel.org,
        mpe@ellerman.id.au, npiggin@gmail.com, hbabu@us.ibm.com,
        haren@us.ibm.com
Subject: Re: [V3 PATCH 15/16] crypto/nx: Get NX capabilities for GZIP
 coprocessor type
Message-ID: <20210422065624.GC5486@gondor.apana.org.au>
References: <a910e5bd3f3398b4bd430b25a856500735b993c3.camel@linux.ibm.com>
 <e5fff6adbf3ce7769b0efe4846f39dbc6c795dd1.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5fff6adbf3ce7769b0efe4846f39dbc6c795dd1.camel@linux.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Apr 17, 2021 at 02:12:51PM -0700, Haren Myneni wrote:
> 
> phyp provides NX capabilities which gives recommended minimum
> compression / decompression length and maximum request buffer size
> in bytes.
> 
> Changes to get NX overall capabilities which points to the specific
> features phyp supports. Then retrieve NXGZIP specific capabilities.
> 
> Signed-off-by: Haren Myneni <haren@linux.ibm.com>
> ---
>  drivers/crypto/nx/nx-common-pseries.c | 83 +++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
