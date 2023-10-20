Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5CA7D07D1
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Oct 2023 07:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjJTFve (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Oct 2023 01:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233507AbjJTFvd (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Oct 2023 01:51:33 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A55D3CA
        for <linux-crypto@vger.kernel.org>; Thu, 19 Oct 2023 22:51:31 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qtiPv-0097Te-6d; Fri, 20 Oct 2023 13:51:28 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Oct 2023 13:51:32 +0800
Date:   Fri, 20 Oct 2023 13:51:32 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH 0/2] crypto: shash optimizations
Message-ID: <ZTIVZKz3gKte2lih@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009073214.423279-1-ebiggers@kernel.org>
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
> This series fixes some inefficiencies in crypto_shash_digest() and
> crypto_shash_finup(), particularly in cases where the algorithm doesn't
> implement ->digest or ->finup respectively.
> 
> Eric Biggers (2):
>  crypto: shash - optimize the default digest and finup
>  crypto: shash - fold shash_digest_unaligned() into
>    crypto_shash_digest()
> 
> crypto/shash.c | 27 +++++++++++++++++++--------
> 1 file changed, 19 insertions(+), 8 deletions(-)
> 
> 
> base-commit: 8468516f9f93a41dc65158b6428a1a1039c68f20

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
