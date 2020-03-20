Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA9718C615
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Mar 2020 04:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbgCTDuj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 19 Mar 2020 23:50:39 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:33866 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726834AbgCTDui (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 19 Mar 2020 23:50:38 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jF8fz-0001VH-AS; Fri, 20 Mar 2020 14:50:28 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Mar 2020 14:50:27 +1100
Date:   Fri, 20 Mar 2020 14:50:27 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Shukun Tan <tanshukun1@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        wangzhou1@hisilicon.com, xuzaibo@huawei.com
Subject: Re: [PATCH v2 0/4] crypto: hisilicon - Refactor find device related
 code
Message-ID: <20200320035027.GB27372@gondor.apana.org.au>
References: <1583829772-53372-1-git-send-email-tanshukun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583829772-53372-1-git-send-email-tanshukun1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Mar 10, 2020 at 04:42:48PM +0800, Shukun Tan wrote:
> By binding device finding with create QP logic to fix the bug of creating
> QP failure occasionally. Then, merge the find device related code into
> qm.c to reduce redundancy.
> 
> This series depends upon this patchset:
> https://lore.kernel.org/linux-crypto/1583373985-718-1-git-send-email-xuzaibo@huawei.com/
> 
> Changes v1 -> v2:
> 	- Fix bug of compile when disable NUMA config.
> 
> Hui Tang (1):
>   crypto: hisilicon/hpre - Optimize finding hpre device process
> 
> Kai Ye (1):
>   crypto: hisilicon/sec2 - Add new create qp process
> 
> Shukun Tan (1):
>   crypto: hisilicon/zip - Use hisi_qm_alloc_qps_node() when init ctx
> 
> Weili Qian (1):
>   crypto: hisilicon/qm - Put device finding logic into QM
> 
>  drivers/crypto/hisilicon/hpre/hpre.h        |   3 +-
>  drivers/crypto/hisilicon/hpre/hpre_crypto.c |  20 ++---
>  drivers/crypto/hisilicon/hpre/hpre_main.c   |  52 +++---------
>  drivers/crypto/hisilicon/qm.c               | 125 ++++++++++++++++++++++++++++
>  drivers/crypto/hisilicon/qm.h               |  31 +++++++
>  drivers/crypto/hisilicon/sec2/sec.h         |   5 +-
>  drivers/crypto/hisilicon/sec2/sec_crypto.c  |  17 ++--
>  drivers/crypto/hisilicon/sec2/sec_main.c    |  81 +++++++-----------
>  drivers/crypto/hisilicon/zip/zip.h          |   2 +-
>  drivers/crypto/hisilicon/zip/zip_crypto.c   |  54 ++++++------
>  drivers/crypto/hisilicon/zip/zip_main.c     |  92 ++------------------
>  11 files changed, 252 insertions(+), 230 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
