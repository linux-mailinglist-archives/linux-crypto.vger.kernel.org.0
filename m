Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7377D07DA
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Oct 2023 07:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbjJTFxC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Oct 2023 01:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235619AbjJTFxC (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Oct 2023 01:53:02 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C64D1A6
        for <linux-crypto@vger.kernel.org>; Thu, 19 Oct 2023 22:52:57 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qtiRI-0097Yc-Le; Fri, 20 Oct 2023 13:52:53 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Oct 2023 13:52:58 +0800
Date:   Fri, 20 Oct 2023 13:52:58 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH 0/4] crypto: adiantum optimizations
Message-ID: <ZTIVuuUYkIDmyKE4@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010055946.263981-1-ebiggers@kernel.org>
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
> This series slightly improves the performance of adiantum encryption and
> decryption on single-page messages.
> 
> Eric Biggers (4):
>  crypto: adiantum - add fast path for single-page messages
>  crypto: arm/nhpoly1305 - implement ->digest
>  crypto: arm64/nhpoly1305 - implement ->digest
>  crypto: x86/nhpoly1305 - implement ->digest
> 
> arch/arm/crypto/nhpoly1305-neon-glue.c   |  9 ++++
> arch/arm64/crypto/nhpoly1305-neon-glue.c |  9 ++++
> arch/x86/crypto/nhpoly1305-avx2-glue.c   |  9 ++++
> arch/x86/crypto/nhpoly1305-sse2-glue.c   |  9 ++++
> crypto/adiantum.c                        | 65 +++++++++++++++++-------
> 5 files changed, 83 insertions(+), 18 deletions(-)
> 
> base-commit: 8468516f9f93a41dc65158b6428a1a1039c68f20

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
