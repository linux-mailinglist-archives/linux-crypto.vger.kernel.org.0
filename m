Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37EEA2FC83
	for <lists+linux-crypto@lfdr.de>; Thu, 30 May 2019 15:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726835AbfE3Nl3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 30 May 2019 09:41:29 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37980 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfE3Nl3 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 30 May 2019 09:41:29 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hWLJA-0005Yv-C6; Thu, 30 May 2019 21:41:28 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hWLJ7-0003dq-13; Thu, 30 May 2019 21:41:25 +0800
Date:   Thu, 30 May 2019 21:41:25 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org,
        Steffen Klassert <steffen.klassert@secunet.com>,
        "David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH] crypto: echainiv - change to 'default n'
Message-ID: <20190530134124.aidn5t5gb4mpdgjq@gondor.apana.org.au>
References: <20190520165207.168925-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520165207.168925-1-ebiggers@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, May 20, 2019 at 09:52:07AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> echainiv is the only algorithm or template in the crypto API that is
> enabled by default.  But there doesn't seem to be a good reason for it.
> And it pulls in a lot of stuff as dependencies, like AEAD support and a
> "NIST SP800-90A DRBG" including HMAC-SHA256.
> 
> The commit which made it default 'm', commit 3491244c6298 ("crypto:
> echainiv - Set Kconfig default to m"), mentioned that it's needed for
> IPsec.  However, later commit 32b6170ca59c ("ipv4+ipv6: Make INET*_ESP
> select CRYPTO_ECHAINIV") made the IPsec kconfig options select it.
> 
> So, remove the 'default m'.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  crypto/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
