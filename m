Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 654CF295752
	for <lists+linux-crypto@lfdr.de>; Thu, 22 Oct 2020 06:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444006AbgJVEgf (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 22 Oct 2020 00:36:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:53544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2444005AbgJVEgf (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 22 Oct 2020 00:36:35 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9188E223C7;
        Thu, 22 Oct 2020 04:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603341394;
        bh=d9mmkSauBF7Ry50v5+cDqD5/qihN8tfYjtw/3j9I1Sk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TStTqs8LBFQPLZlP/h1dDEGo7q7oLfgrzsmG1FoP+F98JrnxL5mYngrx1RUkSkPsY
         qyeb7/D+ORehS20/LN+tXCWLGR1UeybgtySDI95yxtKzBitUaYhCiTtxHJvsx52IvG
         Wfu56bk3mxbsXmRMrXVu/AHqa38FZBIpoW7revz8=
Date:   Wed, 21 Oct 2020 21:36:33 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Arvind Sankar <nivedita@alum.mit.edu>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        David Laight <David.Laight@aculab.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] crypto: Use memzero_explicit() for clearing state
Message-ID: <20201022043633.GD857@sol.localdomain>
References: <20201020203957.3512851-1-nivedita@alum.mit.edu>
 <20201020203957.3512851-2-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020203957.3512851-2-nivedita@alum.mit.edu>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Oct 20, 2020 at 04:39:52PM -0400, Arvind Sankar wrote:
> Without the barrier_data() inside memzero_explicit(), the compiler may
> optimize away the state-clearing if it can tell that the state is not
> used afterwards. At least in lib/crypto/sha256.c:__sha256_final(), the
> function can get inlined into sha256(), in which case the memset is
> optimized away.
> 
> Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>

Reviewed-by: Eric Biggers <ebiggers@google.com>

Maybe get the one in arch/arm64/crypto/sha3-ce-glue.c too?

- Eric
