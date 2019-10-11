Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3612D3913
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Oct 2019 08:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbfJKGCf (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 11 Oct 2019 02:02:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:46826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbfJKGCf (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 11 Oct 2019 02:02:35 -0400
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3356720659;
        Fri, 11 Oct 2019 06:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570773754;
        bh=SBBREUJ7L4LRecn4Q41c/ojYzyaMc2/TOgFSVd6X3/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pRQOnDNSP30Axs6yAHvEH7daP10TLudVuIVeczYBefQVu+1+vv8tvbMePmyxHJpHq
         TDvfFsWWLgf1Komw/hCSujEbmczfeZeArfb3lLeUs3dW2RRYxsn6SsqY4V7cidlfN8
         DPheEEXw1KDFR6xVM7ebGFdBNYNlrWPH3LRTq0Sk=
Date:   Thu, 10 Oct 2019 23:02:32 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Martin Willi <martin@strongswan.org>,
        Rene van Dorst <opensource@vdorst.com>
Subject: Re: [PATCH v3 21/29] crypto: BLAKE2s - generic C library
 implementation and selftest
Message-ID: <20191011060232.GB23882@sol.localdomain>
Mail-Followup-To: Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Samuel Neves <sneves@dei.uc.pt>, Arnd Bergmann <arnd@arndb.de>,
        Andy Lutomirski <luto@kernel.org>,
        Martin Willi <martin@strongswan.org>,
        Rene van Dorst <opensource@vdorst.com>
References: <20191007164610.6881-1-ard.biesheuvel@linaro.org>
 <20191007164610.6881-22-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191007164610.6881-22-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Oct 07, 2019 at 06:46:02PM +0200, Ard Biesheuvel wrote:
> From: "Jason A. Donenfeld" <Jason@zx2c4.com>
> 
> The C implementation was originally based on Samuel Neves' public
> domain reference implementation but has since been heavily modified
> for the kernel. We're able to do compile-time optimizations by moving
> some scaffolding around the final function into the header file.
> 
> Information: https://blake2.net/
> 
> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Signed-off-by: Samuel Neves <sneves@dei.uc.pt>
> Co-developed-by: Samuel Neves <sneves@dei.uc.pt>
> [ardb: move from lib/zinc to lib/crypto and remove simd handling]
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

FYI, I had left a few review comments on Jason's last version of this patch
(https://lkml.kernel.org/linux-crypto/20190326173759.GA607@zzz.localdomain/),
some of which Jason addressed in the Wireguard repository
(https://git.zx2c4.com/WireGuard) but they didn't make it into this patch.
I'd suggest taking a look at the version there.

- Eric
