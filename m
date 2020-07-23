Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49BE22AA2F
	for <lists+linux-crypto@lfdr.de>; Thu, 23 Jul 2020 09:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgGWH6D (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 23 Jul 2020 03:58:03 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34744 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgGWH6D (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 23 Jul 2020 03:58:03 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jyW76-0005xw-88; Thu, 23 Jul 2020 17:58:01 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 23 Jul 2020 17:58:00 +1000
Date:   Thu, 23 Jul 2020 17:58:00 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        David Miller <davem@davemloft.net>
Subject: Re: [PATCH] crypto: skcipher.h: drop duplicated word in kernel-doc
Message-ID: <20200723075800.GF14246@gondor.apana.org.au>
References: <c031a64c-2337-cd9d-e148-ed8365c2365e@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c031a64c-2337-cd9d-e148-ed8365c2365e@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jul 17, 2020 at 04:35:49PM -0700, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Drop the doubled word "request" in a kernel-doc comment.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: linux-crypto@vger.kernel.org
> ---
>  include/crypto/skcipher.h |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
