Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5715D2659B0
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Sep 2020 08:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725550AbgIKG4M (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Sep 2020 02:56:12 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:58908 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgIKG4L (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Sep 2020 02:56:11 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kGcyf-0007r2-1r; Fri, 11 Sep 2020 16:56:10 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 11 Sep 2020 16:56:09 +1000
Date:   Fri, 11 Sep 2020 16:56:09 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Uros Bizjak <ubizjak@gmail.com>
Cc:     linux-crypto@vger.kernel.org, x86@kernel.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] crypto/x86: Use XORL r32,32 in curve25519-x86_64.c
Message-ID: <20200911065608.GB32150@gondor.apana.org.au>
References: <20200827173058.94519-1-ubizjak@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827173058.94519-1-ubizjak@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Aug 27, 2020 at 07:30:58PM +0200, Uros Bizjak wrote:
> x86_64 zero extends 32bit operations, so for 64bit operands,
> XORL r32,r32 is functionally equal to XORL r64,r64, but avoids
> a REX prefix byte when legacy registers are used.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> Cc: "David S. Miller" <davem@davemloft.net>
> ---
>  arch/x86/crypto/curve25519-x86_64.c | 68 ++++++++++++++---------------
>  1 file changed, 34 insertions(+), 34 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
