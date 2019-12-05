Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99EDD113AC4
	for <lists+linux-crypto@lfdr.de>; Thu,  5 Dec 2019 05:24:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfLEEYA (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 4 Dec 2019 23:24:00 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:50424 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728449AbfLEEYA (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 4 Dec 2019 23:24:00 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1icigJ-00079y-88; Thu, 05 Dec 2019 12:23:59 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1icigH-0007Um-D0; Thu, 05 Dec 2019 12:23:57 +0800
Date:   Thu, 5 Dec 2019 12:23:57 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, pvanleeuwen@verimatrix.com
Subject: Re: [v3 PATCH] crypto: api - fix unexpectedly getting generic
 implementation
Message-ID: <20191205042357.ycvn5lwyu7yksafq@gondor.apana.org.au>
References: <20191202221319.258002-1-ebiggers@kernel.org>
 <20191204091910.67fkpomnav4h5tuw@gondor.apana.org.au>
 <20191204172244.GB1023@sol.localdomain>
 <20191205015811.mg6r3qnv7uj3fgpz@gondor.apana.org.au>
 <20191205040442.GB1158@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191205040442.GB1158@sol.localdomain>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Dec 04, 2019 at 08:04:42PM -0800, Eric Biggers wrote:
>
> This logic doesn't make sense to me either.  It's supposed to be looking for a
> "test larval", not a "request larval", right?  But it seems that larval->mask is
> always 0 for "test larvals", so the flags check will never do anything...

No we only care about request larvals.  Test larvals always have
a non-null adult set so they are irrelevant.

> Also, different "request larvals" can use different flags and masks.  So I don't
> think it's possible to know whether 'q' can fulfill every outstanding request
> that 'alg' can without actually going through and looking at the requests.  So
> that's another case where users can start incorrectly getting ENOENT.

That's a good point.  Let me think about this a bit more.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
