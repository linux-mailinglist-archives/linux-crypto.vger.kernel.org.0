Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6188E11A724
	for <lists+linux-crypto@lfdr.de>; Wed, 11 Dec 2019 10:31:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728128AbfLKJbj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 11 Dec 2019 04:31:39 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:53612 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbfLKJbj (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 11 Dec 2019 04:31:39 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ieyLJ-0008Hc-4d; Wed, 11 Dec 2019 17:31:37 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ieyLH-0006wH-6b; Wed, 11 Dec 2019 17:31:35 +0800
Date:   Wed, 11 Dec 2019 17:31:35 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH 0/3] crypto: hisilicon - Misc qm/zip fixes
Message-ID: <20191211093135.2htsnguoke5ngvv3@gondor.apana.org.au>
References: <1574142178-76514-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1574142178-76514-1-git-send-email-wangzhou1@hisilicon.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Nov 19, 2019 at 01:42:55PM +0800, Zhou Wang wrote:
> These patches are independent fixes about qm and zip.
> 
> Jonathan Cameron (2):
>   crypto: hisilicon - Fix issue with wrong number of sg elements after
>     dma map
>   crypto: hisilicon - Use the offset fields in sqe to avoid need to
>     split scatterlists
> 
> Zhou Wang (1):
>   crypto: hisilicon - Remove useless MODULE macros
> 
>  drivers/crypto/hisilicon/Kconfig          |  1 -
>  drivers/crypto/hisilicon/sgl.c            | 17 +++---
>  drivers/crypto/hisilicon/zip/zip.h        |  4 ++
>  drivers/crypto/hisilicon/zip/zip_crypto.c | 92 ++++++++-----------------------
>  4 files changed, 35 insertions(+), 79 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
