Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4D5F2811AF
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Oct 2020 13:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387876AbgJBLzL (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 2 Oct 2020 07:55:11 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49162 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726029AbgJBLzL (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 2 Oct 2020 07:55:11 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kOJeS-0005Tk-MG; Fri, 02 Oct 2020 21:55:05 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Oct 2020 21:55:05 +1000
Date:   Fri, 2 Oct 2020 21:55:05 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yang Shen <shenyang39@huawei.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, xuzaibo@huawei.com,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH RESEND 0/4] crypto: hisilicon/zip - misc clean up
Message-ID: <20201002115504.GH1205@gondor.apana.org.au>
References: <1601042777-26150-1-git-send-email-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601042777-26150-1-git-send-email-shenyang39@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Sep 25, 2020 at 10:06:13PM +0800, Yang Shen wrote:
> This patchset fix some bug:
> patch 1:clear the debug registers when remove driver
> patch 2:intercept invalid input when using decompress
> patch 3:replace the return value '-EBUSY' with '-EAGAIN' when
>     device is busy
> patch 4:initialize the 'curr_qm_qp_num' when probe device
> 
> Resend this patch series because it depends on
> https://patchwork.kernel.org/cover/11760159/
> (crypto: hisilicon/zip - misc clean up).
> Now the patch series has been applied.
> 
> Hao Fang (1):
>   crypto: hisilicon/zip - fix the uncleared debug registers
> 
> Sihang Chen (1):
>   crypto: hisilicon/zip - fix the uninitalized 'curr_qm_qp_num'
> 
> Yang Shen (1):
>   crypto: hisilicon/zip - fix the return value when device is busy
> 
> Zhou Wang (1):
>   crypto: hisilicon/zip - fix zero length input in GZIP decompress
> 
>  drivers/crypto/hisilicon/zip/zip_crypto.c | 26 +++++++++++++++++++-------
>  drivers/crypto/hisilicon/zip/zip_main.c   | 19 +++++++++++++++++++
>  2 files changed, 38 insertions(+), 7 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
