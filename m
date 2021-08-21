Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEA463F396B
	for <lists+linux-crypto@lfdr.de>; Sat, 21 Aug 2021 09:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbhHUHvY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 21 Aug 2021 03:51:24 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53816 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233018AbhHUHvS (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 21 Aug 2021 03:51:18 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mHLm2-0006IM-G4; Sat, 21 Aug 2021 15:50:38 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mHLm2-0000vP-D8; Sat, 21 Aug 2021 15:50:38 +0800
Date:   Sat, 21 Aug 2021 15:50:38 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Changbin Du <changbin.du@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: in_irq() cleanup
Message-ID: <20210821075038.GG3392@gondor.apana.org.au>
References: <20210814011114.4842-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210814011114.4842-1-changbin.du@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Aug 14, 2021 at 09:11:14AM +0800, Changbin Du wrote:
> Replace the obsolete and ambiguos macro in_irq() with new
> macro in_hardirq().
> 
> Signed-off-by: Changbin Du <changbin.du@gmail.com>
> ---
>  crypto/skcipher.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
