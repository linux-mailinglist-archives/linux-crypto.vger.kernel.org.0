Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA94B1CA391
	for <lists+linux-crypto@lfdr.de>; Fri,  8 May 2020 08:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgEHGGo (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 8 May 2020 02:06:44 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:40176 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725937AbgEHGGo (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 8 May 2020 02:06:44 -0400
Received: from gwarestrin.me.apana.org.au ([192.168.0.7] helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1jWw3F-000538-VW; Fri, 08 May 2020 16:00:03 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 08 May 2020 16:06:41 +1000
Date:   Fri, 8 May 2020 16:06:41 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH v2] crypto: lib/sha256 - return void
Message-ID: <20200508060641.GA24931@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501164229.24952-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> The SHA-256 / SHA-224 library functions can't fail, so remove the
> useless return value.
> 
> Also long as the declarations are being changed anyway, also fix some
> parameter names in the declarations to match the definitions.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> 
> v2: remove unnecessary 'extern' keywords
> 
> crypto/sha256_generic.c      | 14 +++++++++-----
> include/crypto/sha.h         | 18 ++++++------------
> include/crypto/sha256_base.h |  6 ++++--
> lib/crypto/sha256.c          | 20 ++++++++------------
> 4 files changed, 27 insertions(+), 31 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
