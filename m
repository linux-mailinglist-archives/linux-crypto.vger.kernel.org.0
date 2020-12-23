Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAA22E1986
	for <lists+linux-crypto@lfdr.de>; Wed, 23 Dec 2020 08:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgLWHwJ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 23 Dec 2020 02:52:09 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:36582 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727063AbgLWHwJ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 23 Dec 2020 02:52:09 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kryvZ-0006eL-Dd; Wed, 23 Dec 2020 18:51:22 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 23 Dec 2020 18:51:21 +1100
Date:   Wed, 23 Dec 2020 18:51:21 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Marco Chiappero <marco.chiappero@intel.com>
Cc:     linux-crypto@vger.kernel.org, qat-linux@intel.com,
        giovanni.cabiddu@intel.com, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] crypto: qat - add CRYPTO_AES to Kconfig dependencies
Message-ID: <20201223075121.GC8269@gondor.apana.org.au>
References: <20201222130024.694558-1-marco.chiappero@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222130024.694558-1-marco.chiappero@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Dec 22, 2020 at 01:00:24PM +0000, Marco Chiappero wrote:
> This patch includes a missing dependency (CRYPTO_AES) which may
> lead to an "undefined reference to `aes_expandkey'" linking error.
> 
> Fixes: 5106dfeaeabe ("crypto: qat - add AES-XTS support for QAT GEN4 devices")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Marco Chiappero <marco.chiappero@intel.com>
> ---
>  drivers/crypto/qat/Kconfig | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
