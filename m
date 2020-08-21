Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621ED24D023
	for <lists+linux-crypto@lfdr.de>; Fri, 21 Aug 2020 09:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728305AbgHUH6Y (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 21 Aug 2020 03:58:24 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50026 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728147AbgHUH6X (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 21 Aug 2020 03:58:23 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k91wE-00043T-76; Fri, 21 Aug 2020 17:58:15 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Aug 2020 17:58:14 +1000
Date:   Fri, 21 Aug 2020 17:58:14 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     trix@redhat.com
Cc:     mpm@selenic.com, arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hwrng : cleanup initialization
Message-ID: <20200821075814.GL25143@gondor.apana.org.au>
References: <20200809150423.31557-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200809150423.31557-1-trix@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Aug 09, 2020 at 08:04:23AM -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> clang static analysis reports this problem
> 
> intel-rng.c:333:2: warning: Assigned value is garbage or undefined
>         void __iomem *mem = mem;
>         ^~~~~~~~~~~~~~~~~   ~~~
> 
> Because mem is assigned before it is used, this is not
> a real problem.  But the initialization is strange and not
> needed, so remove it.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/char/hw_random/intel-rng.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
