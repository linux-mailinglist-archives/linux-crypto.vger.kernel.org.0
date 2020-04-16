Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3B01AB8C5
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Apr 2020 08:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437648AbgDPGyJ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Apr 2020 02:54:09 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:41546 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437468AbgDPGyH (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Apr 2020 02:54:07 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jOyP5-0005SP-QY; Thu, 16 Apr 2020 16:53:40 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 16 Apr 2020 16:53:39 +1000
Date:   Thu, 16 Apr 2020 16:53:39 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     bbrezillon@kernel.org, arno@natisbad.org, schalla@marvell.com,
        davem@davemloft.net, lbartosik@marvell.com,
        colin.king@canonical.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH V2] crypto: marvell/octeontx - Add missing '\n' in log
 messages
Message-ID: <20200416065339.GK7901@gondor.apana.org.au>
References: <20200411120633.22150-1-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200411120633.22150-1-christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Apr 11, 2020 at 02:06:33PM +0200, Christophe JAILLET wrote:
> Message logged by 'dev_xxx()' or 'pr_xxx()' should end with a '\n'.
> 
> While at it, I've introduced a few pr_cont that looked logical to me.
> 
> Fixes: 10b4f09491bf ("crypto: marvell - add the Virtual Function driver for CPT")
> Fixes: d9110b0b01ff ("crypto: marvell - add support for OCTEON TX CPT engine")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> V2: remove a pr_cont after a pr_debug
>     avoid repeating 'engine_group' in a message
> ---
>  .../crypto/marvell/octeontx/otx_cptpf_main.c  |  4 +-
>  .../crypto/marvell/octeontx/otx_cptpf_mbox.c  | 12 +--
>  .../crypto/marvell/octeontx/otx_cptpf_ucode.c | 95 ++++++++++---------
>  .../crypto/marvell/octeontx/otx_cptvf_algs.c  |  6 +-
>  .../crypto/marvell/octeontx/otx_cptvf_main.c  | 12 +--
>  .../marvell/octeontx/otx_cptvf_reqmgr.c       | 10 +-
>  6 files changed, 70 insertions(+), 69 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
