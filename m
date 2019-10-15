Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74ABFD7503
	for <lists+linux-crypto@lfdr.de>; Tue, 15 Oct 2019 13:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727721AbfJOLb5 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 15 Oct 2019 07:31:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57662 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725820AbfJOLb5 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 15 Oct 2019 07:31:57 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9FBUxh2058148
        for <linux-crypto@vger.kernel.org>; Tue, 15 Oct 2019 07:31:50 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vnaf2e5fu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-crypto@vger.kernel.org>; Tue, 15 Oct 2019 07:31:49 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-crypto@vger.kernel.org> from <freude@linux.ibm.com>;
        Tue, 15 Oct 2019 12:31:47 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 15 Oct 2019 12:31:44 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9FBVghS45613172
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 15 Oct 2019 11:31:42 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ABC8742041;
        Tue, 15 Oct 2019 11:31:42 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 46B0B42042;
        Tue, 15 Oct 2019 11:31:41 +0000 (GMT)
Received: from [10.0.2.15] (unknown [9.145.82.252])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 15 Oct 2019 11:31:41 +0000 (GMT)
Subject: Re: [RFT PATCH 2/3] crypto: s390/paes - convert to skcipher API
To:     Eric Biggers <ebiggers@kernel.org>, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20191012201809.160500-1-ebiggers@kernel.org>
 <20191012201809.160500-3-ebiggers@kernel.org>
