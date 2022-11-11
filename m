Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DADFB625229
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Nov 2022 05:06:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbiKKEGv (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 10 Nov 2022 23:06:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiKKEGv (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 10 Nov 2022 23:06:51 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78641E8F
        for <linux-crypto@vger.kernel.org>; Thu, 10 Nov 2022 20:06:48 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1otLJV-00Cpzr-Gn; Fri, 11 Nov 2022 12:06:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 11 Nov 2022 12:06:45 +0800
Date:   Fri, 11 Nov 2022 12:06:45 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2 1/6] crypto: optimize algorithm registration when
 self-tests disabled
Message-ID: <Y23KVfTXHy0M7kH8@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110081346.336046-2-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:
>
> @@ -432,17 +448,16 @@ int crypto_register_alg(struct crypto_alg *alg)
>                return err;
> 
>        down_write(&crypto_alg_sem);
> -       larval = __crypto_register_alg(alg);
> -       test_started = static_key_enabled(&crypto_boot_test_finished);
> +       larval = __crypto_register_alg(alg, &algs_to_put);
>        if (!IS_ERR_OR_NULL(larval))
> -               larval->test_started = test_started;
> +               larval->test_started = static_key_enabled(&crypto_boot_test_finished);
>        up_write(&crypto_alg_sem);
> 
> -       if (IS_ERR_OR_NULL(larval))
> +       if (IS_ERR(larval))
>                return PTR_ERR(larval);
> -
> -       if (test_started)
> +       if (larval && larval->test_started)
>                crypto_wait_for_test(larval);
> +       crypto_remove_final(&algs_to_put);
>        return 0;
> }

Is it safe to test larval->test_started instead of the local
test_started? This value could change from false to true behind
your back.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
