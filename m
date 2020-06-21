Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2757A2027EA
	for <lists+linux-crypto@lfdr.de>; Sun, 21 Jun 2020 04:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729108AbgFUCIO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 20 Jun 2020 22:08:14 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:39668 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729104AbgFUCIO (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 20 Jun 2020 22:08:14 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jmpOo-0000to-FQ; Sun, 21 Jun 2020 12:07:59 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sun, 21 Jun 2020 12:07:58 +1000
Date:   Sun, 21 Jun 2020 12:07:58 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Barry Song <song.bao.hua@hisilicon.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH] crypto: scompress - call the completion callback for the
 completed acomp_req
Message-ID: <20200621020758.GA29905@gondor.apana.org.au>
References: <20200620230756.6592-1-song.bao.hua@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200620230756.6592-1-song.bao.hua@hisilicon.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Jun 21, 2020 at 11:07:56AM +1200, Barry Song wrote:
> While using acomp_req, users may customize a completion callback, if the
> backend of acomp is actually scomp, this callback will never be called.
> This looks a bit messy to users. For one user, all scomp details should
> be hidden by acomp APIs.
> 
> But it won't cause any real problem if users simply use crypto_req_done()
> as the callback, and further use crypto_wait_req() to wait for request to
> be done since crypto_wait_req() depends on the callback only if queuing
> acomp_req returns -EINPROGRESS or -EBUSY.
> 
> This patch will make sure the customized completion callback is called
> for the first case. And it won't break the second case in which users
> use the common crypto_req_done() and crypto_wait_req() only.
> 
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> ---
>  crypto/scompress.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/crypto/scompress.c b/crypto/scompress.c
> index 738f4f8f0f41..634b7ced9348 100644
> --- a/crypto/scompress.c
> +++ b/crypto/scompress.c
> @@ -158,6 +158,10 @@ static int scomp_acomp_comp_decomp(struct acomp_req *req, int dir)
>  	}
>  out:
>  	spin_unlock(&scratch->lock);
> +
> +	if (req->base.complete)
> +		acomp_request_complete(req, ret);
> +
>  	return ret;
>  }

Nack.  This is a deliberate optimisation to allow the sync code
path to execute with no overhead.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
