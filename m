Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4229F38BFFB
	for <lists+linux-crypto@lfdr.de>; Fri, 21 May 2021 08:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232027AbhEUGty (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 21 May 2021 02:49:54 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55272 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231627AbhEUGty (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 21 May 2021 02:49:54 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1ljyxQ-0003U6-Sk; Fri, 21 May 2021 14:48:29 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ljyxO-00007X-4T; Fri, 21 May 2021 14:48:26 +0800
Date:   Fri, 21 May 2021 14:48:26 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yiyuan guo <yguoaz@gmail.com>
Cc:     linux-crypto@vger.kernel.org, davem@davemloft.net,
        Stephan Mueller <smueller@chronox.de>
Subject: Re: A possible divide by zero bug in drbg_ctr_df
Message-ID: <20210521064825.vhovv7sa5qif2f3j@gondor.apana.org.au>
References: <CAM7=BFrCTTuBkYb-ceX5C=e8VhAuWBVb_pYQ+K0LB1gn3h=hqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM7=BFrCTTuBkYb-ceX5C=e8VhAuWBVb_pYQ+K0LB1gn3h=hqA@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, May 21, 2021 at 11:23:36AM +0800, Yiyuan guo wrote:
> In crypto/drbg.c, the function drbg_ctr_df has the following code:
> 
> padlen = (inputlen + sizeof(L_N) + 1) % (drbg_blocklen(drbg));
> 
> However, the function drbg_blocklen may return zero:
> 
> static inline __u8 drbg_blocklen(struct drbg_state *drbg)
> {
>     if (drbg && drbg->core)
>         return drbg->core->blocklen_bytes;
>     return 0;
> }
> 
> Is it possible to trigger a divide by zero problem here?

Add Stephan to the cc as he is the author.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
