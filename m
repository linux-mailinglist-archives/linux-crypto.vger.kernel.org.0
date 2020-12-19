Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92E672DECB3
	for <lists+linux-crypto@lfdr.de>; Sat, 19 Dec 2020 03:06:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgLSCFh (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 18 Dec 2020 21:05:37 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:41518 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725940AbgLSCFh (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 18 Dec 2020 21:05:37 -0500
Received: from [192.168.103.7] (helo=gwarestrin.arnor.me.apana.org.au)
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kqRbX-00054x-AV; Sat, 19 Dec 2020 13:04:20 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 19 Dec 2020 13:04:33 +1100
Date:   Sat, 19 Dec 2020 13:04:33 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Dave Martin <dave.martin@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 0/5] running kernel mode SIMD with softirqs disabled
Message-ID: <20201219020433.GA11077@gondor.apana.org.au>
References: <20201218170106.23280-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201218170106.23280-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Dec 18, 2020 at 06:01:01PM +0100, Ard Biesheuvel wrote:
>
> Questions:
> - what did I miss or break horribly?
> - does any of this matter for RT? AIUI, RT runs softirqs from a dedicated
>   kthread, so I don't think it cares.
> - what would be a reasonable upper bound to keep softirqs disabled? I suppose
>   100s of cycles or less is overkill, but I'm not sure how to derive a better
>   answer.
> - could we do the same on x86, now that kernel_fpu_begin/end is no longer
>   expensive?

If this approach works not only would it allow us to support the
synchronous users better, it would also allow us to remove loads
of cruft in the Crypto API that exist solely to support these SIMD
code paths.

So I eagerly await the assessment of the scheduler/RT folks on this
approach.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
