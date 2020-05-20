Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB151DB2C7
	for <lists+linux-crypto@lfdr.de>; Wed, 20 May 2020 14:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbgETML6 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 20 May 2020 08:11:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgETMLt (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 20 May 2020 08:11:49 -0400
Received: from mo6-p02-ob.smtp.rzone.de (mo6-p02-ob.smtp.rzone.de [IPv6:2a01:238:20a:202:5302::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0B27C061A0E;
        Wed, 20 May 2020 05:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1589976702;
        s=strato-dkim-0002; d=chronox.de;
        h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=dxK4Z+9yHO4jSPBzrsgC+jQ7JJM6/ROZjhK04+QSi/s=;
        b=loekasaQ58kKtS65SiEgMbCExdrlarRrN2LXfhbvpn916/r1eY32+fzUCo//cbUcVp
        PUjksE3TEAorh4s8NRDzCaM6bh2Hb9RQx2D1mse4PLSNVsHwQkIwvGYLpurfvQ/cvxnl
        0qhRBSJFGf26sj81y95Mgz6JnpgbesXgZ+ufVjDpkltvmBPocQAkqGNTQL8hA95QGa2C
        62CsSCriKHIcp0YW/0WoYwI45TsH6KRUU6f+tGOcdXdk1FgKo1C0jn7ie5v4OcjTZRBd
        YKZPp9/PY7YBytHFXTP9+gcA0+ggPx3aREDNYCqzIXUhiTz8NSKVYMgzk4S6Tbt02+2z
        BpLg==
X-RZG-AUTH: ":P2ERcEykfu11Y98lp/T7+hdri+uKZK8TKWEqNyiHySGSa9k9xmwdNnzGHXPbI/Sc5g=="
X-RZG-CLASS-ID: mo00
Received: from tauon.chronox.de
        by smtp.strato.de (RZmta 46.7.0 DYNA|AUTH)
        with ESMTPSA id k09005w4KCBZ5LX
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
        Wed, 20 May 2020 14:11:35 +0200 (CEST)
From:   Stephan Mueller <smueller@chronox.de>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Lukasz Stelmach <l.stelmach@samsung.com>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Kukjin Kim <kgene@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Markus Elfring <elfring@users.sourceforge.net>,
        Matthias Brugger <mbrugger@suse.com>,
        Stefan Wahren <wahrenst@gmx.net>, linux-crypto@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: Re: [PATCH v2 1/2] hwrng: iproc-rng200 - Set the quality value
Date:   Wed, 20 May 2020 14:11:34 +0200
Message-ID: <3322411.JsYv2Y6bm7@tauon.chronox.de>
In-Reply-To: <CAJKOXPeBkZ3R2wT9-A8LWkFx0W9KY70VW7JNjwp0RMDRc7hkTg@mail.gmail.com>
References: <15745285.MnsZKaK4VV@tauon.chronox.de> <2041475.ybOAuNAZB8@tauon.chronox.de> <CAJKOXPeBkZ3R2wT9-A8LWkFx0W9KY70VW7JNjwp0RMDRc7hkTg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Am Mittwoch, 20. Mai 2020, 14:00:01 CEST schrieb Krzysztof Kozlowski:

Hi Krzysztof,

> On Wed, 20 May 2020 at 13:53, Stephan Mueller <smueller@chronox.de> wrote:
> > > > That said, the illustrated example is typical for hardware RNGs. Yet
> > > > it is never guaranteed to work that way. Thus, if you can point to
> > > > architecture documentation of your specific hardware RNGs showing that
> > > > the data read from the hardware is pure unconditioned noise data, then
> > > > I have no objections to the patch.
> > > 
> > > I can tell for sure that this is the case for exynos-trng[1].
> > 
> > So you are saying that the output for the exynos-trng is straight from a
> > ring oscillator without any post-processing of any kind?
> 
> Hi,
> 
> I think we will never be able to state this because the manual is
> quite limited in sharing internals. What the driver does and probably
> Lukasz wanted to say is that there is "post processing" block and
> feature which can be disabled. The manual is saying the TRNG block
> generates random data from thermal noise but not how much in a direct
> way. There could be some simple post-processing or not (except the one
> able to on/off). Also manual says this post processing block is there
> to remove statistical weakness from the TRNG block. To me it does not
> prove enough that raw data is really raw...

Unterstood, but can't that statement be added to the commit message?
> 
> Best regards,
> Krzysztof


Ciao
Stephan


