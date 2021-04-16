Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5EE5361EAE
	for <lists+linux-crypto@lfdr.de>; Fri, 16 Apr 2021 13:30:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241812AbhDPLaj (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 16 Apr 2021 07:30:39 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:53042 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235124AbhDPLah (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 16 Apr 2021 07:30:37 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1lXMfq-0003L7-QI; Fri, 16 Apr 2021 21:30:11 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 16 Apr 2021 21:30:10 +1000
Date:   Fri, 16 Apr 2021 21:30:10 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: arm64/aes-ce - deal with oversight in new CTR
 carry code
Message-ID: <20210416113010.GE16633@gondor.apana.org.au>
References: <20210406142523.1101817-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210406142523.1101817-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Apr 06, 2021 at 04:25:23PM +0200, Ard Biesheuvel wrote:
> The new carry handling code in the CTR driver can deal with a carry
> occurring in the 4x/5x parallel code path, by using a computed goto to
> jump into the carry sequence at the right place as to only apply the
> carry to a subset of the blocks being processed.
> 
> If the lower half of the counter wraps and ends up at exactly 0x0, a
> carry needs to be applied to the counter, but not to the counter values
> taken for the 4x/5x parallel sequence. In this case, the computed goto
> skips all register assignments, and branches straight to the jump
> instruction that gets us back to the fast path. This produces the
> correct result, but due to the fact that this branch target does not
> carry the correct BTI annotation, this fails when BTI is enabled.
> 
> Let's omit the computed goto entirely in this case, and jump straight
> back to the fast path after applying the carry to the main counter.
> 
> Fixes: 5318d3db465d ("crypto: arm64/aes-ctr - improve tail handling")
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  arch/arm64/crypto/aes-modes.S | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
