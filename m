Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 663DF27CFB
	for <lists+linux-crypto@lfdr.de>; Thu, 23 May 2019 14:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729902AbfEWMiS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 23 May 2019 08:38:18 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50096 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729762AbfEWMiS (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 23 May 2019 08:38:18 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hTmzA-0002N7-Jk; Thu, 23 May 2019 20:38:16 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hTmz7-0007Dd-Ln; Thu, 23 May 2019 20:38:13 +0800
Date:   Thu, 23 May 2019 20:38:13 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia Geanta <horia.geanta@nxp.com>
Cc:     Iuliana Prodan <iuliana.prodan@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v2 1/2] crypto: caam - fix pkcs1pad(rsa-caam, sha256)
 failure because of invalid input
Message-ID: <20190523123813.xosynrnsdpqfieqv@gondor.apana.org.au>
References: <1557919546-360-1-git-send-email-iuliana.prodan@nxp.com>
 <20190523061202.ic2vgimgzvvm6dzc@gondor.apana.org.au>
 <AM0PR0402MB3476BE4FE08AC135742D262998010@AM0PR0402MB3476.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR0402MB3476BE4FE08AC135742D262998010@AM0PR0402MB3476.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, May 23, 2019 at 10:02:41AM +0000, Horia Geanta wrote:
>
> When crypto_register_akcipher fails, it merely prints a warning and falls
> through (does not immediately return), thus there's no leak.

How can this work? Wouldn't the exit path then unregister a bunch of
unregistered algorithms and crash?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
