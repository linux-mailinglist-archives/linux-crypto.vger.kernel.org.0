Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE2B7E4FF1
	for <lists+linux-crypto@lfdr.de>; Fri, 25 Oct 2019 17:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440616AbfJYPTE (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 25 Oct 2019 11:19:04 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35700 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439061AbfJYPTD (ORCPT <rfc822;linux-crypto@vger.kernel.orG>);
        Fri, 25 Oct 2019 11:19:03 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iO1Mk-0001dg-D8; Fri, 25 Oct 2019 23:19:02 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iO1Mh-0007ng-5d; Fri, 25 Oct 2019 23:18:59 +0800
Date:   Fri, 25 Oct 2019 23:18:59 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ondrej Mosnacek <omosnace@redhat.com>
Subject: Re: [PATCH v2 0/2] crypto: aegis128 SIMD improvements
Message-ID: <20191025151859.5lof25mpv47s4pfy@gondor.apana.org.au>
References: <20191014161645.1961-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191014161645.1961-1-ard.biesheuvel@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Oct 14, 2019 at 06:16:43PM +0200, Ard Biesheuvel wrote:
> Refactor the aegis128 code to get rid of indirect calls, and implement
> SIMD versions of the init() and final() hooks. This results in a ~2x
> speedup on ARM Cortex-A57 for ~1500 byte inputs.
> 
> Changes since v1:
> - fix missing Sbox loads for plain SIMD on GCC
> - fix endianness issue in final_simd() routine
> 
> Cc: Ondrej Mosnacek <omosnace@redhat.com>
> 
> Ard Biesheuvel (2):
>   crypto: aegis128 - avoid function pointers for parameterization
>   crypto: aegis128 - duplicate init() and final() hooks in SIMD code
> 
>  crypto/aegis128-core.c       | 125 ++++++++++----------
>  crypto/aegis128-neon-inner.c |  50 ++++++++
>  crypto/aegis128-neon.c       |  21 ++++
>  3 files changed, 134 insertions(+), 62 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
