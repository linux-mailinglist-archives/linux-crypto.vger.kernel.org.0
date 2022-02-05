Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7D44AA682
	for <lists+linux-crypto@lfdr.de>; Sat,  5 Feb 2022 05:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbiBEEcK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Feb 2022 23:32:10 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:34034 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1379378AbiBEEcK (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Feb 2022 23:32:10 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nGCk3-000269-PG; Sat, 05 Feb 2022 15:32:08 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Feb 2022 15:32:07 +1100
Date:   Sat, 5 Feb 2022 15:32:07 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org,
        Nathan Huckleberry <nhuck@google.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH] crypto: arm64/aes-neon-ctr - improve handling of single
 tail block
Message-ID: <Yf39x1mHvRsM1jvi@gondor.apana.org.au>
References: <20220127095211.3481959-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127095211.3481959-1-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jan 27, 2022 at 10:52:11AM +0100, Ard Biesheuvel wrote:
> Instead of falling back to C code to do a memcpy of the output of the
> last block, handle this in the asm code directly if possible, which is
> the case if the entire input is longer than 16 bytes.
> 
> Cc: Nathan Huckleberry <nhuck@google.com>
> Cc: Eric Biggers <ebiggers@google.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/crypto/aes-glue.c  | 21 +++++++-------------
>  arch/arm64/crypto/aes-modes.S | 18 ++++++++++++-----
>  2 files changed, 20 insertions(+), 19 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
