Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D121F544C
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Jun 2020 14:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728947AbgFJMLR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 10 Jun 2020 08:11:17 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60338 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728558AbgFJMLP (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 10 Jun 2020 08:11:15 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jizZT-0001e7-0V; Wed, 10 Jun 2020 22:11:08 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 10 Jun 2020 22:11:07 +1000
Date:   Wed, 10 Jun 2020 22:11:07 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Mikulas Patocka <mpatocka@redhat.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, Mike Snitzer <msnitzer@redhat.com>,
        Milan Broz <mbroz@redhat.com>, dm-devel@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: crypto API and GFP_ATOMIC
Message-ID: <20200610121106.GA23137@gondor.apana.org.au>
References: <alpine.LRH.2.02.2006091259250.30590@file01.intranet.prod.int.rdu2.redhat.com>
 <20200610010450.GA6449@gondor.apana.org.au>
 <alpine.LRH.2.02.2006100756270.27811@file01.intranet.prod.int.rdu2.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.02.2006100756270.27811@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Jun 10, 2020 at 08:02:23AM -0400, Mikulas Patocka wrote:
>
> Yes, fixing the drivers would be the best - but you can hardly find any 
> person who has all the crypto hardware and who is willing to rewrite all 
> the drivers for it.

We don't have to rewrite them straight away.  We could mark the
known broken ones (or the known working ones) and then dm-crypt
can allocate only those using the types/mask to crypto_alloc.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
