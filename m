Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9495338E81
	for <lists+linux-crypto@lfdr.de>; Fri, 12 Mar 2021 14:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbhCLNOw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 12 Mar 2021 08:14:52 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54572 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231330AbhCLNOj (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 12 Mar 2021 08:14:39 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lKhci-0006Lk-Vf; Sat, 13 Mar 2021 00:14:38 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 13 Mar 2021 00:14:36 +1100
Date:   Sat, 13 Mar 2021 00:14:36 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     linux-crypto@vger.kernel.org,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH] crypto: sun4i-ss - simplify optional reset handling
Message-ID: <20210312131436.GL31502@gondor.apana.org.au>
References: <20210305091236.22046-1-p.zabel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210305091236.22046-1-p.zabel@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Mar 05, 2021 at 10:12:36AM +0100, Philipp Zabel wrote:
> As of commit bb475230b8e5 ("reset: make optional functions really
> optional"), the reset framework API calls use NULL pointers to describe
> optional, non-present reset controls.
> 
> This allows to unconditionally return errors from
> devm_reset_control_get_optional_exclusive.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> ---
>  .../crypto/allwinner/sun4i-ss/sun4i-ss-core.c | 21 +++++++------------
>  1 file changed, 8 insertions(+), 13 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
