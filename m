Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 218BB2221F6
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Jul 2020 13:57:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgGPL42 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Jul 2020 07:56:28 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:40160 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728225AbgGPL40 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Jul 2020 07:56:26 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jw2Uy-00006K-5m; Thu, 16 Jul 2020 21:56:25 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 16 Jul 2020 21:56:24 +1000
Date:   Thu, 16 Jul 2020 21:56:24 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-crypto@vger.kernel.org, arnd@arndb.de
Subject: Re: [PATCH] crypto: lrw - prefix function and struct names with "lrw"
Message-ID: <20200716115624.GA31663@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200711033649.144903-1-ebiggers@kernel.org>
X-Newsgroups: apana.lists.os.linux.cryptoapi
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Eric Biggers <ebiggers@kernel.org> wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Overly-generic names can cause problems like naming collisions,
> confusing crash reports, and reduced grep-ability.  E.g. see
> commit d099ea6e6fde ("crypto - Avoid free() namespace collision").
> 
> Clean this up for the lrw template by prefixing the names with "lrw_".
> 
> (I didn't use "crypto_lrw_" instead because that seems overkill.)
> 
> Also constify the tfm context in a couple places.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
> crypto/lrw.c | 119 ++++++++++++++++++++++++++-------------------------
> 1 file changed, 61 insertions(+), 58 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
