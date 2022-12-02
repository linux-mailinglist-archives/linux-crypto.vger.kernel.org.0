Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D42C640443
	for <lists+linux-crypto@lfdr.de>; Fri,  2 Dec 2022 11:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiLBKMY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 2 Dec 2022 05:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233436AbiLBKME (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 2 Dec 2022 05:12:04 -0500
Received: from formenos.hmeau.com (helcar.hmeau.com [216.24.177.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B195CCFE7
        for <linux-crypto@vger.kernel.org>; Fri,  2 Dec 2022 02:12:04 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1p131Q-003C81-Bo; Fri, 02 Dec 2022 18:11:57 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 02 Dec 2022 18:11:56 +0800
Date:   Fri, 2 Dec 2022 18:11:56 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Taehee Yoo <ap420073@gmail.com>
Cc:     linux-crypto@vger.kernel.org, davem@davemloft.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        kirill.shutemov@linux.intel.com, richard@nod.at,
        viro@zeniv.linux.org.uk,
        sathyanarayanan.kuppuswamy@linux.intel.com, jpoimboe@kernel.org,
        elliott@hpe.com, x86@kernel.org, jussi.kivilinna@iki.fi,
        ebiggers@kernel.org
Subject: Re: [PATCH v6 2/4] crypto: aria: do not use magic number offsets of
 aria_ctx
Message-ID: <Y4nPbMHNQl++bItU@gondor.apana.org.au>
References: <20221121003955.2214462-1-ap420073@gmail.com>
 <20221121003955.2214462-3-ap420073@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121003955.2214462-3-ap420073@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Nov 21, 2022 at 12:39:53AM +0000, Taehee Yoo wrote:
>
> +#if defined(CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64) ||  \
> +	defined(CONFIG_CRYPTO_ARIA_AESNI_AVX_X86_64_MODULE)

Why isn't this IS_ENABLED like the hunk below?

> +
> +	/* Offset for fields in aria_ctx */
> +	BLANK();
> +	OFFSET(ARIA_CTX_enc_key, aria_ctx, enc_key);
> +	OFFSET(ARIA_CTX_dec_key, aria_ctx, dec_key);
> +	OFFSET(ARIA_CTX_rounds, aria_ctx, rounds);
> +#endif
> +
>  	if (IS_ENABLED(CONFIG_KVM_INTEL)) {
>  		BLANK();
>  		OFFSET(VMX_spec_ctrl, vcpu_vmx, spec_ctrl);

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
