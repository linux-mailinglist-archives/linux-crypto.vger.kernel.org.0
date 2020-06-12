Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA77C1F7421
	for <lists+linux-crypto@lfdr.de>; Fri, 12 Jun 2020 08:49:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbgFLGts (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 12 Jun 2020 02:49:48 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:38992 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726300AbgFLGtr (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 12 Jun 2020 02:49:47 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jjdVP-0000rs-JM; Fri, 12 Jun 2020 16:49:36 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Jun 2020 16:49:35 +1000
Date:   Fri, 12 Jun 2020 16:49:35 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>
Cc:     Dan Carpenter <dan.carpenter@oracle.com>, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+2e635807decef724a1fa@syzkaller.appspotmail.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v3] crypto: DRBG - always try to free Jitter RNG instance
Message-ID: <20200612064935.GF16987@gondor.apana.org.au>
References: <0000000000002a280b05a725cd93@google.com>
 <20200603110919.GK30374@kadam>
 <2551009.mvXUDI8C0e@positron.chronox.de>
 <4563687.31r3eYUQgx@positron.chronox.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4563687.31r3eYUQgx@positron.chronox.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Jun 07, 2020 at 03:20:26PM +0200, Stephan Müller wrote:
> The Jitter RNG is unconditionally allocated as a seed source follwoing
> the patch 97f2650e5040. Thus, the instance must always be deallocated.
> 
> Reported-by: syzbot+2e635807decef724a1fa@syzkaller.appspotmail.com
> Fixes: 97f2650e5040 ("crypto: drbg - always seeded with SP800-90B ...")
> Signed-off-by: Stephan Mueller <smueller@chronox.de>
> ---
>  crypto/drbg.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
