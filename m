Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6AE1AA379C
	for <lists+linux-crypto@lfdr.de>; Fri, 30 Aug 2019 15:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbfH3NQO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 30 Aug 2019 09:16:14 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59780 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727620AbfH3NQO (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 30 Aug 2019 09:16:14 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1i3gkq-00032B-LZ; Fri, 30 Aug 2019 23:15:53 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Aug 2019 23:15:47 +1000
Date:   Fri, 30 Aug 2019 23:15:47 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Iuliana Prodan <iuliana.prodan@nxp.com>
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "christopher.spencer@sea.co.uk" <christopher.spencer@sea.co.uk>,
        "cory.tusar@zii.aero" <cory.tusar@zii.aero>,
        "cphealy@gmail.com" <cphealy@gmail.com>,
        "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v8 00/16] crypto: caam - Add i.MX8MQ support
Message-ID: <20190830131547.GA27480@gondor.apana.org.au>
References: <20190830082320.GA8729@gondor.apana.org.au>
 <VI1PR04MB444580B237A9F57A7BAAF32B8CBD0@VI1PR04MB4445.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <VI1PR04MB444580B237A9F57A7BAAF32B8CBD0@VI1PR04MB4445.eurprd04.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Aug 30, 2019 at 09:15:12AM +0000, Iuliana Prodan wrote:
>
> Can you, please, add, also, the device tree patch ("arm64: dts: imx8mq: 
> Add CAAM node") in cryptodev tree?
> Unfortunately Shawn Guo wasn't cc-ed on this patch and, to have the 
> complete support for imx8mq, in kernel v5.4, we need the node in dts.

If Shawn can ack this then I'm happy to apply this patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
