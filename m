Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EC6C5060CB
	for <lists+linux-crypto@lfdr.de>; Tue, 19 Apr 2022 02:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbiDSAQ7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 18 Apr 2022 20:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239970AbiDSAQq (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 18 Apr 2022 20:16:46 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391AD635E
        for <linux-crypto@vger.kernel.org>; Mon, 18 Apr 2022 17:13:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B017761319
        for <linux-crypto@vger.kernel.org>; Tue, 19 Apr 2022 00:13:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1135C385A8;
        Tue, 19 Apr 2022 00:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650327236;
        bh=ZRTxrfE8PkJLHcYz2PYZrGMLP4HRmWMZazUtQo5mkKM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ub+g3h8KZ0zX3gAHd8ai6lMMJH/F0FDv5o9qIfmKKYU69CNdK5b9fACqc4QonU8HM
         gG83idVoUmRcBrxwckmIWK62D/gqnCKBNAsQaHrLvyt0T8b4yVSMp5bmYxcw8hgwML
         i79QLMdkoeR6uCbt2kuBHlueIBxNAUHgfVdq0b8RRvNI2VgXxm08l8SmFX3glKuaAH
         clo2Qv//oa+2r1QX9qrpqvUeaAsOvaCq9NDZ8oYccHG2SA2pSanEOzY3uTZPkQP92e
         i/HhEV5PzygiMsjUfw3uCVXff0beJdVtjtnfXeWoszUVYoNLj9zCaajeXE7KFnrUT2
         ++9nTH9Y3cTGA==
Date:   Mon, 18 Apr 2022 17:13:54 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Nathan Huckleberry <nhuck@google.com>
Cc:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        linux-arm-kernel@lists.infradead.org,
        Paul Crowley <paulcrowley@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v4 4/8] crypto: x86/aesni-xctr: Add accelerated
 implementation of XCTR
Message-ID: <Yl3+wqeOw2/jRgOC@sol.localdomain>
References: <20220412172816.917723-1-nhuck@google.com>
 <20220412172816.917723-5-nhuck@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220412172816.917723-5-nhuck@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Apr 12, 2022 at 05:28:12PM +0000, Nathan Huckleberry wrote:
> diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
> index 363699dd7220..ce17fe630150 100644
> --- a/arch/x86/crypto/aesni-intel_asm.S
> +++ b/arch/x86/crypto/aesni-intel_asm.S
> @@ -2821,6 +2821,76 @@ SYM_FUNC_END(aesni_ctr_enc)
>  
>  #endif
>  
> +#ifdef __x86_64__
> +/*
> + * void aesni_xctr_enc(struct crypto_aes_ctx *ctx, const u8 *dst, u8 *src,
> + *		      size_t len, u8 *iv, int byte_ctr)
> + */
> +SYM_FUNC_START(aesni_xctr_enc)
> +	FRAME_BEGIN
> +	cmp $16, LEN
> +	jb .Lxctr_ret
> +	shr	$4, %arg6
> +	movq %arg6, CTR
> +	mov 480(KEYP), KLEN
> +	movups (IVP), IV
> +	cmp $64, LEN
> +	jb .Lxctr_enc_loop1
> +.align 4
> +.Lxctr_enc_loop4:
> +	movaps IV, STATE1
> +	vpaddq ONE(%rip), CTR, CTR
> +	vpxor CTR, STATE1, STATE1
> +	movups (INP), IN1
> +	movaps IV, STATE2
> +	vpaddq ONE(%rip), CTR, CTR
> +	vpxor CTR, STATE2, STATE2
> +	movups 0x10(INP), IN2
> +	movaps IV, STATE3
> +	vpaddq ONE(%rip), CTR, CTR
> +	vpxor CTR, STATE3, STATE3
> +	movups 0x20(INP), IN3
> +	movaps IV, STATE4
> +	vpaddq ONE(%rip), CTR, CTR
> +	vpxor CTR, STATE4, STATE4
> +	movups 0x30(INP), IN4
> +	call _aesni_enc4
> +	pxor IN1, STATE1
> +	movups STATE1, (OUTP)
> +	pxor IN2, STATE2
> +	movups STATE2, 0x10(OUTP)
> +	pxor IN3, STATE3
> +	movups STATE3, 0x20(OUTP)
> +	pxor IN4, STATE4
> +	movups STATE4, 0x30(OUTP)
> +	sub $64, LEN
> +	add $64, INP
> +	add $64, OUTP
> +	cmp $64, LEN
> +	jge .Lxctr_enc_loop4
> +	cmp $16, LEN
> +	jb .Lxctr_ret
> +.align 4
> +.Lxctr_enc_loop1:
> +	movaps IV, STATE
> +	vpaddq ONE(%rip), CTR, CTR
> +	vpxor CTR, STATE1, STATE1
> +	movups (INP), IN
> +	call _aesni_enc1
> +	pxor IN, STATE
> +	movups STATE, (OUTP)
> +	sub $16, LEN
> +	add $16, INP
> +	add $16, OUTP
> +	cmp $16, LEN
> +	jge .Lxctr_enc_loop1
> +.Lxctr_ret:
> +	FRAME_END
> +	RET
> +SYM_FUNC_END(aesni_xctr_enc)
> +
> +#endif

Sorry, I missed this file.  This is the non-AVX version, right?  That means that
AVX instructions, i.e. basically anything instruction starting with "v", can't
be used here.  So the above isn't going to work.  (There might be a way to test
this with QEMU; maybe --cpu-type=Nehalem without --enable-kvm?)

You could rewrite this without using AVX instructions.  However, polyval-clmulni
is broken in the same way; it uses AVX instructions without checking whether
they are available.  But your patchset doesn't aim to provide a non-AVX polyval
implementation at all.  So even if you got the non-AVX XCTR working, it wouldn't
be paired with an accelerated polyval.

So I think you should just not provide non-AVX versions for now.  That would
mean:

	1.) Drop the change to aesni-intel_asm.S
	2.) Don't register the AES XCTR algorithm unless AVX is available
	    (in addition to AES-NI)
	3.) Don't register polyval-clmulni unless AVX is available
	    (in addition to CLMUL-NI)

- Eric
