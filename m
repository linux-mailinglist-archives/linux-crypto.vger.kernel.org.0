Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E25A11769F3
	for <lists+linux-crypto@lfdr.de>; Tue,  3 Mar 2020 02:24:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgCCBYm (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 2 Mar 2020 20:24:42 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:10709 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726755AbgCCBYm (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 2 Mar 2020 20:24:42 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 8508537ADC7E359B5180;
        Tue,  3 Mar 2020 09:24:39 +0800 (CST)
Received: from [127.0.0.1] (10.67.101.242) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Mar 2020
 09:24:30 +0800
Subject: Re: [PATCH v2 4/5] crypto: hisilicon/sec2 - Update IV and MAC
 operation
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <1583129716-28382-1-git-send-email-xuzaibo@huawei.com>
 <1583129716-28382-5-git-send-email-xuzaibo@huawei.com>
 <20200302115836.00004002@Huawei.com>
CC:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <qianweili@huawei.com>, <tanghui20@huawei.com>,
        <forest.zhouchang@huawei.com>, <linuxarm@huawei.com>,
        <zhangwei375@huawei.com>, <yekai13@huawei.com>,
        <linux-crypto@vger.kernel.org>
From:   Xu Zaibo <xuzaibo@huawei.com>
Message-ID: <92b2bffb-ff0b-5c64-e500-e9804ab5c58c@huawei.com>
Date:   Tue, 3 Mar 2020 09:24:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20200302115836.00004002@Huawei.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.101.242]
X-CFilter-Loop: Reflected
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi,

On 2020/3/2 19:58, Jonathan Cameron wrote:
> On Mon, 2 Mar 2020 14:15:15 +0800
> Zaibo Xu <xuzaibo@huawei.com> wrote:
>
>> From: liulongfang <liulongfang@huawei.com>
>>
>> We have updated the operation method of IV and MAC address
>> to prepare for pbuf patch.
>>
>> Signed-off-by: liulongfang <liulongfang@huawei.com>
>> Signed-off-by: Zaibo Xu <xuzaibo@huawei.com>
> Trivial comment inline.
>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Okay.
>
>> ---
>>   drivers/crypto/hisilicon/sec2/sec.h        |  2 +
>>   drivers/crypto/hisilicon/sec2/sec_crypto.c | 73 +++++++++++++++++-------------
>>   2 files changed, 43 insertions(+), 32 deletions(-)
>>
>> diff --git a/drivers/crypto/hisilicon/sec2/sec.h b/drivers/crypto/hisilicon/sec2/sec.h
>> index eab0d22..e67b416 100644
>> --- a/drivers/crypto/hisilicon/sec2/sec.h
>> +++ b/drivers/crypto/hisilicon/sec2/sec.h
>> @@ -23,6 +23,8 @@ struct sec_cipher_req {
>>   	dma_addr_t c_in_dma;
>>   	struct hisi_acc_hw_sgl *c_out;
>>   	dma_addr_t c_out_dma;
>> +	u8 *c_ivin;
>> +	dma_addr_t c_ivin_dma;
>>   	struct skcipher_request *sk_req;
>>   	u32 c_len;
>>   	bool encrypt;
>> diff --git a/drivers/crypto/hisilicon/sec2/sec_crypto.c b/drivers/crypto/hisilicon/sec2/sec_crypto.c
>> index acd1550..1eeaa74 100644
>> --- a/drivers/crypto/hisilicon/sec2/sec_crypto.c
>> +++ b/drivers/crypto/hisilicon/sec2/sec_crypto.c
>> @@ -46,6 +46,7 @@
>>   #define SEC_CIPHER_AUTH		0xfe
>>   #define SEC_AUTH_CIPHER		0x1
>>   #define SEC_MAX_MAC_LEN		64
>> +#define SEC_MAX_AAD_LEN		65535
>>   #define SEC_TOTAL_MAC_SZ	(SEC_MAX_MAC_LEN * QM_Q_DEPTH)
>>   #define SEC_SQE_LEN_RATE	4
>>   #define SEC_SQE_CFLAG		2
>> @@ -110,12 +111,12 @@ static void sec_free_req_id(struct sec_req *req)
>>   	mutex_unlock(&qp_ctx->req_lock);
>>   }
>>   
>> -static int sec_aead_verify(struct sec_req *req, struct sec_qp_ctx *qp_ctx)
>> +static int sec_aead_verify(struct sec_req *req)
>>   {
>>   	struct aead_request *aead_req = req->aead_req.aead_req;
>>   	struct crypto_aead *tfm = crypto_aead_reqtfm(aead_req);
>> -	u8 *mac_out = qp_ctx->res[req->req_id].out_mac;
>>   	size_t authsize = crypto_aead_authsize(tfm);
>> +	u8 *mac_out = req->aead_req.out_mac;
>>   	u8 *mac = mac_out + SEC_MAX_MAC_LEN;
>>   	struct scatterlist *sgl = aead_req->src;
>>   	size_t sz;
>> @@ -163,7 +164,7 @@ static void sec_req_cb(struct hisi_qp *qp, void *resp)
>>   	}
>>   
>>   	if (ctx->alg_type == SEC_AEAD && !req->c_req.encrypt)
>> -		err = sec_aead_verify(req, qp_ctx);
>> +		err = sec_aead_verify(req);
>>   
>>   	atomic64_inc(&ctx->sec->debug.dfx.recv_cnt);
>>   
>> @@ -259,11 +260,11 @@ static int sec_alg_resource_alloc(struct sec_ctx *ctx,
>>   	if (ctx->alg_type == SEC_AEAD) {
>>   		ret = sec_alloc_mac_resource(dev, res);
>>   		if (ret)
>> -			goto get_fail;
>> +			goto alloc_fail;
> This looks like an unrelated change.
> At very least should be mentioned as an additional cleanup in the patch intro.
Yes, will add it.

Thanks,
Zaibo

.
>
>>   	}
>>   
>>   	return 0;
>> -get_fail:
>> +alloc_fail:
>>   	sec_free_civ_resource(dev, res);
>>   
>>   	return ret;
>> @@ -590,11 +591,21 @@ GEN_SEC_SETKEY_FUNC(3des_cbc, SEC_CALG_3DES, SEC_CMODE_CBC)
>>   GEN_SEC_SETKEY_FUNC(sm4_xts, SEC_CALG_SM4, SEC_CMODE_XTS)
>>   GEN_SEC_SETKEY_FUNC(sm4_cbc, SEC_CALG_SM4, SEC_CMODE_CBC)
>>   
>> -static int sec_cipher_map(struct device *dev, struct sec_req *req,
>> +static int sec_cipher_map(struct sec_ctx *ctx, struct sec_req *req,
>>   			  struct scatterlist *src, struct scatterlist *dst)
>>   {
>>   	struct sec_cipher_req *c_req = &req->c_req;
>> +	struct sec_aead_req *a_req = &req->aead_req;
>>   	struct sec_qp_ctx *qp_ctx = req->qp_ctx;
>> +	struct sec_alg_res *res = &qp_ctx->res[req->req_id];
>> +	struct device *dev = SEC_CTX_DEV(ctx);
>> +
>> +	c_req->c_ivin = res->c_ivin;
>> +	c_req->c_ivin_dma = res->c_ivin_dma;
>> +	if (ctx->alg_type == SEC_AEAD) {
>> +		a_req->out_mac = res->out_mac;
>> +		a_req->out_mac_dma = res->out_mac_dma;
>> +	}
>>   
>>   	c_req->c_in = hisi_acc_sg_buf_map_to_hw_sgl(dev, src,
>>   						    qp_ctx->c_in_pool,
>> @@ -625,29 +636,30 @@ static int sec_cipher_map(struct device *dev, struct sec_req *req,
>>   	return 0;
>>   }
>>   
>> -static void sec_cipher_unmap(struct device *dev, struct sec_cipher_req *req,
>> +static void sec_cipher_unmap(struct sec_ctx *ctx, struct sec_req *req,
>>   			     struct scatterlist *src, struct scatterlist *dst)
>>   {
>> +	struct sec_cipher_req *c_req = &req->c_req;
>> +	struct device *dev = SEC_CTX_DEV(ctx);
>> +
>>   	if (dst != src)
>> -		hisi_acc_sg_buf_unmap(dev, src, req->c_in);
>> +		hisi_acc_sg_buf_unmap(dev, src, c_req->c_in);
>>   
>> -	hisi_acc_sg_buf_unmap(dev, dst, req->c_out);
>> +	hisi_acc_sg_buf_unmap(dev, dst, c_req->c_out);
>>   }
>>   
>>   static int sec_skcipher_sgl_map(struct sec_ctx *ctx, struct sec_req *req)
>>   {
>>   	struct skcipher_request *sq = req->c_req.sk_req;
>>   
>> -	return sec_cipher_map(SEC_CTX_DEV(ctx), req, sq->src, sq->dst);
>> +	return sec_cipher_map(ctx, req, sq->src, sq->dst);
>>   }
>>   
>>   static void sec_skcipher_sgl_unmap(struct sec_ctx *ctx, struct sec_req *req)
>>   {
>> -	struct device *dev = SEC_CTX_DEV(ctx);
>> -	struct sec_cipher_req *c_req = &req->c_req;
>> -	struct skcipher_request *sk_req = c_req->sk_req;
>> +	struct skcipher_request *sq = req->c_req.sk_req;
>>   
>> -	sec_cipher_unmap(dev, c_req, sk_req->src, sk_req->dst);
>> +	sec_cipher_unmap(ctx, req, sq->src, sq->dst);
>>   }
>>   
>>   static int sec_aead_aes_set_key(struct sec_cipher_ctx *c_ctx,
>> @@ -758,16 +770,14 @@ static int sec_aead_sgl_map(struct sec_ctx *ctx, struct sec_req *req)
>>   {
>>   	struct aead_request *aq = req->aead_req.aead_req;
>>   
>> -	return sec_cipher_map(SEC_CTX_DEV(ctx), req, aq->src, aq->dst);
>> +	return sec_cipher_map(ctx, req, aq->src, aq->dst);
>>   }
>>   
>>   static void sec_aead_sgl_unmap(struct sec_ctx *ctx, struct sec_req *req)
>>   {
>> -	struct device *dev = SEC_CTX_DEV(ctx);
>> -	struct sec_cipher_req *cq = &req->c_req;
>>   	struct aead_request *aq = req->aead_req.aead_req;
>>   
>> -	sec_cipher_unmap(dev, cq, aq->src, aq->dst);
>> +	sec_cipher_unmap(ctx, req, aq->src, aq->dst);
>>   }
>>   
>>   static int sec_request_transfer(struct sec_ctx *ctx, struct sec_req *req)
>> @@ -800,9 +810,9 @@ static void sec_request_untransfer(struct sec_ctx *ctx, struct sec_req *req)
>>   static void sec_skcipher_copy_iv(struct sec_ctx *ctx, struct sec_req *req)
>>   {
>>   	struct skcipher_request *sk_req = req->c_req.sk_req;
>> -	u8 *c_ivin = req->qp_ctx->res[req->req_id].c_ivin;
>> +	struct sec_cipher_req *c_req = &req->c_req;
>>   
>> -	memcpy(c_ivin, sk_req->iv, ctx->c_ctx.ivsize);
>> +	memcpy(c_req->c_ivin, sk_req->iv, ctx->c_ctx.ivsize);
>>   }
>>   
>>   static int sec_skcipher_bd_fill(struct sec_ctx *ctx, struct sec_req *req)
>> @@ -817,8 +827,7 @@ static int sec_skcipher_bd_fill(struct sec_ctx *ctx, struct sec_req *req)
>>   	memset(sec_sqe, 0, sizeof(struct sec_sqe));
>>   
>>   	sec_sqe->type2.c_key_addr = cpu_to_le64(c_ctx->c_key_dma);
>> -	sec_sqe->type2.c_ivin_addr =
>> -		cpu_to_le64(req->qp_ctx->res[req->req_id].c_ivin_dma);
>> +	sec_sqe->type2.c_ivin_addr = cpu_to_le64(c_req->c_ivin_dma);
>>   	sec_sqe->type2.data_src_addr = cpu_to_le64(c_req->c_in_dma);
>>   	sec_sqe->type2.data_dst_addr = cpu_to_le64(c_req->c_out_dma);
>>   
>> @@ -903,9 +912,9 @@ static void sec_skcipher_callback(struct sec_ctx *ctx, struct sec_req *req,
>>   static void sec_aead_copy_iv(struct sec_ctx *ctx, struct sec_req *req)
>>   {
>>   	struct aead_request *aead_req = req->aead_req.aead_req;
>> -	u8 *c_ivin = req->qp_ctx->res[req->req_id].c_ivin;
>> +	struct sec_cipher_req *c_req = &req->c_req;
>>   
>> -	memcpy(c_ivin, aead_req->iv, ctx->c_ctx.ivsize);
>> +	memcpy(c_req->c_ivin, aead_req->iv, ctx->c_ctx.ivsize);
>>   }
>>   
>>   static void sec_auth_bd_fill_ex(struct sec_auth_ctx *ctx, int dir,
>> @@ -938,8 +947,7 @@ static void sec_auth_bd_fill_ex(struct sec_auth_ctx *ctx, int dir,
>>   
>>   	sec_sqe->type2.cipher_src_offset = cpu_to_le16((u16)aq->assoclen);
>>   
>> -	sec_sqe->type2.mac_addr =
>> -		cpu_to_le64(req->qp_ctx->res[req->req_id].out_mac_dma);
>> +	sec_sqe->type2.mac_addr = cpu_to_le64(a_req->out_mac_dma);
>>   }
>>   
>>   static int sec_aead_bd_fill(struct sec_ctx *ctx, struct sec_req *req)
>> @@ -963,6 +971,7 @@ static void sec_aead_callback(struct sec_ctx *c, struct sec_req *req, int err)
>>   {
>>   	struct aead_request *a_req = req->aead_req.aead_req;
>>   	struct crypto_aead *tfm = crypto_aead_reqtfm(a_req);
>> +	struct sec_aead_req *aead_req = &req->aead_req;
>>   	struct sec_cipher_req *c_req = &req->c_req;
>>   	size_t authsize = crypto_aead_authsize(tfm);
>>   	struct sec_qp_ctx *qp_ctx = req->qp_ctx;
>> @@ -978,7 +987,7 @@ static void sec_aead_callback(struct sec_ctx *c, struct sec_req *req, int err)
>>   		struct scatterlist *sgl = a_req->dst;
>>   
>>   		sz = sg_pcopy_from_buffer(sgl, sg_nents(sgl),
>> -					  qp_ctx->res[req->req_id].out_mac,
>> +					  aead_req->out_mac,
>>   					  authsize, a_req->cryptlen +
>>   					  a_req->assoclen);
>>   
>> @@ -1030,6 +1039,7 @@ static int sec_request_init(struct sec_ctx *ctx, struct sec_req *req)
>>   
>>   static int sec_process(struct sec_ctx *ctx, struct sec_req *req)
>>   {
>> +	struct sec_cipher_req *c_req = &req->c_req;
>>   	int ret;
>>   
>>   	ret = sec_request_init(ctx, req);
>> @@ -1056,12 +1066,10 @@ static int sec_process(struct sec_ctx *ctx, struct sec_req *req)
>>   	/* As failing, restore the IV from user */
>>   	if (ctx->c_ctx.c_mode == SEC_CMODE_CBC && !req->c_req.encrypt) {
>>   		if (ctx->alg_type == SEC_SKCIPHER)
>> -			memcpy(req->c_req.sk_req->iv,
>> -			       req->qp_ctx->res[req->req_id].c_ivin,
>> +			memcpy(req->c_req.sk_req->iv, c_req->c_ivin,
>>   			       ctx->c_ctx.ivsize);
>>   		else
>> -			memcpy(req->aead_req.aead_req->iv,
>> -			       req->qp_ctx->res[req->req_id].c_ivin,
>> +			memcpy(req->aead_req.aead_req->iv, c_req->c_ivin,
>>   			       ctx->c_ctx.ivsize);
>>   	}
>>   
>> @@ -1320,7 +1328,8 @@ static int sec_aead_param_check(struct sec_ctx *ctx, struct sec_req *sreq)
>>   	struct crypto_aead *tfm = crypto_aead_reqtfm(req);
>>   	size_t authsize = crypto_aead_authsize(tfm);
>>   
>> -	if (unlikely(!req->src || !req->dst || !req->cryptlen)) {
>> +	if (unlikely(!req->src || !req->dst || !req->cryptlen ||
>> +		req->assoclen > SEC_MAX_AAD_LEN)) {
>>   		dev_err(SEC_CTX_DEV(ctx), "aead input param error!\n");
>>   		return -EINVAL;
>>   	}
>
> .
>


