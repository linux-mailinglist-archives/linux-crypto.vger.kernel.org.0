Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD16B5F0498
	for <lists+linux-crypto@lfdr.de>; Fri, 30 Sep 2022 08:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiI3GOV (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 30 Sep 2022 02:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbiI3GOT (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 30 Sep 2022 02:14:19 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCB0132D41;
        Thu, 29 Sep 2022 23:14:18 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oe9Hm-00A54Y-HK; Fri, 30 Sep 2022 16:14:11 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 30 Sep 2022 14:14:10 +0800
Date:   Fri, 30 Sep 2022 14:14:10 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     George Cherian <gcherian@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Daney <david.daney@cavium.com>,
        linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] crypto: cavium - prevent integer overflow loading
 firmware
Message-ID: <YzaJMu191++1ptvq@gondor.apana.org.au>
References: <YygPj8aYTvApOQFB@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YygPj8aYTvApOQFB@kili>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Sep 19, 2022 at 09:43:27AM +0300, Dan Carpenter wrote:
> The "code_length" value comes from the firmware file.  If your firmware
> is untrusted realistically there is probably very little you can do to
> protect yourself.  Still we try to limit the damage as much as possible.
> Also Smatch marks any data read from the filesystem as untrusted and
> prints warnings if it not capped correctly.
> 
> The "ntohl(ucode->code_length) * 2" multiplication can have an
> integer overflow.
> 
> Fixes: 9e2c7d99941d ("crypto: cavium - Add Support for Octeon-tx CPT Engine")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> v2: The first code removed the " * 2" so it would have caused immediate
>     memory corruption and crashes.
> 
>     Also in version 2 I combine the "if (!mcode->code_size) {" check
>     with the overflow check for better readability.
> 
>  drivers/crypto/cavium/cpt/cptpf_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
