Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33F721FF01B
	for <lists+linux-crypto@lfdr.de>; Thu, 18 Jun 2020 13:01:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgFRLBF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 18 Jun 2020 07:01:05 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60922 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729419AbgFRLA7 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 18 Jun 2020 07:00:59 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jlsHq-0005MS-OE; Thu, 18 Jun 2020 21:00:51 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 18 Jun 2020 21:00:50 +1000
Date:   Thu, 18 Jun 2020 21:00:50 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Colin King <colin.king@canonical.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "David S . Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] crypto: caam/qi2: remove redundant assignment to ret
Message-ID: <20200618110050.GA10995@gondor.apana.org.au>
References: <20200611153934.928021-1-colin.king@canonical.com>
 <8e08adcb-ef91-124d-d093-921fc97da3af@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e08adcb-ef91-124d-d093-921fc97da3af@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jun 18, 2020 at 01:54:55PM +0300, Horia Geantă wrote:
>
> The proper fix would be updating the ahash_finup_no_ctx() function
> to return the specific error code:
> 	return ret;
> instead of returning -ENOMEM for all error cases.
> 
> For example error code returned by dpaa2_caam_enqueue()
> should be returned instead of -ENOMEM.

You can do that as a follow-up.  The patch is correct as is.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
