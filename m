Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72C957C832E
	for <lists+linux-crypto@lfdr.de>; Fri, 13 Oct 2023 12:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjJMKgF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 13 Oct 2023 06:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjJMKgF (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 13 Oct 2023 06:36:05 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 729E7BB
        for <linux-crypto@vger.kernel.org>; Fri, 13 Oct 2023 03:36:02 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qrFWO-006jWk-Pm; Fri, 13 Oct 2023 18:35:57 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 13 Oct 2023 18:36:01 +0800
Date:   Fri, 13 Oct 2023 18:36:01 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
Subject: Re: [PATCH] crypto: qat - add namespace to driver
Message-ID: <ZSkdkagAaZJRVz4U@gondor.apana.org.au>
References: <20231002085126.11127-2-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002085126.11127-2-giovanni.cabiddu@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Oct 02, 2023 at 09:51:09AM +0100, Giovanni Cabiddu wrote:
> Create CRYPTO_QAT namespace for symbols exported by the qat_common
> module and import those in the QAT drivers. It will reduce the global
> namespace crowdedness and potential misuse or the API.
> 
> This does not introduce any functional change.
> 
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/crypto/intel/qat/qat_4xxx/adf_drv.c       | 1 +
>  drivers/crypto/intel/qat/qat_c3xxx/adf_drv.c      | 1 +
>  drivers/crypto/intel/qat/qat_c3xxxvf/adf_drv.c    | 1 +
>  drivers/crypto/intel/qat/qat_c62x/adf_drv.c       | 1 +
>  drivers/crypto/intel/qat/qat_c62xvf/adf_drv.c     | 1 +
>  drivers/crypto/intel/qat/qat_common/Makefile      | 1 +
>  drivers/crypto/intel/qat/qat_dh895xcc/adf_drv.c   | 1 +
>  drivers/crypto/intel/qat/qat_dh895xccvf/adf_drv.c | 1 +
>  8 files changed, 8 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
