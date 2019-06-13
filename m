Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5CEE44502
	for <lists+linux-crypto@lfdr.de>; Thu, 13 Jun 2019 18:41:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726959AbfFMQlR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 13 Jun 2019 12:41:17 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49990 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730562AbfFMGzh (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 13 Jun 2019 02:55:37 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hbJe3-0006Dk-Ap; Thu, 13 Jun 2019 14:55:35 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hbJe1-00053K-Px; Thu, 13 Jun 2019 14:55:33 +0800
Date:   Thu, 13 Jun 2019 14:55:33 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, martin@strongswan.org
Subject: Re: [PATCH] crypto: chacha20poly1305 - a few cleanups
Message-ID: <20190613065533.pmh5puuupfeidqhg@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603054634.6363-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi
Organization: Core
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> - Use sg_init_one() instead of sg_init_table() then sg_set_buf().
> 
> - Remove unneeded calls to sg_init_table() prior to scatterwalk_ffwd().
> 
> - Simplify initializing the poly tail block.
> 
> - Simplify computing padlen.
> 
> This doesn't change any actual behavior.
> 
> Cc: Martin Willi <martin@strongswan.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> crypto/chacha20poly1305.c | 43 ++++++++++++---------------------------
> 1 file changed, 13 insertions(+), 30 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
