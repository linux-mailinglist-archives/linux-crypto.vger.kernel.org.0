Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5792E88BE
	for <lists+linux-crypto@lfdr.de>; Sat,  2 Jan 2021 23:01:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbhABWBb (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 2 Jan 2021 17:01:31 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:37262 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726678AbhABWBa (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 2 Jan 2021 17:01:30 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kvowz-0000UE-Qg; Sun, 03 Jan 2021 09:00:42 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sun, 03 Jan 2021 09:00:41 +1100
Date:   Sun, 3 Jan 2021 09:00:41 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org, ebiggers@kernel.org,
        dhowells@redhat.com
Subject: Re: [PATCH v2] crypto: aes-ni - implement support for cts(cbc(aes))
Message-ID: <20210102220041.GC12767@gondor.apana.org.au>
References: <20201207233402.17472-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207233402.17472-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Dec 08, 2020 at 12:34:02AM +0100, Ard Biesheuvel wrote:
> Follow the same approach as the arm64 driver for implementing a version
> of AES-NI in CBC mode that supports ciphertext stealing. This results in
> a ~2x speed increase for relatively short inputs (less than 256 bytes),
> which is relevant given that AES-CBC with ciphertext stealing is used
> for filename encryption in the fscrypt layer. For larger inputs, the
> speedup is still significant (~25% on decryption, ~6% on encryption)
> 
> Tested-by: Eric Biggers <ebiggers@google.com> # x86_64
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
> v2: add 32-bit support:
>     . load IV earlier so we can reuse the IVP register to replace T2 which is
>       not defined on i386
>     . add i386 boilerplate for preserving/restoring callee-saved registers
>     . use absolute reference to .Lcts_permute_table on i386
> 
>  arch/x86/crypto/aesni-intel_asm.S  | 129 ++++++++++++++++++-
>  arch/x86/crypto/aesni-intel_glue.c | 133 ++++++++++++++++++++
>  2 files changed, 261 insertions(+), 1 deletion(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
