Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26635286E3D
	for <lists+linux-crypto@lfdr.de>; Thu,  8 Oct 2020 07:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbgJHFnx (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 8 Oct 2020 01:43:53 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:41206 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726245AbgJHFnx (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 8 Oct 2020 01:43:53 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kQOiU-0006SF-P0; Thu, 08 Oct 2020 16:43:51 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 08 Oct 2020 16:43:51 +1100
Date:   Thu, 8 Oct 2020 16:43:51 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Fiona Trahe <fiona.trahe@intel.com>,
        Wojciech Ziemba <wojciech.ziemba@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: Re: [PATCH] crypto: qat - drop input parameter from adf_enable_aer()
Message-ID: <20201008054351.GB9733@gondor.apana.org.au>
References: <20200930222211.557316-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930222211.557316-1-giovanni.cabiddu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Sep 30, 2020 at 11:22:11PM +0100, Giovanni Cabiddu wrote:
> Remove pointer to struct pci_driver from function adf_enable_aer() as it
> is possible to get it directly from pdev->driver.
> 
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Fiona Trahe <fiona.trahe@intel.com>
> Reviewed-by: Wojciech Ziemba <wojciech.ziemba@intel.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> ---
>  drivers/crypto/qat/qat_c3xxx/adf_drv.c         | 2 +-
>  drivers/crypto/qat/qat_c62x/adf_drv.c          | 2 +-
>  drivers/crypto/qat/qat_common/adf_aer.c        | 6 +++---
>  drivers/crypto/qat/qat_common/adf_common_drv.h | 2 +-
>  drivers/crypto/qat/qat_dh895xcc/adf_drv.c      | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
