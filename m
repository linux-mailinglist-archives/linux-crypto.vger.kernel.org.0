Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5BD2CE885
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Dec 2020 08:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbgLDHQW (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Dec 2020 02:16:22 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:60978 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728473AbgLDHQW (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Dec 2020 02:16:22 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kl5JR-0006dG-Dz; Fri, 04 Dec 2020 18:15:30 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Dec 2020 18:15:29 +1100
Date:   Fri, 4 Dec 2020 18:15:29 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        james.morse@arm.com, ebiggers@kernel.org
Subject: Re: [PATCH v2] crypto: arm/aes-ce - work around Cortex-A57/A72
 silion errata
Message-ID: <20201204071529.GB31775@gondor.apana.org.au>
References: <20201126074907.18965-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201126074907.18965-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Nov 26, 2020 at 08:49:07AM +0100, Ard Biesheuvel wrote:
> ARM Cortex-A57 and Cortex-A72 cores running in 32-bit mode are affected
> by silicon errata #1742098 and #1655431, respectively, where the second
> instruction of a AES instruction pair may execute twice if an interrupt
> is taken right after the first instruction consumes an input register of
> which a single 32-bit lane has been updated the last time it was modified.
> 
> This is not such a rare occurrence as it may seem: in counter mode, only
> the least significant 32-bit word is incremented in the absence of a
> carry, which makes our counter mode implementation susceptible to these
> errata.
> 
> So let's shuffle the counter assignments around a bit so that the most
> recent updates when the AES instruction pair executes are 128-bit wide.
> 
> [0] ARM-EPM-049219 v23 Cortex-A57 MPCore Software Developers Errata Notice
> [1] ARM-EPM-012079 v11.0 Cortex-A72 MPCore Software Developers Errata Notice
> 
> Cc: <stable@vger.kernel.org> # v5.4+
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> v2: - add comment block describing the erratum and how it is being worked
>       around
>     - mention A57 as well as A72, as both are affected
> 
>  arch/arm/crypto/aes-ce-core.S | 32 ++++++++++++++------
>  1 file changed, 22 insertions(+), 10 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
