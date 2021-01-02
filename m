Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A72C72E88BF
	for <lists+linux-crypto@lfdr.de>; Sat,  2 Jan 2021 23:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbhABWBi (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 2 Jan 2021 17:01:38 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:37266 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbhABWBh (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 2 Jan 2021 17:01:37 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kvox8-0000UK-1T; Sun, 03 Jan 2021 09:00:51 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sun, 03 Jan 2021 09:00:49 +1100
Date:   Sun, 3 Jan 2021 09:00:49 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: tcrypt - avoid signed overflow in byte count
Message-ID: <20210102220049.GD12767@gondor.apana.org.au>
References: <20201208143441.2796-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208143441.2796-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Dec 08, 2020 at 03:34:41PM +0100, Ard Biesheuvel wrote:
> The signed long type used for printing the number of bytes processed in
> tcrypt benchmarks limits the range to -/+ 2 GiB, which is not sufficient
> to cover the performance of common accelerated ciphers such as AES-NI
> when benchmarked with sec=1. So switch to u64 instead.
> 
> While at it, fix up a missing printk->pr_cont conversion in the AEAD
> benchmark.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  crypto/tcrypt.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
