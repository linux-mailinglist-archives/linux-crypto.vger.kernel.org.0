Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4523596E6
	for <lists+linux-crypto@lfdr.de>; Fri,  9 Apr 2021 09:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbhDIHzn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 9 Apr 2021 03:55:43 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:52116 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229846AbhDIHzn (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 9 Apr 2021 03:55:43 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lUlzE-0006Q7-Gs; Fri, 09 Apr 2021 17:55:29 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 09 Apr 2021 17:55:28 +1000
Date:   Fri, 9 Apr 2021 17:55:28 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ayush Sawal <ayush.sawal@chelsio.com>
Cc:     linux-crypto@vger.kernel.org, davem@davemloft.net,
        secdev@chelsio.com
Subject: Re: [PATCH crypto] chcr: Read rxchannel-id from firmware
Message-ID: <20210409075528.GM31447@gondor.apana.org.au>
References: <20210402192548.9405-1-ayush.sawal@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210402192548.9405-1-ayush.sawal@chelsio.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Apr 03, 2021 at 12:55:48AM +0530, Ayush Sawal wrote:
> The rxchannel id is updated by the driver using the
> port no value, but this does not ensure that the value
> is correct. So now rx channel value is obtained from
> etoc channel map value.
> 
> Fixes: 567be3a5d227 ("crypto: chelsio - Use multiple txq/rxq per tfm to process the requests)
> Signed-off-by: Ayush Sawal <ayush.sawal@chelsio.com>
> ---
>  drivers/crypto/chelsio/chcr_algo.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
