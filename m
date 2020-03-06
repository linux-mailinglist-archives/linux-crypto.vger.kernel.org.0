Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0025217B3E6
	for <lists+linux-crypto@lfdr.de>; Fri,  6 Mar 2020 02:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726178AbgCFBsG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 5 Mar 2020 20:48:06 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:45972 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726162AbgCFBsG (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 5 Mar 2020 20:48:06 -0500
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jA25q-0005iR-Jm; Fri, 06 Mar 2020 12:48:03 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 06 Mar 2020 12:48:02 +1100
Date:   Fri, 6 Mar 2020 12:48:02 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ayush Sawal <ayush.sawal@chelsio.com>
Cc:     linux-crypto@vger.kernel.org, vinay.yadav@chelsio.com,
        manojmalviya@chelsio.com
Subject: Re: [PATCH Crypto 0/2] Improving the performance of chelsio crypto
 operations
Message-ID: <20200306014802.GA30653@gondor.apana.org.au>
References: <20200224034233.12476-1-ayush.sawal@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224034233.12476-1-ayush.sawal@chelsio.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Feb 24, 2020 at 09:12:31AM +0530, Ayush Sawal wrote:
> patch 1: Recalculate iv only if it is needed for aes-xts.
> patch 2: Use multiple txq/rxq per tfm to process the requests.
> 
> Ayush Sawal (2):
>   chcr: Recalculate iv only if it is needed
>   chcr: Use multiple txq/rxq per tfm to process the requests
> 
>  drivers/crypto/chelsio/chcr_algo.c   | 337 +++++++++++++++++----------
>  drivers/crypto/chelsio/chcr_core.h   |   1 -
>  drivers/crypto/chelsio/chcr_crypto.h |  15 +-
>  3 files changed, 227 insertions(+), 126 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
