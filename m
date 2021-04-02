Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BF2352902
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Apr 2021 11:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhDBJrz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 2 Apr 2021 05:47:55 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:33720 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234275AbhDBJrz (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 2 Apr 2021 05:47:55 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lSGP7-0003UQ-PM; Fri, 02 Apr 2021 20:47:50 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Apr 2021 20:47:49 +1100
Date:   Fri, 2 Apr 2021 20:47:49 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        Marco Chiappero <marco.chiappero@intel.com>
Subject: Re: [PATCH] crypto: qat - fix error path in adf_isr_resource_alloc()
Message-ID: <20210402094749.GD24509@gondor.apana.org.au>
References: <20210325083418.153771-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325083418.153771-1-giovanni.cabiddu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Mar 25, 2021 at 08:34:18AM +0000, Giovanni Cabiddu wrote:
> The function adf_isr_resource_alloc() is not unwinding correctly in case
> of error.
> This patch fixes the error paths and propagate the errors to the caller.
> 
> Fixes: 7afa232e76ce ("crypto: qat - Intel(R) QAT DH895xcc accelerator")
> Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
> Reviewed-by: Marco Chiappero <marco.chiappero@intel.com>
> ---
>  drivers/crypto/qat/qat_common/adf_isr.c | 29 ++++++++++++++++++-------
>  1 file changed, 21 insertions(+), 8 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
