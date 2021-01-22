Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D788F2FFC7E
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Jan 2021 07:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726072AbhAVGWP (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 22 Jan 2021 01:22:15 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54146 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbhAVGWO (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 22 Jan 2021 01:22:14 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l2pov-000229-VQ; Fri, 22 Jan 2021 17:21:23 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 Jan 2021 17:21:21 +1100
Date:   Fri, 22 Jan 2021 17:21:21 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ovidiu Panait <ovidiu.panait@windriver.com>
Cc:     daniele.alessandrelli@intel.com, linux-crypto@vger.kernel.org,
        davem@davemloft.net
Subject: Re: [PATCH] crypto: keembay: ocs-aes: use 64-bit arithmetic for
 computing bit_len
Message-ID: <20210122062121.GE1217@gondor.apana.org.au>
References: <20210115204605.36834-1-ovidiu.panait@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115204605.36834-1-ovidiu.panait@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jan 15, 2021 at 10:46:05PM +0200, Ovidiu Panait wrote:
> src_size and aad_size are defined as u32, so the following expressions are
> currently being evaluated using 32-bit arithmetic:
> 
> bit_len = src_size * 8;
> ...
> bit_len = aad_size * 8;
> 
> However, bit_len is used afterwards in a context that expects a valid
> 64-bit value (the lower and upper 32-bit words of bit_len are extracted
> and written to hw).
> 
> In order to make sure the correct bit length is generated and the 32-bit
> multiplication does not wrap around, cast src_size and aad_size to u64.
> 
> Signed-off-by: Ovidiu Panait <ovidiu.panait@windriver.com>
> ---
>  drivers/crypto/keembay/ocs-aes.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
