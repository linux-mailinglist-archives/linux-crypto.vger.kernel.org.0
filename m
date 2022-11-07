Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56A7C61ED5E
	for <lists+linux-crypto@lfdr.de>; Mon,  7 Nov 2022 09:48:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230209AbiKGIsY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 7 Nov 2022 03:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiKGIsX (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 7 Nov 2022 03:48:23 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4762D5
        for <linux-crypto@vger.kernel.org>; Mon,  7 Nov 2022 00:48:22 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1orxn8-00AyQ8-9R; Mon, 07 Nov 2022 16:48:15 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Mon, 07 Nov 2022 16:48:14 +0800
Date:   Mon, 7 Nov 2022 16:48:14 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Taehee Yoo <ap420073@gmail.com>
Cc:     linux-crypto@vger.kernel.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, richard@nod.at,
        viro@zeniv.linux.org.uk,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@kernel.org,
        elliott@hpe.com, x86@kernel.org, jussi.kivilinna@iki.fi
Subject: Re: [PATCH v3 1/4] crypto: aria: add keystream array into struct
 aria_ctx
Message-ID: <Y2jGTvgHnu4QZV+D@gondor.apana.org.au>
References: <20221106143627.30920-1-ap420073@gmail.com>
 <20221106143627.30920-2-ap420073@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221106143627.30920-2-ap420073@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Sun, Nov 06, 2022 at 02:36:24PM +0000, Taehee Yoo wrote:
>
>  struct aria_ctx {
>  	u32 enc_key[ARIA_MAX_RD_KEYS][ARIA_RD_KEY_WORDS];
>  	u32 dec_key[ARIA_MAX_RD_KEYS][ARIA_RD_KEY_WORDS];
>  	int rounds;
>  	int key_length;
> +#if defined(CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64) ||	\
> +	defined(CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64_MODULE)
> +	u8 keystream[ARIA_KEYSTREAM_SIZE];
> +#endif
>  };

The tfm ctx is shared between all users of the tfm.  You need
something that is private to the request so this needs to be
moved into the reqctx.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
