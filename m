Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F85B2F82CC
	for <lists+linux-crypto@lfdr.de>; Fri, 15 Jan 2021 18:46:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728560AbhAORpg (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 15 Jan 2021 12:45:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:60008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726309AbhAORpg (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 15 Jan 2021 12:45:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B13B238D6;
        Fri, 15 Jan 2021 17:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610732696;
        bh=BfZcGJY2IOBcFycPKt71T3dXLotsclHcHkIuIfRyXfI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QWzXqKiJAUBOOBlkaSfYDGdBZrUcdH1YITvhHLWOUVzDzQbgrarajA2KnsGQbdf3U
         Oyymyl/H+dL6cZAIgm7jdEwVkquq0YZ27Zomes+BdRJlQwYh95lq7NdEtUY7d3SdjN
         h/yXcLrBHEj2C/MedWm5cWRWNpjPSM/5l0fC5ujrzDDm7rkibOnmoik72VBxhXXxCI
         wbonfXFnSxWLkD4Qp1TAD1aSrVaq53+vl1t+p1pLmEJXr3Rm2LdxZxQuidvTHUO3Ex
         ppSS5u27KDJOE/oKNq863wvoK1uAM+OZfuJPOBCi/AcUXg4e8H965a8tFf+hzXMcDV
         qz53BU0sTSzOg==
Date:   Fri, 15 Jan 2021 09:44:54 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-crypto@vger.kernel.org, ardb@kernel.org,
        herbert@gondor.apana.org.au,
        John Donnelly <john.p.donnelly@oracle.com>
Subject: Re: [PATCH] crypto: lib/chacha20poly1305 - define empty module exit
 function
Message-ID: <YAHUlvfmSSg3+Wl/@sol.localdomain>
References: <20210115171743.1559595-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115171743.1559595-1-Jason@zx2c4.com>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jan 15, 2021 at 06:17:43PM +0100, Jason A. Donenfeld wrote:
> users are unable to load the module after use.

It should say "unload".

- Eric
