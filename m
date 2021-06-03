Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC97D39A0F2
	for <lists+linux-crypto@lfdr.de>; Thu,  3 Jun 2021 14:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhFCMc4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 3 Jun 2021 08:32:56 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60928 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhFCMcz (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 3 Jun 2021 08:32:55 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lomVC-000242-9e; Thu, 03 Jun 2021 20:31:10 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lomVC-0001fZ-4m; Thu, 03 Jun 2021 20:31:10 +0800
Date:   Thu, 3 Jun 2021 20:31:10 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH 0/3] crypto: hisilicon - supports new skciphers for new
 hardware
Message-ID: <20210603123110.GH6161@gondor.apana.org.au>
References: <1622202126-19237-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1622202126-19237-1-git-send-email-yekai13@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, May 28, 2021 at 07:42:03PM +0800, Kai Ye wrote:
> The driver adds new skciphers, add fallback tfm supporting for XTS mode.
> The crypto fuzzing test has been passed. fixup 3des minimum key size declaration
> that fuzz testing found.
> 
> Kai Ye (3):
>   crypto: hisilicon/sec - add new skcipher mode for SEC
>   crypto: hisilicon/sec - add fallback tfm supporting for XTS mode
>   crypto: hisilicon/sec - fixup 3des minimum key size declaration
> 
>  drivers/crypto/hisilicon/sec2/sec.h        |   4 +
>  drivers/crypto/hisilicon/sec2/sec_crypto.c | 192 ++++++++++++++++++++++++++---
>  drivers/crypto/hisilicon/sec2/sec_crypto.h |   3 +
>  3 files changed, 182 insertions(+), 17 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
