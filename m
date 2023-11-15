Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 054397DB619
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Oct 2023 10:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbjJ3J0G (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 30 Oct 2023 05:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232453AbjJ3J0B (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 30 Oct 2023 05:26:01 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0A7EE;
        Mon, 30 Oct 2023 02:25:57 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qxOWl-00CSLu-P2; Mon, 30 Oct 2023 17:25:44 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 30 Oct 2023 17:25:50 +0800
Date:   Mon, 30 Oct 2023 17:25:50 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Mahmoud Adam <mngyadam@amazon.com>,
        "David S. Miller" <davem@davemloft.net>,
        Stephan Mueller <smueller@chronox.de>,
        linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] crypto: rsa - add a check for allocation failure
Message-ID: <ZT92nv/HG5LBTnND@gondor.apana.org.au>
References: <d870c278-3f0e-4386-a58d-c9e2c97a7c6c@moroto.mountain>
 <ZT9zRaTmFp6xl9x3@gondor.apana.org.au>
 <43d34a02-fc43-4ce8-b3ca-d996cf605ba2@kadam.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43d34a02-fc43-4ce8-b3ca-d996cf605ba2@kadam.mountain>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Oct 30, 2023 at 12:15:19PM +0300, Dan Carpenter wrote:
>
> The checker is not wrong.  Kernel policy is that every allocation has
> to be checked for failure.  In *current* kernels it won't but we have
> discussed changing this so the policy makes sense.

Nevermind, I misread it as kmalloc(0).  mpi_alloc(0) can indeed
fail because it's not allocating nothing.

I'll take this patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
