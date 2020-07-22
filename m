Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9995122921E
	for <lists+linux-crypto@lfdr.de>; Wed, 22 Jul 2020 09:31:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgGVH3m (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 22 Jul 2020 03:29:42 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59752 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727096AbgGVH3l (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 22 Jul 2020 03:29:41 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jy9C0-0002pI-51; Wed, 22 Jul 2020 17:29:33 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 22 Jul 2020 17:29:32 +1000
Date:   Wed, 22 Jul 2020 17:29:32 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, mpatocka@redhat.com,
        linux-crypto@vger.kernel.org, dm-devel@redhat.com
Subject: Re: [PATCH v2 0/7] crypto: add CRYPTO_ALG_ALLOCATES_MEMORY
Message-ID: <20200722072932.GA27544@gondor.apana.org.au>
References: <20200716115538.GA31461@gondor.apana.org.au>
 <8eefed8b-5ad5-424b-ab32-85e0cbac0a15@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8eefed8b-5ad5-424b-ab32-85e0cbac0a15@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jul 17, 2020 at 05:42:43PM +0300, Horia Geantă wrote:
>
> Looks like there's no mention of a limit on src, dst scatterlists size
> that crypto implementations could use when pre-allocating memory
> and crypto users needing CRYPTO_ALG_ALLOCATES_MEMORY should be aware of
> (for the contract to be honoured):
> https://lore.kernel.org/linux-crypto/780cb500-2241-61bc-eb44-6f872ad567d3@nxp.com

Good point.  I think we should limit this flag only to the cases
applicable to dm-crypt, which seems to be 4 entries maximum.

Anything else should be allowed to allocate extra memory as needed.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
