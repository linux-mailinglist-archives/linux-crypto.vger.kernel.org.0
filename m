Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0DF1AB891
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Apr 2020 08:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408592AbgDPGvc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Apr 2020 02:51:32 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:41390 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436560AbgDPGvb (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Apr 2020 02:51:31 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jOyMv-0005IZ-FF; Thu, 16 Apr 2020 16:51:26 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 16 Apr 2020 16:51:25 +1000
Date:   Thu, 16 Apr 2020 16:51:25 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Shukun Tan <tanshukun1@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        xuzaibo@huawei.com, wangzhou1@hisilicon.com, fanghao11@huawei.com
Subject: Re: [PATCH 0/3] crypto: hisilicon - refactor vfs_num related codes
Message-ID: <20200416065125.GD7901@gondor.apana.org.au>
References: <1585810383-49392-1-git-send-email-tanshukun1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1585810383-49392-1-git-send-email-tanshukun1@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Apr 02, 2020 at 02:53:00PM +0800, Shukun Tan wrote:
> This series clean the vfs_num related redundant code in this series,
> move all into QM.
> 
> Hao Fang (1):
>   crypto: hisilicon - add vfs_num module parameter for hpre/sec
> 
> Shukun Tan (2):
>   crypto: hisilicon - put vfs_num into struct hisi_qm
>   crypto: hisilicon - unify SR-IOV related codes into QM
> 
>  drivers/crypto/hisilicon/hpre/hpre.h      |   1 -
>  drivers/crypto/hisilicon/hpre/hpre_main.c | 130 +++++-----------------------
>  drivers/crypto/hisilicon/qm.c             | 136 +++++++++++++++++++++++++++--
>  drivers/crypto/hisilicon/qm.h             |  25 +++++-
>  drivers/crypto/hisilicon/sec2/sec.h       |   1 -
>  drivers/crypto/hisilicon/sec2/sec_main.c  | 137 ++++++------------------------
>  drivers/crypto/hisilicon/zip/zip_main.c   | 131 ++++------------------------
>  7 files changed, 215 insertions(+), 346 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
