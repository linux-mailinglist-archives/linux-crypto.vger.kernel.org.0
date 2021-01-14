Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC722F5AE1
	for <lists+linux-crypto@lfdr.de>; Thu, 14 Jan 2021 07:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbhANGrC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 14 Jan 2021 01:47:02 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:42152 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725989AbhANGrC (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 14 Jan 2021 01:47:02 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kzwOX-00087Q-1U; Thu, 14 Jan 2021 17:46:10 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 14 Jan 2021 17:46:08 +1100
Date:   Thu, 14 Jan 2021 17:46:08 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Marco Chiappero <marco.chiappero@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        giovanni.cabiddu@intel.com, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH] crypto: qat - replace CRYPTO_AES with CRYPTO_LIB_AES in
 Kconfig
Message-ID: <20210114064608.GA12584@gondor.apana.org.au>
References: <20201223205755.GA19858@gondor.apana.org.au>
 <20210104153515.749496-1-marco.chiappero@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104153515.749496-1-marco.chiappero@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jan 04, 2021 at 03:35:15PM +0000, Marco Chiappero wrote:
> Use CRYPTO_LIB_AES in place of CRYPTO_AES in the dependences for the QAT
> common code.
> 
> Fixes: c0e583ab2016 ("crypto: qat - add CRYPTO_AES to Kconfig dependencies")
> Reported-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Marco Chiappero <marco.chiappero@intel.com>
> ---
>  drivers/crypto/qat/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
