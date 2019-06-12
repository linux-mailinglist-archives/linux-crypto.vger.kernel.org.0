Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 653D241AE3
	for <lists+linux-crypto@lfdr.de>; Wed, 12 Jun 2019 06:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbfFLEDD (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 12 Jun 2019 00:03:03 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:16842 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725280AbfFLEDD (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 12 Jun 2019 00:03:03 -0400
X-UUID: fc6ce90485e84dd9b89e82f2c271838d-20190612
X-UUID: fc6ce90485e84dd9b89e82f2c271838d-20190612
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 812905548; Wed, 12 Jun 2019 12:02:55 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 12 Jun 2019 12:02:54 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 12 Jun 2019 12:02:54 +0800
Message-ID: <1560312174.20601.6.camel@mtkswgap22>
Subject: Re: [PATCH v3 2/3] dt-bindings: rng: update bindings for MediaTek
 ARMv8 SoCs
From:   Neal Liu <neal.liu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        <linux-crypto@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        Crystal Guo <Crystal.Guo@mediatek.com>
Date:   Wed, 12 Jun 2019 12:02:54 +0800
In-Reply-To: <20190611225351.GA17332@bogus>
References: <1560162984-26104-1-git-send-email-neal.liu@mediatek.com>
         <1560162984-26104-3-git-send-email-neal.liu@mediatek.com>
         <20190611225351.GA17332@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, 2019-06-11 at 16:53 -0600, Rob Herring wrote:
> On Mon, Jun 10, 2019 at 06:36:23PM +0800, Neal Liu wrote:
> > Document the binding used by the MediaTek ARMv8 SoCs random
> > number generator with TrustZone enabled.
> > 
> > Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> > ---
> >  Documentation/devicetree/bindings/rng/mtk-rng.txt |   15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/rng/mtk-rng.txt b/Documentation/devicetree/bindings/rng/mtk-rng.txt
> > index 2bc89f1..fb3dd59 100644
> > --- a/Documentation/devicetree/bindings/rng/mtk-rng.txt
> > +++ b/Documentation/devicetree/bindings/rng/mtk-rng.txt
> > @@ -3,9 +3,13 @@ found in MediaTek SoC family
> >  
> >  Required properties:
> >  - compatible	    : Should be
> > -			"mediatek,mt7622-rng", 	"mediatek,mt7623-rng" : for MT7622
> > -			"mediatek,mt7629-rng",  "mediatek,mt7623-rng" : for MT7629
> > -			"mediatek,mt7623-rng" : for MT7623
> > +			"mediatek,mt7622-rng", "mediatek,mt7623-rng" for MT7622
> > +			"mediatek,mt7629-rng", "mediatek,mt7623-rng" for MT7629
> > +			"mediatek,mt7623-rng" for MT7623
> > +			"mediatek,mtk-sec-rng" for MediaTek ARMv8 SoCs with
> > +			security RNG
> 
> Is there any commonality with the prior h/w? If not, make this a 
> separate binding doc.

There are less common with the prior h/w... I had been thinking about
make new binding doc. Since your suggestion, I'll make one.

> 
> > +
> > +Optional properties:
> >  - clocks	    : list of clock specifiers, corresponding to
> >  		      entries in clock-names property;
> >  - clock-names	    : Should contain "rng" entries;
> > @@ -19,3 +23,8 @@ rng: rng@1020f000 {
> >  	clocks = <&infracfg CLK_INFRA_TRNG>;
> >  	clock-names = "rng";
> >  };
> > +
> > +/* secure RNG */
> > +hwrng: hwrng {
> > +	compatible = "mediatek,mtk-sec-rng";
> 
> How does one access this? Seems like this should be part of a node for 
> firmware? What about other functions?

Yes, We move all hw register & clock control access to the ATF by smc.

> 
> > +};
> > -- 
> > 1.7.9.5
> > 


