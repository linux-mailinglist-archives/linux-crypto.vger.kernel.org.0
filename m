Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C64A26F6EB
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Sep 2020 09:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726216AbgIRH21 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 18 Sep 2020 03:28:27 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:57588 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726322AbgIRH21 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 18 Sep 2020 03:28:27 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kJAof-0003TQ-Mk; Fri, 18 Sep 2020 17:28:22 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Sep 2020 17:28:21 +1000
Date:   Fri, 18 Sep 2020 17:28:21 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH] crypto: omap-sham: convert to use crypto engine
Message-ID: <20200918072821.GA23319@gondor.apana.org.au>
References: <20200907075610.32326-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200907075610.32326-1-t-kristo@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Sep 07, 2020 at 10:56:10AM +0300, Tero Kristo wrote:
> Convert the omap-sham driver to use crypto engine for queue handling,
> instead of using local implementation.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/crypto/omap-sham.c | 186 ++++++++++++++++---------------------
>  1 file changed, 78 insertions(+), 108 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
