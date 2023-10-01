Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10BCD7B461E
	for <lists+linux-crypto@lfdr.de>; Sun,  1 Oct 2023 10:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234438AbjJAISz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 1 Oct 2023 04:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234402AbjJAISz (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 1 Oct 2023 04:18:55 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5209DC6
        for <linux-crypto@vger.kernel.org>; Sun,  1 Oct 2023 01:18:51 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qmrf4-002P9t-77; Sun, 01 Oct 2023 16:18:47 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 01 Oct 2023 16:18:50 +0800
Date:   Sun, 1 Oct 2023 16:18:50 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Lucas Segarra Fernandez <lucas.segarra.fernandez@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: Re: [PATCH v5 2/2] crypto: qat - add pm_status debugfs file
Message-ID: <ZRkrasH0zjj2m+GQ@gondor.apana.org.au>
References: <20230922101541.19408-1-lucas.segarra.fernandez@intel.com>
 <20230922101541.19408-3-lucas.segarra.fernandez@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922101541.19408-3-lucas.segarra.fernandez@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Sep 22, 2023 at 12:15:27PM +0200, Lucas Segarra Fernandez wrote:
>
> diff --git a/drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c b/drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c
> new file mode 100644
> index 000000000000..55db62a46497
> --- /dev/null
> +++ b/drivers/crypto/intel/qat/qat_common/adf_gen4_pm_debugfs.c
> @@ -0,0 +1,255 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2023 Intel Corporation */
> +#include <linux/bits.h>
> +#include <linux/dma-mapping.h>
> +#include <linux/slab.h>
> +#include <linux/stddef.h>
> +#include <linux/string_helpers.h>
> +#include <linux/stringify.h>
> +#include <linux/types.h>

The kernel.h comment applies to this patch too.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
