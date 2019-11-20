Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 165611030FC
	for <lists+linux-crypto@lfdr.de>; Wed, 20 Nov 2019 02:10:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbfKTBKT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 19 Nov 2019 20:10:19 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:58322 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727262AbfKTBKT (ORCPT <rfc822;linux-crypto@vger.kernel.orG>);
        Tue, 19 Nov 2019 20:10:19 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iXEVe-0003Pi-3i; Wed, 20 Nov 2019 09:10:18 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iXEVb-0000OH-LM; Wed, 20 Nov 2019 09:10:15 +0800
Date:   Wed, 20 Nov 2019 09:10:15 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH] padata: Remove unused padata_remove_cpu
Message-ID: <20191120011015.qzhn3yd6w5qhze3l@gondor.apana.org.au>
References: <20191119223250.jaefneeatsa52nhh@gondor.apana.org.au>
 <20191119225101.t4ktiggrdyptd3ii@ca-dmjordan1.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191119225101.t4ktiggrdyptd3ii@ca-dmjordan1.us.oracle.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Nov 19, 2019 at 05:51:01PM -0500, Daniel Jordan wrote:
> On Wed, Nov 20, 2019 at 06:32:50AM +0800, Herbert Xu wrote:
> > The function padata_remove_cpu was supposed to have been removed
> > along with padata_add_cpu but somehow it remained behind.  Let's
> > kill it now as it doesn't even have a prototype anymore.
> 
> Documentation/padata.txt still has a reference to this function that should be
> removed.

It also has references to all the other functions that have long
disappeared, such as padata_add_cpu.  Would you like to send a
patch to remove all of them?

> Do you plan on posting other fixes in this area?  Asking so I know which to
> work on further.  Thanks.

Not at this point.  So feel free to rebase your work on top of these
patches.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
