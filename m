Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3967CB1C49
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Sep 2019 13:32:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388217AbfIMLbo (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 13 Sep 2019 07:31:44 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:33610 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388181AbfIMLba (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 13 Sep 2019 07:31:30 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1i8jnJ-0001Ny-5R; Fri, 13 Sep 2019 21:31:18 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 Sep 2019 21:31:14 +1000
Date:   Fri, 13 Sep 2019 21:31:14 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Uri Shir <uri.shir@arm.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Gilad <gilad@benyossef.com>, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: ccree - enable CTS support in AES-XTS
Message-ID: <20190913113113.GD14972@gondor.apana.org.au>
References: <1567929866-7089-1-git-send-email-uri.shir@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567929866-7089-1-git-send-email-uri.shir@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Sep 08, 2019 at 11:04:26AM +0300, Uri Shir wrote:
> In XTS encryption/decryption the plaintext byte size
> can be >= AES_BLOCK_SIZE. This patch enable the AES-XTS ciphertext
> stealing implementation in ccree driver.
> 
> Signed-off-by: Uri Shir <uri.shir@arm.com>
> ---
>  drivers/crypto/ccree/cc_cipher.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
