Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65EB5B18CF
	for <lists+linux-crypto@lfdr.de>; Thu,  8 Sep 2022 11:35:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiIHJfU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 8 Sep 2022 05:35:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiIHJfT (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 8 Sep 2022 05:35:19 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C37972EC6;
        Thu,  8 Sep 2022 02:35:12 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oWDvm-002OS8-HJ; Thu, 08 Sep 2022 19:34:43 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 08 Sep 2022 17:34:42 +0800
Date:   Thu, 8 Sep 2022 17:34:42 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        "David S. Miller" <davem@davemloft.net>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Lukasz Bartosik <lbartosik@marvell.com>,
        linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] crypto: marvell/octeontx - prevent integer overflows
Message-ID: <Yxm3MuG+2hMdJSGB@gondor.apana.org.au>
References: <YxDQeeqY6u5EBn5H@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxDQeeqY6u5EBn5H@kili>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Sep 01, 2022 at 06:32:09PM +0300, Dan Carpenter wrote:
>
> @@ -303,7 +304,13 @@ static int process_tar_file(struct device *dev,
>  	if (get_ucode_type(ucode_hdr, &ucode_type))
>  		return 0;
>  
> -	ucode_size = ntohl(ucode_hdr->code_length) * 2;
> +	code_length = ntohl(ucode_hdr->code_length);
> +	if (code_length >= INT_MAX / 2) {
> +		dev_err(dev, "Invalid code_length %u\n", code_length);
> +		return -EINVAL;
> +	}
> +
> +	ucode_size = code_length * 2;
>  	if (!ucode_size || (size < round_up(ucode_size, 16) +
>  	    sizeof(struct otx_cpt_ucode_hdr) + OTX_CPT_UCODE_SIGN_LEN)) {
>  		dev_err(dev, "Ucode %s invalid size\n", filename);

How come you didn't add a "ucode_size > size" check like you did
below?

> @@ -896,9 +904,16 @@ static int ucode_load(struct device *dev, struct otx_cpt_ucode *ucode,
>  	ucode_hdr = (struct otx_cpt_ucode_hdr *) fw->data;
>  	memcpy(ucode->ver_str, ucode_hdr->ver_str, OTX_CPT_UCODE_VER_STR_SZ);
>  	ucode->ver_num = ucode_hdr->ver_num;
> -	ucode->size = ntohl(ucode_hdr->code_length) * 2;
> -	if (!ucode->size || (fw->size < round_up(ucode->size, 16)
> -	    + sizeof(struct otx_cpt_ucode_hdr) + OTX_CPT_UCODE_SIGN_LEN)) {
> +	code_length = ntohl(ucode_hdr->code_length);
> +	if (code_length >= INT_MAX / 2) {
> +		ret = -EINVAL;
> +		goto release_fw;
> +	}
> +	ucode->size = code_length * 2;
> +	if (!ucode->size ||
> +	    ucode->size > fw->size ||
> +	    (fw->size < round_up(ucode->size, 16) +
> +	     sizeof(struct otx_cpt_ucode_hdr) + OTX_CPT_UCODE_SIGN_LEN)) {
>  		dev_err(dev, "Ucode %s invalid size\n", ucode_filename);
>  		ret = -EINVAL;
>  		goto release_fw;
> -- 
> 2.35.1

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
