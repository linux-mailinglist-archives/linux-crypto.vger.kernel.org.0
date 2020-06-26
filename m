Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097BA20AA35
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2020 03:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgFZBmR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 25 Jun 2020 21:42:17 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51306 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727876AbgFZBmR (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 25 Jun 2020 21:42:17 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jodNd-0001zz-4M; Fri, 26 Jun 2020 11:42:14 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Jun 2020 11:42:13 +1000
Date:   Fri, 26 Jun 2020 11:42:13 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com
Subject: Re: [PATCH 4/4] crypto: qat - fallback for xts with 192 bit keys
Message-ID: <20200626014213.GA2234@gondor.apana.org.au>
References: <20200625125904.142840-1-giovanni.cabiddu@intel.com>
 <20200625125904.142840-5-giovanni.cabiddu@intel.com>
 <20200625195649.GA151942@silpixa00400314>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200625195649.GA151942@silpixa00400314>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jun 25, 2020 at 08:56:49PM +0100, Giovanni Cabiddu wrote:
> On Thu, Jun 25, 2020 at 01:59:04PM +0100, Giovanni Cabiddu wrote:
> > +	ctx->ftfm = crypto_alloc_skcipher("xts(aes)", 0, CRYPTO_ALG_ASYNC);
> > +	if (IS_ERR(ctx->ftfm))
> > +		return(PTR_ERR(ctx->ftfm));
> I just realized I added an extra pair of parenthesis around PTR_ERR.
> Below is a new version with this changed.
> 
> ----8<----
> Subject: [PATCH] crypto: qat - fallback for xts with 192 bit keys

Sorry but this doesn't work with patchwork as your new patch just
shows up as a comment on the old one.  Please repost the whole
series.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
