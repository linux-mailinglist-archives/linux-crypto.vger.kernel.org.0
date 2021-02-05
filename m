Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6DCD3103BE
	for <lists+linux-crypto@lfdr.de>; Fri,  5 Feb 2021 04:39:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhBEDjK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 4 Feb 2021 22:39:10 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54496 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229989AbhBEDjK (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 4 Feb 2021 22:39:10 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l7rwf-0002Zf-Kp; Fri, 05 Feb 2021 14:38:10 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Feb 2021 14:38:09 +1100
Date:   Fri, 5 Feb 2021 14:38:09 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     dingsenjie@163.com
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, dingsenjie@yulong.com
Subject: Re: [PATCH] crypto/ccree: fix spelling typo of allocated
Message-ID: <20210205033809.GA14665@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210126034553.44496-1-dingsenjie@163.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

dingsenjie@163.com wrote:
> From: dingsenjie <dingsenjie@yulong.com>
> 
> allocted -> allocated
> 
> Signed-off-by: dingsenjie <dingsenjie@yulong.com>
> ---
> drivers/crypto/ccree/cc_cipher.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
