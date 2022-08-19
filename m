Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D29BF599944
	for <lists+linux-crypto@lfdr.de>; Fri, 19 Aug 2022 11:59:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346618AbiHSJyQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 19 Aug 2022 05:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346996AbiHSJyP (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 19 Aug 2022 05:54:15 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BACB6D72;
        Fri, 19 Aug 2022 02:54:12 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oOyha-00CoFN-SG; Fri, 19 Aug 2022 19:54:08 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 19 Aug 2022 17:54:06 +0800
Date:   Fri, 19 Aug 2022 17:54:06 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ignat Korchagin <ignat@cloudflare.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@cloudflare.com
Subject: Re: [PATCH] crypto: akcipher - default implementations for setting
 private/public keys
Message-ID: <Yv9dvvy0rK/1T0sU@gondor.apana.org.au>
References: <20220729165954.991-1-ignat@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220729165954.991-1-ignat@cloudflare.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jul 29, 2022 at 05:59:54PM +0100, Ignat Korchagin wrote:
>
> @@ -132,6 +138,10 @@ int crypto_register_akcipher(struct akcipher_alg *alg)
>  		alg->encrypt = akcipher_default_op;
>  	if (!alg->decrypt)
>  		alg->decrypt = akcipher_default_op;
> +	if (!alg->set_priv_key)
> +		alg->set_priv_key = akcipher_default_set_key;
> +	if (!alg->set_pub_key)
> +		alg->set_pub_key = akcipher_default_set_key;

Under what circumstances could we have an algorithm without a
set_pub_key function?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
