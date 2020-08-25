Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0769250DC1
	for <lists+linux-crypto@lfdr.de>; Tue, 25 Aug 2020 02:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726912AbgHYAnl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 24 Aug 2020 20:43:41 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:58782 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726090AbgHYAnl (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 24 Aug 2020 20:43:41 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kAN3o-0004XJ-Ti; Tue, 25 Aug 2020 10:43:38 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 25 Aug 2020 10:43:36 +1000
Date:   Tue, 25 Aug 2020 10:43:36 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Fabio Estevam <festevam@gmail.com>
Cc:     linux-crypto@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com
Subject: Re: [PATCH 1/2] crypto: stm32/crc32 - include <linux/io.h>
Message-ID: <20200825004336.GA7849@gondor.apana.org.au>
References: <20200824135840.3716-1-festevam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200824135840.3716-1-festevam@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Aug 24, 2020 at 10:58:39AM -0300, Fabio Estevam wrote:
> Building ARM allmodconfig leads to the following warnings:
> 
> drivers/crypto/stm32/stm32-crc32.c:128:2: error: implicit declaration of function 'writel_relaxed' [-Werror=implicit-function-declaration]
> drivers/crypto/stm32/stm32-crc32.c:134:17: error: implicit declaration of function 'readl_relaxed' [-Werror=implicit-function-declaration]
> drivers/crypto/stm32/stm32-crc32.c:176:4: error: implicit declaration of function 'writeb_relaxed' [-Werror=implicit-function-declaration]
> 
> Include <linux/io.h> to fix such warnings.
> 
> Reported-by: Olof's autobuilder <build@lixom.net>
> Signed-off-by: Fabio Estevam <festevam@gmail.com>
> ---
>  drivers/crypto/stm32/stm32-crc32.c | 1 +
>  1 file changed, 1 insertion(+)

Thank you.  But this is already in the queue:

https://patchwork.kernel.org/patch/11729369/
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
