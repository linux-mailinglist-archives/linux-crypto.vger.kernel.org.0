Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B960172DB5
	for <lists+linux-crypto@lfdr.de>; Fri, 28 Feb 2020 01:51:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730155AbgB1Av4 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 27 Feb 2020 19:51:56 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:55678 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729984AbgB1Av4 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 27 Feb 2020 19:51:56 -0500
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1j7Tsf-0000MP-VI; Fri, 28 Feb 2020 11:51:55 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 28 Feb 2020 11:51:53 +1100
Date:   Fri, 28 Feb 2020 11:51:53 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Devulapally Shiva Krishna <shiva@chelsio.com>
Cc:     linux-crypto@vger.kernel.org, manojmalviya@chelsio.com,
        ayush.sawal@chelsio.com
Subject: Re: [PATCH Crypto] chcr: un-register crypto algorithms
Message-ID: <20200228005153.GC9506@gondor.apana.org.au>
References: <20200219131357.5679-1-shiva@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219131357.5679-1-shiva@chelsio.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Feb 19, 2020 at 06:43:57PM +0530, Devulapally Shiva Krishna wrote:
> When a PCI device will be removed, cxgb4(LLD) will notify chcr(ULD).
> Incase if it's a last pci device, chcr should un-register all the crypto
> algorithms.
> 
> Signed-off-by: Devulapally Shiva Krishna <shiva@chelsio.com>
> ---
>  drivers/crypto/chelsio/chcr_core.c | 2 ++
>  1 file changed, 2 insertions(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
