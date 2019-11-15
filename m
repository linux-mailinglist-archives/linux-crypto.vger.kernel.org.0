Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A68DFD5B2
	for <lists+linux-crypto@lfdr.de>; Fri, 15 Nov 2019 07:05:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfKOGFt (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 15 Nov 2019 01:05:49 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57800 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726182AbfKOGFs (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 15 Nov 2019 01:05:48 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iVUjr-0004fW-D5; Fri, 15 Nov 2019 14:05:47 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iVUjj-000650-GH; Fri, 15 Nov 2019 14:05:39 +0800
Date:   Fri, 15 Nov 2019 14:05:39 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mpm@selenic.com, robh+dt@kernel.org, mark.rutland@arm.com,
        nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
        ludovic.desroches@microchip.com, arnd@arndb.de,
        Tudor.Ambarus@microchip.com, Claudiu.Beznea@microchip.com,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: rng: atmel-trng: add new compatible
Message-ID: <20191115060539.u6wamay56otcqcnm@gondor.apana.org.au>
References: <20191104115457.2681-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191104115457.2681-1-codrin.ciubotariu@microchip.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Nov 04, 2019 at 01:54:56PM +0200, Codrin Ciubotariu wrote:
> Add compatible for new IP found on sam9x60 SoC.
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
> 
> Changes in v2:
>  - added 'Acked-by' from Rob;
> 
>  Documentation/devicetree/bindings/rng/atmel-trng.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
