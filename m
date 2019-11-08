Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02549F4F4C
	for <lists+linux-crypto@lfdr.de>; Fri,  8 Nov 2019 16:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKHPUR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 Nov 2019 10:20:17 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:57964 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfKHPUR (ORCPT <rfc822;linux-crypto@vger.kernel.orG>);
        Fri, 8 Nov 2019 10:20:17 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iT63c-0007HT-4y; Fri, 08 Nov 2019 23:20:16 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iT63Y-00078y-I4; Fri, 08 Nov 2019 23:20:12 +0800
Date:   Fri, 8 Nov 2019 23:20:12 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zaibo Xu <xuzaibo@huawei.com>
Cc:     mpm@selenic.com, linux-crypto@vger.kernel.org,
        jonathan.cameron@huawei.com, wangzhou1@hisilicon.com,
        linuxarm@huawei.com, wangkefeng.wang@huawei.com,
        qianweili@huawei.com, forest.zhouchang@huawei.com
Subject: Re: [PATCH 0/2] hw_random: hisilicon - add HiSilicon TRNG V2 support
Message-ID: <20191108152012.il3wlqymmbxa4sng@gondor.apana.org.au>
References: <1572510870-40390-1-git-send-email-xuzaibo@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572510870-40390-1-git-send-email-xuzaibo@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Oct 31, 2019 at 04:34:28PM +0800, Zaibo Xu wrote:
> This adds HiSilicon True Random Number Generator (TRNG) version 2
> driver in hw_random subsystem.
> 
> Zaibo Xu (2):
>   hw_random: add HiSilicon TRNG driver support
>   MAINTAINERS: Add maintainer for HiSilicon TRNG V2 driver
> 
>  MAINTAINERS                           |  5 ++
>  drivers/char/hw_random/Kconfig        | 13 +++++
>  drivers/char/hw_random/Makefile       |  1 +
>  drivers/char/hw_random/hisi-trng-v2.c | 99 +++++++++++++++++++++++++++++++++++
>  4 files changed, 118 insertions(+)
>  create mode 100644 drivers/char/hw_random/hisi-trng-v2.c

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
