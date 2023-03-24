Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744DF6C7BE7
	for <lists+linux-crypto@lfdr.de>; Fri, 24 Mar 2023 10:49:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjCXJtT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 24 Mar 2023 05:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230071AbjCXJtS (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 24 Mar 2023 05:49:18 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE228E;
        Fri, 24 Mar 2023 02:49:17 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1pfe2P-008EuX-M7; Fri, 24 Mar 2023 17:48:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 24 Mar 2023 17:48:45 +0800
Date:   Fri, 24 Mar 2023 17:48:45 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v3 4/4] crypto: starfive - Add hash and HMAC support
Message-ID: <ZB1x/bUdOSWzim+8@gondor.apana.org.au>
References: <20230313135646.2077707-1-jiajie.ho@starfivetech.com>
 <20230313135646.2077707-5-jiajie.ho@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230313135646.2077707-5-jiajie.ho@starfivetech.com>
X-Spam-Status: No, score=4.3 required=5.0 tests=HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,TVD_RCVD_IP
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Mar 13, 2023 at 09:56:46PM +0800, Jia Jie Ho wrote:
>
> +static int starfive_hash_copy_sgs(struct starfive_cryp_request_ctx *rctx)
> +{
> +	void *buf_in;
> +	int pages, total_in;
> +
> +	if (!starfive_hash_check_io_aligned(rctx)) {
> +		rctx->sgs_copied = 0;
> +		return 0;
> +	}
> +
> +	total_in = ALIGN(rctx->total, rctx->blksize);
> +	pages = total_in ? get_order(total_in) : 1;
> +	buf_in = (void *)__get_free_pages(GFP_ATOMIC, pages);

Please don't allocate the whole thing because it could be unlimited
in size (and triggered from user-space by untrusted users too).

If you have to copy, then just allocate a single page and copy
that, hash, and then repeat until it's all done.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
