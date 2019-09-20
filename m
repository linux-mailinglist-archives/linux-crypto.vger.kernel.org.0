Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B27FB901A
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Sep 2019 15:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfITNAW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Sep 2019 09:00:22 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34572 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfITNAW (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Sep 2019 09:00:22 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iBIVz-0007oL-Gk; Fri, 20 Sep 2019 23:00:00 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Sep 2019 22:59:57 +1000
Date:   Fri, 20 Sep 2019 22:59:57 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Pascal van Leeuwen <pascalvanl@gmail.com>
Cc:     linux-crypto@vger.kernel.org, antoine.tenart@bootlin.com,
        davem@davemloft.net,
        Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
Subject: Re: [PATCHv4] crypto: inside-secure - Fix unused variable warning
 when CONFIG_PCI=n
Message-ID: <20190920125957.GB23242@gondor.apana.org.au>
References: <1568365480-7700-1-git-send-email-pvanleeuwen@verimatrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568365480-7700-1-git-send-email-pvanleeuwen@verimatrix.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Sep 13, 2019 at 11:04:40AM +0200, Pascal van Leeuwen wrote:
> This patch fixes an unused variable warning from the compiler when the
> driver is being compiled without PCI support in the kernel.
> 
> changes since v1:
> - capture the platform_register_driver error code as well
> - actually return the (last) error code
> - swapped registration to do PCI first as that's just for development
>   boards anyway, so in case both are done we want the platform error
>   or no error at all if that passes
> - also fixes some indentation issue in the affected code
> 
> changes since v2:
> - handle the situation where both CONFIG_PCI and CONFIG_OF are undefined
>   by always returning a -EINVAL error
> - only unregister PCI or OF if it was previously successfully registered
> 
> changes since v3:
> - if *both* PCI and OF are configured, then return success if *either*
>   registration was OK, also ensuring exit is called and PCI unregister
>   occurs (eventually) if only OF registration fails
> 
> Signed-off-by: Pascal van Leeuwen <pvanleeuwen@verimatrix.com>
> ---
>  drivers/crypto/inside-secure/safexcel.c | 40 ++++++++++++++++++++++++---------
>  1 file changed, 29 insertions(+), 11 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
