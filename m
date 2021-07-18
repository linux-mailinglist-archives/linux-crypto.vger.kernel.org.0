Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C90943CC954
	for <lists+linux-crypto@lfdr.de>; Sun, 18 Jul 2021 15:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233666AbhGRNaJ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 18 Jul 2021 09:30:09 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:51438 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232859AbhGRNaJ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 18 Jul 2021 09:30:09 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1m56om-0003cS-3J; Sun, 18 Jul 2021 21:26:52 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1m56ob-0003CV-F6; Sun, 18 Jul 2021 21:26:41 +0800
Date:   Sun, 18 Jul 2021 21:26:41 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Hannes Reinecke <hare@suse.de>
Cc:     Stephan =?iso-8859-1?Q?M=FCller?= <smueller@chronox.de>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <keith.busch@wdc.com>,
        linux-nvme@lists.infradead.org,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH 09/11] nvmet: Implement basic In-Band Authentication
Message-ID: <20210718132641.GA12275@gondor.apana.org.au>
References: <20210716110428.9727-1-hare@suse.de>
 <20210716110428.9727-10-hare@suse.de>
 <2510347.locV8n3378@positron.chronox.de>
 <a4d4bda0-2bc8-0d0c-3e81-55adecd6ce52@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4d4bda0-2bc8-0d0c-3e81-55adecd6ce52@suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Jul 18, 2021 at 02:37:34PM +0200, Hannes Reinecke wrote:
>
> > > +	response = kmalloc(data->hl, GFP_KERNEL);
> > 
> > Again, align to CRYPTO_MINALIGN_ATTR?
> 
> Ah, _that_ alignment.
> Wasn't aware that I need to align to anything.
> But if that's required, sure, I'll be fixing it.

Memory returned by kmalloc is guaranteed to be aligned to
CRYPTO_MINALIGN_ATTR, in fact that's the whole point of that
attribute.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
