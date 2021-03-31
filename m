Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11CC934A472
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Mar 2021 10:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbhCZJbv (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 26 Mar 2021 05:31:51 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35390 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230135AbhCZJba (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 26 Mar 2021 05:31:30 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lPioN-0003VM-PV; Fri, 26 Mar 2021 20:31:24 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Mar 2021 20:31:23 +1100
Date:   Fri, 26 Mar 2021 20:31:23 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>
Cc:     atenart@kernel.org, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        rdunlap@infradead.org
Subject: Re: [PATCH] crypto: inside-secure: Minor typo fix in the file
 safexcel.c
Message-ID: <20210326093123.GG12658@gondor.apana.org.au>
References: <20210317091445.614865-1-unixbhaskar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317091445.614865-1-unixbhaskar@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Mar 17, 2021 at 02:44:45PM +0530, Bhaskar Chowdhury wrote:
> 
> s/procesing/processing/
> 
> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
> ---
>  drivers/crypto/inside-secure/safexcel.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
