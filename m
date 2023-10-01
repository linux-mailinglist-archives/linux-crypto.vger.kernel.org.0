Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9178D7B4652
	for <lists+linux-crypto@lfdr.de>; Sun,  1 Oct 2023 10:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234510AbjJAIez (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 1 Oct 2023 04:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231649AbjJAIez (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 1 Oct 2023 04:34:55 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A15C083
        for <linux-crypto@vger.kernel.org>; Sun,  1 Oct 2023 01:34:50 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qmruX-002PY4-JV; Sun, 01 Oct 2023 16:34:46 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sun, 01 Oct 2023 16:34:49 +0800
Date:   Sun, 1 Oct 2023 16:34:49 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Damian Muszynski <damian.muszynski@intel.com>
Subject: Re: [PATCH] crypto: qat - increase size of buffers
Message-ID: <ZRkvKQtKQIy6cfMJ@gondor.apana.org.au>
References: <20230922090439.30120-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230922090439.30120-1-giovanni.cabiddu@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Sep 22, 2023 at 10:03:47AM +0100, Giovanni Cabiddu wrote:
> Increase the size of the buffers used for composing the names used for
> the transport debugfs entries and the vector name to avoid a potential
> truncation.
> 
> This resolves the following errors when compiling the driver with W=1
> and KCFLAGS=-Werror on GCC 12.3.1:
> 
>     drivers/crypto/intel/qat/qat_common/adf_transport_debug.c: In function ‘adf_ring_debugfs_add’:
>     drivers/crypto/intel/qat/qat_common/adf_transport_debug.c:100:60: error: ‘snprintf’ output may be truncated before the last format character [-Werror=format-truncation=]
>     drivers/crypto/intel/qat/qat_common/adf_isr.c: In function ‘adf_isr_resource_alloc’:
>     drivers/crypto/intel/qat/qat_common/adf_isr.c:197:47: error: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size between 0 and 5 [-Werror=format-truncation=]
> 
> Fixes: a672a9dc872e ("crypto: qat - Intel(R) QAT transport code")
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Damian Muszynski <damian.muszynski@intel.com>
> ---
>  drivers/crypto/intel/qat/qat_common/adf_accel_devices.h   | 2 +-
>  drivers/crypto/intel/qat/qat_common/adf_transport_debug.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
