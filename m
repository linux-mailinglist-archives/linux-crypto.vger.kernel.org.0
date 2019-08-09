Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 878C787216
	for <lists+linux-crypto@lfdr.de>; Fri,  9 Aug 2019 08:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729419AbfHIGSm (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 9 Aug 2019 02:18:42 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37396 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725879AbfHIGSm (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 9 Aug 2019 02:18:42 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hvyEN-0007HC-Fn; Fri, 09 Aug 2019 16:18:27 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hvyEK-0002o3-9L; Fri, 09 Aug 2019 16:18:24 +1000
Date:   Fri, 9 Aug 2019 16:18:24 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Hook, Gary" <Gary.Hook@amd.com>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Subject: Re: [PATCH v2] crypto:ccp - Clean up and exit correctly on
 allocation failure
Message-ID: <20190809061824.GI10392@gondor.apana.org.au>
References: <20190731000314.2839-1-gary.hook@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731000314.2839-1-gary.hook@amd.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Jul 31, 2019 at 12:03:25AM +0000, Hook, Gary wrote:
> From: Gary R Hook <gary.hook@amd.com>
> 
> Return and fail driver initialization if a DMA pool or coherent memory
> can't be allocated. Be sure to clean up allocated memory.
> 
> Fixes: 4b394a232df7 ("crypto: ccp - Let a v5 CCP provide the same function as v3")
> 
> Signed-off-by: Gary R Hook <gary.hook@amd.com>
> ---
> 
> Changes since v1:
>  - Switch to devm allocation where appropriate
> 
>  drivers/crypto/ccp/ccp-dev-v5.c | 14 ++++----------
>  1 file changed, 4 insertions(+), 10 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
