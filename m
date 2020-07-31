Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88576233FF0
	for <lists+linux-crypto@lfdr.de>; Fri, 31 Jul 2020 09:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731587AbgGaHXo (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 31 Jul 2020 03:23:44 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:39876 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731419AbgGaHXo (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 31 Jul 2020 03:23:44 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k1POE-0001Et-Aa; Fri, 31 Jul 2020 17:23:39 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 31 Jul 2020 17:23:38 +1000
Date:   Fri, 31 Jul 2020 17:23:38 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Elena Petrova <lenaptr@google.com>
Cc:     linux-crypto@vger.kernel.org, lenaptr@google.com,
        ebiggers@kernel.org, smueller@chronox.de, ardb@kernel.org,
        jeffv@google.com
Subject: Re: [PATCH v4] crypto: af_alg - add extra parameters for DRBG
 interface
Message-ID: <20200731072338.GA17285@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729154501.2461888-1-lenaptr@google.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Elena Petrova <lenaptr@google.com> wrote:
>
> +#ifdef CONFIG_CRYPTO_USER_API_CAVP_DRBG
> +static int rng_setentropy(void *private, const u8 *entropy, unsigned int len)

Please use __maybe_unused instead of the ifdef.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
