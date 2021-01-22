Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEA82FFC7D
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Jan 2021 07:22:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725771AbhAVGWC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 22 Jan 2021 01:22:02 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54128 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbhAVGWB (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 22 Jan 2021 01:22:01 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l2pom-00021u-IN; Fri, 22 Jan 2021 17:21:13 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 Jan 2021 17:21:12 +1100
Date:   Fri, 22 Jan 2021 17:21:12 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, ardb@kernel.org,
        John Donnelly <john.p.donnelly@oracle.com>
Subject: Re: [PATCH v2] crypto: lib/chacha20poly1305 - define empty module
 exit function
Message-ID: <20210122062112.GD1217@gondor.apana.org.au>
References: <20210115171743.1559595-1-Jason@zx2c4.com>
 <20210115193012.3059929-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115193012.3059929-1-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jan 15, 2021 at 08:30:12PM +0100, Jason A. Donenfeld wrote:
> With no mod_exit function, users are unable to unload the module after
> use. I'm not aware of any reason why module unloading should be
> prohibited for this one, so this commit simply adds an empty exit
> function.
> 
> Reported-and-tested-by: John Donnelly <john.p.donnelly@oracle.com>
> Acked-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> ---
> v1->v2:
> - Fix typo in commit message.
> 
>  lib/crypto/chacha20poly1305.c | 5 +++++
>  1 file changed, 5 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
