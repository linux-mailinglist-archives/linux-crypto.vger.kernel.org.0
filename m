Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09B46871FA
	for <lists+linux-crypto@lfdr.de>; Fri,  9 Aug 2019 08:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727618AbfHIGKO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 9 Aug 2019 02:10:14 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:37254 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726025AbfHIGKO (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 9 Aug 2019 02:10:14 -0400
Received: from gondolin.me.apana.org.au ([192.168.0.6] helo=gondolin.hengli.com.au)
        by fornost.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hvy6G-00076x-OF; Fri, 09 Aug 2019 16:10:04 +1000
Received: from herbert by gondolin.hengli.com.au with local (Exim 4.80)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hvy6B-0002hw-Se; Fri, 09 Aug 2019 16:09:59 +1000
Date:   Fri, 9 Aug 2019 16:09:59 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] crypto: ccree: aead fixes
Message-ID: <20190809060959.GA10392@gondor.apana.org.au>
References: <20190729104020.3681-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729104020.3681-1-gilad@benyossef.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jul 29, 2019 at 01:40:17PM +0300, Gilad Ben-Yossef wrote:
> Fix AEAD handling of authentication failures.
> 
> Gilad Ben-Yossef (2):
>   crypto: ccree: use the full crypt length value
>   crypto: ccree: use std api sg_zero_buffer
> 
>  drivers/crypto/ccree/cc_aead.c       |  3 ++-
>  drivers/crypto/ccree/cc_buffer_mgr.c | 21 ---------------------
>  drivers/crypto/ccree/cc_buffer_mgr.h |  2 --
>  3 files changed, 2 insertions(+), 24 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
