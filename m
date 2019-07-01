Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D27122FC81
	for <lists+linux-crypto@lfdr.de>; Thu, 30 May 2019 15:41:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfE3NlO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 30 May 2019 09:41:14 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37968 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725913AbfE3NlO (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 30 May 2019 09:41:14 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hWLIv-0005Xn-4N; Thu, 30 May 2019 21:41:13 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hWLIu-0003dO-VR; Thu, 30 May 2019 21:41:13 +0800
Date:   Thu, 30 May 2019 21:41:12 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: testmgr - make extra tests depend on cryptomgr
Message-ID: <20190530134112.d7xzk3kmcvgrgfrp@gondor.apana.org.au>
References: <20190520164829.167433-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190520164829.167433-1-ebiggers@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, May 20, 2019 at 09:48:29AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The crypto self-tests are part of the "cryptomgr" module, which can
> technically be disabled (though it rarely is).  If you do so, currently
> you can still enable CRYPTO_MANAGER_EXTRA_TESTS, which doesn't make
> sense since in that case testmgr.c isn't compiled at all.  Fix it by
> making it CRYPTO_MANAGER_EXTRA_TESTS depend on CRYPTO_MANAGER2, like
> CRYPTO_MANAGER_DISABLE_TESTS already does.
> 
> Fixes: 5b2706a4d459 ("crypto: testmgr - introduce CONFIG_CRYPTO_MANAGER_EXTRA_TESTS")
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  crypto/Kconfig | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
