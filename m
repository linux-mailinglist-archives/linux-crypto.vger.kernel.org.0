Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC046219A6F
	for <lists+linux-crypto@lfdr.de>; Thu,  9 Jul 2020 10:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbgGIIGQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 9 Jul 2020 04:06:16 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35058 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726118AbgGIIGP (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 9 Jul 2020 04:06:15 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jtRZN-0006mx-31; Thu, 09 Jul 2020 18:06:14 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 09 Jul 2020 18:06:13 +1000
Date:   Thu, 9 Jul 2020 18:06:13 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org, j-keerthy@ti.com
Subject: Re: [PATCHv5 2/7] crypto: sa2ul: Add crypto driver
Message-ID: <20200709080612.GA16409@gondor.apana.org.au>
References: <20200701080553.22604-1-t-kristo@ti.com>
 <20200701080553.22604-3-t-kristo@ti.com>
 <20200709080301.GA11760@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200709080301.GA11760@gondor.apana.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jul 09, 2020 at 06:03:01PM +1000, Herbert Xu wrote:
> On Wed, Jul 01, 2020 at 11:05:48AM +0300, Tero Kristo wrote:
> > From: Keerthy <j-keerthy@ti.com>
> > 
> > Adds a basic crypto driver and currently supports AES/3DES
> > in cbc mode for both encryption and decryption.
> > 
> > Signed-off-by: Keerthy <j-keerthy@ti.com>
> > [t-kristo@ti.com: major re-work to fix various bugs in the driver and to
> >  cleanup the code]
> > Signed-off-by: Tero Kristo <t-kristo@ti.com>
> > ---
> >  drivers/crypto/Kconfig  |   14 +
> >  drivers/crypto/Makefile |    1 +
> >  drivers/crypto/sa2ul.c  | 1391 +++++++++++++++++++++++++++++++++++++++
> >  drivers/crypto/sa2ul.h  |  380 +++++++++++
> >  4 files changed, 1786 insertions(+)
> >  create mode 100644 drivers/crypto/sa2ul.c
> >  create mode 100644 drivers/crypto/sa2ul.h
> 
> I get lots of sparse warnings with this driver.  Please fix them
> and resubmit.

Please also compile test with W=1.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
