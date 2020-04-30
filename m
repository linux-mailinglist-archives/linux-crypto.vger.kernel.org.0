Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB91C1BEFBD
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Apr 2020 07:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgD3Fc5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 30 Apr 2020 01:32:57 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60398 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgD3Fc5 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 30 Apr 2020 01:32:57 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jU1nf-0005SS-TK; Thu, 30 Apr 2020 15:31:57 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 30 Apr 2020 15:32:49 +1000
Date:   Thu, 30 Apr 2020 15:32:49 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe@baylibre.com>
Cc:     davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/3] crypto: fix some DRBG Kconfig deps
Message-ID: <20200430053249.GF11738@gondor.apana.org.au>
References: <1587735647-17718-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587735647-17718-1-git-send-email-clabbe@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Apr 24, 2020 at 01:40:44PM +0000, Corentin Labbe wrote:
> Hello
> 
> Fix serie try to fix some DRBG depencies in Kconfig
> 
> Change since v2:
> - added patch #2
> 
> Changes since v1:
> - Updated commit message with recursive dependency
> 
> Corentin Labbe (3):
>   crypto: drbg: DRBG should select SHA512
>   crypto: CRYPTO_CTR no longer need CRYPTO_SEQIV
>   crypto: drbg: DRBG_CTR should select CTR
> 
>  crypto/Kconfig | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Patches 2-3 applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
