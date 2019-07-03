Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B80E15E69B
	for <lists+linux-crypto@lfdr.de>; Wed,  3 Jul 2019 16:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfGCO1p (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 3 Jul 2019 10:27:45 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:52138 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfGCO1o (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 3 Jul 2019 10:27:44 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1higEZ-0000dZ-Er; Wed, 03 Jul 2019 22:27:43 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1higEW-0000Uz-3u; Wed, 03 Jul 2019 22:27:40 +0800
Date:   Wed, 3 Jul 2019 22:27:40 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-crypto@vger.kernel.org, ebiggers@kernel.org,
        linux-arm-kernel@lists.infradead.org, steve.capper@arm.com
Subject: Re: [PATCH 0/2] crypto: arm64/aes-ce - implement 5-way interleave
 for some modes
Message-ID: <20190703142740.55cpcpkas4zhgxx5@gondor.apana.org.au>
References: <20190624173831.8375-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190624173831.8375-1-ard.biesheuvel@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jun 24, 2019 at 07:38:29PM +0200, Ard Biesheuvel wrote:
> As it turns out, even a 4-way interleave is not sufficient to saturate
> the ThunderX2 pipeline with AES instructions, so this series implements
> 5-way interleave for modes that can be modified without running out of
> registers to maintain chaining mode state across the encryption operation,
> i.e., ECB, CBC-decryption and CTR.
> 
> Ard Biesheuvel (2):
>   crypto: arm64/aes-ce - add 5 way interleave routines
>   crypto: arm64/aes-ce - implement 5 way interleave for ECB, CBC and CTR
> 
>  arch/arm64/crypto/aes-ce.S    |  60 ++++++----
>  arch/arm64/crypto/aes-modes.S | 118 +++++++++++++++-----
>  arch/arm64/crypto/aes-neon.S  |  48 +-------
>  3 files changed, 127 insertions(+), 99 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
