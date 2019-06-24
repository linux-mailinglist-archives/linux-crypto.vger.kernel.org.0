Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6D45192E
	for <lists+linux-crypto@lfdr.de>; Mon, 24 Jun 2019 18:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728825AbfFXQ4p (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 24 Jun 2019 12:56:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:47688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728732AbfFXQ4p (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 24 Jun 2019 12:56:45 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62B54204FD;
        Mon, 24 Jun 2019 16:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561395404;
        bh=3hkfTpC6rBigy8mkthNbeb4HOBKv55TtVfAodMMom1s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0uRYdpMHOhraNoygK/CwO+XJYTCqH/IF17KSJxeSmOhK7TbbEhcX7qumziczOhWUY
         KErUvZz2+FgahvGOqwJbF7L1pCHIreL9z2rsTSAXTfmfsvSP8P2+KtIxP2GmZ5quSY
         hRzbcNYe++IieiqZpqb8gJ+WFWT2926yp0+KHBX0=
Date:   Mon, 24 Jun 2019 09:56:42 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Steve Capper <steve.capper@arm.com>,
        Milan Broz <gmazyland@gmail.com>
Subject: Re: [PATCH 0/6] crypto: aegis128 - add NEON intrinsics version for
 ARM/arm64
Message-ID: <20190624165641.GB211064@gmail.com>
References: <20190624073818.29296-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624073818.29296-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jun 24, 2019 at 09:38:12AM +0200, Ard Biesheuvel wrote:
> Now that aegis128 has been announced as one of the winners of the CAESAR
> competition, it's time to provide some better support for it on arm64 (and
> 32-bit ARM *)
> 
> This time, instead of cloning the generic driver twice and rewriting half
> of it in arm64 and ARM assembly, add hooks for an accelerated SIMD path to
> the generic driver, and populate it with a C version using NEON intrinsics
> that can be built for both ARM and arm64. This results in a speedup of ~11x,
> resulting in a performance of 2.2 cycles per byte on Cortex-A53.
> 
> Patches #1 .. #3 are some fixes/improvements for the generic code. Patch #4
> adds the plumbing for using a SIMD accelerated implementation. Patch #5
> adds the ARM and arm64 code, and patch #6 adds a speed test.
> 
> Note that aegis128l and aegis256 were not selected, and nor where any of the
> morus contestants, and so we should probably consider dropping those drivers
> again.
> 

I'll also note that a few months ago there were attacks published on all
versions of full MORUS, with only 2^76 data and time complexity
(https://eprint.iacr.org/2019/172.pdf).  So MORUS is cryptographically broken,
and isn't really something that people should be using.  Ondrej, are people
actually using MORUS in the kernel?  I understand that you added it for your
Master's Thesis with the intent that it would be used with dm-integrity and
dm-crypt, but it's not clear that people are actually doing that.

In any case we could consider dropping the assembly implementations, though.

- Eric
