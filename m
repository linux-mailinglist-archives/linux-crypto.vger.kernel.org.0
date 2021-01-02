Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2B5B2E88E6
	for <lists+linux-crypto@lfdr.de>; Sat,  2 Jan 2021 23:09:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbhABWI5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 2 Jan 2021 17:08:57 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:37356 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbhABWI5 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 2 Jan 2021 17:08:57 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kvp4D-0000be-Vu; Sun, 03 Jan 2021 09:08:11 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sun, 03 Jan 2021 09:08:09 +1100
Date:   Sun, 3 Jan 2021 09:08:09 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH 1/2] crypto: arm64/aes-ce - really hide slower algos when
 faster ones are enabled
Message-ID: <20210102220809.GM12767@gondor.apana.org.au>
References: <20201217185516.26969-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201217185516.26969-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Dec 17, 2020 at 07:55:15PM +0100, Ard Biesheuvel wrote:
> Commit 69b6f2e817e5b ("crypto: arm64/aes-neon - limit exposed routines if
> faster driver is enabled") intended to hide modes from the plain NEON
> driver that are also implemented by the faster bit sliced NEON one if
> both are enabled. However, the defined() CPP function does not detect
> if the bit sliced NEON driver is enabled as a module. So instead, let's
> use IS_ENABLED() here.
> 
> Fixes: 69b6f2e817e5b ("crypto: arm64/aes-neon - limit exposed routines if ...")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/crypto/aes-glue.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
