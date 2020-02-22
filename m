Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25FD4168B8A
	for <lists+linux-crypto@lfdr.de>; Sat, 22 Feb 2020 02:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgBVBTs (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 21 Feb 2020 20:19:48 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:52070 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726852AbgBVBTs (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 21 Feb 2020 20:19:48 -0500
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1j5JS2-0002aA-9T; Sat, 22 Feb 2020 12:19:27 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 22 Feb 2020 12:19:26 +1100
Date:   Sat, 22 Feb 2020 12:19:26 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Cc:     davem@davemloft.net, ebiggers@kernel.org, pvanleeuwen@rambus.com,
        zohar@linux.ibm.com, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: sm3 - export crypto_sm3_final function
Message-ID: <20200222011926.GA18695@gondor.apana.org.au>
References: <20200216090233.109416-1-tianjia.zhang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200216090233.109416-1-tianjia.zhang@linux.alibaba.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Feb 16, 2020 at 05:02:33PM +0800, Tianjia Zhang wrote:
> Both crypto_sm3_update and crypto_sm3_finup have been
> exported, exporting crypto_sm3_final, to avoid having to
> use crypto_sm3_finup(desc, NULL, 0, dgst) to calculate
> the hash in some cases.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>  crypto/sm3_generic.c | 7 ++++---
>  include/crypto/sm3.h | 2 ++
>  2 files changed, 6 insertions(+), 3 deletions(-)

Please add this into the series that actually uses the function.
It makes no sense on its own.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
