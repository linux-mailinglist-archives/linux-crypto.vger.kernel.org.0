Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 205EF23ACCA
	for <lists+linux-crypto@lfdr.de>; Mon,  3 Aug 2020 21:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgHCTLX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 3 Aug 2020 15:11:23 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:38418 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgHCTLX (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 3 Aug 2020 15:11:23 -0400
Received: from [192.168.254.5] (unknown [50.34.202.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id B9A0213C2B0;
        Mon,  3 Aug 2020 12:11:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com B9A0213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1596481882;
        bh=NXIBdheEeMpeFv8pJxFxGlKustZNMxlCveXLAgAAT94=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=f0Q1W0KqXklJP0qVwDZYws2UiVw6ClMDfapVYqvo4tGn/waRuECtUGnvdrBOjCj3G
         Mvbofa1BMBrL2pPhBgHFK50yzHnHsMneAvT/JBWOdHNQ1FCPKucl/0nRVVVbw+oHHP
         r9ywPOilSPV7cUZirpvHnRIYnoRtcI0ddNogwYFs=
Subject: Re: [PATCH] crypto: x86/aesni - implement accelerated CBCMAC, CMAC
 and XCBC shashes
To:     Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org
Cc:     herbert@gondor.apana.org.au, ebiggers@kernel.org
References: <20200802090616.1328-1-ardb@kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <25776a56-4c6a-3976-f4bc-fa53ba4a1550@candelatech.com>
Date:   Mon, 3 Aug 2020 12:11:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200802090616.1328-1-ardb@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hello,

This helps a bit...now download sw-crypt performance is about 150Mbps,
but still not as good as with my patch on 5.4 kernel, and fpu is still
high in perf top:

    13.89%  libc-2.29.so   [.] __memset_sse2_unaligned_erms
      6.62%  [kernel]       [k] kernel_fpu_begin
      4.14%  [kernel]       [k] _aesni_enc1
      2.06%  [kernel]       [k] __crypto_xor
      1.95%  [kernel]       [k] copy_user_generic_string
      1.93%  libjvm.so      [.] SpinPause
      1.01%  [kernel]       [k] aesni_encrypt
      0.98%  [kernel]       [k] crypto_ctr_crypt
      0.93%  [kernel]       [k] udp_sendmsg
      0.78%  [kernel]       [k] crypto_inc
      0.74%  [kernel]       [k] __ip_append_data.isra.53
      0.65%  [kernel]       [k] aesni_cbc_enc
      0.64%  [kernel]       [k] __dev_queue_xmit
      0.62%  [kernel]       [k] ipt_do_table
      0.62%  [kernel]       [k] igb_xmit_frame_ring
      0.59%  [kernel]       [k] ip_route_output_key_hash_rcu
      0.57%  [kernel]       [k] memcpy
      0.57%  libjvm.so      [.] InstanceKlass::oop_follow_contents
      0.56%  [kernel]       [k] irq_fpu_usable
      0.56%  [kernel]       [k] mac_do_update

If you'd like help setting up a test rig and have an ath10k pcie NIC or ath9k pcie NIC,
then I can help.  Possibly hwsim would also be a good test case, but I have not tried
that.

Not sure it is related or not, but system was throwing this during
the test.  We'll try to verify whether or not it is related to that
patch.

...
Message from syslogd@lf0350-35c0 at Aug  3 09:55:05 ...
  kernel:[Hardware Error]: CPU:0 (16:30:1) MC2_STATUS[Over|CE|-|AddrV|-|CECC|-|-]: 0xd45840900012017a

Message from syslogd@lf0350-35c0 at Aug  3 09:55:05 ...
  kernel:[Hardware Error]: Error Addr: 0x00000000a656a810

Message from syslogd@lf0350-35c0 at Aug  3 09:55:05 ...
  kernel:[Hardware Error]: MC2 Error: ECC error in L2 data array (Vict).

Message from syslogd@lf0350-35c0 at Aug  3 09:55:05 ...
  kernel:[Hardware Error]: cache level: L2, tx: GEN, mem-tx: EV

Message from syslogd@lf0350-35c0 at Aug  3 10:00:33 ...
  kernel:[Hardware Error]: Corrected error, no action required.

Message from syslogd@lf0350-35c0 at Aug  3 10:00:33 ...
  kernel:[Hardware Error]: CPU:0 (16:30:1) MC2_STATUS[Over|CE|-|AddrV|-|CECC|-|-]: 0xd55840920010011a


Thanks,
Ben


On 8/2/20 2:06 AM, Ard Biesheuvel wrote:
> Ben reports that CCM using AES-NI instructions performs pathologically
> poorly, which is due to the overhead of preserving/restoring the SIMD
> state, which is repeated after every 16 bytes of input when executing
> the CBCMAC portion of the algorithm.
> 
> So let's clone the arm64 implementation of cbcmac(aes), which takes
> care to only preserve/restore the SIMD state after processing the
> whole input. Since cmac(aes) and xcbc(aes) can reuse most of the code,
> let's expose those as well.
> 
> Cc: Ben Greear <greearb@candelatech.com>
> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> ---
>   arch/x86/crypto/Makefile           |   2 +-
>   arch/x86/crypto/aesni-intel.h      |  39 +++
>   arch/x86/crypto/aesni-intel_glue.c |  42 +---
>   arch/x86/crypto/aesni-intel_mac.c  | 257 ++++++++++++++++++++
>   4 files changed, 306 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/x86/crypto/Makefile b/arch/x86/crypto/Makefile
> index a31de0c6ccde..f83e162f87ad 100644
> --- a/arch/x86/crypto/Makefile
> +++ b/arch/x86/crypto/Makefile
> @@ -51,7 +51,7 @@ chacha-x86_64-y := chacha-avx2-x86_64.o chacha-ssse3-x86_64.o chacha_glue.o
>   chacha-x86_64-$(CONFIG_AS_AVX512) += chacha-avx512vl-x86_64.o
>   
>   obj-$(CONFIG_CRYPTO_AES_NI_INTEL) += aesni-intel.o
> -aesni-intel-y := aesni-intel_asm.o aesni-intel_glue.o
> +aesni-intel-y := aesni-intel_asm.o aesni-intel_glue.o aesni-intel_mac.o
>   aesni-intel-$(CONFIG_64BIT) += aesni-intel_avx-x86_64.o aes_ctrby8_avx-x86_64.o
>   
>   obj-$(CONFIG_CRYPTO_SHA1_SSSE3) += sha1-ssse3.o
> diff --git a/arch/x86/crypto/aesni-intel.h b/arch/x86/crypto/aesni-intel.h
> new file mode 100644
> index 000000000000..d9204c043184
> --- /dev/null
> +++ b/arch/x86/crypto/aesni-intel.h
> @@ -0,0 +1,39 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +
> +#include <crypto/algapi.h>
> +#include <crypto/aes.h>
> +#include <crypto/internal/hash.h>
> +
> +#define AESNI_ALIGN	16
> +#define AESNI_ALIGN_ATTR __attribute__ ((__aligned__(AESNI_ALIGN)))
> +#define AES_BLOCK_MASK	(~(AES_BLOCK_SIZE - 1))
> +#define RFC4106_HASH_SUBKEY_SIZE 16
> +#define AESNI_ALIGN_EXTRA ((AESNI_ALIGN - 1) & ~(CRYPTO_MINALIGN - 1))
> +#define CRYPTO_AES_CTX_SIZE (sizeof(struct crypto_aes_ctx) + AESNI_ALIGN_EXTRA)
> +#define XTS_AES_CTX_SIZE (sizeof(struct aesni_xts_ctx) + AESNI_ALIGN_EXTRA)
> +
> +extern struct shash_alg aesni_mac_algs[];
> +extern const int aesni_num_mac_algs;
> +
> +asmlinkage int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
> +			     unsigned int key_len);
> +asmlinkage void aesni_enc(const void *ctx, u8 *out, const u8 *in);
> +asmlinkage void aesni_dec(const void *ctx, u8 *out, const u8 *in);
> +asmlinkage void aesni_ecb_enc(struct crypto_aes_ctx *ctx, u8 *out,
> +			      const u8 *in, unsigned int len);
> +asmlinkage void aesni_ecb_dec(struct crypto_aes_ctx *ctx, u8 *out,
> +			      const u8 *in, unsigned int len);
> +asmlinkage void aesni_cbc_enc(struct crypto_aes_ctx *ctx, u8 *out,
> +			      const u8 *in, unsigned int len, u8 *iv);
> +asmlinkage void aesni_cbc_dec(struct crypto_aes_ctx *ctx, u8 *out,
> +			      const u8 *in, unsigned int len, u8 *iv);
> +
> +static inline struct crypto_aes_ctx *aes_ctx(void *raw_ctx)
> +{
> +	unsigned long addr = (unsigned long)raw_ctx;
> +	unsigned long align = AESNI_ALIGN;
> +
> +	if (align <= crypto_tfm_ctx_alignment())
> +		align = 1;
> +	return (struct crypto_aes_ctx *)ALIGN(addr, align);
> +}
> diff --git a/arch/x86/crypto/aesni-intel_glue.c b/arch/x86/crypto/aesni-intel_glue.c
> index ad8a7188a2bf..bc51c5f80858 100644
> --- a/arch/x86/crypto/aesni-intel_glue.c
> +++ b/arch/x86/crypto/aesni-intel_glue.c
> @@ -19,8 +19,6 @@
>   #include <linux/types.h>
>   #include <linux/module.h>
>   #include <linux/err.h>
> -#include <crypto/algapi.h>
> -#include <crypto/aes.h>
>   #include <crypto/ctr.h>
>   #include <crypto/b128ops.h>
>   #include <crypto/gcm.h>
> @@ -37,14 +35,7 @@
>   #include <asm/crypto/glue_helper.h>
>   #endif
>   
> -
> -#define AESNI_ALIGN	16
> -#define AESNI_ALIGN_ATTR __attribute__ ((__aligned__(AESNI_ALIGN)))
> -#define AES_BLOCK_MASK	(~(AES_BLOCK_SIZE - 1))
> -#define RFC4106_HASH_SUBKEY_SIZE 16
> -#define AESNI_ALIGN_EXTRA ((AESNI_ALIGN - 1) & ~(CRYPTO_MINALIGN - 1))
> -#define CRYPTO_AES_CTX_SIZE (sizeof(struct crypto_aes_ctx) + AESNI_ALIGN_EXTRA)
> -#define XTS_AES_CTX_SIZE (sizeof(struct aesni_xts_ctx) + AESNI_ALIGN_EXTRA)
> +#include "aesni-intel.h"
>   
>   /* This data is stored at the end of the crypto_tfm struct.
>    * It's a type of per "session" data storage location.
> @@ -81,19 +72,6 @@ struct gcm_context_data {
>   	u8 hash_keys[GCM_BLOCK_LEN * 16];
>   };
>   
> -asmlinkage int aesni_set_key(struct crypto_aes_ctx *ctx, const u8 *in_key,
> -			     unsigned int key_len);
> -asmlinkage void aesni_enc(const void *ctx, u8 *out, const u8 *in);
> -asmlinkage void aesni_dec(const void *ctx, u8 *out, const u8 *in);
> -asmlinkage void aesni_ecb_enc(struct crypto_aes_ctx *ctx, u8 *out,
> -			      const u8 *in, unsigned int len);
> -asmlinkage void aesni_ecb_dec(struct crypto_aes_ctx *ctx, u8 *out,
> -			      const u8 *in, unsigned int len);
> -asmlinkage void aesni_cbc_enc(struct crypto_aes_ctx *ctx, u8 *out,
> -			      const u8 *in, unsigned int len, u8 *iv);
> -asmlinkage void aesni_cbc_dec(struct crypto_aes_ctx *ctx, u8 *out,
> -			      const u8 *in, unsigned int len, u8 *iv);
> -
>   #define AVX_GEN2_OPTSIZE 640
>   #define AVX_GEN4_OPTSIZE 4096
>   
> @@ -296,16 +274,6 @@ generic_gcmaes_ctx *generic_gcmaes_ctx_get(struct crypto_aead *tfm)
>   }
>   #endif
>   
> -static inline struct crypto_aes_ctx *aes_ctx(void *raw_ctx)
> -{
> -	unsigned long addr = (unsigned long)raw_ctx;
> -	unsigned long align = AESNI_ALIGN;
> -
> -	if (align <= crypto_tfm_ctx_alignment())
> -		align = 1;
> -	return (struct crypto_aes_ctx *)ALIGN(addr, align);
> -}
> -
>   static int aes_set_key_common(struct crypto_tfm *tfm, void *raw_ctx,
>   			      const u8 *in_key, unsigned int key_len)
>   {
> @@ -1098,8 +1066,15 @@ static int __init aesni_init(void)
>   	if (err)
>   		goto unregister_skciphers;
>   
> +	err = crypto_register_shashes(aesni_mac_algs, aesni_num_mac_algs);
> +	if (err)
> +		goto unregister_aeads;
> +
>   	return 0;
>   
> +unregister_aeads:
> +	simd_unregister_aeads(aesni_aeads, ARRAY_SIZE(aesni_aeads),
> +			      aesni_simd_aeads);
>   unregister_skciphers:
>   	simd_unregister_skciphers(aesni_skciphers, ARRAY_SIZE(aesni_skciphers),
>   				  aesni_simd_skciphers);
> @@ -1110,6 +1085,7 @@ static int __init aesni_init(void)
>   
>   static void __exit aesni_exit(void)
>   {
> +	crypto_unregister_shashes(aesni_mac_algs, aesni_num_mac_algs);
>   	simd_unregister_aeads(aesni_aeads, ARRAY_SIZE(aesni_aeads),
>   			      aesni_simd_aeads);
>   	simd_unregister_skciphers(aesni_skciphers, ARRAY_SIZE(aesni_skciphers),
> diff --git a/arch/x86/crypto/aesni-intel_mac.c b/arch/x86/crypto/aesni-intel_mac.c
> new file mode 100644
> index 000000000000..7d546bbf21e5
> --- /dev/null
> +++ b/arch/x86/crypto/aesni-intel_mac.c
> @@ -0,0 +1,257 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2013 - 2017 Linaro Ltd <ard.biesheuvel@linaro.org>
> + * Copyright (C) 2020 Arm Ltd <ard.biesheuvel@arm.com>
> + */
> +
> +#include <asm/simd.h>
> +#include <crypto/b128ops.h>
> +#include <crypto/internal/hash.h>
> +#include <crypto/internal/simd.h>
> +#include <linux/module.h>
> +
> +#include "aesni-intel.h"
> +
> +MODULE_ALIAS_CRYPTO("cmac(aes)");
> +MODULE_ALIAS_CRYPTO("xcbc(aes)");
> +MODULE_ALIAS_CRYPTO("cbcmac(aes)");
> +
> +struct mac_tfm_ctx {
> +	u8 key[CRYPTO_AES_CTX_SIZE];
> +	u8 __aligned(8) consts[];
> +};
> +
> +struct mac_desc_ctx {
> +	u8 dg[AES_BLOCK_SIZE];
> +	unsigned int len;
> +};
> +
> +asmlinkage void aesni_enc(const void *ctx, u8 *out, const u8 *in);
> +asmlinkage void aesni_ecb_enc(struct crypto_aes_ctx *ctx, u8 *out,
> +			      const u8 *in, unsigned int len);
> +asmlinkage void aesni_cbc_enc(struct crypto_aes_ctx *ctx, u8 *out,
> +			      const u8 *in, unsigned int len, u8 *iv);
> +
> +static int cbcmac_setkey(struct crypto_shash *tfm, const u8 *in_key,
> +			 unsigned int key_len)
> +{
> +	struct mac_tfm_ctx *ctx = crypto_shash_ctx(tfm);
> +
> +	return aes_expandkey(aes_ctx(&ctx->key), in_key, key_len);
> +}
> +
> +static void cmac_gf128_mul_by_x(be128 *y, const be128 *x)
> +{
> +	u64 a = be64_to_cpu(x->a);
> +	u64 b = be64_to_cpu(x->b);
> +
> +	y->a = cpu_to_be64((a << 1) | (b >> 63));
> +	y->b = cpu_to_be64((b << 1) ^ ((a >> 63) ? 0x87 : 0));
> +}
> +
> +static int cmac_setkey(struct crypto_shash *tfm, const u8 *in_key,
> +		       unsigned int key_len)
> +{
> +	struct mac_tfm_ctx *ctx = crypto_shash_ctx(tfm);
> +	be128 *consts = (be128 *)ctx->consts;
> +	int err;
> +
> +	err = cbcmac_setkey(tfm, in_key, key_len);
> +	if (err)
> +		return err;
> +
> +	/* encrypt the zero vector */
> +	kernel_fpu_begin();
> +	aesni_ecb_enc(aes_ctx(&ctx->key), ctx->consts, (u8[AES_BLOCK_SIZE]){},
> +		      AES_BLOCK_SIZE);
> +	kernel_fpu_end();
> +
> +	cmac_gf128_mul_by_x(consts, consts);
> +	cmac_gf128_mul_by_x(consts + 1, consts);
> +
> +	return 0;
> +}
> +
> +static int xcbc_setkey(struct crypto_shash *tfm, const u8 *in_key,
> +		       unsigned int key_len)
> +{
> +	static u8 const ks[3][AES_BLOCK_SIZE] = {
> +		{ [0 ... AES_BLOCK_SIZE - 1] = 0x1 },
> +		{ [0 ... AES_BLOCK_SIZE - 1] = 0x2 },
> +		{ [0 ... AES_BLOCK_SIZE - 1] = 0x3 },
> +	};
> +
> +	struct mac_tfm_ctx *ctx = crypto_shash_ctx(tfm);
> +	u8 key[AES_BLOCK_SIZE];
> +	int err;
> +
> +	err = cbcmac_setkey(tfm, in_key, key_len);
> +	if (err)
> +		return err;
> +
> +	kernel_fpu_begin();
> +	aesni_ecb_enc(aes_ctx(&ctx->key), key, ks[0], AES_BLOCK_SIZE);
> +	aesni_ecb_enc(aes_ctx(&ctx->key), ctx->consts, ks[1], 2 * AES_BLOCK_SIZE);
> +	kernel_fpu_end();
> +
> +	return cbcmac_setkey(tfm, key, sizeof(key));
> +}
> +
> +static int mac_init(struct shash_desc *desc)
> +{
> +	struct mac_desc_ctx *ctx = shash_desc_ctx(desc);
> +
> +	memset(ctx->dg, 0, AES_BLOCK_SIZE);
> +	ctx->len = 0;
> +
> +	return 0;
> +}
> +
> +static void mac_do_update(struct crypto_aes_ctx *ctx, u8 const in[], int blocks,
> +			  u8 dg[], int enc_before, int enc_after)
> +{
> +	if (likely(crypto_simd_usable())) {
> +		kernel_fpu_begin();
> +		if (enc_before)
> +			aesni_enc(ctx, dg, dg);
> +
> +		while (blocks--) {
> +			if (!blocks && !enc_after) {
> +				crypto_xor(dg, in, AES_BLOCK_SIZE);
> +				break;
> +			}
> +			aesni_cbc_enc(ctx, dg, in, AES_BLOCK_SIZE, dg);
> +			in += AES_BLOCK_SIZE;
> +		}
> +		kernel_fpu_end();
> +	} else {
> +		if (enc_before)
> +			aes_encrypt(ctx, dg, dg);
> +
> +		while (blocks--) {
> +			crypto_xor(dg, in, AES_BLOCK_SIZE);
> +			in += AES_BLOCK_SIZE;
> +
> +			if (blocks || enc_after)
> +				aes_encrypt(ctx, dg, dg);
> +		}
> +	}
> +}
> +
> +static int mac_update(struct shash_desc *desc, const u8 *p, unsigned int len)
> +{
> +	struct mac_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
> +	struct mac_desc_ctx *ctx = shash_desc_ctx(desc);
> +
> +	while (len > 0) {
> +		unsigned int l;
> +
> +		if ((ctx->len % AES_BLOCK_SIZE) == 0 &&
> +		    (ctx->len + len) > AES_BLOCK_SIZE) {
> +
> +			int blocks = len / AES_BLOCK_SIZE;
> +
> +			len %= AES_BLOCK_SIZE;
> +
> +			mac_do_update(aes_ctx(&tctx->key), p, blocks, ctx->dg,
> +				      (ctx->len != 0), (len != 0));
> +
> +			p += blocks * AES_BLOCK_SIZE;
> +
> +			if (!len) {
> +				ctx->len = AES_BLOCK_SIZE;
> +				break;
> +			}
> +			ctx->len = 0;
> +		}
> +
> +		l = min(len, AES_BLOCK_SIZE - ctx->len);
> +
> +		if (l <= AES_BLOCK_SIZE) {
> +			crypto_xor(ctx->dg + ctx->len, p, l);
> +			ctx->len += l;
> +			len -= l;
> +			p += l;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static int cbcmac_final(struct shash_desc *desc, u8 *out)
> +{
> +	struct mac_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
> +	struct mac_desc_ctx *ctx = shash_desc_ctx(desc);
> +
> +	mac_do_update(aes_ctx(&tctx->key), NULL, 0, ctx->dg, (ctx->len != 0), 0);
> +
> +	memcpy(out, ctx->dg, AES_BLOCK_SIZE);
> +
> +	return 0;
> +}
> +
> +static int cmac_final(struct shash_desc *desc, u8 *out)
> +{
> +	struct mac_tfm_ctx *tctx = crypto_shash_ctx(desc->tfm);
> +	struct mac_desc_ctx *ctx = shash_desc_ctx(desc);
> +	u8 *consts = tctx->consts;
> +
> +	if (ctx->len != AES_BLOCK_SIZE) {
> +		ctx->dg[ctx->len] ^= 0x80;
> +		consts += AES_BLOCK_SIZE;
> +	}
> +
> +	mac_do_update(aes_ctx(&tctx->key), consts, 1, ctx->dg, 0, 1);
> +
> +	memcpy(out, ctx->dg, AES_BLOCK_SIZE);
> +
> +	return 0;
> +}
> +
> +struct shash_alg aesni_mac_algs[] = { {
> +	.base.cra_name		= "cmac(aes)",
> +	.base.cra_driver_name	= "cmac-aes-aesni",
> +	.base.cra_priority	= 400,
> +	.base.cra_blocksize	= AES_BLOCK_SIZE,
> +	.base.cra_ctxsize	= sizeof(struct mac_tfm_ctx) +
> +				  2 * AES_BLOCK_SIZE,
> +	.base.cra_module	= THIS_MODULE,
> +
> +	.digestsize		= AES_BLOCK_SIZE,
> +	.init			= mac_init,
> +	.update			= mac_update,
> +	.final			= cmac_final,
> +	.setkey			= cmac_setkey,
> +	.descsize		= sizeof(struct mac_desc_ctx),
> +}, {
> +	.base.cra_name		= "xcbc(aes)",
> +	.base.cra_driver_name	= "xcbc-aes-aesni",
> +	.base.cra_priority	= 400,
> +	.base.cra_blocksize	= AES_BLOCK_SIZE,
> +	.base.cra_ctxsize	= sizeof(struct mac_tfm_ctx) +
> +				  2 * AES_BLOCK_SIZE,
> +	.base.cra_module	= THIS_MODULE,
> +
> +	.digestsize		= AES_BLOCK_SIZE,
> +	.init			= mac_init,
> +	.update			= mac_update,
> +	.final			= cmac_final,
> +	.setkey			= xcbc_setkey,
> +	.descsize		= sizeof(struct mac_desc_ctx),
> +}, {
> +	.base.cra_name		= "cbcmac(aes)",
> +	.base.cra_driver_name	= "cbcmac-aes-aesni",
> +	.base.cra_priority	= 400,
> +	.base.cra_blocksize	= 1,
> +	.base.cra_ctxsize	= sizeof(struct mac_tfm_ctx),
> +	.base.cra_module	= THIS_MODULE,
> +
> +	.digestsize		= AES_BLOCK_SIZE,
> +	.init			= mac_init,
> +	.update			= mac_update,
> +	.final			= cbcmac_final,
> +	.setkey			= cbcmac_setkey,
> +	.descsize		= sizeof(struct mac_desc_ctx),
> +} };
> +
> +const int aesni_num_mac_algs = ARRAY_SIZE(aesni_mac_algs);
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
