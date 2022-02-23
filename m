Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C414C09AA
	for <lists+linux-crypto@lfdr.de>; Wed, 23 Feb 2022 03:50:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233587AbiBWCue (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 22 Feb 2022 21:50:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiBWCud (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 22 Feb 2022 21:50:33 -0500
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F3C4D609
        for <linux-crypto@vger.kernel.org>; Tue, 22 Feb 2022 18:50:06 -0800 (PST)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1nMhj9-00067c-Mt; Wed, 23 Feb 2022 13:50:04 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Wed, 23 Feb 2022 14:50:03 +1200
Date:   Wed, 23 Feb 2022 14:50:03 +1200
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-crypto@vger.kernel.org, ebiggers@kernel.org
Subject: Re: [PATCH] crypto: crypto_xor - use helpers for unaligned accesses
Message-ID: <YhWg246ql3Xa0MRR@gondor.apana.org.au>
References: <20220215105717.184572-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215105717.184572-1-ardb@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Feb 15, 2022 at 11:57:17AM +0100, Ard Biesheuvel wrote:
> Dereferencing a misaligned pointer is undefined behavior in C, and may
> result in codegen on architectures such as ARM that trigger alignments
> traps and expensive fixups in software.
> 
> Instead, use the get_aligned()/put_aligned() accessors, which are cheap
> or even completely free when CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y.
> 
> In the converse case, the prior alignment checks ensure that the casts
> are safe, and so no unaligned accessors are necessary.
> 
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>  crypto/algapi.c         | 24 +++++++++++++++++++++---
>  include/crypto/algapi.h | 11 +++++++++--
>  2 files changed, 30 insertions(+), 5 deletions(-)

Ard, could you please take a look at the two kbuild reports and
see if there is an issue that needs to be resolved?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
