Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1F1D2FCABC
	for <lists+linux-crypto@lfdr.de>; Wed, 20 Jan 2021 06:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730075AbhATFap (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 20 Jan 2021 00:30:45 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:45336 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730129AbhATF1Z (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 20 Jan 2021 00:27:25 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l260k-0005rv-1s; Wed, 20 Jan 2021 16:26:31 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 20 Jan 2021 16:26:29 +1100
Date:   Wed, 20 Jan 2021 16:26:29 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sven Auhagen <sven.auhagen@voleatech.de>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [BUG] marvell/cesa - Fix sparse warnings breaks driver
Message-ID: <20210120052629.GA7040@gondor.apana.org.au>
References: <20210118091808.3dlauqgbv5yk25oa@SvensMacbookPro.hq.voleatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118091808.3dlauqgbv5yk25oa@SvensMacbookPro.hq.voleatech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jan 18, 2021 at 10:18:08AM +0100, Sven Auhagen wrote:
>
> Also on my 5.10 Kernel the hash tests are failing now
> but this also happens when I remove your patch:
> 
> [    6.859791] alg: ahash: mv-hmac-md5 test failed (wrong result) on test vector 0, cfg="init+update+final aligned buffer"
> [    6.883144] alg: ahash: mv-hmac-sha1 test failed (wrong result) on test vector 0, cfg="init+update+final aligned buffer"
> [    6.923069] alg: ahash: mv-hmac-sha256 test failed (wrong result) on test vector 0, cfg="init+update+final aligned buffer"

Are these errors with or without my patch?

Is your machine big-endian or little-endian?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
