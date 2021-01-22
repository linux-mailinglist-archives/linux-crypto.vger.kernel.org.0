Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3742FFC7F
	for <lists+linux-crypto@lfdr.de>; Fri, 22 Jan 2021 07:22:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbhAVGWV (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 22 Jan 2021 01:22:21 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:54150 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbhAVGWU (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 22 Jan 2021 01:22:20 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l2pp5-00022K-T9; Fri, 22 Jan 2021 17:21:33 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 22 Jan 2021 17:21:31 +1100
Date:   Fri, 22 Jan 2021 17:21:31 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org, Megha Dey <megha.dey@intel.com>,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH 0/2] crypto: aesni - fix more FPU handling and indirect
 call issues
Message-ID: <20210122062131.GF1217@gondor.apana.org.au>
References: <20210116164810.21192-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210116164810.21192-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sat, Jan 16, 2021 at 05:48:08PM +0100, Ard Biesheuvel wrote:
> My recent patches to the AES-NI driver addressed all the instances of
> indirect calls occurring in the XTS and GCM drivers, and while at it,
> limited the scope of FPU enabled/preemption disabled regions not to
> cover the work that goes on inside the skcipher walk API. This gets rid
> of scheduling latency spikes for large skcipher/aead inputs, which are
> more common these days after the introduction of s/w kTLS.
> 
> Let's address the other modes in this driver as well: ECB, CBC and CTR,
> all of which currently keep the FPU enabled (and thus preemption disabled)
> for the entire skcipher request, which is unnecessary, and potentially
> problematic for workloads that are sensitive to scheduling latency.
> 
> Let's also switch to a static call for the CTR mode asm helper, which
> gets chosen once at driver init time.
> 
> Cc: Megha Dey <megha.dey@intel.com>
> Cc: Eric Biggers <ebiggers@google.com>
> Cc: Herbert Xu <herbert@gondor.apana.org.au>
> 
> Ard Biesheuvel (2):
>   crypto: aesni - replace CTR function pointer with static call
>   crypto: aesni - release FPU during skcipher walk API calls
> 
>  arch/x86/crypto/aesni-intel_glue.c | 78 +++++++++-----------
>  1 file changed, 35 insertions(+), 43 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
