Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70B4C13D504
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Jan 2020 08:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAPH3X (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Jan 2020 02:29:23 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:39956 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726889AbgAPH3X (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Jan 2020 02:29:23 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1irzaj-0005a3-Pr; Thu, 16 Jan 2020 15:29:21 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1irzag-0000na-Vs; Thu, 16 Jan 2020 15:29:19 +0800
Date:   Thu, 16 Jan 2020 15:29:18 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zaibo Xu <xuzaibo@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linuxarm@huawei.com, jonathan.cameron@huawei.com,
        wangzhou1@hisilicon.com, tanghui20@huawei.com, yekai13@huawei.com,
        liulongfang@huawei.com, qianweili@huawei.com,
        zhangwei375@huawei.com, fanghao11@huawei.com,
        forest.zhouchang@huawei.com
Subject: Re: [PATCH v2 0/9] crypto: hisilicon-SEC V2 AEAD added with some
 bugfixed
Message-ID: <20200116072918.emqpubgi3fxthpe4@gondor.apana.org.au>
References: <1578710516-40535-1-git-send-email-xuzaibo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578710516-40535-1-git-send-email-xuzaibo@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Jan 11, 2020 at 10:41:47AM +0800, Zaibo Xu wrote:
> Add AEAD algorithms supporting, and some bugfixed with
> some updating on internal funcions to support more algorithms.
> 
> This series is based on:
> git://git.kernel.org/pub/scm/linux/kernel/git/herbert/crypto-2.6.git
> 
> Change log:
>   V2: Rebased on Arnd Bergmann's fixing patch on DebugFS usage.
> 
> Zaibo Xu (9):
>   crypto: hisilicon - Update debugfs usage of SEC V2
>   crypto: hisilicon - fix print/comment of SEC V2
>   crypto: hisilicon - Update some names on SEC V2
>   crypto: hisilicon - Update QP resources of SEC V2
>   crypto: hisilicon - Adjust some inner logic
>   crypto: hisilicon - Add callback error check
>   crypto: hisilicon - Add branch prediction macro
>   crypto: hisilicon - redefine skcipher initiation
>   crypto: hisilicon - Add aead support on SEC2
> 
>  drivers/crypto/hisilicon/Kconfig           |   8 +-
>  drivers/crypto/hisilicon/sec2/sec.h        |  49 +-
>  drivers/crypto/hisilicon/sec2/sec_crypto.c | 963 +++++++++++++++++++++++------
>  drivers/crypto/hisilicon/sec2/sec_crypto.h |  22 +-
>  drivers/crypto/hisilicon/sec2/sec_main.c   |  23 +-
>  5 files changed, 833 insertions(+), 232 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
