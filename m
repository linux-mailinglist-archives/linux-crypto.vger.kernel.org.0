Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54DE311A791
	for <lists+linux-crypto@lfdr.de>; Wed, 11 Dec 2019 10:40:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfLKJkb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 11 Dec 2019 04:40:31 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54468 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbfLKJkb (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 11 Dec 2019 04:40:31 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ieyTp-0000DT-VC; Wed, 11 Dec 2019 17:40:26 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ieyTp-00071q-PC; Wed, 11 Dec 2019 17:40:25 +0800
Date:   Wed, 11 Dec 2019 17:40:25 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sami Tolvanen <samitolvanen@google.com>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Eric Biggers <ebiggers@google.com>,
        Kees Cook <keescook@chromium.org>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v4] crypto: arm64/sha: fix function types
Message-ID: <20191211094025.6gagdb5iwk7bcjr3@gondor.apana.org.au>
References: <20191112223046.176097-1-samitolvanen@google.com>
 <20191127235503.93635-1-samitolvanen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127235503.93635-1-samitolvanen@google.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Nov 27, 2019 at 03:55:03PM -0800, Sami Tolvanen wrote:
> Instead of casting pointers to callback functions, add C wrappers
> to avoid type mismatch failures with Control-Flow Integrity (CFI)
> checking.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> Changes in v4:
>   - Removed unnecessary returns.
> 
> Changes in v3:
>   - Removed unnecessary inline attributes.
> 
> Changes in v2:
>   - Added wrapper functions instead of changing parameter types
>     for the assembly functions.
> 
> ---
>  arch/arm64/crypto/sha1-ce-glue.c   | 17 +++++++++------
>  arch/arm64/crypto/sha2-ce-glue.c   | 34 ++++++++++++++++++------------
>  arch/arm64/crypto/sha256-glue.c    | 32 +++++++++++++++++-----------
>  arch/arm64/crypto/sha512-ce-glue.c | 26 ++++++++++++-----------
>  arch/arm64/crypto/sha512-glue.c    | 15 ++++++++-----
>  5 files changed, 76 insertions(+), 48 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
