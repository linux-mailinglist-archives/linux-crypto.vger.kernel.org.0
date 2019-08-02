Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D19A97EBAD
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Aug 2019 06:55:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730199AbfHBEzh (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 2 Aug 2019 00:55:37 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:48658 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbfHBEzh (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 2 Aug 2019 00:55:37 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1htPb6-0006I5-Vn; Fri, 02 Aug 2019 14:55:21 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1htPaz-0004jR-OD; Fri, 02 Aug 2019 14:55:13 +1000
Date:   Fri, 2 Aug 2019 14:55:13 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nishka Dasgupta <nishkadg.linux@gmail.com>
Cc:     haren@us.ibm.com, davem@davemloft.net, benh@kernel.crashing.org,
        paulus@samba.org, mpe@ellerman.id.au, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] crypto: nx: nx-842-powernv: Add of_node_put() before
 return
Message-ID: <20190802045513.GE18077@gondor.apana.org.au>
References: <20190724075433.9446-1-nishkadg.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724075433.9446-1-nishkadg.linux@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Jul 24, 2019 at 01:24:33PM +0530, Nishka Dasgupta wrote:
> Each iteration of for_each_compatible_node puts the previous node, but
> in the case of a return from the middle of the loop, there is no put,
> thus causing a memory leak. Add an of_node_put before the return.
> Issue found with Coccinelle.
> 
> Acked-by: Stewart Smith <stewart@linux.ibm.com>
> Signed-off-by: Nishka Dasgupta <nishkadg.linux@gmail.com>
> 
> ---
> Changes in v2:
> - Fixed commit message to match the loop in question.
> 
>  drivers/crypto/nx/nx-842-powernv.c | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
