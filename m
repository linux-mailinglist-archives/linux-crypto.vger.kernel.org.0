Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04772BA2B8
	for <lists+linux-crypto@lfdr.de>; Fri, 20 Nov 2020 07:57:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgKTG5G (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 20 Nov 2020 01:57:06 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:34200 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725789AbgKTG5G (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 20 Nov 2020 01:57:06 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kg0Lm-0007il-IE; Fri, 20 Nov 2020 17:56:55 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 20 Nov 2020 17:56:54 +1100
Date:   Fri, 20 Nov 2020 17:56:54 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Wang Qing <wangqing@vivo.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: crypto: caam/qi - simplify error path for context allocation
Message-ID: <20201120065654.GC20581@gondor.apana.org.au>
References: <1604653287-16577-1-git-send-email-wangqing@vivo.com>
 <7e8409c9-ce91-3970-6ae0-e6e06987c117@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e8409c9-ce91-3970-6ae0-e6e06987c117@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Nov 12, 2020 at 11:21:46AM +0200, Horia Geantă wrote:
> 
> Wang Qing reports that IS_ERR_OR_NULL() should be matched with
> PTR_ERR_OR_ZERO(), not PTR_ERR().
> 
> As it turns out, the error path always returns an error code,
> i.e. NULL is never returned.
> Update the code accordingly - s/IS_ERR_OR_NULL/IS_ERR.
> 
> Reported-by: Wang Qing <wangqing@vivo.com>
> Signed-off-by: Horia Geantă <horia.geanta@nxp.com>
> ---
>  drivers/crypto/caam/caamalg_qi.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
