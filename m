Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D53A72E81B2
	for <lists+linux-crypto@lfdr.de>; Thu, 31 Dec 2020 19:57:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgLaS5e (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 31 Dec 2020 13:57:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:36354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbgLaS5e (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 31 Dec 2020 13:57:34 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 952FD222BB;
        Thu, 31 Dec 2020 18:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609441013;
        bh=m74NieL/HeZalPHJBOIb1zbMm8aCdvi4atrF4Z97icQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UxKMjo3OXD5v9Nkdg3pGnXPn295jUt0moROyBSoFUSp9Ic7OPCq82Kl2tREQDypVU
         KShnmGnx6d1HcRR2ZdfHeP56vEnyOMZdJvRvTpowaC7Ma1Tnh2nNBAv5TOPh6QTFOr
         Kt1HNkrQKjjygVLb7Tnxgn4HKJKn4olUvtVYIotpIFfxWrfzvm3nJQ+Be0uvrEaDDC
         s1omeGRXo/6CLd2FjHC0ESB/MKmXZMujWVsLJnbnkiutqho4/Jf1bpiVGeGSf+fDms
         0k+O2F2MHJIQWmoWF4muCEFWxNY9D0szLYFGw5bdF/umlEPgM3FrkQFo0QcvBK2NRD
         wplHveQpYz5aw==
Date:   Thu, 31 Dec 2020 10:56:52 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org, Megha Dey <megha.dey@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Milan Broz <gmazyland@gmail.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: Re: [PATCH 15/21] crypto: x86/camellia - drop dependency on glue
 helper
Message-ID: <X+4e9Jjlsgtsy4B6@sol.localdomain>
References: <20201231172337.23073-1-ardb@kernel.org>
 <20201231172337.23073-16-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201231172337.23073-16-ardb@kernel.org>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Dec 31, 2020 at 06:23:31PM +0100, Ard Biesheuvel wrote:
> Replace the glue helper dependency with implementations of ECB and CBC
> based on the new CPP macros, which avoid the need for indirect calls.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/x86/crypto/camellia_aesni_avx2_glue.c | 85 ++++++--------------
>  arch/x86/crypto/camellia_aesni_avx_glue.c  | 73 +++++------------
>  arch/x86/crypto/camellia_glue.c            | 61 ++++----------
>  crypto/Kconfig                             |  2 -
>  4 files changed, 60 insertions(+), 161 deletions(-)

Acked-by: Eric Biggers <ebiggers@google.com>
