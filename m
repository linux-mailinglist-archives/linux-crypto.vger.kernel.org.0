Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC64137EE14
	for <lists+linux-crypto@lfdr.de>; Thu, 13 May 2021 00:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345750AbhELVIM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 12 May 2021 17:08:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:55256 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1385565AbhELUJ4 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 12 May 2021 16:09:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EC11C613FB;
        Wed, 12 May 2021 20:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620850128;
        bh=36cqi9wAZ8Ti0+6IfUg3LWypVtFAf7LGyg3uyNPITkA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KYbCW6+aTm/son93aWv64TKSMBBME5E+nrCtN9bBV8C5t1WAHNrX5H7in5bmyP2EZ
         FWqRXEY4/g8oQgFGXvdI8W4/HJeWlXdYaQKVxHj10sZxlSY58GwviPrxFoSOfOo4HP
         Sp7jeMP7Phj41bTDubxjzc84fmQR2DiwKu5ydi3NTjTgJO/fRU8QYwAeZ+8eQwH/DB
         XZsGDxzK9S76TUixPlEFvOTxJLVlksn+3KISOt+CS59tdXB8mTGCrMTe861Z/z2K77
         RIVVCiMiDwsyvn/j91S4qkDxs7XjRn0uPS2XY3hInuVJlBSViDIJEQ8+0u7CETX2zC
         1pzW5h1II+asQ==
Date:   Wed, 12 May 2021 13:08:46 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        herbert@gondor.apana.org.au, will@kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH v3 5/7] crypto: arm64/aes-neonbs - stop using SIMD helper
 for skciphers
Message-ID: <YJw1zrPQMqKDVeih@gmail.com>
References: <20210512184439.8778-1-ardb@kernel.org>
 <20210512184439.8778-6-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210512184439.8778-6-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, May 12, 2021 at 08:44:37PM +0200, Ard Biesheuvel wrote:
> Calls into the skcipher API can only occur from contexts where the SIMD
> unit is available, so there is no need for the SIMD helper.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>

It would be helpful if the commit message made it clear that "Calls into the
skcipher API can only occur from contexts where the SIMD unit is available" is
something that is now the case but wasn't the case previously.  Otherwise I
could see people backporting this patch without its prerequisites.

Likewise for some of the other patches in this patchset.

- Eric
