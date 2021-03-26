Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF10534A3EE
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Mar 2021 10:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbhCZJPR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 26 Mar 2021 05:15:17 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35276 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229463AbhCZJPP (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 26 Mar 2021 05:15:15 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lPiYT-00034K-Bz; Fri, 26 Mar 2021 20:14:58 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Mar 2021 20:14:57 +1100
Date:   Fri, 26 Mar 2021 20:14:57 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yang Shen <shenyang39@huawei.com>
Cc:     davem@davemloft.net, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, wangzhou1@hisilicon.com
Subject: Re: [PATCH 4/4] crypto: hisilicon/zip - support new 'sqe' type in
 Kunpeng930
Message-ID: <20210326091457.GA1153@gondor.apana.org.au>
References: <1616139187-63425-1-git-send-email-shenyang39@huawei.com>
 <1616139187-63425-5-git-send-email-shenyang39@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1616139187-63425-5-git-send-email-shenyang39@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Mar 19, 2021 at 03:33:07PM +0800, Yang Shen wrote:
>
> +const struct hisi_zip_sqe_ops hisi_zip_ops_v2 = {
> +	.sqe_type		= 0x3,
> +	.fill_addr		= hisi_zip_fill_addr,
> +	.fill_buf_size		= hisi_zip_fill_buf_size,
> +	.fill_buf_type		= hisi_zip_fill_buf_type,
> +	.fill_req_type		= hisi_zip_fill_req_type,
> +	.fill_tag		= hisi_zip_fill_tag_v2,
> +	.fill_sqe_type		= hisi_zip_fill_sqe_type,
> +	.get_tag		= hisi_zip_get_tag_v2,
> +	.get_status		= hisi_zip_get_status,
> +	.get_dstlen		= hisi_zip_get_dstlen,
> +};
> +

This triggers a new warning:

  CHECK   ../drivers/crypto/hisilicon/zip/zip_crypto.c
  ../drivers/crypto/hisilicon/zip/zip_crypto.c:527:31: warning: symbol 'hisi_zip_ops_v1' was not declared. Should it be static?
  ../drivers/crypto/hisilicon/zip/zip_crypto.c:540:31: warning: symbol 'hisi_zip_ops_v2' was not declared. Should it be static?

Please fix.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
