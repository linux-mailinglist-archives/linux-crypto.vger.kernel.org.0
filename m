Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C854025D39A
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Sep 2020 10:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729815AbgIDI2U (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Sep 2020 04:28:20 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42680 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726575AbgIDI2P (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Sep 2020 04:28:15 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kE74m-0001Ov-L7; Fri, 04 Sep 2020 18:28:05 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Sep 2020 18:28:04 +1000
Date:   Fri, 4 Sep 2020 18:28:04 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Gilad Ben-Yossef <gilad@benyossef.com>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] crypto: sa2ul - Hide pointer and fix
 -Wpointer-to-int-cast in dev_dbg()
Message-ID: <20200904082804.GB1214@gondor.apana.org.au>
References: <20200826162954.28636-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200826162954.28636-1-krzk@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Aug 26, 2020 at 06:29:52PM +0200, Krzysztof Kozlowski wrote:
> Pointers should not be printed because they might leak important
> information about address space layout.  Use %p to hash the value.  This
> also fixes compilation warnings on 32-bit architecture:
> 
>     drivers/crypto/sa2ul.c:1486:33: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/crypto/sa2ul.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
