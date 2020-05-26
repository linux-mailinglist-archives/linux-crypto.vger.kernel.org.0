Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3344A1D45AF
	for <lists+linux-crypto@lfdr.de>; Fri, 15 May 2020 08:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbgEOGQZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 15 May 2020 02:16:25 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:34308 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726137AbgEOGQZ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 15 May 2020 02:16:25 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jZTdV-0007KG-6Z; Fri, 15 May 2020 16:15:58 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 15 May 2020 16:15:57 +1000
Date:   Fri, 15 May 2020 16:15:57 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     michal.simek@xilinx.com, gregkh@linuxfoundation.org,
        rajan.vaja@xilinx.com, kalyani.akula@xilinx.com,
        jolly.shah@xilinx.com, yuehaibing@huawei.com,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, hulkci@huawei.com
Subject: Re: [PATCH -next] crypto: xilinx - Remove set but not used variable
 'drv_ctx'
Message-ID: <20200515061557.GA11092@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505101200.195184-1-yuehaibing@huawei.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> wrote:
> Fixes gcc '-Wunused-but-set-variable' warning:
> 
> drivers/crypto/xilinx/zynqmp-aes-gcm.c: In function 'zynqmp_aes_aead_cipher':
> drivers/crypto/xilinx/zynqmp-aes-gcm.c:83:30: warning:
> variable 'drv_ctx' set but not used [-Wunused-but-set-variable]
> 
> commit bc86f9c54616 ("firmware: xilinx: Remove eemi ops for aes engine") left
> behind this, remove it.
> 
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
> drivers/crypto/xilinx/zynqmp-aes-gcm.c | 4 ----
> 1 file changed, 4 deletions(-)

This patch doesn't apply to the current cryptodev tree.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
