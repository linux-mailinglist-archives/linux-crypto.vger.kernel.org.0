Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1D66CBF24
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Oct 2019 17:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389539AbfJDP23 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Oct 2019 11:28:29 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42364 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389318AbfJDP23 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Oct 2019 11:28:29 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.89 #2 (Debian))
        id 1iGPVK-0000q3-EO; Sat, 05 Oct 2019 01:28:27 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sat, 05 Oct 2019 01:28:23 +1000
Date:   Sat, 5 Oct 2019 01:28:23 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ebiggers@google.com, marc.zyngier@arm.com
Subject: Re: [PATCH 0/2] crypto: faster GCM-AES for arm64
Message-ID: <20191004152823.GD5148@gondor.apana.org.au>
References: <20190910231900.25445-1-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190910231900.25445-1-ard.biesheuvel@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Sep 11, 2019 at 12:18:58AM +0100, Ard Biesheuvel wrote:
> This series reimplements gcm(aes) for arm64 systems that support the
> AES and 64x64->128 PMULL/PMULL2 instructions. Patch #1 adds a test
> case and patch #2 updates the driver.
> 
> Ard Biesheuvel (2):
>   crypto: testmgr - add another gcm(aes) testcase
>   crypto: arm64/gcm-ce - implement 4 way interleave
> 
>  arch/arm64/crypto/ghash-ce-core.S | 501 ++++++++++++++------
>  arch/arm64/crypto/ghash-ce-glue.c | 293 +++++-------
>  crypto/testmgr.h                  | 192 ++++++++
>  3 files changed, 659 insertions(+), 327 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
