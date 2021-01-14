Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530C32F5AED
	for <lists+linux-crypto@lfdr.de>; Thu, 14 Jan 2021 07:48:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726896AbhANGsF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 14 Jan 2021 01:48:05 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:42214 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726172AbhANGsF (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 14 Jan 2021 01:48:05 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kzwPY-000885-LE; Thu, 14 Jan 2021 17:47:13 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 14 Jan 2021 17:47:12 +1100
Date:   Thu, 14 Jan 2021 17:47:12 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: crypto: marvell: Fix a spelling
 s/fautly/faultly/ in comment
Message-ID: <20210114064712.GH12584@gondor.apana.org.au>
References: <20210105100108.3375-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105100108.3375-1-unixbhaskar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jan 05, 2021 at 03:31:08PM +0530, Bhaskar Chowdhury wrote:
> 
> s/fautly/faulty/p
> 
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  drivers/crypto/marvell/cesa/tdma.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
