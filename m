Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864135B1903
	for <lists+linux-crypto@lfdr.de>; Thu,  8 Sep 2022 11:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231140AbiIHJnK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 8 Sep 2022 05:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbiIHJnJ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 8 Sep 2022 05:43:09 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D8513B10B;
        Thu,  8 Sep 2022 02:43:08 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oWE3j-002Ogk-2M; Thu, 08 Sep 2022 19:42:56 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 08 Sep 2022 17:42:54 +0800
Date:   Thu, 8 Sep 2022 17:42:54 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     George Cherian <gcherian@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Daney <david.daney@cavium.com>,
        linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] crypto: cavium - prevent integer overflow loading
 firmware
Message-ID: <Yxm5HrtXBiz6gKtv@gondor.apana.org.au>
References: <YxDQpc9IINUuUhQr@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxDQpc9IINUuUhQr@kili>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Sep 01, 2022 at 06:32:53PM +0300, Dan Carpenter wrote:
>
> @@ -263,7 +264,13 @@ static int cpt_ucode_load_fw(struct cpt_device *cpt, const u8 *fw, bool is_ae)
>  	ucode = (struct ucode_header *)fw_entry->data;
>  	mcode = &cpt->mcode[cpt->next_mc_idx];
>  	memcpy(mcode->version, (u8 *)fw_entry->data, CPT_UCODE_VERSION_SZ);
> -	mcode->code_size = ntohl(ucode->code_length) * 2;
> +
> +	code_length = ntohl(ucode->code_length);
> +	if (code_length >= INT_MAX / 2) {
> +		ret = -EINVAL;
> +		goto fw_release;
> +	}
> +	mcode->code_size = code_length;

Where did the "* 2" go?

BTW, what is the threat model here? If the firmware metadata can't
be trusted, shouldn't we be capping the firmware size at a level
a lot lower than INT_MAX?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
