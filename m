Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39B0F233FF4
	for <lists+linux-crypto@lfdr.de>; Fri, 31 Jul 2020 09:26:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731557AbgGaH05 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 31 Jul 2020 03:26:57 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:39886 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731419AbgGaH05 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 31 Jul 2020 03:26:57 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k1PRO-0001Iv-9s; Fri, 31 Jul 2020 17:26:55 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 31 Jul 2020 17:26:54 +1000
Date:   Fri, 31 Jul 2020 17:26:54 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     lenaptr@google.com, linux-crypto@vger.kernel.org, ardb@kernel.org
Subject: Re: [PATCH 1/1] crypto: af_alg - add extra parameters for DRBG
 interface
Message-ID: <20200731072654.GA17312@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713172511.GB722906@gmail.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:
>
> lock_sock() would solve the former.  I'm not sure what should be done about
> rng_recvmsg().  It apparently relies on the crypto_rng doing its own locking,
> but maybe it should just use lock_sock() too.

The lock_sock is only needed if you're doing testing.  What I'd
prefer is to have a completely different code-path for testing.

How about you fork the code in rng_accept_parent so that you have
a separate proto_ops for the test path that is used only if
setentropy has been called? That way all of this code could
magically go away if the CONFIG option wasn't set.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
