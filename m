Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 168277D07D3
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Oct 2023 07:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233559AbjJTFv7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Oct 2023 01:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235618AbjJTFv6 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Oct 2023 01:51:58 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFC17D51
        for <linux-crypto@vger.kernel.org>; Thu, 19 Oct 2023 22:51:56 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qtiQK-0097Ws-FG; Fri, 20 Oct 2023 13:51:53 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Oct 2023 13:51:58 +0800
Date:   Fri, 20 Oct 2023 13:51:58 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: x86/sha256 - implement ->digest for sha256
Message-ID: <ZTIVfv9FLsPXOT0u@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009081900.503086-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Implement a ->digest function for sha256-ssse3, sha256-avx, sha256-avx2,
> and sha256-ni.  This improves the performance of crypto_shash_digest()
> with these algorithms by reducing the number of indirect calls that are
> made.
> 
> For now, don't bother with this for sha224, since sha224 is rarely used.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> arch/x86/crypto/sha256_ssse3_glue.c | 32 +++++++++++++++++++++++++++++
> 1 file changed, 32 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
