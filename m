Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECB320AC1E
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jun 2020 08:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgFZGIU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 26 Jun 2020 02:08:20 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51952 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgFZGIU (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 26 Jun 2020 02:08:20 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1johX5-0004Y5-Al; Fri, 26 Jun 2020 16:08:16 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 26 Jun 2020 16:08:15 +1000
Date:   Fri, 26 Jun 2020 16:08:15 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Colin King <colin.king@canonical.com>,
        linux-crypto@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>
Subject: Re: [PATCH] crypto: caam/qi2 - fix return code in
 ahash_finup_no_ctx()
Message-ID: <20200626060815.GD20811@gondor.apana.org.au>
References: <b351f9b5-940c-61d3-38f2-3654c6da55b0@nxp.com>
 <20200619132253.17207-1-horia.geanta@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200619132253.17207-1-horia.geanta@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jun 19, 2020 at 04:22:53PM +0300, Horia Geantă wrote:
> ahash_finup_no_ctx() returns -ENOMEM in most error cases,
> and this is fine for almost all of them.
> 
> However, the return code provided by dpaa2_caam_enqueue()
> (e.g. -EIO or -EBUSY) shouldn't be overridden by -ENOMEM.
> 
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
> ---
>  drivers/crypto/caam/caamalg_qi2.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
