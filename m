Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1F142FC91
	for <lists+linux-crypto@lfdr.de>; Thu, 30 May 2019 15:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfE3Nnl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 30 May 2019 09:43:41 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:38070 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfE3Nnl (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 30 May 2019 09:43:41 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hWLLI-0005fZ-FN; Thu, 30 May 2019 21:43:40 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hWLLH-0003hG-FO; Thu, 30 May 2019 21:43:39 +0800
Date:   Thu, 30 May 2019 21:43:39 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sascha Hauer <s.hauer@pengutronix.de>
Cc:     linux-crypto@vger.kernel.org,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
        kernel@pengutronix.de
Subject: Re: [PATCH 1/4] crypto: caam - print IV only when non NULL
Message-ID: <20190530134339.p6t6tj2xyq7enpsl@gondor.apana.org.au>
References: <20190523085030.4969-1-s.hauer@pengutronix.de>
 <20190523085030.4969-2-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190523085030.4969-2-s.hauer@pengutronix.de>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, May 23, 2019 at 10:50:27AM +0200, Sascha Hauer wrote:
> Since eaed71a44ad9 ("crypto: caam - add ecb(*) support") the IV can be
> NULL, so only dump it when it's non NULL as designated by the ivsize
> variable.
> 
> Fixes: eaed71a44ad9 ("crypto: caam - add ecb(*) support")
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  drivers/crypto/caam/caamalg.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
