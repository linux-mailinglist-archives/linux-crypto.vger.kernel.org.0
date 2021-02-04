Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AD6030FD2F
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Feb 2021 20:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231686AbhBDTqI (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 4 Feb 2021 14:46:08 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:52768 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238040AbhBDTqC (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 4 Feb 2021 14:46:02 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l7kYy-0002kW-3F; Fri, 05 Feb 2021 06:45:13 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 05 Feb 2021 06:45:11 +1100
Date:   Fri, 5 Feb 2021 06:45:11 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Will Deacon <will@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Android Kernel Team <kernel-team@android.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Eric Biggers <ebiggers@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: (subset) Re: [PATCH v2 0/9] arm64: rework NEON yielding to avoid
 scheduling from asm code
Message-ID: <20210204194511.GA9961@gondor.apana.org.au>
References: <20210203113626.220151-1-ardb@kernel.org>
 <161238528350.1984862.12324465919265084208.b4-ty@kernel.org>
 <20210204024429.GB5482@gondor.apana.org.au>
 <CAMj1kXH6B8jbVk6xMa4H6GOpEgDCS9vbWLxvM0X-cdataoijdA@mail.gmail.com>
 <20210204111026.GA8155@gondor.apana.org.au>
 <20210204130311.GD20468@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210204130311.GD20468@willie-the-truck>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Feb 04, 2021 at 01:03:11PM +0000, Will Deacon wrote:
>
> Cheers, Herbert. Please just leave the final patch ("arm64: assembler:
> remove conditional NEON yield macro"), as we can come back to that for
> 5.13.

Sure I'll leave out the last patch.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
