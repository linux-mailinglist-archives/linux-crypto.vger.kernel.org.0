Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C453EA322
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Aug 2021 12:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236252AbhHLKxe (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 12 Aug 2021 06:53:34 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:52724 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235059AbhHLKxe (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 12 Aug 2021 06:53:34 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1mE8Ki-00039R-0M; Thu, 12 Aug 2021 18:53:08 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1mE8Kh-0001ZC-De; Thu, 12 Aug 2021 18:53:07 +0800
Date:   Thu, 12 Aug 2021 18:53:07 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Kai Ye <yekai13@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        wangzhou1@hisilicon.com
Subject: Re: [PATCH v2 2/5] crypto: hisilicon/sec - delete the print of
 fallback tfm application failure
Message-ID: <20210812105307.GA5890@gondor.apana.org.au>
References: <1628243066-32648-1-git-send-email-yekai13@huawei.com>
 <1628243066-32648-3-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1628243066-32648-3-git-send-email-yekai13@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Aug 06, 2021 at 05:44:23PM +0800, Kai Ye wrote:
> Modify the print of information that might lead to user misunderstanding.
> Currently only XTS mode need the fallback tfm when using 192bit key.
> Others algs not need soft fallback tfm. So others algs can return
> directly.
> 
> Signed-off-by: Kai Ye <yekai13@huawei.com>
> ---
>  drivers/crypto/hisilicon/sec2/sec_crypto.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)

I still don't get the point of this change.  Fallbacks are typically
the software implementation, and they should never fail except when
you run out of memory.  So what do you gain by delaying the error
from allocation time to runtime?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
