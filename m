Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18212CAF3A
	for <lists+linux-crypto@lfdr.de>; Tue,  1 Dec 2020 22:58:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729712AbgLAV6H (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 1 Dec 2020 16:58:07 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:51234 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726883AbgLAV6H (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 1 Dec 2020 16:58:07 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kkDeE-0001QL-52; Wed, 02 Dec 2020 08:57:23 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 02 Dec 2020 08:57:22 +1100
Date:   Wed, 2 Dec 2020 08:57:22 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org, greearb@candelatech.com,
        Steve deRosier <derosier@cal-sierra.com>
Subject: Re: [PATCH v2] crypto: aesni - add ccm(aes) algorithm implementation
Message-ID: <20201201215722.GA31941@gondor.apana.org.au>
References: <20201201194556.5220-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201201194556.5220-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Dec 01, 2020 at 08:45:56PM +0100, Ard Biesheuvel wrote:
> Add ccm(aes) implementation from linux-wireless mailing list (see
> http://permalink.gmane.org/gmane.linux.kernel.wireless.general/126679).
> 
> This eliminates FPU context store/restore overhead existing in more
> general ccm_base(ctr(aes-aesni),aes-aesni) case in MAC calculation.
> 
> Suggested-by: Ben Greear <greearb@candelatech.com>
> Co-developed-by: Steve deRosier <derosier@cal-sierra.com>
> Signed-off-by: Steve deRosier <derosier@cal-sierra.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> v2: avoid the SIMD helper, as it produces an CRYPTO_ALG_ASYNC aead, which
>     is not usable by the 802.11 ccmp driver

Sorry, but this is not the way to go.  Please fix wireless to
use the async interface instead.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
