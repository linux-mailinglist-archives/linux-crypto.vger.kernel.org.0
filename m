Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18589532003
	for <lists+linux-crypto@lfdr.de>; Tue, 24 May 2022 02:56:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbiEXA4V (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 23 May 2022 20:56:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbiEXA4U (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 23 May 2022 20:56:20 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646D6E7B;
        Mon, 23 May 2022 17:56:16 -0700 (PDT)
Received: from kwepemi100015.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L6bMB163Yz1JCDp;
        Tue, 24 May 2022 08:54:46 +0800 (CST)
Received: from kwepemm600018.china.huawei.com (7.193.23.140) by
 kwepemi100015.china.huawei.com (7.221.188.125) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 08:56:14 +0800
Received: from [10.174.176.88] (10.174.176.88) by
 kwepemm600018.china.huawei.com (7.193.23.140) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 08:56:13 +0800
Message-ID: <db28d6cf-fa87-8647-29cb-0122e26fa8aa@huawei.com>
Date:   Tue, 24 May 2022 08:56:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH -next] crypto: Fix build error when CRYPTO_BLAKE2S_X86=m
 && CRYPTO_ALGAPI2=m && CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
From:   "gaochao (L)" <gaochao49@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>
CC:     <hpa@zytor.com>, <ebiggers@google.com>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <zhengbin13@huawei.com>
References: <20220517033630.1182-1-gaochao49@huawei.com>
In-Reply-To: <20220517033630.1182-1-gaochao49@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.88]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600018.china.huawei.com (7.193.23.140)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

friendly ping 

在 2022/5/17 11:36, gaochao 写道:
> If CRYPTO=m, CRYPTO_ALGAPI=m, CRYPTO_ALGAPI2=m, CRYPTO_BLAKE2S_X86=m,
> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
> bulding fails:
> 
> arch/x86/crypto/blake2s-glue.o: In function `blake2s_compress':
> (.text+0x5a): undefined reference to `crypto_simd_disabled_for_test'
> make: *** [vmlinux] Error 1
> 
> When CRYPTO_MANAGER_EXTRA_TESTS=y, blake2s_compress will call
> crypto_simd_disabled_for_test.
> When CRYPTO_ALGAPI2=m, crypto_algapi build as a module,
> but if CONFIG_CRYPTO_BLAKE2S_X86=m at the same time,
> libblake2s-x86_64.o build with obj-y, this will accuse the above error.
> 
> To fix this error:
> 1 Choose CRYPTO_ALGAPI2 for CRYPTO_BLAKE2S_X86
> when CRYPTO_MANAGER_EXTRA_TESTS=y.
> 2 build libblake2s-x86_64.o as a module when CONFIG_CRYPTO_BLAKE2S_X86=y
> 
> Fixes: 8fc5f2ad896b ("crypto: testmgr - Move crypto_simd_disabled_for_test out")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: gaochao <gaochao49@huawei.com>
> ---
>  arch/x86/crypto/Makefile | 2 +-
>  crypto/Kconfig           | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
> index 2831685adf6f..54b2469fa49a 100644
> --- a/arch/x86/crypto/Makefile
> +++ b/arch/x86/crypto/Makefile
> @@ -63,7 +63,7 @@ sha512-ssse3-y := sha512-ssse3-asm.o sha512-avx-asm.o sha512-avx2-asm.o sha512_s
> 
>  obj-$(CONFIG_CRYPTO_BLAKE2S_X86) += blake2s-x86_64.o
>  blake2s-x86_64-y := blake2s-shash.o
> -obj-$(if $(CONFIG_CRYPTO_BLAKE2S_X86),y) += libblake2s-x86_64.o
> +obj-$(CONFIG_CRYPTO_BLAKE2S_X86) += libblake2s-x86_64.o
>  libblake2s-x86_64-y := blake2s-core.o blake2s-glue.o
> 
>  obj-$(CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL) += ghash-clmulni-intel.o
> diff --git a/crypto/Kconfig b/crypto/Kconfig
> index 19197469cfab..e61598f8f8c5 100644
> --- a/crypto/Kconfig
> +++ b/crypto/Kconfig
> @@ -714,6 +714,7 @@ config CRYPTO_BLAKE2S_X86
>  	depends on X86 && 64BIT
>  	select CRYPTO_LIB_BLAKE2S_GENERIC
>  	select CRYPTO_ARCH_HAVE_LIB_BLAKE2S
> +	select CRYPTO_ALGAPI2 if CRYPTO_MANAGER_EXTRA_TESTS
> 
>  config CRYPTO_CRCT10DIF
>  	tristate "CRCT10DIF algorithm"
> --
> 2.17.1
> 
> .
