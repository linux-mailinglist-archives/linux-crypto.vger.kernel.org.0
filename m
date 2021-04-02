Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE58352904
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Apr 2021 11:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234275AbhDBJsR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 2 Apr 2021 05:48:17 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:33750 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233718AbhDBJsR (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 2 Apr 2021 05:48:17 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lSGPR-0003VP-TH; Fri, 02 Apr 2021 20:48:11 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Apr 2021 20:48:09 +1100
Date:   Fri, 2 Apr 2021 20:48:09 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Milan Djurovic <mdjurovic@zohomail.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: keywrap: Remove else after break statement
Message-ID: <20210402094809.GF24509@gondor.apana.org.au>
References: <20210326181359.97406-1-mdjurovic@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326181359.97406-1-mdjurovic@zohomail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Mar 26, 2021 at 11:13:59AM -0700, Milan Djurovic wrote:
> Remove the else because the if statement has a break statement. Fix the
> checkpatch.pl warning.
> 
> Signed-off-by: Milan Djurovic <mdjurovic@zohomail.com>
> ---
>  crypto/keywrap.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
