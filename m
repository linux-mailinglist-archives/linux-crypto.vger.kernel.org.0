Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BCB34F74CD
	for <lists+linux-crypto@lfdr.de>; Thu,  7 Apr 2022 06:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240736AbiDGEev (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 7 Apr 2022 00:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240722AbiDGEep (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 7 Apr 2022 00:34:45 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB931EDA2D
        for <linux-crypto@vger.kernel.org>; Wed,  6 Apr 2022 21:32:46 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1ncJp5-001Y5X-3r; Thu, 07 Apr 2022 14:32:44 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 07 Apr 2022 14:32:43 +1000
Date:   Thu, 7 Apr 2022 14:32:43 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org, keescook@chromium.org
Subject: Re: [PATCH 2/8] crypto: safexcel - take request size after setting
 TFM
Message-ID: <Yk5pa7rdMuCGPVG5@gondor.apana.org.au>
References: <20220406142715.2270256-1-ardb@kernel.org>
 <20220406142715.2270256-3-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220406142715.2270256-3-ardb@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Apr 06, 2022 at 04:27:09PM +0200, Ard Biesheuvel wrote:
>
> +#define EIP197_SKCIPHER_REQ_SIZE	(ALIGN(sizeof(struct skcipher_request),	\
> +					       CRYPTO_MINALIGN) +		\

The whole point of CRYPTO_MINALIGN is that it comes for free
via kmalloc.

If you need alignment over and above that of kmalloc, you need
to do it explicitly in the driver.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
