Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68FBCB4E03
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Sep 2019 14:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbfIQMk2 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 17 Sep 2019 08:40:28 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34036 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728123AbfIQMk2 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 17 Sep 2019 08:40:28 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iACmL-0008IP-Ik; Tue, 17 Sep 2019 22:40:22 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 17 Sep 2019 22:40:18 +1000
Date:   Tue, 17 Sep 2019 22:40:18 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Laurent Vivier <lvivier@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Amit Shah <amit@kernel.org>,
        linux-crypto@vger.kernel.org, Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] hw_random: don't wait on add_early_randomness()
Message-ID: <20190917124018.GA32437@gondor.apana.org.au>
References: <20190917095450.11625-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917095450.11625-1-lvivier@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Sep 17, 2019 at 11:54:50AM +0200, Laurent Vivier wrote:
> add_early_randomness() is called by hwrng_register() when the
> hardware is added. If this hardware and its module are present
> at boot, and if there is no data available the boot hangs until
> data are available and can't be interrupted.
> 
> To avoid that, call rng_get_data() in non-blocking mode (wait=0)
> from add_early_randomness().
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> ---
>  drivers/char/hw_random/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please provide more context in your patch description such as which
driver actually causes a hang here.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
