Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BFB367AF2
	for <lists+linux-crypto@lfdr.de>; Thu, 22 Apr 2021 09:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhDVHWC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 22 Apr 2021 03:22:02 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:48444 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229629AbhDVHWC (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 22 Apr 2021 03:22:02 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lZTeO-0002cC-RT; Thu, 22 Apr 2021 17:21:26 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 22 Apr 2021 17:21:24 +1000
Date:   Thu, 22 Apr 2021 17:21:24 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     linux-crypto@vger.kernel.org, linus.walleij@linaro.org,
        linux-kernel@vger.kernel.org
Subject: Re: cortina/gemini: hwrng: what is its quality ?
Message-ID: <20210422072124.GA5610@gondor.apana.org.au>
References: <YICFBQ8mQRJ4zSh9@Red>
 <20210422001430.GA4246@gondor.apana.org.au>
 <YIEdJ3G/QwA8/BEU@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YIEdJ3G/QwA8/BEU@Red>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Apr 22, 2021 at 08:52:23AM +0200, Corentin Labbe wrote:
>
> But as an admin, what value I can set ?
> If I do a rule-of-3, success rate is 73%.
> So does a quality of 730 is ok ?

This is not hard science, the admin can choose whatever value they
like.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
