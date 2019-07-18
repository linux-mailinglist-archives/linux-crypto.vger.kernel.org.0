Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD2C6D093
	for <lists+linux-crypto@lfdr.de>; Thu, 18 Jul 2019 16:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfGRO7L (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 18 Jul 2019 10:59:11 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:52482 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727623AbfGRO7L (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 18 Jul 2019 10:59:11 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ho7sE-0000Qa-5m; Thu, 18 Jul 2019 22:59:10 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ho7sC-0006K4-17; Thu, 18 Jul 2019 22:59:08 +0800
Date:   Thu, 18 Jul 2019 22:59:08 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH] crypto: gcm - restrict assoclen for rfc4543
Message-ID: <20190718145907.wercecqwr3wlny73@gondor.apana.org.au>
References: <1563460984-24593-1-git-send-email-iuliana.prodan@nxp.com>
 <20190718144647.bbsd65qabqpafehe@gondor.apana.org.au>
 <VI1PR04MB44451D12B66EE3FADA1ECE208CC80@VI1PR04MB4445.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB44451D12B66EE3FADA1ECE208CC80@VI1PR04MB4445.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jul 18, 2019 at 02:56:35PM +0000, Iuliana Prodan wrote:
>
> Yes, this is for fuzz testing.
> The generic implementation for rfc4543 considers any assoclen valid, 
> which is not correct.

So I presume the driver does enforce the limit.  Please actually
state that in the commit description for future reference.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
