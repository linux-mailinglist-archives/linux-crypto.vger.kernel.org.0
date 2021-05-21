Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B76B38C0EF
	for <lists+linux-crypto@lfdr.de>; Fri, 21 May 2021 09:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232255AbhEUHra (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 21 May 2021 03:47:30 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55786 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231636AbhEUHr2 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 21 May 2021 03:47:28 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1ljzr1-0004Ly-Va; Fri, 21 May 2021 15:45:56 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ljzqz-0005p8-9A; Fri, 21 May 2021 15:45:53 +0800
Date:   Fri, 21 May 2021 15:45:53 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Hui Tang <tanghui20@huawei.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        xuzaibo@huawei.com, wangzhou1@hisilicon.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] crypto: ecdh - fix 'ecdh_init'
Message-ID: <20210521074553.w6qtqv5nnbdbqycx@gondor.apana.org.au>
References: <1620801602-49287-1-git-send-email-tanghui20@huawei.com>
 <1620801602-49287-2-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620801602-49287-2-git-send-email-tanghui20@huawei.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, May 12, 2021 at 02:40:00PM +0800, Hui Tang wrote:
> NIST P192 is not unregistered if failed to register NIST P256,
> actually it need to unregister the algorithms already registered.
> 
> Signed-off-by: Hui Tang <tanghui20@huawei.com>
> ---
>  crypto/ecdh.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Thanks for catching this.  The variable ecdh_nist_p192_registered
is bogus.  You should just make it so that if p192 fails to
register then the init function aborts.  There would then be
no need to check for the registered state in the exit function.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
