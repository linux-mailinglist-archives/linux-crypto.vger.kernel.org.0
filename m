Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40F9832C333
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Mar 2021 01:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356730AbhCDAHN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 3 Mar 2021 19:07:13 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:37046 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241086AbhCCK0o (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 3 Mar 2021 05:26:44 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lHNg3-0000S4-Mt; Wed, 03 Mar 2021 20:20:20 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 03 Mar 2021 20:20:19 +1100
Date:   Wed, 3 Mar 2021 20:20:19 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, mpm@selenic.com,
        nsaenzjulienne@suse.de, f.fainelli@gmail.com, rjui@broadcom.com,
        sbranden@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        rikard.falkeborn@gmail.com, linux-crypto@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        stijn@linux-ipv6.be, ynezz@true.cz
Subject: Re: [PATCH] hwrng: bcm2835: set quality to 1000
Message-ID: <20210303092019.GB8134@gondor.apana.org.au>
References: <20210220174741.23665-1-noltari@gmail.com>
 <YDFeao/bOxvoXI9D@lunn.ch>
 <9b86c773-7153-1e18-472a-f66b01c83173@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b86c773-7153-1e18-472a-f66b01c83173@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Feb 20, 2021 at 08:12:45PM +0100, �lvaro Fern�ndez Rojas wrote:
> 
> I ran rngtest and this is what I got:

This is meaningless except for sources that have not been whitened.

Your justification needs to be based on what the hardware does or
is documented to do.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
