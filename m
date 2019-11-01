Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB513EBDB2
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Nov 2019 07:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725784AbfKAGNM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 1 Nov 2019 02:13:12 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37776 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725280AbfKAGNM (ORCPT <rfc822;linux-crypto@vger.kernel.orG>);
        Fri, 1 Nov 2019 02:13:12 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iQQBJ-000200-IJ; Fri, 01 Nov 2019 14:13:09 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iQQBH-0004vE-GG; Fri, 01 Nov 2019 14:13:07 +0800
Date:   Fri, 1 Nov 2019 14:13:07 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Zhou Wang <wangzhou1@hisilicon.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: hisilicon - use sgl API to get sgl dma addr and
 len
Message-ID: <20191101061307.xu2d7hjjhxddlzyw@gondor.apana.org.au>
References: <1572058641-173376-1-git-send-email-wangzhou1@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1572058641-173376-1-git-send-email-wangzhou1@hisilicon.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Oct 26, 2019 at 10:57:21AM +0800, Zhou Wang wrote:
> Use sgl API to get sgl dma addr and len, this will help to avoid compile
> error in some platforms. So NEED_SG_DMA_LENGTH can be removed here, which
> can only be selected by arch code.
> 
> Signed-off-by: Zhou Wang <wangzhou1@hisilicon.com>
> Suggested-by: Herbert Xu <herbert@gondor.apana.org.au>
> ---
>  drivers/crypto/hisilicon/Kconfig | 1 -
>  drivers/crypto/hisilicon/sgl.c   | 4 ++--
>  2 files changed, 2 insertions(+), 3 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
