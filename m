Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4B532C38C
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Mar 2021 01:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357131AbhCDAHQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 3 Mar 2021 19:07:16 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:37046 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241217AbhCCK1f (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 3 Mar 2021 05:27:35 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lHN87-0000Ec-Hg; Wed, 03 Mar 2021 19:45:16 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 03 Mar 2021 19:45:15 +1100
Date:   Wed, 3 Mar 2021 19:45:15 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Vic Wu <vic.wu@mediatek.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: mediatek - remove obsolete documentation
Message-ID: <20210303084515.GA8036@gondor.apana.org.au>
References: <20210303080923.16761-1-vic.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210303080923.16761-1-vic.wu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Mar 03, 2021 at 04:09:23PM +0800, Vic Wu wrote:
> The crypto mediatek driver has been replaced by the inside-secure driver now.
> Remove DT bindings documentation and update crypto engine nodes to the mt7623.dtsi files.
> 
> Signed-off-by: Vic Wu <vic.wu@mediatek.com>
> Acked-by: Ryder Lee <ryder.lee@mediatek.com>
> ---
>  Documentation/devicetree/bindings/crypto/mediatek-crypto.txt       | 25 -------------------
>  arch/arm/boot/dts/mt7623.dtsi                 |  8 +++---
>  2 files changed, 3 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/crypto/mediatek-crypto.txt

Shouldn't this go through Matthias Brugger <matthias.bgg@gmail.com>?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