From:   Harald Freudenberger <freude@linux.ibm.com>
Date:   Tue, 15 Oct 2019 13:31:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191012201809.160500-3-ebiggers@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-TM-AS-GCONF: 00
x-cbid: 19101511-0012-0000-0000-000003583D8A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101511-0013-0000-0000-000021935311
Message-Id: <77a7eb57-2a26-8d2f-1ada-800d925514a4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-15_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910150107
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 12.10.19 22:18, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
>
> Convert the glue code for the S390 CPACF protected key implementations
> of AES-ECB, AES-CBC, AES-XTS, and AES-CTR from the deprecated
> "blkcipher" API to the "skcipher" API.  This is needed in order for the
> blkcipher API to be removed.
>
> Note: I made CTR use the same function for encryption and decryption,
> since CTR encryption and decryption are identical.
>
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---
>  arch/s390/crypto/paes_s390.c | 414 +++++++++++++++--------------------
>  1 file changed, 174 insertions(+), 240 deletions(-)
>
> diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
> index 6184dceed340..c7119c617b6e 100644
> --- a/arch/s390/crypto/paes_s390.c
> +++ b/arch/s390/crypto/paes_s390.c
> @@ -21,6 +21,7 @@
>  #include <linux/cpufeature.h>
>  #include <linux/init.h>
>  #include <linux/spinlock.h>
> +#include <crypto/internal/skcipher.h>
>  #include <crypto/xts.h>
>  #include <asm/cpacf.h>
>  #include <asm/pkey.h>
> @@ -123,27 +124,27 @@ static int __paes_set_key(struct s390_paes_ctx *ctx)
>  	return ctx->fc ? 0 : -EINVAL;
>  }
>  
> -static int ecb_paes_init(struct crypto_tfm *tfm)
> +static int ecb_paes_init(struct crypto_skcipher *tfm)
>  {
> -	struct s390_paes_ctx *ctx = crypto_tfm_ctx(tfm);
> +	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
>  
>  	ctx->kb.key = NULL;
>  
>  	return 0;
>  }
>  
> -static void ecb_paes_exit(struct crypto_tfm *tfm)
> +static void ecb_paes_exit(struct crypto_skcipher *tfm)
>  {
> -	struct s390_paes_ctx *ctx = crypto_tfm_ctx(tfm);
> +	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
>  
>  	_free_kb_keybuf(&ctx->kb);
>  }
>  
> -static int ecb_paes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
> +static int ecb_paes_set_key(struct crypto_skcipher *tfm, const u8 *in_key,
>  			    unsigned int key_len)
>  {
>  	int rc;
> -	struct s390_paes_ctx *ctx = crypto_tfm_ctx(tfm);
> +	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
>  
>  	_free_kb_keybuf(&ctx->kb);
>  	rc = _copy_key_to_kb(&ctx->kb, in_key, key_len);
> @@ -151,91 +152,75 @@ static int ecb_paes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
>  		return rc;
>  
>  	if (__paes_set_key(ctx)) {
> -		tfm->crt_flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
> +		crypto_skcipher_set_flags(tfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
>  		return -EINVAL;
>  	}
>  	return 0;
>  }
>  
> -static int ecb_paes_crypt(struct blkcipher_desc *desc,
> -			  unsigned long modifier,
> -			  struct blkcipher_walk *walk)
> +static int ecb_paes_crypt(struct skcipher_request *req, unsigned long modifier)
>  {
> -	struct s390_paes_ctx *ctx = crypto_blkcipher_ctx(desc->tfm);
> +	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> +	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
> +	struct skcipher_walk walk;
>  	unsigned int nbytes, n, k;
>  	int ret;
>  
> -	ret = blkcipher_walk_virt(desc, walk);
> -	while ((nbytes = walk->nbytes) >= AES_BLOCK_SIZE) {
> +	ret = skcipher_walk_virt(&walk, req, false);
> +	while ((nbytes = walk.nbytes) != 0) {
>  		/* only use complete blocks */
>  		n = nbytes & ~(AES_BLOCK_SIZE - 1);
>  		k = cpacf_km(ctx->fc | modifier, ctx->pk.protkey,
> -			     walk->dst.virt.addr, walk->src.virt.addr, n);
> +			     walk.dst.virt.addr, walk.src.virt.addr, n);
>  		if (k)
> -			ret = blkcipher_walk_done(desc, walk, nbytes - k);
> +			ret = skcipher_walk_done(&walk, nbytes - k);
>  		if (k < n) {
>  			if (__paes_set_key(ctx) != 0)
> -				return blkcipher_walk_done(desc, walk, -EIO);
> +				return skcipher_walk_done(&walk, -EIO);
>  		}
>  	}
>  	return ret;
>  }
>  
> -static int ecb_paes_encrypt(struct blkcipher_desc *desc,
> -			    struct scatterlist *dst, struct scatterlist *src,
> -			    unsigned int nbytes)
> +static int ecb_paes_encrypt(struct skcipher_request *req)
>  {
> -	struct blkcipher_walk walk;
> -
> -	blkcipher_walk_init(&walk, dst, src, nbytes);
> -	return ecb_paes_crypt(desc, CPACF_ENCRYPT, &walk);
> +	return ecb_paes_crypt(req, 0);
>  }
>  
> -static int ecb_paes_decrypt(struct blkcipher_desc *desc,
> -			    struct scatterlist *dst, struct scatterlist *src,
> -			    unsigned int nbytes)
> +static int ecb_paes_decrypt(struct skcipher_request *req)
>  {
> -	struct blkcipher_walk walk;
> -
> -	blkcipher_walk_init(&walk, dst, src, nbytes);
> -	return ecb_paes_crypt(desc, CPACF_DECRYPT, &walk);
> +	return ecb_paes_crypt(req, CPACF_DECRYPT);
>  }
>  
> -static struct crypto_alg ecb_paes_alg = {
> -	.cra_name		=	"ecb(paes)",
> -	.cra_driver_name	=	"ecb-paes-s390",
> -	.cra_priority		=	401,	/* combo: aes + ecb + 1 */
> -	.cra_flags		=	CRYPTO_ALG_TYPE_BLKCIPHER,
> -	.cra_blocksize		=	AES_BLOCK_SIZE,
> -	.cra_ctxsize		=	sizeof(struct s390_paes_ctx),
> -	.cra_type		=	&crypto_blkcipher_type,
> -	.cra_module		=	THIS_MODULE,
> -	.cra_list		=	LIST_HEAD_INIT(ecb_paes_alg.cra_list),
> -	.cra_init		=	ecb_paes_init,
> -	.cra_exit		=	ecb_paes_exit,
> -	.cra_u			=	{
> -		.blkcipher = {
> -			.min_keysize		=	PAES_MIN_KEYSIZE,
> -			.max_keysize		=	PAES_MAX_KEYSIZE,
> -			.setkey			=	ecb_paes_set_key,
> -			.encrypt		=	ecb_paes_encrypt,
> -			.decrypt		=	ecb_paes_decrypt,
> -		}
> -	}
> +static struct skcipher_alg ecb_paes_alg = {
> +	.base.cra_name		=	"ecb(paes)",
> +	.base.cra_driver_name	=	"ecb-paes-s390",
> +	.base.cra_priority	=	401,	/* combo: aes + ecb + 1 */
> +	.base.cra_blocksize	=	AES_BLOCK_SIZE,
> +	.base.cra_ctxsize	=	sizeof(struct s390_paes_ctx),
> +	.base.cra_module	=	THIS_MODULE,
> +	.base.cra_list		=	LIST_HEAD_INIT(ecb_paes_alg.base.cra_list),
> +	.init			=	ecb_paes_init,
> +	.exit			=	ecb_paes_exit,
> +	.min_keysize		=	PAES_MIN_KEYSIZE,
> +	.max_keysize		=	PAES_MAX_KEYSIZE,
> +	.setkey			=	ecb_paes_set_key,
> +	.encrypt		=	ecb_paes_encrypt,
> +	.decrypt		=	ecb_paes_decrypt,
>  };
>  
> -static int cbc_paes_init(struct crypto_tfm *tfm)
> +static int cbc_paes_init(struct crypto_skcipher *tfm)
>  {
> -	struct s390_paes_ctx *ctx = crypto_tfm_ctx(tfm);
> +	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
>  
>  	ctx->kb.key = NULL;
>  
>  	return 0;
>  }
>  
> -static void cbc_paes_exit(struct crypto_tfm *tfm)
> +static void cbc_paes_exit(struct crypto_skcipher *tfm)
>  {
> -	struct s390_paes_ctx *ctx = crypto_tfm_ctx(tfm);
> +	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
>  
>  	_free_kb_keybuf(&ctx->kb);
>  }
> @@ -258,11 +243,11 @@ static int __cbc_paes_set_key(struct s390_paes_ctx *ctx)
>  	return ctx->fc ? 0 : -EINVAL;
>  }
>  
> -static int cbc_paes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
> +static int cbc_paes_set_key(struct crypto_skcipher *tfm, const u8 *in_key,
>  			    unsigned int key_len)
>  {
>  	int rc;
> -	struct s390_paes_ctx *ctx = crypto_tfm_ctx(tfm);
> +	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
>  
>  	_free_kb_keybuf(&ctx->kb);
>  	rc = _copy_key_to_kb(&ctx->kb, in_key, key_len);
> @@ -270,16 +255,17 @@ static int cbc_paes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
>  		return rc;
>  
>  	if (__cbc_paes_set_key(ctx)) {
> -		tfm->crt_flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
> +		crypto_skcipher_set_flags(tfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
>  		return -EINVAL;
>  	}
>  	return 0;
>  }
>  
> -static int cbc_paes_crypt(struct blkcipher_desc *desc, unsigned long modifier,
> -			  struct blkcipher_walk *walk)
> +static int cbc_paes_crypt(struct skcipher_request *req, unsigned long modifier)
>  {
> -	struct s390_paes_ctx *ctx = crypto_blkcipher_ctx(desc->tfm);
> +	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> +	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
> +	struct skcipher_walk walk;
>  	unsigned int nbytes, n, k;
>  	int ret;
>  	struct {
> @@ -287,73 +273,60 @@ static int cbc_paes_crypt(struct blkcipher_desc *desc, unsigned long modifier,
>  		u8 key[MAXPROTKEYSIZE];
>  	} param;
>  
> -	ret = blkcipher_walk_virt(desc, walk);
> -	memcpy(param.iv, walk->iv, AES_BLOCK_SIZE);
> +	ret = skcipher_walk_virt(&walk, req, false);
> +	if (ret)
> +		return ret;
> +	memcpy(param.iv, walk.iv, AES_BLOCK_SIZE);
>  	memcpy(param.key, ctx->pk.protkey, MAXPROTKEYSIZE);
> -	while ((nbytes = walk->nbytes) >= AES_BLOCK_SIZE) {
> +	while ((nbytes = walk.nbytes) != 0) {
>  		/* only use complete blocks */
>  		n = nbytes & ~(AES_BLOCK_SIZE - 1);
>  		k = cpacf_kmc(ctx->fc | modifier, &param,
> -			      walk->dst.virt.addr, walk->src.virt.addr, n);
> -		if (k)
> -			ret = blkcipher_walk_done(desc, walk, nbytes - k);
> +			      walk.dst.virt.addr, walk.src.virt.addr, n);
> +		if (k) {
> +			memcpy(walk.iv, param.iv, AES_BLOCK_SIZE);
> +			ret = skcipher_walk_done(&walk, nbytes - k);
> +		}
>  		if (k < n) {
>  			if (__cbc_paes_set_key(ctx) != 0)
> -				return blkcipher_walk_done(desc, walk, -EIO);
> +				return skcipher_walk_done(&walk, -EIO);
>  			memcpy(param.key, ctx->pk.protkey, MAXPROTKEYSIZE);
>  		}
>  	}
> -	memcpy(walk->iv, param.iv, AES_BLOCK_SIZE);
>  	return ret;
>  }
>  
> -static int cbc_paes_encrypt(struct blkcipher_desc *desc,
> -			    struct scatterlist *dst, struct scatterlist *src,
> -			    unsigned int nbytes)
> +static int cbc_paes_encrypt(struct skcipher_request *req)
>  {
> -	struct blkcipher_walk walk;
> -
> -	blkcipher_walk_init(&walk, dst, src, nbytes);
> -	return cbc_paes_crypt(desc, 0, &walk);
> +	return cbc_paes_crypt(req, 0);
>  }
>  
> -static int cbc_paes_decrypt(struct blkcipher_desc *desc,
> -			    struct scatterlist *dst, struct scatterlist *src,
> -			    unsigned int nbytes)
> +static int cbc_paes_decrypt(struct skcipher_request *req)
>  {
> -	struct blkcipher_walk walk;
> -
> -	blkcipher_walk_init(&walk, dst, src, nbytes);
> -	return cbc_paes_crypt(desc, CPACF_DECRYPT, &walk);
> +	return cbc_paes_crypt(req, CPACF_DECRYPT);
>  }
>  
> -static struct crypto_alg cbc_paes_alg = {
> -	.cra_name		=	"cbc(paes)",
> -	.cra_driver_name	=	"cbc-paes-s390",
> -	.cra_priority		=	402,	/* ecb-paes-s390 + 1 */
> -	.cra_flags		=	CRYPTO_ALG_TYPE_BLKCIPHER,
> -	.cra_blocksize		=	AES_BLOCK_SIZE,
> -	.cra_ctxsize		=	sizeof(struct s390_paes_ctx),
> -	.cra_type		=	&crypto_blkcipher_type,
> -	.cra_module		=	THIS_MODULE,
> -	.cra_list		=	LIST_HEAD_INIT(cbc_paes_alg.cra_list),
> -	.cra_init		=	cbc_paes_init,
> -	.cra_exit		=	cbc_paes_exit,
> -	.cra_u			=	{
> -		.blkcipher = {
> -			.min_keysize		=	PAES_MIN_KEYSIZE,
> -			.max_keysize		=	PAES_MAX_KEYSIZE,
> -			.ivsize			=	AES_BLOCK_SIZE,
> -			.setkey			=	cbc_paes_set_key,
> -			.encrypt		=	cbc_paes_encrypt,
> -			.decrypt		=	cbc_paes_decrypt,
> -		}
> -	}
> +static struct skcipher_alg cbc_paes_alg = {
> +	.base.cra_name		=	"cbc(paes)",
> +	.base.cra_driver_name	=	"cbc-paes-s390",
> +	.base.cra_priority	=	402,	/* ecb-paes-s390 + 1 */
> +	.base.cra_blocksize	=	AES_BLOCK_SIZE,
> +	.base.cra_ctxsize	=	sizeof(struct s390_paes_ctx),
> +	.base.cra_module	=	THIS_MODULE,
> +	.base.cra_list		=	LIST_HEAD_INIT(cbc_paes_alg.base.cra_list),
> +	.init			=	cbc_paes_init,
> +	.exit			=	cbc_paes_exit,
> +	.min_keysize		=	PAES_MIN_KEYSIZE,
> +	.max_keysize		=	PAES_MAX_KEYSIZE,
> +	.ivsize			=	AES_BLOCK_SIZE,
> +	.setkey			=	cbc_paes_set_key,
> +	.encrypt		=	cbc_paes_encrypt,
> +	.decrypt		=	cbc_paes_decrypt,
>  };
>  
> -static int xts_paes_init(struct crypto_tfm *tfm)
> +static int xts_paes_init(struct crypto_skcipher *tfm)
>  {
> -	struct s390_pxts_ctx *ctx = crypto_tfm_ctx(tfm);
> +	struct s390_pxts_ctx *ctx = crypto_skcipher_ctx(tfm);
>  
>  	ctx->kb[0].key = NULL;
>  	ctx->kb[1].key = NULL;
> @@ -361,9 +334,9 @@ static int xts_paes_init(struct crypto_tfm *tfm)
>  	return 0;
>  }
>  
> -static void xts_paes_exit(struct crypto_tfm *tfm)
> +static void xts_paes_exit(struct crypto_skcipher *tfm)
>  {
> -	struct s390_pxts_ctx *ctx = crypto_tfm_ctx(tfm);
> +	struct s390_pxts_ctx *ctx = crypto_skcipher_ctx(tfm);
>  
>  	_free_kb_keybuf(&ctx->kb[0]);
>  	_free_kb_keybuf(&ctx->kb[1]);
> @@ -391,11 +364,11 @@ static int __xts_paes_set_key(struct s390_pxts_ctx *ctx)
>  	return ctx->fc ? 0 : -EINVAL;
>  }
>  
> -static int xts_paes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
> +static int xts_paes_set_key(struct crypto_skcipher *tfm, const u8 *in_key,
>  			    unsigned int xts_key_len)
>  {
>  	int rc;
> -	struct s390_pxts_ctx *ctx = crypto_tfm_ctx(tfm);
> +	struct s390_pxts_ctx *ctx = crypto_skcipher_ctx(tfm);
>  	u8 ckey[2 * AES_MAX_KEY_SIZE];
>  	unsigned int ckey_len, key_len;
>  
> @@ -414,7 +387,7 @@ static int xts_paes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
>  		return rc;
>  
>  	if (__xts_paes_set_key(ctx)) {
> -		tfm->crt_flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
> +		crypto_skcipher_set_flags(tfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
>  		return -EINVAL;
>  	}
>  
> @@ -427,13 +400,14 @@ static int xts_paes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
>  		AES_KEYSIZE_128 : AES_KEYSIZE_256;
>  	memcpy(ckey, ctx->pk[0].protkey, ckey_len);
>  	memcpy(ckey + ckey_len, ctx->pk[1].protkey, ckey_len);
> -	return xts_check_key(tfm, ckey, 2*ckey_len);
> +	return xts_verify_key(tfm, ckey, 2*ckey_len);
>  }
>  
> -static int xts_paes_crypt(struct blkcipher_desc *desc, unsigned long modifier,
> -			  struct blkcipher_walk *walk)
> +static int xts_paes_crypt(struct skcipher_request *req, unsigned long modifier)
>  {
> -	struct s390_pxts_ctx *ctx = crypto_blkcipher_ctx(desc->tfm);
> +	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> +	struct s390_pxts_ctx *ctx = crypto_skcipher_ctx(tfm);
> +	struct skcipher_walk walk;
>  	unsigned int keylen, offset, nbytes, n, k;
>  	int ret;
>  	struct {
> @@ -448,90 +422,76 @@ static int xts_paes_crypt(struct blkcipher_desc *desc, unsigned long modifier,
>  		u8 init[16];
>  	} xts_param;
>  
> -	ret = blkcipher_walk_virt(desc, walk);
> +	ret = skcipher_walk_virt(&walk, req, false);
> +	if (ret)
> +		return ret;
>  	keylen = (ctx->pk[0].type == PKEY_KEYTYPE_AES_128) ? 48 : 64;
>  	offset = (ctx->pk[0].type == PKEY_KEYTYPE_AES_128) ? 16 : 0;
>  retry:
>  	memset(&pcc_param, 0, sizeof(pcc_param));
> -	memcpy(pcc_param.tweak, walk->iv, sizeof(pcc_param.tweak));
> +	memcpy(pcc_param.tweak, walk.iv, sizeof(pcc_param.tweak));
>  	memcpy(pcc_param.key + offset, ctx->pk[1].protkey, keylen);
>  	cpacf_pcc(ctx->fc, pcc_param.key + offset);
>  
>  	memcpy(xts_param.key + offset, ctx->pk[0].protkey, keylen);
>  	memcpy(xts_param.init, pcc_param.xts, 16);
>  
> -	while ((nbytes = walk->nbytes) >= AES_BLOCK_SIZE) {
> +	while ((nbytes = walk.nbytes) != 0) {
>  		/* only use complete blocks */
>  		n = nbytes & ~(AES_BLOCK_SIZE - 1);
>  		k = cpacf_km(ctx->fc | modifier, xts_param.key + offset,
> -			     walk->dst.virt.addr, walk->src.virt.addr, n);
> +			     walk.dst.virt.addr, walk.src.virt.addr, n);
>  		if (k)
> -			ret = blkcipher_walk_done(desc, walk, nbytes - k);
> +			ret = skcipher_walk_done(&walk, nbytes - k);
>  		if (k < n) {
>  			if (__xts_paes_set_key(ctx) != 0)
> -				return blkcipher_walk_done(desc, walk, -EIO);
> +				return skcipher_walk_done(&walk, -EIO);
>  			goto retry;
>  		}
>  	}
>  	return ret;
>  }
>  
> -static int xts_paes_encrypt(struct blkcipher_desc *desc,
> -			    struct scatterlist *dst, struct scatterlist *src,
> -			    unsigned int nbytes)
> +static int xts_paes_encrypt(struct skcipher_request *req)
>  {
> -	struct blkcipher_walk walk;
> -
> -	blkcipher_walk_init(&walk, dst, src, nbytes);
> -	return xts_paes_crypt(desc, 0, &walk);
> +	return xts_paes_crypt(req, 0);
>  }
>  
> -static int xts_paes_decrypt(struct blkcipher_desc *desc,
> -			    struct scatterlist *dst, struct scatterlist *src,
> -			    unsigned int nbytes)
> +static int xts_paes_decrypt(struct skcipher_request *req)
>  {
> -	struct blkcipher_walk walk;
> -
> -	blkcipher_walk_init(&walk, dst, src, nbytes);
> -	return xts_paes_crypt(desc, CPACF_DECRYPT, &walk);
> +	return xts_paes_crypt(req, CPACF_DECRYPT);
>  }
>  
> -static struct crypto_alg xts_paes_alg = {
> -	.cra_name		=	"xts(paes)",
> -	.cra_driver_name	=	"xts-paes-s390",
> -	.cra_priority		=	402,	/* ecb-paes-s390 + 1 */
> -	.cra_flags		=	CRYPTO_ALG_TYPE_BLKCIPHER,
> -	.cra_blocksize		=	AES_BLOCK_SIZE,
> -	.cra_ctxsize		=	sizeof(struct s390_pxts_ctx),
> -	.cra_type		=	&crypto_blkcipher_type,
> -	.cra_module		=	THIS_MODULE,
> -	.cra_list		=	LIST_HEAD_INIT(xts_paes_alg.cra_list),
> -	.cra_init		=	xts_paes_init,
> -	.cra_exit		=	xts_paes_exit,
> -	.cra_u			=	{
> -		.blkcipher = {
> -			.min_keysize		=	2 * PAES_MIN_KEYSIZE,
> -			.max_keysize		=	2 * PAES_MAX_KEYSIZE,
> -			.ivsize			=	AES_BLOCK_SIZE,
> -			.setkey			=	xts_paes_set_key,
> -			.encrypt		=	xts_paes_encrypt,
> -			.decrypt		=	xts_paes_decrypt,
> -		}
> -	}
> +static struct skcipher_alg xts_paes_alg = {
> +	.base.cra_name		=	"xts(paes)",
> +	.base.cra_driver_name	=	"xts-paes-s390",
> +	.base.cra_priority	=	402,	/* ecb-paes-s390 + 1 */
> +	.base.cra_blocksize	=	AES_BLOCK_SIZE,
> +	.base.cra_ctxsize	=	sizeof(struct s390_pxts_ctx),
> +	.base.cra_module	=	THIS_MODULE,
> +	.base.cra_list		=	LIST_HEAD_INIT(xts_paes_alg.base.cra_list),
> +	.init			=	xts_paes_init,
> +	.exit			=	xts_paes_exit,
> +	.min_keysize		=	2 * PAES_MIN_KEYSIZE,
> +	.max_keysize		=	2 * PAES_MAX_KEYSIZE,
> +	.ivsize			=	AES_BLOCK_SIZE,
> +	.setkey			=	xts_paes_set_key,
> +	.encrypt		=	xts_paes_encrypt,
> +	.decrypt		=	xts_paes_decrypt,
>  };
>  
> -static int ctr_paes_init(struct crypto_tfm *tfm)
> +static int ctr_paes_init(struct crypto_skcipher *tfm)
>  {
> -	struct s390_paes_ctx *ctx = crypto_tfm_ctx(tfm);
> +	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
>  
>  	ctx->kb.key = NULL;
>  
>  	return 0;
>  }
>  
> -static void ctr_paes_exit(struct crypto_tfm *tfm)
> +static void ctr_paes_exit(struct crypto_skcipher *tfm)
>  {
> -	struct s390_paes_ctx *ctx = crypto_tfm_ctx(tfm);
> +	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
>  
>  	_free_kb_keybuf(&ctx->kb);
>  }
> @@ -555,11 +515,11 @@ static int __ctr_paes_set_key(struct s390_paes_ctx *ctx)
>  	return ctx->fc ? 0 : -EINVAL;
>  }
>  
> -static int ctr_paes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
> +static int ctr_paes_set_key(struct crypto_skcipher *tfm, const u8 *in_key,
>  			    unsigned int key_len)
>  {
>  	int rc;
> -	struct s390_paes_ctx *ctx = crypto_tfm_ctx(tfm);
> +	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
>  
>  	_free_kb_keybuf(&ctx->kb);
>  	rc = _copy_key_to_kb(&ctx->kb, in_key, key_len);
> @@ -567,7 +527,7 @@ static int ctr_paes_set_key(struct crypto_tfm *tfm, const u8 *in_key,
>  		return rc;
>  
>  	if (__ctr_paes_set_key(ctx)) {
> -		tfm->crt_flags |= CRYPTO_TFM_RES_BAD_KEY_LEN;
> +		crypto_skcipher_set_flags(tfm, CRYPTO_TFM_RES_BAD_KEY_LEN);
>  		return -EINVAL;
>  	}
>  	return 0;
> @@ -588,37 +548,37 @@ static unsigned int __ctrblk_init(u8 *ctrptr, u8 *iv, unsigned int nbytes)
>  	return n;
>  }
>  
> -static int ctr_paes_crypt(struct blkcipher_desc *desc, unsigned long modifier,
> -			  struct blkcipher_walk *walk)
> +static int ctr_paes_crypt(struct skcipher_request *req)
>  {
> -	struct s390_paes_ctx *ctx = crypto_blkcipher_ctx(desc->tfm);
> +	struct crypto_skcipher *tfm = crypto_skcipher_reqtfm(req);
> +	struct s390_paes_ctx *ctx = crypto_skcipher_ctx(tfm);
>  	u8 buf[AES_BLOCK_SIZE], *ctrptr;
> +	struct skcipher_walk walk;
>  	unsigned int nbytes, n, k;
>  	int ret, locked;
>  
>  	locked = spin_trylock(&ctrblk_lock);
>  
> -	ret = blkcipher_walk_virt_block(desc, walk, AES_BLOCK_SIZE);
> -	while ((nbytes = walk->nbytes) >= AES_BLOCK_SIZE) {
> +	ret = skcipher_walk_virt(&walk, req, false);
> +	while ((nbytes = walk.nbytes) >= AES_BLOCK_SIZE) {
>  		n = AES_BLOCK_SIZE;
>  		if (nbytes >= 2*AES_BLOCK_SIZE && locked)
> -			n = __ctrblk_init(ctrblk, walk->iv, nbytes);
> -		ctrptr = (n > AES_BLOCK_SIZE) ? ctrblk : walk->iv;
> -		k = cpacf_kmctr(ctx->fc | modifier, ctx->pk.protkey,
> -				walk->dst.virt.addr, walk->src.virt.addr,
> -				n, ctrptr);
> +			n = __ctrblk_init(ctrblk, walk.iv, nbytes);
> +		ctrptr = (n > AES_BLOCK_SIZE) ? ctrblk : walk.iv;
> +		k = cpacf_kmctr(ctx->fc, ctx->pk.protkey, walk.dst.virt.addr,
> +				walk.src.virt.addr, n, ctrptr);
>  		if (k) {
>  			if (ctrptr == ctrblk)
> -				memcpy(walk->iv, ctrptr + k - AES_BLOCK_SIZE,
> +				memcpy(walk.iv, ctrptr + k - AES_BLOCK_SIZE,
>  				       AES_BLOCK_SIZE);
> -			crypto_inc(walk->iv, AES_BLOCK_SIZE);
> -			ret = blkcipher_walk_done(desc, walk, nbytes - n);
> +			crypto_inc(walk.iv, AES_BLOCK_SIZE);
> +			ret = skcipher_walk_done(&walk, nbytes - n);

Looks like a bug here. It should be

ret = skcipher_walk_done(&walk, nbytes - k);

similar to the other modes.
You can add this in your patch or leave it to me to provide a separate patch.

>  		}
>  		if (k < n) {
>  			if (__ctr_paes_set_key(ctx) != 0) {
>  				if (locked)
>  					spin_unlock(&ctrblk_lock);
> -				return blkcipher_walk_done(desc, walk, -EIO);
> +				return skcipher_walk_done(&walk, -EIO);
>  			}
>  		}
>  	}
> @@ -629,80 +589,54 @@ static int ctr_paes_crypt(struct blkcipher_desc *desc, unsigned long modifier,
>  	 */
>  	if (nbytes) {
>  		while (1) {
> -			if (cpacf_kmctr(ctx->fc | modifier,
> -					ctx->pk.protkey, buf,
> -					walk->src.virt.addr, AES_BLOCK_SIZE,
> -					walk->iv) == AES_BLOCK_SIZE)
> +			if (cpacf_kmctr(ctx->fc, ctx->pk.protkey, buf,
> +					walk.src.virt.addr, AES_BLOCK_SIZE,
> +					walk.iv) == AES_BLOCK_SIZE)
>  				break;
>  			if (__ctr_paes_set_key(ctx) != 0)
> -				return blkcipher_walk_done(desc, walk, -EIO);
> +				return skcipher_walk_done(&walk, -EIO);
>  		}
> -		memcpy(walk->dst.virt.addr, buf, nbytes);
> -		crypto_inc(walk->iv, AES_BLOCK_SIZE);
> -		ret = blkcipher_walk_done(desc, walk, 0);
> +		memcpy(walk.dst.virt.addr, buf, nbytes);
> +		crypto_inc(walk.iv, AES_BLOCK_SIZE);
> +		ret = skcipher_walk_done(&walk, 0);
>  	}
>  
>  	return ret;
>  }
>  
> -static int ctr_paes_encrypt(struct blkcipher_desc *desc,
> -			    struct scatterlist *dst, struct scatterlist *src,
> -			    unsigned int nbytes)
> -{
> -	struct blkcipher_walk walk;
> -
> -	blkcipher_walk_init(&walk, dst, src, nbytes);
> -	return ctr_paes_crypt(desc, 0, &walk);
> -}
> -
> -static int ctr_paes_decrypt(struct blkcipher_desc *desc,
> -			    struct scatterlist *dst, struct scatterlist *src,
> -			    unsigned int nbytes)
> -{
> -	struct blkcipher_walk walk;
> -
> -	blkcipher_walk_init(&walk, dst, src, nbytes);
> -	return ctr_paes_crypt(desc, CPACF_DECRYPT, &walk);
> -}
> -
> -static struct crypto_alg ctr_paes_alg = {
> -	.cra_name		=	"ctr(paes)",
> -	.cra_driver_name	=	"ctr-paes-s390",
> -	.cra_priority		=	402,	/* ecb-paes-s390 + 1 */
> -	.cra_flags		=	CRYPTO_ALG_TYPE_BLKCIPHER,
> -	.cra_blocksize		=	1,
> -	.cra_ctxsize		=	sizeof(struct s390_paes_ctx),
> -	.cra_type		=	&crypto_blkcipher_type,
> -	.cra_module		=	THIS_MODULE,
> -	.cra_list		=	LIST_HEAD_INIT(ctr_paes_alg.cra_list),
> -	.cra_init		=	ctr_paes_init,
> -	.cra_exit		=	ctr_paes_exit,
> -	.cra_u			=	{
> -		.blkcipher = {
> -			.min_keysize		=	PAES_MIN_KEYSIZE,
> -			.max_keysize		=	PAES_MAX_KEYSIZE,
> -			.ivsize			=	AES_BLOCK_SIZE,
> -			.setkey			=	ctr_paes_set_key,
> -			.encrypt		=	ctr_paes_encrypt,
> -			.decrypt		=	ctr_paes_decrypt,
> -		}
> -	}
> +static struct skcipher_alg ctr_paes_alg = {
> +	.base.cra_name		=	"ctr(paes)",
> +	.base.cra_driver_name	=	"ctr-paes-s390",
> +	.base.cra_priority	=	402,	/* ecb-paes-s390 + 1 */
> +	.base.cra_blocksize	=	1,
> +	.base.cra_ctxsize	=	sizeof(struct s390_paes_ctx),
> +	.base.cra_module	=	THIS_MODULE,
> +	.base.cra_list		=	LIST_HEAD_INIT(ctr_paes_alg.base.cra_list),
> +	.init			=	ctr_paes_init,
> +	.exit			=	ctr_paes_exit,
> +	.min_keysize		=	PAES_MIN_KEYSIZE,
> +	.max_keysize		=	PAES_MAX_KEYSIZE,
> +	.ivsize			=	AES_BLOCK_SIZE,
> +	.setkey			=	ctr_paes_set_key,
> +	.encrypt		=	ctr_paes_crypt,
> +	.decrypt		=	ctr_paes_crypt,
> +	.chunksize		=	AES_BLOCK_SIZE,
>  };
>  
> -static inline void __crypto_unregister_alg(struct crypto_alg *alg)
> +static inline void __crypto_unregister_skcipher(struct skcipher_alg *alg)
>  {
> -	if (!list_empty(&alg->cra_list))
> -		crypto_unregister_alg(alg);
> +	if (!list_empty(&alg->base.cra_list))
> +		crypto_unregister_skcipher(alg);
>  }
>  
>  static void paes_s390_fini(void)
>  {
>  	if (ctrblk)
>  		free_page((unsigned long) ctrblk);
> -	__crypto_unregister_alg(&ctr_paes_alg);
> -	__crypto_unregister_alg(&xts_paes_alg);
> -	__crypto_unregister_alg(&cbc_paes_alg);
> -	__crypto_unregister_alg(&ecb_paes_alg);
> +	__crypto_unregister_skcipher(&ctr_paes_alg);
> +	__crypto_unregister_skcipher(&xts_paes_alg);
> +	__crypto_unregister_skcipher(&cbc_paes_alg);
> +	__crypto_unregister_skcipher(&ecb_paes_alg);
>  }
>  
>  static int __init paes_s390_init(void)
> @@ -717,7 +651,7 @@ static int __init paes_s390_init(void)
>  	if (cpacf_test_func(&km_functions, CPACF_KM_PAES_128) ||
>  	    cpacf_test_func(&km_functions, CPACF_KM_PAES_192) ||
>  	    cpacf_test_func(&km_functions, CPACF_KM_PAES_256)) {
> -		ret = crypto_register_alg(&ecb_paes_alg);
> +		ret = crypto_register_skcipher(&ecb_paes_alg);
>  		if (ret)
>  			goto out_err;
>  	}
> @@ -725,14 +659,14 @@ static int __init paes_s390_init(void)
>  	if (cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_128) ||
>  	    cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_192) ||
>  	    cpacf_test_func(&kmc_functions, CPACF_KMC_PAES_256)) {
> -		ret = crypto_register_alg(&cbc_paes_alg);
> +		ret = crypto_register_skcipher(&cbc_paes_alg);
>  		if (ret)
>  			goto out_err;
>  	}
>  
>  	if (cpacf_test_func(&km_functions, CPACF_KM_PXTS_128) ||
>  	    cpacf_test_func(&km_functions, CPACF_KM_PXTS_256)) {
> -		ret = crypto_register_alg(&xts_paes_alg);
> +		ret = crypto_register_skcipher(&xts_paes_alg);
>  		if (ret)
>  			goto out_err;
>  	}
> @@ -740,7 +674,7 @@ static int __init paes_s390_init(void)
>  	if (cpacf_test_func(&kmctr_functions, CPACF_KMCTR_PAES_128) ||
>  	    cpacf_test_func(&kmctr_functions, CPACF_KMCTR_PAES_192) ||
>  	    cpacf_test_func(&kmctr_functions, CPACF_KMCTR_PAES_256)) {
> -		ret = crypto_register_alg(&ctr_paes_alg);
> +		ret = crypto_register_skcipher(&ctr_paes_alg);
>  		if (ret)
>  			goto out_err;
>  		ctrblk = (u8 *) __get_free_page(GFP_KERNEL);
Tested with extended selftests and own tests via AF_ALG interface, works.
Thanks for this great work.
reviewed-by: Harald Freudenberger <freude@linux.ibm.com>

