Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7EBA23BA6F
	for <lists+linux-crypto@lfdr.de>; Tue,  4 Aug 2020 14:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgHDMdp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 4 Aug 2020 08:33:45 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55652 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgHDMdo (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 4 Aug 2020 08:33:44 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k2w8U-0006wE-6E; Tue, 04 Aug 2020 22:33:43 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 04 Aug 2020 22:33:42 +1000
Date:   Tue, 4 Aug 2020 22:33:42 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH] crypto: ccree - Delete non-standard algorithms
Message-ID: <20200804123342.GA12191@gondor.apana.org.au>
References: <20200728040446.GA12763@gondor.apana.org.au>
 <CAOtvUMc-RnxJ2c=GaTpS5nNd0xjKqd1zyFPO=5_ANCzMYXFU1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOtvUMc-RnxJ2c=GaTpS5nNd0xjKqd1zyFPO=5_ANCzMYXFU1w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Aug 04, 2020 at 03:32:40PM +0300, Gilad Ben-Yossef wrote:
>
> Sigh... yes, these were left in because I I thought it might be
> interesting to bring support
> for these algorithms (including a generic implementation) into
> dm-crypt but alas, there seems
> to be no interest.

I think we definitely should do them at some point.  But we need
to do this in a way that is general rather than specific to one
driver.

> If it's OK with you instead of this patch I'll send a patch series
> that also removes the support for
> these from the driver, not just the registration, as there is no point
> in carrying dead code.

Sure, I'll wait for your patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
