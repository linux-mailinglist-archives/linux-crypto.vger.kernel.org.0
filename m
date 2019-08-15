Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F15C08EB1A
	for <lists+linux-crypto@lfdr.de>; Thu, 15 Aug 2019 14:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfHOMIF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 15 Aug 2019 08:08:05 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:57260 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729986AbfHOMIF (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 15 Aug 2019 08:08:05 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hyEXx-0003QY-UU; Thu, 15 Aug 2019 22:08:02 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hyEXw-0007jt-Vo; Thu, 15 Aug 2019 22:08:01 +1000
Date:   Thu, 15 Aug 2019 22:08:00 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-crypto@vger.kernel.org, ebiggers@kernel.org,
        gmazyland@gmail.com,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH v2] crypto: xts - add support for ciphertext stealing
Message-ID: <20190815120800.GI29355@gondor.apana.org.au>
References: <20190809171457.12400-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190809171457.12400-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Aug 09, 2019 at 08:14:57PM +0300, Ard Biesheuvel wrote:
> Add support for the missing ciphertext stealing part of the XTS-AES
> specification, which permits inputs of any size >= the block size.
> 
> Cc: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
> Cc: Ondrej Mosnacek <omosnace@redhat.com>
> Tested-by: Milan Broz <gmazyland@gmail.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> v2: fix scatterlist issue in async handling
>     remove stale comment
> 
>  crypto/xts.c | 152 +++++++++++++++++---
>  1 file changed, 132 insertions(+), 20 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
