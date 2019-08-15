Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BB828EB07
	for <lists+linux-crypto@lfdr.de>; Thu, 15 Aug 2019 14:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbfHOMFx (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 15 Aug 2019 08:05:53 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:57190 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbfHOMFx (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 15 Aug 2019 08:05:53 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hyEVp-0003JN-Gq; Thu, 15 Aug 2019 22:05:49 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hyEVn-0007dk-RK; Thu, 15 Aug 2019 22:05:47 +1000
Date:   Thu, 15 Aug 2019 22:05:47 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        linux-crypto@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH v2] crypto: caam/qi - execute library only on DPAA 1.x
Message-ID: <20190815120547.GA29355@gondor.apana.org.au>
References: <20190805124955.11751-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190805124955.11751-1-horia.geanta@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Aug 05, 2019 at 03:49:55PM +0300, Horia Geantă wrote:
> In the process of turning caam/qi into a library, the check of
> MCFGR[QI] bit has been inadvertently dropped.
> Fix the condition for DPAA 1.x QI detection, which should be:
> MCFGR[QI] && !MCFGR[DPAA2]
> 
> A check in the library exit point is currently not needed,
> since the list of registered algorithms is empty.
> 
> While here, silence the library initialization abort - since jr.c
> calls it unconditionally.
> 
> Fixes: 1b46c90c8e00 ("crypto: caam - convert top level drivers to libraries")
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
> ---
> v2: dropped check at library exit point
> 
>  drivers/crypto/caam/caamalg_qi.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
