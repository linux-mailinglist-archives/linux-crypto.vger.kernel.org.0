Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92AE02132C
	for <lists+linux-crypto@lfdr.de>; Fri, 17 May 2019 06:41:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbfEQEl5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 17 May 2019 00:41:57 -0400
Received: from [128.1.224.119] ([128.1.224.119]:47674 "EHLO deadmen.hmeau.com"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725929AbfEQEl5 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 17 May 2019 00:41:57 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hRUgn-0007Sr-JW; Fri, 17 May 2019 12:41:49 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hRUgd-0006YT-Cg; Fri, 17 May 2019 12:41:39 +0800
Date:   Fri, 17 May 2019 12:41:39 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Daniel Axtens <dja@axtens.net>
Cc:     Michael Ellerman <mpe@ellerman.id.au>, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, marcelo.cerri@canonical.com,
        Stephan Mueller <smueller@chronox.de>,
        leo.barbosa@canonical.com, linuxppc-dev@lists.ozlabs.org,
        nayna@linux.ibm.com, pfsmorigo@gmail.com, leitao@debian.org,
        gcwilson@linux.ibm.com, omosnacek@gmail.com
Subject: Re: [PATCH] crypto: vmx - ghash: do nosimd fallback manually
Message-ID: <20190517044139.vx4wxzflmjpcjw6f@gondor.apana.org.au>
References: <20190516154002.26246-1-dja@axtens.net>
 <87bm02hsl4.fsf@concordia.ellerman.id.au>
 <87tvdtzzsj.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tvdtzzsj.fsf@dja-thinkpad.axtens.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, May 17, 2019 at 10:32:12AM +1000, Daniel Axtens wrote:
>
> Yes, I think that's the right fixes tag. Not quite sure how I managed to
> miss that! Herbert, I assume this will go via your tree: do you want me
> to send a v2 with the tag or are you OK to just add that in when you
> merge it?

I can add this when applying the patch.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
