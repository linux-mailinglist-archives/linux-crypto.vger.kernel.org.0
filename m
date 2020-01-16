Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CDF1413D505
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Jan 2020 08:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726315AbgAPH31 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Jan 2020 02:29:27 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:39964 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726827AbgAPH31 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Jan 2020 02:29:27 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1irzao-0005aa-5G; Thu, 16 Jan 2020 15:29:26 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1irzao-0000nl-0R; Thu, 16 Jan 2020 15:29:26 +0800
Date:   Thu, 16 Jan 2020 15:29:25 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zaibo Xu <xuzaibo@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linuxarm@huawei.com, jonathan.cameron@huawei.com,
        wangzhou1@hisilicon.com, tanghui20@huawei.com, yekai13@huawei.com,
        liulongfang@huawei.com, qianweili@huawei.com, fanghao11@huawei.com,
        forest.zhouchang@huawei.com
Subject: Re: [PATCH 0/4] crypto: hisilicon - Misc fixed on HPRE
Message-ID: <20200116072925.6i4mptf5snxyweb3@gondor.apana.org.au>
References: <1578733098-13863-1-git-send-email-xuzaibo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578733098-13863-1-git-send-email-xuzaibo@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Jan 11, 2020 at 04:58:14PM +0800, Zaibo Xu wrote:
> 1.Bugfixed tfm leak with some other tiny bugfixed.
> 2.Fixed some tiny bugs and update some code style.
> 3.Adjust input parameter order of hpre_crt_para_get.
> 4.Add branch prediction macro on hot path with small performance gain(~1%).
> 
> This series is based on:
> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/cryptodev-2.6.git
> 
> Zaibo Xu (4):
>   crypto: hisilicon - Bugfixed tfm leak
>   crypto: hisilicon - Fixed some tiny bugs of HPRE
>   crypto: hisilicon - adjust hpre_crt_para_get
>   crypto: hisilicon - add branch prediction macro
> 
>  drivers/crypto/hisilicon/hpre/hpre_crypto.c | 141 ++++++++++++++--------------
>  drivers/crypto/hisilicon/hpre/hpre_main.c   |  32 ++++---
>  2 files changed, 86 insertions(+), 87 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
