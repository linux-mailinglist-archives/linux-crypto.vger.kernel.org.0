Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6B84F0D83
	for <lists+linux-crypto@lfdr.de>; Wed,  6 Nov 2019 05:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731006AbfKFEDp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 5 Nov 2019 23:03:45 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:37602 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfKFEDp (ORCPT <rfc822;linux-crypto@vger.kernel.orG>);
        Tue, 5 Nov 2019 23:03:45 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iSCXn-00064F-Uy; Wed, 06 Nov 2019 12:03:44 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iSCXj-0004XI-Rf; Wed, 06 Nov 2019 12:03:39 +0800
Date:   Wed, 6 Nov 2019 12:03:39 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 28/29] crypto: remove deprecated and unused ablkcipher
 support
Message-ID: <20191106040339.mclk3vyjv3wawmhx@gondor.apana.org.au>
References: <20191105132826.1838-1-ardb@kernel.org>
 <20191105132826.1838-29-ardb@kernel.org>
 <20191105175206.GD757@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105175206.GD757@sol.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Nov 05, 2019 at 09:52:06AM -0800, Eric Biggers wrote:
>
> Now that these helpers are trivial, they could be removed and we could just
> dereference the struct skcipher_alg directly.

We probably should just keep them to avoid churn.  New code can
certainly start using them directly.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
