Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E43B739A0E5
	for <lists+linux-crypto@lfdr.de>; Thu,  3 Jun 2021 14:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbhFCMbv (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 3 Jun 2021 08:31:51 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60874 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229976AbhFCMbv (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 3 Jun 2021 08:31:51 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lomU3-0001xu-6z; Thu, 03 Jun 2021 20:29:59 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lomU0-0001dK-Ua; Thu, 03 Jun 2021 20:29:57 +0800
Date:   Thu, 3 Jun 2021 20:29:56 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tian Tao <tiantao6@hisilicon.com>
Cc:     mpm@selenic.com, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] hwrng: ks-sa - Use pm_runtime_resume_and_get() to
 replace open coding
Message-ID: <20210603122956.GC6161@gondor.apana.org.au>
References: <1621859318-65095-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621859318-65095-1-git-send-email-tiantao6@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, May 24, 2021 at 08:28:38PM +0800, Tian Tao wrote:
> use pm_runtime_resume_and_get() to replace pm_runtime_get_sync and
> pm_runtime_put_noidle. this change is just to simplify the code, no
> actual functional changes.
> 
> Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
> ---
>  drivers/char/hw_random/ks-sa-rng.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
