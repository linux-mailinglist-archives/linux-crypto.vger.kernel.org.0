Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEDDA4102F5
	for <lists+linux-crypto@lfdr.de>; Sat, 18 Sep 2021 04:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236293AbhIRC0b (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 17 Sep 2021 22:26:31 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:38332 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232711AbhIRC0a (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 17 Sep 2021 22:26:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Uojb6DE_1631931902;
Received: from B-455UMD6M-2027.local(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0Uojb6DE_1631931902)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sat, 18 Sep 2021 10:25:04 +0800
Subject: Re: [PATCH] X.509: Support parsing certificate using SM2 algorithm
To:     David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Gilad Ben-Yossef <gilad@benyossef.com>,
        Pascal van Leeuwen <pvanleeuwen@rambus.com>,
        keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jia Zhang <zhang.jia@linux.alibaba.com>,
        "YiLin . Li" <YiLin.Li@linux.alibaba.com>
References: <20210712081352.23692-1-tianjia.zhang@linux.alibaba.com>
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
Message-ID: <99a79ccb-8dd9-ac37-2a1d-ec390bcb0c8a@linux.alibaba.com>
Date:   Sat, 18 Sep 2021 10:25:02 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210712081352.23692-1-tianjia.zhang@linux.alibaba.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

ping.

On 7/12/21 4:13 PM, Tianjia Zhang wrote:
> The SM2-with-SM3 certificate generated by latest openssl no longer
> reuses the OID_id_ecPublicKey, but directly uses OID_sm2. This patch
> supports this type of x509 certificate parsing.
> 
> Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
> ---
>   crypto/asymmetric_keys/x509_cert_parser.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
> index 6d003096b5bc..6a945a6ce787 100644
> --- a/crypto/asymmetric_keys/x509_cert_parser.c
> +++ b/crypto/asymmetric_keys/x509_cert_parser.c
> @@ -496,6 +496,9 @@ int x509_extract_key_data(void *context, size_t hdrlen,
>   	case OID_gost2012PKey512:
>   		ctx->cert->pub->pkey_algo = "ecrdsa";
>   		break;
> +	case OID_sm2:
> +		ctx->cert->pub->pkey_algo = "sm2";
> +		break;
>   	case OID_id_ecPublicKey:
>   		if (parse_OID(ctx->params, ctx->params_size, &oid) != 0)
>   			return -EBADMSG;
> 
