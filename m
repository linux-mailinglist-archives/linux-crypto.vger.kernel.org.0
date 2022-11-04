Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8D4619396
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Nov 2022 10:32:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiKDJcn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Nov 2022 05:32:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231511AbiKDJcj (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Nov 2022 05:32:39 -0400
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51942A704
        for <linux-crypto@vger.kernel.org>; Fri,  4 Nov 2022 02:32:35 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1oqt34-00A22B-QK; Fri, 04 Nov 2022 17:32:16 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Nov 2022 17:32:15 +0800
Date:   Fri, 4 Nov 2022 17:32:15 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Taehee Yoo <ap420073@gmail.com>
Cc:     linux-crypto@vger.kernel.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, x86@kernel.org,
        jussi.kivilinna@iki.fi
Subject: Re: [PATCH 2/2] crypto: aria: implement aria-avx512
Message-ID: <Y2TcH5CeGZxIpcnO@gondor.apana.org.au>
References: <20221026052057.12688-1-ap420073@gmail.com>
 <20221026052057.12688-3-ap420073@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026052057.12688-3-ap420073@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Oct 26, 2022 at 05:20:57AM +0000, Taehee Yoo wrote:
>
> +		while (nbytes >= ARIA_GFNI_AVX512_PARALLEL_BLOCK_SIZE) {
> +			u8 keystream[ARIA_GFNI_AVX512_PARALLEL_BLOCK_SIZE];

This is too big for the stack.  Perhaps put it into the reqctx.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
