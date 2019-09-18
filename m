Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA62CB5964
	for <lists+linux-crypto@lfdr.de>; Wed, 18 Sep 2019 03:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726234AbfIRBoY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 17 Sep 2019 21:44:24 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:3615 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725943AbfIRBoY (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 17 Sep 2019 21:44:24 -0400
X-UUID: ea1a39deb5f24d4bb57402fa54c802a7-20190918
X-UUID: ea1a39deb5f24d4bb57402fa54c802a7-20190918
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw01.mediatek.com
        (envelope-from <neal.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1909629750; Wed, 18 Sep 2019 09:44:18 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Wed, 18 Sep 2019 09:44:16 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Wed, 18 Sep 2019 09:44:16 +0800
Message-ID: <1568771054.21700.7.camel@mtkswgap22>
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
        <linux-arm-kernel@lists.infradead.org>,
        Neal Liu <neal.liu@mediatek.com>
Date:   Wed, 18 Sep 2019 09:44:14 +0800
In-Reply-To: <CAL_Jsq+SRhd=-5O2G_CMfJX9Z188kvA05MQOXaU1J8iExwUixQ@mail.gmail.com>
References: <1561361052-13072-1-git-send-email-neal.liu@mediatek.com>
         <1561361052-13072-3-git-send-email-neal.liu@mediatek.com>
         <20190722171320.GA9806@bogus> <1563848465.31451.4.camel@mtkswgap22>
         <CAL_Jsq+SRhd=-5O2G_CMfJX9Z188kvA05MQOXaU1J8iExwUixQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, 2019-07-23 at 22:35 +0800, Rob Herring wrote:
> On Mon, Jul 22, 2019 at 8:21 PM Neal Liu <neal.liu@mediatek.com> wrote:
> >
> 
> Please don't top post to lists.
> 
> > Dear Rob,
> >         You can check my driver for detail:
> >         http://patchwork.kernel.org/patch/11012475/ or patchset 3/3
> 
> I could, or you could just answer my question.
> 
> >
> >         This driver is registered as hardware random number generator, and
> > combines with rng-core.
> >         We want to add one rng hw based on the dts. Is this proper or do you
> > have other suggestion to meet this requirement?
> 
> It depends. There doesn't appear to be any resource configuration, so
> why does it need to be in DT. DT is not the only way instantiate
> drivers.
> 
> Rob
> 

We would like to consult more about this patch.
We cannot figure out what method should be used instead of DT.
The interface to access firmware is "smc" and firmware function only
exists on certain platforms.
Some DT has similar way, like:
http://github.com/torvalds/linux/blob/master/arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts#L470

	firmware {
		optee {
			compatible = "linaro,optee-tz";
			method = "smc";
		};
	};

Is there any way to instantiate driver on certain platforms without DT?
Could you give us some examples?
Thanks

> >
> >         Thanks
> >
> >
> > On Tue, 2019-07-23 at 01:13 +0800, Rob Herring wrote:
> > > On Mon, Jun 24, 2019 at 03:24:11PM +0800, Neal Liu wrote:
> > > > Document the binding used by the MediaTek ARMv8 SoCs random
> > > > number generator with TrustZone enabled.
> > > >
> > > > Signed-off-by: Neal Liu <neal.liu@mediatek.com>
> > > > ---
> > > >  .../devicetree/bindings/rng/mtk-sec-rng.txt        |   10 ++++++++++
> > > >  1 file changed, 10 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/rng/mtk-sec-rng.txt
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/rng/mtk-sec-rng.txt b/Documentation/devicetree/bindings/rng/mtk-sec-rng.txt
> > > > new file mode 100644
> > > > index 0000000..c04ce15
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/rng/mtk-sec-rng.txt
> > > > @@ -0,0 +1,10 @@
> > > > +MediaTek random number generator with TrustZone enabled
> > > > +
> > > > +Required properties:
> > > > +- compatible : Should be "mediatek,mtk-sec-rng"
> > >
> > > What's the interface to access this?
> > >
> > > A node with a 'compatible' and nothing else is a sign of something that
> > > a parent device should instantiate and doesn't need to be in DT. IOW,
> > > what do complete bindings for firmware functions look like?
> > >
> > > > +
> > > > +Example:
> > > > +
> > > > +hwrng: hwrng {
> > > > +   compatible = "mediatek,mtk-sec-rng";
> > > > +}
> > > > --
> > > > 1.7.9.5
> > > >
> > >
> > > _______________________________________________
> > > Linux-mediatek mailing list
> > > Linux-mediatek@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-mediatek
> >
> >


