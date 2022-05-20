Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D679E52E498
	for <lists+linux-crypto@lfdr.de>; Fri, 20 May 2022 07:59:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245118AbiETF7W (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 May 2022 01:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244615AbiETF7W (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 May 2022 01:59:22 -0400
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3EE14AA74
        for <linux-crypto@vger.kernel.org>; Thu, 19 May 2022 22:59:21 -0700 (PDT)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1nrvfS-00Fi0H-7h; Fri, 20 May 2022 15:59:19 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 May 2022 13:59:18 +0800
Date:   Fri, 20 May 2022 13:59:18 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Srinivas Kerekare <srinivas.kerekare@intel.com>
Subject: Re: [PATCH] crypto: qat - add support for 401xx devices
Message-ID: <YocuNpEm6R/dbGdc@gondor.apana.org.au>
References: <20220510165419.182774-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510165419.182774-1-giovanni.cabiddu@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, May 10, 2022 at 05:54:19PM +0100, Giovanni Cabiddu wrote:
> QAT_401xx is a derivative of 4xxx. Add support for that device in the
> qat_4xxx driver by including the DIDs (both PF and VF), extending the
> probe and the firmware loader.
> 
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Srinivas Kerekare <srinivas.kerekare@intel.com>
> ---
>  drivers/crypto/qat/qat_4xxx/adf_drv.c             | 1 +
>  drivers/crypto/qat/qat_common/adf_accel_devices.h | 2 ++
>  drivers/crypto/qat/qat_common/qat_hal.c           | 1 +
>  drivers/crypto/qat/qat_common/qat_uclo.c          | 1 +
>  4 files changed, 5 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
