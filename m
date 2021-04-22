Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 925E1367B5E
	for <lists+linux-crypto@lfdr.de>; Thu, 22 Apr 2021 09:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhDVHr3 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 22 Apr 2021 03:47:29 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:48754 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235146AbhDVHr3 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 22 Apr 2021 03:47:29 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lZU32-00035I-4E; Thu, 22 Apr 2021 17:46:53 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 22 Apr 2021 17:46:51 +1000
Date:   Thu, 22 Apr 2021 17:46:51 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Srujana Challa <schalla@marvell.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        jerinj@marvell.com, pathreya@marvell.com, sgoutham@marvell.com
Subject: Re: [PATCH] crypto: octeontx2: add support for OcteonTX2 98xx CPT
 block.
Message-ID: <20210422074651.GG14354@gondor.apana.org.au>
References: <20210415122837.20506-1-schalla@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210415122837.20506-1-schalla@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Apr 15, 2021 at 05:58:37PM +0530, Srujana Challa wrote:
> OcteonTX2 series of silicons have multiple variants, the
> 98xx variant has two crypto (CPT0 & CPT1) blocks. This patch
> adds support for firmware load on new CPT block(CPT1).
> 
> Signed-off-by: Srujana Challa <schalla@marvell.com>
> ---
>  .../marvell/octeontx2/otx2_cpt_common.h       |  10 +-
>  .../marvell/octeontx2/otx2_cpt_mbox_common.c  |  14 +-
>  drivers/crypto/marvell/octeontx2/otx2_cptlf.c |   8 +-
>  drivers/crypto/marvell/octeontx2/otx2_cptlf.h |   1 +
>  drivers/crypto/marvell/octeontx2/otx2_cptpf.h |   1 +
>  .../marvell/octeontx2/otx2_cptpf_main.c       |  33 +++-
>  .../marvell/octeontx2/otx2_cptpf_ucode.c      | 144 +++++++++++++-----
>  7 files changed, 153 insertions(+), 58 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
