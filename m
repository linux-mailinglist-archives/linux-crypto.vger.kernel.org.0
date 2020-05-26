Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAA51AB88D
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Apr 2020 08:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408565AbgDPGvm (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Apr 2020 02:51:42 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:41406 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408627AbgDPGvj (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Apr 2020 02:51:39 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jOyN3-0005Il-6Z; Thu, 16 Apr 2020 16:51:34 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 16 Apr 2020 16:51:33 +1000
Date:   Thu, 16 Apr 2020 16:51:33 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Shukun Tan <tanshukun1@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 0/5] crypto: hisilicon - add controller reset support
Message-ID: <20200416065133.GE7901@gondor.apana.org.au>
References: <1585901802-48945-1-git-send-email-tanshukun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585901802-48945-1-git-send-email-tanshukun1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Apr 03, 2020 at 04:16:37PM +0800, Shukun Tan wrote:
> Add support controller reset for ZIP/HPRE/SEC drivers, put the main
> implementation into QM. Meanwhile modified the logic of the queue
> stop judgment.
> 
> This series depends upon:
> https://patchwork.kernel.org/cover/11470171/ 
> 
> Hui Tang (1):
>   crypto: hisilicon/hpre - add controller reset support for HPRE
> 
> Shukun Tan (2):
>   crypto: hisilicon/qm - add controller reset interface
>   crypto: hisilicon/zip - add controller reset support for zip
> 
> Yang Shen (2):
>   crypto: hisilicon/sec2 - add controller reset support for SEC2
>   crypto: hisilicon/qm - stop qp by judging sq and cq tail
> 
>  drivers/crypto/hisilicon/hpre/hpre_main.c |  46 ++-
>  drivers/crypto/hisilicon/qm.c             | 667 +++++++++++++++++++++++++++++-
>  drivers/crypto/hisilicon/qm.h             |  16 +
>  drivers/crypto/hisilicon/sec2/sec_main.c  |  40 +-
>  drivers/crypto/hisilicon/zip/zip_main.c   |  57 ++-
>  5 files changed, 790 insertions(+), 36 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
