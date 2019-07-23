Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9BC70F1B
	for <lists+linux-crypto@lfdr.de>; Tue, 23 Jul 2019 04:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfGWCV0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 22 Jul 2019 22:21:26 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:59495 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726930AbfGWCVZ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 22 Jul 2019 22:21:25 -0400
X-UUID: 791c5dbc0a0e46ca99e8e8dbb509d716-20190723
X-UUID: 791c5dbc0a0e46ca99e8e8dbb509d716-20190723
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw02.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1532202587; Tue, 23 Jul 2019 10:21:08 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Tue, 23 Jul 2019 10:21:05 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Tue, 23 Jul 2019 10:21:05 +0800
Message-ID: <1563848465.31451.4.camel@mtkswgap22>
Subject: Re: [PATCH v4 2/3] dt-bindings: rng: add bindings for MediaTek
 ARMv8 SoCs
From:   Neal Liu <neal.liu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Mark Rutland <mark.rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Crystal Guo =?UTF-8?Q?=28=E9=83=AD=E6=99=B6=29?= 
        <Crystal.Guo@mediatek.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Matt Mackall <mpm@selenic.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 23 Jul 2019 10:21:05 +0800
In-Reply-To: <20190722171320.GA9806@bogus>
References: <1561361052-13072-1-git-send-email-neal.liu@mediatek.com>
         <1561361052-13072-3-git-send-email-neal.liu@mediatek.com>
         <20190722171320.GA9806@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Dear Rob,
	You can check my driver for detail:
	http://patchwork.kernel.org/patch/11012475/ or patchset 3/3

	This driver is registered as hardware random number generator, and
combines with rng-core.
	We want to add one rng hw based on the dts. Is this proper or do you
have other suggestion to meet this requirement?

	Thanks


On Tue, 2019-07-23 at 01:13 +0800, Rob Herring wrote:
> On Mon, Jun 24, 2019 at 03:24:11PM +0800, Neal Liu wrote:
> > Document the binding used by the MediaTek ARMv8 SoCs random
> > number generator with TrustZone enabled.
> > 
> > Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> > ---
> >  .../devicetree/bindings/rng/mtk-sec-rng.txt        |   10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/rng/mtk-sec-rng.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/rng/mtk-sec-rng.txt b/Documentation/devicetree/bindings/rng/mtk-sec-rng.txt
> > new file mode 100644
> > index 0000000..c04ce15
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/rng/mtk-sec-rng.txt
> > @@ -0,0 +1,10 @@
> > +MediaTek random number generator with TrustZone enabled
> > +
> > +Required properties:
> > +- compatible : Should be "mediatek,mtk-sec-rng"
> 
> What's the interface to access this? 
> 
> A node with a 'compatible' and nothing else is a sign of something that 
> a parent device should instantiate and doesn't need to be in DT. IOW, 
> what do complete bindings for firmware functions look like?
> 
> > +
> > +Example:
> > +
> > +hwrng: hwrng {
> > +	compatible = "mediatek,mtk-sec-rng";
> > +}
> > -- 
> > 1.7.9.5
> > 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek


