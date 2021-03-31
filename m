Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDFB34A46E
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Mar 2021 10:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbhCZJbT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 26 Mar 2021 05:31:19 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35376 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229904AbhCZJbO (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 26 Mar 2021 05:31:14 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lPioB-0003Uu-3l; Fri, 26 Mar 2021 20:31:12 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Mar 2021 20:31:11 +1100
Date:   Fri, 26 Mar 2021 20:31:11 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Milan Djurovic <mdjurovic@zohomail.com>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: jitterentropy: Put constants on the right side
 of the expression
Message-ID: <20210326093110.GF12658@gondor.apana.org.au>
References: <20210317014403.12742-1-mdjurovic@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317014403.12742-1-mdjurovic@zohomail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Mar 16, 2021 at 06:44:03PM -0700, Milan Djurovic wrote:
> This patch fixes the following checkpatch.pl warnings:
> 
> crypto/jitterentropy.c:600: WARNING: Comparisons should place the constant on the right side of the test
> crypto/jitterentropy.c:681: WARNING: Comparisons should place the constant on the right side of the test
> crypto/jitterentropy.c:772: WARNING: Comparisons should place the constant on the right side of the test
> crypto/jitterentropy.c:829: WARNING: Comparisons should place the constant on the right side of the test
> 
> Signed-off-by: Milan Djurovic <mdjurovic@zohomail.com>
> ---
>  crypto/jitterentropy.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
