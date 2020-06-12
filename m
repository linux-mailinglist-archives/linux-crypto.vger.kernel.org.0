Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5433A1F741E
	for <lists+linux-crypto@lfdr.de>; Fri, 12 Jun 2020 08:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726502AbgFLGst (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 12 Jun 2020 02:48:49 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:38982 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbgFLGst (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 12 Jun 2020 02:48:49 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jjdUW-0000qz-65; Fri, 12 Jun 2020 16:48:41 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 12 Jun 2020 16:48:40 +1000
Date:   Fri, 12 Jun 2020 16:48:40 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        SrujanaChalla <schalla@marvell.com>,
        Arnaud Ebalard <arno@natisbad.org>,
        "David S. Miller" <davem@davemloft.net>,
        Lukasz Bartosik <lbartosik@marvell.com>,
        linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] crypto: marvell/octeontx - Fix a potential NULL
 dereference
Message-ID: <20200612064840.GE16987@gondor.apana.org.au>
References: <20200605110339.GE978434@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200605110339.GE978434@mwanda>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jun 05, 2020 at 02:03:39PM +0300, Dan Carpenter wrote:
> Smatch reports that:
> 
>     drivers/crypto/marvell/octeontx/otx_cptvf_algs.c:132 otx_cpt_aead_callback()
>     warn: variable dereferenced before check 'cpt_info' (see line 121)
> 
> This function is called from process_pending_queue() as:
> 
> drivers/crypto/marvell/octeontx/otx_cptvf_reqmgr.c
>    599                  /*
>    600                   * Call callback after current pending entry has been
>    601                   * processed, we don't do it if the callback pointer is
>    602                   * invalid.
>    603                   */
>    604                  if (callback)
>    605                          callback(res_code, areq, cpt_info);
> 
> It does appear to me that "cpt_info" can be NULL so this could lead to
> a NULL dereference.
> 
> Fixes: 10b4f09491bf ("crypto: marvell - add the Virtual Function driver for CPT")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/crypto/marvell/octeontx/otx_cptvf_algs.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
