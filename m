Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A5B2659AF
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Sep 2020 08:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725535AbgIKG4G (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Sep 2020 02:56:06 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:58904 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725497AbgIKG4E (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Sep 2020 02:56:04 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kGcyV-0007qo-1n; Fri, 11 Sep 2020 16:56:00 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 11 Sep 2020 16:55:59 +1000
Date:   Fri, 11 Sep 2020 16:55:59 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org
Subject: Re: [PATCH 2/2] crypto: sa2ul: fix compiler warning produced by clang
Message-ID: <20200911065558.GA32150@gondor.apana.org.au>
References: <20200825133106.21542-1-t-kristo@ti.com>
 <20200825133106.21542-3-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200825133106.21542-3-t-kristo@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Aug 25, 2020 at 04:31:06PM +0300, Tero Kristo wrote:
> Clang detects a warning for an assignment that doesn't really do
> anything. Fix this by removing the offending piece of code.
> 
> Fixes: 7694b6ca649f ("crypto: sa2ul - Add crypto driver")
> Reported-by: Nathan Chancellor <natechancellor@gmail.com>
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  drivers/crypto/sa2ul.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
