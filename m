Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED3D72812FD
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Oct 2020 14:42:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgJBMm2 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 2 Oct 2020 08:42:28 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49326 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgJBMm1 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 2 Oct 2020 08:42:27 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kOKOF-0006lI-Qr; Fri, 02 Oct 2020 22:42:24 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Oct 2020 22:42:23 +1000
Date:   Fri, 2 Oct 2020 22:42:23 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        Kim Phillips <kim.phillips@arm.com>
Subject: Re: [PATCH] crypto: talitos - Fix sparse warnings
Message-ID: <20201002124223.GA1547@gondor.apana.org.au>
References: <20201002115236.GA14707@gondor.apana.org.au>
 <be222fed-425b-d55c-3efc-9c4e873ccf8e@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be222fed-425b-d55c-3efc-9c4e873ccf8e@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Oct 02, 2020 at 02:40:00PM +0200, Christophe Leroy wrote:
>
> However I guess the initial intention was to avoid conversion as much as
> possible. Most tests and bit wise operations can be done regardless of the
> endianess, that's the reason why the endianness conversion was applied to
> constants, in order to apply them at build time and avoid converting vars
> back and forth during runtime.
> 
> I have not looked at your patch in details but I have the feeling you are
> defeating this initial purpose.

I don't think that's a valid optimisation unless it's backed up
with real numbers.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
