Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0A168EB1D
	for <lists+linux-crypto@lfdr.de>; Thu, 15 Aug 2019 14:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729986AbfHOMIq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 15 Aug 2019 08:08:46 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:57280 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730497AbfHOMIq (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 15 Aug 2019 08:08:46 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hyEYZ-0003S4-5r; Thu, 15 Aug 2019 22:08:39 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hyEYZ-0007km-02; Thu, 15 Aug 2019 22:08:39 +1000
Date:   Thu, 15 Aug 2019 22:08:38 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH 0/5] crypto: hisilicon: Misc fixes
Message-ID: <20190815120838.GA29793@gondor.apana.org.au>
References: <1565774919-31853-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565774919-31853-1-git-send-email-wangzhou1@hisilicon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Aug 14, 2019 at 05:28:34PM +0800, Zhou Wang wrote:
> Patch 1~3 are fixes about kbuild errors, patch 4,5 are tiny fixes about qm
> and zip.
> 
> This series is based on cryptodev-2.6.
> 
> Zhou Wang (5):
>   crypto: hisilicon - fix kbuild warnings
>   crypto: hisilicon - add dependency for CRYPTO_DEV_HISI_ZIP
>   crypto: hisilicon - init curr_sgl_dma to fix compile warning
>   crypto: hisilicon - add missing single_release
>   crypto: hisilicon - fix error handle in hisi_zip_create_req_q
> 
>  drivers/crypto/hisilicon/Kconfig          | 1 +
>  drivers/crypto/hisilicon/qm.c             | 7 ++++---
>  drivers/crypto/hisilicon/sgl.c            | 2 +-
>  drivers/crypto/hisilicon/zip/zip_crypto.c | 6 ++++--
>  4 files changed, 10 insertions(+), 6 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
