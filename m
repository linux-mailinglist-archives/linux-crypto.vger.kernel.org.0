Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9182621A04A
	for <lists+linux-crypto@lfdr.de>; Thu,  9 Jul 2020 14:54:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbgGIMx4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 9 Jul 2020 08:53:56 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:36120 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726347AbgGIMxz (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 9 Jul 2020 08:53:55 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jtW3i-0003v5-1F; Thu, 09 Jul 2020 22:53:51 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 09 Jul 2020 22:53:50 +1000
Date:   Thu, 9 Jul 2020 22:53:50 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com
Subject: Re: [PATCH v3 0/4] crypto: qat - fixes to aes xts
Message-ID: <20200709125349.GB31057@gondor.apana.org.au>
References: <20200629171620.2989-1-giovanni.cabiddu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200629171620.2989-1-giovanni.cabiddu@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jun 29, 2020 at 06:16:16PM +0100, Giovanni Cabiddu wrote:
> This series fixes a few issues with the xts(aes) implementation in the
> QuickAssist driver:
>  - Requests that are not multiple of the block size are rejected
>  - Input key not validated
>  - xts(aes) requests with key size 192 bits are rejected with -EINVAL
> 
> Changes from v2:
>  - Patch #4 - removed CRYPTO_ALG_ASYNC flag from mask in the allocation
>    of the fallback tfm to allow asynchronous implementations as fallback.
>  - Patch #4 - added CRYPTO_ALG_NEED_FALLBACK flag as mask when allocating
>    fallback tfm to avoid implementations that require fallback.
>  - Reworked commit messages to have system logs in one line.
> 
> Changes from v1:
>  - Removed extra pair of parenthesis around PTR_ERR in patch #4 (crypto:
>    qat - allow xts requests not multiple of block)
> 
> Giovanni Cabiddu (4):
>   crypto: qat - allow xts requests not multiple of block
>   crypto: qat - validate xts key
>   crypto: qat - remove unused field in skcipher ctx
>   crypto: qat - fallback for xts with 192 bit keys
> 
>  drivers/crypto/qat/qat_common/qat_algs.c | 98 ++++++++++++++++++++++--
>  1 file changed, 90 insertions(+), 8 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
