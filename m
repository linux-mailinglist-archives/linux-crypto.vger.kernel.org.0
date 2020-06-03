Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4C1F1ECCE6
	for <lists+linux-crypto@lfdr.de>; Wed,  3 Jun 2020 11:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgFCJsz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 3 Jun 2020 05:48:55 -0400
Received: from foss.arm.com ([217.140.110.172]:59252 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbgFCJsz (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 3 Jun 2020 05:48:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B576831B;
        Wed,  3 Jun 2020 02:48:54 -0700 (PDT)
Received: from bogus (unknown [10.37.12.118])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2EE943F305;
        Wed,  3 Jun 2020 02:48:51 -0700 (PDT)
Date:   Wed, 3 Jun 2020 10:48:40 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Neal Liu <neal.liu@mediatek.com>
Cc:     Marc Zyngier <maz@kernel.org>, Julius Werner <jwerner@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sean Wang <sean.wang@kernel.org>,
        linux-mediatek@lists.infradead.org,
        lkml <linux-kernel@vger.kernel.org>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Matt Mackall <mpm@selenic.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jose Marinho <Jose.Marinho@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Crystal Guo =?utf-8?B?KOmDreaZtik=?= <Crystal.Guo@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Security Random Number Generator support
Message-ID: <20200603094829.GA7259@bogus>
References: <1591085678-22764-1-git-send-email-neal.liu@mediatek.com>
 <CAMj1kXHjAdk5=-uSh_=S9j5cz42zr3h6t+YYGy+obevuQDp0fg@mail.gmail.com>
 <85dfc0142d3879d50c0ba18bcc71e199@misterjones.org>
 <1591169342.4878.9.camel@mtkswgap22>
 <fcbe37f6f9cbcde24f9c28bc504f1f0e@kernel.org>
 <1591170857.19414.5.camel@mtkswgap22>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1591170857.19414.5.camel@mtkswgap22>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

+ Jose

On Wed, Jun 03, 2020 at 03:54:17PM +0800, Neal Liu wrote:
> On Wed, 2020-06-03 at 08:40 +0100, Marc Zyngier wrote:

[...]

> > The idea is simply to have *one* single ID that caters for all
> > implementations, just like we did for PSCI at the time. This
> > requires ARM to edict a standard, which is what I was referring
> > to above.
> >
> > There is zero benefit in having a platform-dependent ID. It just
> > pointlessly increases complexity, and means we cannot use the RNG
> > before the firmware tables are available (yes, we need it that
> > early).
> >
>
> Do you know which ARM expert could edict this standard?
> Or is there any chance that we can make one? And be reviewed by
> maintainers?
>

Jose Marinho is working on the spec, may be he has more updates on the
timeline.

--
Regards,
Sudeep
