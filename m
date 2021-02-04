Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E95B30EA61
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Feb 2021 03:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhBDCpS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 3 Feb 2021 21:45:18 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:51158 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhBDCpS (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 3 Feb 2021 21:45:18 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l7UdB-00007F-R6; Thu, 04 Feb 2021 13:44:31 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 04 Feb 2021 13:44:29 +1100
Date:   Thu, 4 Feb 2021 13:44:29 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Will Deacon <will@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org,
        catalin.marinas@arm.com, kernel-team@android.com,
        mark.rutland@arm.com, Dave Martin <dave.martin@arm.com>,
        Eric Biggers <ebiggers@google.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: (subset) Re: [PATCH v2 0/9] arm64: rework NEON yielding to avoid
 scheduling from asm code
Message-ID: <20210204024429.GB5482@gondor.apana.org.au>
References: <20210203113626.220151-1-ardb@kernel.org>
 <161238528350.1984862.12324465919265084208.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <161238528350.1984862.12324465919265084208.b4-ty@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Feb 03, 2021 at 09:31:31PM +0000, Will Deacon wrote:
>
> Applied first patch only to arm64 (for-next/crypto), thanks!
> 
> [1/9] arm64: assembler: add cond_yield macro
>       https://git.kernel.org/arm64/c/d13c613f136c
> 
> This is the only patch on the branch, so I'm happy for it to be pulled
> into the crypto tree too if it enables some of the other patches to land
> in 5.12.

Hi Will:

I think it might be easier if you take the lot.

Acked-by: Herbert Xu <herbert@gondor.apana.org.au>

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
