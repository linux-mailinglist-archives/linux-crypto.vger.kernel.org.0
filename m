Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 178BD286E44
	for <lists+linux-crypto@lfdr.de>; Thu,  8 Oct 2020 07:46:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgJHFoN (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 8 Oct 2020 01:44:13 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:41226 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgJHFoK (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 8 Oct 2020 01:44:10 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kQOih-0006Th-Oo; Thu, 08 Oct 2020 16:44:04 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 08 Oct 2020 16:44:04 +1100
Date:   Thu, 8 Oct 2020 16:44:04 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] crypto: xor - Remove unused variable count in
 do_xor_speed
Message-ID: <20201008054403.GD9733@gondor.apana.org.au>
References: <20201006195848.707504-1-natechancellor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006195848.707504-1-natechancellor@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Oct 06, 2020 at 12:58:48PM -0700, Nathan Chancellor wrote:
> Clang warns:
> 
> crypto/xor.c:101:4: warning: variable 'count' is uninitialized when used
> here [-Wuninitialized]
>                         count++;
>                         ^~~~~
> crypto/xor.c:86:17: note: initialize the variable 'count' to silence
> this warning
>         int i, j, count;
>                        ^
>                         = 0
> 1 warning generated.
> 
> After the refactoring to use ktime that happened in this function, count
> is only assigned, never read. Just remove the variable to get rid of the
> warning.
> 
> Fixes: c055e3eae0f1 ("crypto: xor - use ktime for template benchmarking")
> Link: https://github.com/ClangBuiltLinux/linux/issues/1171
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> ---
>  crypto/xor.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
