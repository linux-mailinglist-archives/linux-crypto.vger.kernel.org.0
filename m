Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA192346E5
	for <lists+linux-crypto@lfdr.de>; Fri, 31 Jul 2020 15:30:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731521AbgGaNaW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 31 Jul 2020 09:30:22 -0400
Received: from [216.24.177.18] ([216.24.177.18]:40522 "EHLO fornost.hmeau.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1731345AbgGaNaV (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 31 Jul 2020 09:30:21 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k1V6i-00016O-76; Fri, 31 Jul 2020 23:29:57 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 31 Jul 2020 23:29:56 +1000
Date:   Fri, 31 Jul 2020 23:29:56 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org, colin.king@canonical.com
Subject: Re: [PATCH] crypto: xts - Replace memcpy() invocation with simple
 assignment
Message-ID: <20200731132956.GD14360@gondor.apana.org.au>
References: <20200721060554.8151-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721060554.8151-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jul 21, 2020 at 09:05:54AM +0300, Ard Biesheuvel wrote:
> Colin reports that the memcpy() call in xts_cts_final() trigggers a
> "Overlapping buffer in memory copy" warning in Coverity, which is a
> false postive, given that tail is guaranteed to be smaller than or
> equal to the distance between source and destination.
> 
> However, given that any additional bytes that we copy will be ignored
> anyway, we can simply copy XTS_BLOCK_SIZE unconditionally, which means
> we can use struct assignment of the array members instead, which is
> likely to be more efficient as well.
> 
> Addresses-Coverity: ("Overlapping buffer in memory copy")
> Fixes: 8083b1bf8163 ("crypto: xts - add support for ciphertext stealing")
> Reported-by: Colin Ian King <colin.king@canonical.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  crypto/xts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
