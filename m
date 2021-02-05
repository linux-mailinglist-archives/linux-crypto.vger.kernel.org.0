Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6B403103C0
	for <lists+linux-crypto@lfdr.de>; Fri,  5 Feb 2021 04:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBEDjV (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 4 Feb 2021 22:39:21 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54510 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229989AbhBEDjS (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 4 Feb 2021 22:39:18 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l7rwu-0002aK-LD; Fri, 05 Feb 2021 14:38:25 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Feb 2021 14:38:24 +1100
Date:   Fri, 5 Feb 2021 14:38:24 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Suheil Chandran <schandran@marvell.com>,
        Lukasz Bartosik <lbartosik@marvell.com>,
        linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] crypto: octeontx2 - fix signedness bug in
 cptvf_register_interrupts()
Message-ID: <20210205033824.GA14594@gondor.apana.org.au>
References: <YBD5Z11GeYlJGuTh@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YBD5Z11GeYlJGuTh@mwanda>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Jan 27, 2021 at 08:25:59AM +0300, Dan Carpenter wrote:
> The "num_vec" has to be signed for the error handling to work.
> 
> Fixes: 19d8e8c7be15 ("crypto: octeontx2 - add virtual function driver support")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/crypto/marvell/octeontx2/otx2_cptvf_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
