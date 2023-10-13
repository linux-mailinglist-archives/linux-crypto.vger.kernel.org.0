Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8767C82BF
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Oct 2023 12:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbjJMKNX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 13 Oct 2023 06:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjJMKNW (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 13 Oct 2023 06:13:22 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1A71A9
        for <linux-crypto@vger.kernel.org>; Fri, 13 Oct 2023 03:13:19 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qrFAQ-006iwe-L0; Fri, 13 Oct 2023 18:13:15 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 Oct 2023 18:13:19 +0800
Date:   Fri, 13 Oct 2023 18:13:19 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: xts - use 'spawn' for underlying single-block
 cipher
Message-ID: <ZSkYPxtzbdcinLGx@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231009023116.266210-1-ebiggers@kernel.org>
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
>
> static int xts_create(struct crypto_template *tmpl, struct rtattr **tb)
> {
>        struct skcipher_instance *inst;
>        struct xts_instance_ctx *ctx;
>        struct skcipher_alg *alg;
>        const char *cipher_name;
> +       char name[CRYPTO_MAX_ALG_NAME];

Please keep the line sorting from longest to shortest.  I'll
fix this one by hand so this is just for future reference.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
