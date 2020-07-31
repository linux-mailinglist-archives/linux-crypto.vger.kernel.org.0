Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 861142340E5
	for <lists+linux-crypto@lfdr.de>; Fri, 31 Jul 2020 10:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbgGaIMf (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 31 Jul 2020 04:12:35 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:39954 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731510AbgGaIMf (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 31 Jul 2020 04:12:35 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k1Q9T-0002Aq-DQ; Fri, 31 Jul 2020 18:12:28 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 31 Jul 2020 18:12:27 +1000
Date:   Fri, 31 Jul 2020 18:12:27 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yang Shen <shenyang39@huawei.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, xuzaibo@huawei.com,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH 03/10] crypto: hisilicon/zip - modify debugfs interface
 parameters
Message-ID: <20200731081227.GA20741@gondor.apana.org.au>
References: <1595648683-50590-1-git-send-email-shenyang39@huawei.com>
 <1595648683-50590-4-git-send-email-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1595648683-50590-4-git-send-email-shenyang39@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Jul 25, 2020 at 11:44:36AM +0800, Yang Shen wrote:
> From: Shukun Tan <tanshukun1@huawei.com>
> 
> Update debugfs interface parameters
> 
> Signed-off-by: Shukun Tan <tanshukun1@huawei.com>
> Signed-off-by: Yang Shen <shenyang39@huawei.com>
> Reviewed-by: Zhou Wang <wangzhou1@hisilicon.com>
> ---
>  drivers/crypto/hisilicon/zip/zip_main.c | 55 ++++++++++++++-------------------
>  1 file changed, 24 insertions(+), 31 deletions(-)

This patch doesn't apply against cryptodev.

Plesae stop sending patch series that depend on others.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
