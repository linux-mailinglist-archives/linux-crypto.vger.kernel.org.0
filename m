Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632211AB5D9
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Apr 2020 04:27:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731975AbgDPCZz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 15 Apr 2020 22:25:55 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:39942 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731031AbgDPCZv (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 15 Apr 2020 22:25:51 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jOuD8-0001xU-SK; Thu, 16 Apr 2020 12:25:04 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 16 Apr 2020 12:25:02 +1000
Date:   Thu, 16 Apr 2020 12:25:02 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     syzbot <syzbot+fc0674cde00b66844470@syzkaller.appspotmail.com>,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: crypto: api - Fix use-after-free and race in crypto_spawn_alg
Message-ID: <20200416022502.GA18386@gondor.apana.org.au>
References: <0000000000002656a605a2a34356@google.com>
 <20200410060942.GA4048@gondor.apana.org.au>
 <20200416021703.GD816@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200416021703.GD816@sol.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Apr 15, 2020 at 07:17:03PM -0700, Eric Biggers wrote:
> 
> Wouldn't it be a bit simpler to set 'target = NULL', remove 'shoot',
> and use 'if (target)' instead of 'if (shoot)'?

Yes it is simpler but it's actually semantically different because
the compiler doesn't know that spawn->alg cannot be NULL in this
case.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
