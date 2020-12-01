Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DBF92CAFDA
	for <lists+linux-crypto@lfdr.de>; Tue,  1 Dec 2020 23:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgLAWRR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 1 Dec 2020 17:17:17 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:51272 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbgLAWRR (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 1 Dec 2020 17:17:17 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kkDwi-00024w-II; Wed, 02 Dec 2020 09:16:29 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 02 Dec 2020 09:16:28 +1100
Date:   Wed, 2 Dec 2020 09:16:28 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Ben Greear <greearb@candelatech.com>,
        Steve deRosier <derosier@cal-sierra.com>
Subject: Re: [PATCH v2] crypto: aesni - add ccm(aes) algorithm implementation
Message-ID: <20201201221628.GA32130@gondor.apana.org.au>
References: <20201201194556.5220-1-ardb@kernel.org>
 <20201201215722.GA31941@gondor.apana.org.au>
 <CAMj1kXHb27ugTWuQZhPD0DvjtgYC8t_pj+igqK7dNfh+WsUS4w@mail.gmail.com>
 <20201201220431.GA32072@gondor.apana.org.au>
 <CAMj1kXGO+kbZ+2VmUQKxLYos2nR5vqZKjengxPxPjSXudG-zLw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGO+kbZ+2VmUQKxLYos2nR5vqZKjengxPxPjSXudG-zLw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Dec 01, 2020 at 11:12:32PM +0100, Ard Biesheuvel wrote:
>
> What do you mean by just one direction? Ben just confirmed a

The TX direction generally executes in process context, which
would benefit from an accelerated sync implementation.  The RX
side on the other hand is always in softirq context.

> substantial speedup for his use case, which requires the use of
> software encryption even on hardware that could support doing it in
> hardware, and that software encryption currently only supports the
> synchronous interface.

The problem is that the degradation would come at the worst time,
when the system is loaded.  IOW when you get an interrupt during
your TX path and get RX traffic that's when you'll take the fallback
path.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
