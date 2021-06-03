Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0A539A0A2
	for <lists+linux-crypto@lfdr.de>; Thu,  3 Jun 2021 14:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhFCMRn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 3 Jun 2021 08:17:43 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60768 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229747AbhFCMRm (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 3 Jun 2021 08:17:42 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lomGT-0001iq-G4; Thu, 03 Jun 2021 20:15:57 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lomGT-0000aS-Ah; Thu, 03 Jun 2021 20:15:57 +0800
Date:   Thu, 3 Jun 2021 20:15:57 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Marco Chiappero <marco.chiappero@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Subject: Re: [PATCH 01/10] crypto: qat - use proper type for vf_mask
Message-ID: <20210603121557.GB2062@gondor.apana.org.au>
References: <20210527191251.6317-1-marco.chiappero@intel.com>
 <20210527191251.6317-2-marco.chiappero@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210527191251.6317-2-marco.chiappero@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, May 27, 2021 at 08:12:42PM +0100, Marco Chiappero wrote:
>
> diff --git a/drivers/crypto/qat/qat_common/adf_isr.c b/drivers/crypto/qat/qat_common/adf_isr.c
> index e3ad5587be49..22f8ef5bfbc5 100644
> --- a/drivers/crypto/qat/qat_common/adf_isr.c
> +++ b/drivers/crypto/qat/qat_common/adf_isr.c
> @@ -15,6 +15,10 @@
>  #include "adf_transport_access_macros.h"
>  #include "adf_transport_internal.h"
>  
> +#ifdef CONFIG_PCI_IOV
> +#define ADF_MAX_NUM_VFS	32
> +#endif

The #ifdef is not necessary.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
