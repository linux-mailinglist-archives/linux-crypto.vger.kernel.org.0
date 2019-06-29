Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D36585A7F9
	for <lists+linux-crypto@lfdr.de>; Sat, 29 Jun 2019 03:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbfF2BQI (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 28 Jun 2019 21:16:08 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:60656 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726884AbfF2BQI (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 28 Jun 2019 21:16:08 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hh1yE-0002yf-KG; Sat, 29 Jun 2019 09:16:02 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hh1yB-0006BE-Ca; Sat, 29 Jun 2019 09:15:59 +0800
Date:   Sat, 29 Jun 2019 09:15:59 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] crypto: serpent - mark __serpent_setkey_sbox
 noinline
Message-ID: <20190629011559.vp4t2tubhyihow3q@gondor.apana.org.au>
References: <20190618111953.3183723-1-arnd@arndb.de>
 <20190628041912.qprczc23gzeelag7@gondor.apana.org.au>
 <20190628170437.GA103946@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190628170437.GA103946@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jun 28, 2019 at 10:04:38AM -0700, Eric Biggers wrote:
>
> Hi Herbert, seems you forgot to push?  I don't see this in cryptodev.

Yes you're right.  It should be there now.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
