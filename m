Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 957A7156380
	for <lists+linux-crypto@lfdr.de>; Sat,  8 Feb 2020 09:58:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgBHI6E (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 8 Feb 2020 03:58:04 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:52844 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726229AbgBHI6E (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 8 Feb 2020 03:58:04 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1j0Lw4-0007g5-89; Sat, 08 Feb 2020 16:57:56 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1j0LvN-0002bM-Od; Sat, 08 Feb 2020 16:57:13 +0800
Date:   Sat, 8 Feb 2020 16:57:13 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>
Cc:     Eric Biggers <ebiggers@kernel.org>, davem@davemloft.net,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [BUG] crypto: export() overran state buffer on test vector
Message-ID: <20200208085713.ftuqxhatk6iioz7e@gondor.apana.org.au>
References: <20200206085442.GA5585@Red>
 <20200207065719.GA8284@sol.localdomain>
 <20200207104659.GA10979@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200207104659.GA10979@Red>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Feb 07, 2020 at 11:46:59AM +0100, Corentin Labbe wrote:
>
> My goal is to do like n2-crypto/rk3288crypto/etc..., fallback for init/update/final/finup and only do stuff with digest().
> So I have just exactly copied what they do.

n2 at least is totally broken wrt import/export.  The other ones
would work provided that the fallback have the same statesize as
the generic sha implementations.

Are you not using the standard state sizes?

This should probably be switched over to lib/crypto or at least
shash.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
