Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21247668ABD
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Jan 2023 05:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbjAMERQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 12 Jan 2023 23:17:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235540AbjAMEQV (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 12 Jan 2023 23:16:21 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C01C68CA7
        for <linux-crypto@vger.kernel.org>; Thu, 12 Jan 2023 20:13:13 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pGBRG-00H5JY-6G; Fri, 13 Jan 2023 12:13:11 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 Jan 2023 12:13:10 +0800
Date:   Fri, 13 Jan 2023 12:13:10 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org, ebiggers@kernel.org
Subject: Re: [PATCH] crypto: skcipher - Use scatterwalk (un)map interface for
 dst and src buffers
Message-ID: <Y8DaVjPiZGAPhN1G@gondor.apana.org.au>
References: <20230102101846.116448-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102101846.116448-1-ardb@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jan 02, 2023 at 11:18:46AM +0100, Ard Biesheuvel wrote:
> The skcipher walk API implementation avoids scatterwalk_map() for
> mapping the source and destination buffers, and invokes kmap_atomic()
> directly if the buffer in question is not in low memory (which can only
> happen on 32-bit architectures). This avoids some overhead on 64-bit
> architectures, and most notably, permits the skcipher code to run with
> preemption enabled.
> 
> Now that scatterwalk_map() has been updated to use kmap_local(), none of
> this is needed, so we can simply use scatterwalk_map/unmap instead.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  crypto/skcipher.c | 22 ++++------------------
>  1 file changed, 4 insertions(+), 18 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
