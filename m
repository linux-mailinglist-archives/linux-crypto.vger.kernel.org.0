Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE7BCBF9C
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Oct 2019 17:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390044AbfJDPpA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Oct 2019 11:45:00 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42622 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389669AbfJDPpA (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Oct 2019 11:45:00 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iGPlE-0001Sy-Ej; Sat, 05 Oct 2019 01:44:53 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Oct 2019 01:44:52 +1000
Date:   Sat, 5 Oct 2019 01:44:52 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eneas U de Queiroz <cotequeiroz@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: qce - add CRYPTO_ALG_KERN_DRIVER_ONLY flag
Message-ID: <20191004154452.GZ5148@gondor.apana.org.au>
References: <20190919213302.9174-1-cotequeiroz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190919213302.9174-1-cotequeiroz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Sep 19, 2019 at 06:33:02PM -0300, Eneas U de Queiroz wrote:
> Set the CRYPTO_ALG_KERN_DRIVER_ONLY flag to all algorithms exposed by
> the qce driver, since they are all hardware accelerated, accessible
> through a kernel driver only, and not available directly to userspace.
> 
> Signed-off-by: Eneas U de Queiroz <cotequeiroz@gmail.com>

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
