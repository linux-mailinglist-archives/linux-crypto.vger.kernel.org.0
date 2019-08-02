Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 561327EBB7
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Aug 2019 06:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732226AbfHBE4P (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 2 Aug 2019 00:56:15 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:48716 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726723AbfHBE4P (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 2 Aug 2019 00:56:15 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1htPbw-0006LL-Lq; Fri, 02 Aug 2019 14:56:12 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1htPbw-0004l1-7X; Fri, 02 Aug 2019 14:56:12 +1000
Date:   Fri, 2 Aug 2019 14:56:12 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Vakul Garg <vakul.garg@nxp.com>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Iuliana Prodan <iuliana.prodan@nxp.com>,
        linux-crypto@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] crypto: caam - defer probing until QMan is available
Message-ID: <20190802045612.GJ18077@gondor.apana.org.au>
References: <20190728192638.1929-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190728192638.1929-1-horia.geanta@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Jul 28, 2019 at 10:26:38PM +0300, Horia Geantă wrote:
> When QI (Queue Interface) support is enabled on DPAA 1.x platforms,
> defer probing if dependencies (QMan drivers) are not available yet.
> 
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
> ---
> This patch was previously submitted as part of IOMMU support series:
> https://patchwork.kernel.org/cover/10928833/
> 
> Re-sending since the compile dependency:
> commit 1c8f39946c03 ("soc: fsl: qbman_portals: add APIs to retrieve the probing status")
> is now available in cryptodev-2.6 tree.
> 
>  drivers/crypto/caam/ctrl.c | 74 ++++++++++++++++++++++++--------------
>  1 file changed, 48 insertions(+), 26 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
