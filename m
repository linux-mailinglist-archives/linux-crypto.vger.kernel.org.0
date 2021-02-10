Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12E0C315FF5
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Feb 2021 08:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbhBJHXe (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 10 Feb 2021 02:23:34 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:50234 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232395AbhBJHXc (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 10 Feb 2021 02:23:32 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l9jpb-0001FL-HF; Wed, 10 Feb 2021 18:22:36 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 10 Feb 2021 18:22:35 +1100
Date:   Wed, 10 Feb 2021 18:22:35 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     davem@davemloft.net, mpe@ellerman.id.au, benh@kernel.crashing.org,
        paulus@samba.org, linux-crypto@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: powerpc: remove unneeded semicolon
Message-ID: <20210210072235.GE4493@gondor.apana.org.au>
References: <1612235850-87446-1-git-send-email-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612235850-87446-1-git-send-email-yang.lee@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Feb 02, 2021 at 11:17:30AM +0800, Yang Li wrote:
> Eliminate the following coccicheck warning:
> ./arch/powerpc/crypto/sha256-spe-glue.c:132:2-3: Unneeded
> semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> ---
>  arch/powerpc/crypto/sha256-spe-glue.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
