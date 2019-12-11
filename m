Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A48A11A77D
	for <lists+linux-crypto@lfdr.de>; Wed, 11 Dec 2019 10:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbfLKJjE (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 11 Dec 2019 04:39:04 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54420 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727318AbfLKJjE (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 11 Dec 2019 04:39:04 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1ieySU-000098-Sc; Wed, 11 Dec 2019 17:39:02 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1ieySU-0005lW-63; Wed, 11 Dec 2019 17:39:02 +0800
Date:   Wed, 11 Dec 2019 17:39:02 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org, Gary R Hook <gary.hook@amd.com>
Subject: Re: [PATCH] crypto: ccp: set max RSA modulus size for v3 platform
 devices as well
Message-ID: <20191211093902.r7udrunanpqvuout@gondor.apana.org.au>
References: <20191127120136.105325-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191127120136.105325-1-ardb@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Nov 27, 2019 at 01:01:36PM +0100, Ard Biesheuvel wrote:
> AMD Seattle incorporates a non-PCI version of the v3 CCP crypto
> accelerator, and this version was left behind when the maximum
> RSA modulus size was parameterized in order to support v5 hardware
> which supports larger moduli than v3 hardware does. Due to this
> oversight, RSA acceleration no longer works at all on these systems.
> 
> Fix this by setting the .rsamax property to the appropriate value
> for v3 platform hardware.
> 
> Fixes: e28c190db66830c0 ("csrypto: ccp - Expand RSA support for a v5 ccp")
> Cc: Gary R Hook <gary.hook@amd.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  drivers/crypto/ccp/ccp-dev-v3.c | 1 +
>  1 file changed, 1 insertion(+)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
