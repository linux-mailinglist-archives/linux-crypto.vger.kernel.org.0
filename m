Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76262278280
	for <lists+linux-crypto@lfdr.de>; Fri, 25 Sep 2020 10:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgIYIR3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 25 Sep 2020 04:17:29 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53406 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727151AbgIYIR3 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 25 Sep 2020 04:17:29 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kLiv0-0007Pl-TK; Fri, 25 Sep 2020 18:17:27 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 25 Sep 2020 18:17:26 +1000
Date:   Fri, 25 Sep 2020 18:17:26 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Weili Qian <qianweili@huawei.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, xuzaibo@huawei.com,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH 0/2] crypto: hisilicon/qm - misc fixes
Message-ID: <20200925081726.GT6381@gondor.apana.org.au>
References: <1600513296-29287-1-git-send-email-qianweili@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600513296-29287-1-git-send-email-qianweili@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Sep 19, 2020 at 07:01:34PM +0800, Weili Qian wrote:
> This patchset fix some driver bugs
> 
> Resend this patch series because it depends on
> https://patchwork.kernel.org/cover/11760159/
> (crypto: hisilicon/zip - misc clean up).
> Now the patch series has been applied.
> 
> Weili Qian (1):
>   crypto: hisilicon/qm - remove the update of flags
> 
> Yang Shen (1):
>   crypto: hisilicon/qm - fix wrong return type of 'pci_get_drvdata'
> 
>  drivers/crypto/hisilicon/hpre/hpre_main.c | 3 +--
>  drivers/crypto/hisilicon/qm.c             | 1 -
>  drivers/crypto/hisilicon/sec2/sec_main.c  | 3 +--
>  drivers/crypto/hisilicon/zip/zip_main.c   | 3 +--
>  4 files changed, 3 insertions(+), 7 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
