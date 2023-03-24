Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64316C7B49
	for <lists+linux-crypto@lfdr.de>; Fri, 24 Mar 2023 10:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230350AbjCXJ1r (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 24 Mar 2023 05:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjCXJ1q (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 24 Mar 2023 05:27:46 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66747E3AB
        for <linux-crypto@vger.kernel.org>; Fri, 24 Mar 2023 02:27:44 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pfdhx-008EFc-VC; Fri, 24 Mar 2023 17:27:39 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 24 Mar 2023 17:27:37 +0800
Date:   Fri, 24 Mar 2023 17:27:37 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: Jitter RNG - Permanent and Intermittent health
 errors
Message-ID: <ZB1tCY3ruqvtWfHS@gondor.apana.org.au>
References: <12194787.O9o76ZdvQC@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <12194787.O9o76ZdvQC@positron.chronox.de>
X-Spam-Status: No, score=4.3 required=5.0 tests=HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Mar 23, 2023 at 08:17:14AM +0100, Stephan M�ller wrote:
>
> @@ -138,29 +139,35 @@ static int jent_kcapi_random(struct crypto_rng *tfm,
>  
>  	spin_lock(&rng->jent_lock);
>  
> -	/* Return a permanent error in case we had too many resets in a row. */
> -	if (rng->reset_cnt > (1<<10)) {
> +	/* Enforce a disabled entropy source. */
> +	if (rng->disabled) {
>  		ret = -EFAULT;
>  		goto out;
>  	}

Can we please get rid of this completely when we're not in FIPS 
mode? Remember that jent is now used by all kernel users through
drbg.  Having it fail permanently in this fashion is unacceptable.

If we're not in FIPS mode it should simply carry on or at least
seek another source of entropy, perhaps from the kernel RNG.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
