Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE44D1EEED5
	for <lists+linux-crypto@lfdr.de>; Fri,  5 Jun 2020 02:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgFEAni (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 4 Jun 2020 20:43:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725955AbgFEAni (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 4 Jun 2020 20:43:38 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92B41206DC;
        Fri,  5 Jun 2020 00:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591317817;
        bh=JEz/i2vtRp2cUc9b42d0KplmYCWeHtbLReqkDwAq4bY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xAX8xta8/6NDVO2Ll9J9IjALaiko3WCQJwhqASXX0kO8iYaeEF5bubQBwMvfo6vrY
         jEkbVvqvpieS8DSZs0ZKJYNDpg1AdLxpwebor85+lYLmAcdu1WmhUxVu/UXvEmiOCx
         VeZDEUqBBRT7VyMKdzqKPlcS3BcVwnCMKbvRV3zU=
Date:   Thu, 4 Jun 2020 17:43:36 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, davem@davemloft.net,
        herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+2e635807decef724a1fa@syzkaller.appspotmail.com>
Subject: Re: [PATCH v2] crypto: DRBG - always try to free Jitter RNG instance
Message-ID: <20200605004336.GC148196@sol.localdomain>
References: <0000000000002a280b05a725cd93@google.com>
 <2583872.mvXUDI8C0e@positron.chronox.de>
 <20200603110919.GK30374@kadam>
 <2551009.mvXUDI8C0e@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2551009.mvXUDI8C0e@positron.chronox.de>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jun 04, 2020 at 08:41:00AM +0200, Stephan Müller wrote:
> The Jitter RNG is unconditionally allocated as a seed source follwoing
> the patch 97f2650e5040. Thus, the instance must always be deallocated.
> 
> Reported-by: syzbot+2e635807decef724a1fa@syzkaller.appspotmail.com
> Fixes: 97f2650e5040 ("crypto: drbg - always seeded with SP800-90B ...")
> Signed-off-by: Stephan Mueller <smueller@chronox.de>
> ---
>  crypto/drbg.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/crypto/drbg.c b/crypto/drbg.c
> index 37526eb8c5d5..8a0f16950144 100644
> --- a/crypto/drbg.c
> +++ b/crypto/drbg.c
> @@ -1631,6 +1631,9 @@ static int drbg_uninstantiate(struct drbg_state *drbg)
>  	if (drbg->random_ready.func) {
>  		del_random_ready_callback(&drbg->random_ready);
>  		cancel_work_sync(&drbg->seed_work);
> +	}
> +
> +	if (!IS_ERR_OR_NULL(drbg->jent)) {
>  		crypto_free_rng(drbg->jent);
>  		drbg->jent = NULL;
>  	}

It it okay that ->jent can be left as an ERR_PTR() value?

Perhaps it should always be set to NULL?

- Eric
