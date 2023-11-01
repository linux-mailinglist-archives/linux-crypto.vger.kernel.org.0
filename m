Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45D317DDC2A
	for <lists+linux-crypto@lfdr.de>; Wed,  1 Nov 2023 06:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346905AbjKAEvf (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 1 Nov 2023 00:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345092AbjKAEve (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 1 Nov 2023 00:51:34 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04A59101
        for <linux-crypto@vger.kernel.org>; Tue, 31 Oct 2023 21:51:27 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qy3C9-00D9Tv-4j; Wed, 01 Nov 2023 12:51:10 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 01 Nov 2023 12:51:15 +0800
Date:   Wed, 1 Nov 2023 12:51:15 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     agk@redhat.com, snitzer@kernel.org, dm-devel@lists.linux.dev,
        linux-crypto@vger.kernel.org, gilad@benyossef.com,
        samitolvanen@google.com
Subject: Re: [PATCH] dm-verity: hash blocks with shash import+finup when
 possible
Message-ID: <ZUHZQ3tJH0WSV9dX@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231030023351.6041-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:
>
> +       driver_name = crypto_ahash_driver_name(ahash);
> +       if (v->version >= 1 /* salt prepended, not appended? */ &&
> +           1 << v->data_dev_block_bits <= PAGE_SIZE) {
> +               shash = crypto_alloc_shash(alg_name, 0, 0);

I'm sorry but this is disgusting.

Can't we do the same optimisation for the ahash import+finup path?

On a side note, if we're going to use shash for bulk data then we
should reintroduce the can/cannot sleep flag.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
