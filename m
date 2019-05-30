Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 368DD2F7DC
	for <lists+linux-crypto@lfdr.de>; Thu, 30 May 2019 09:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbfE3HXl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-crypto@lfdr.de>); Thu, 30 May 2019 03:23:41 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:58606 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfE3HXk (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 30 May 2019 03:23:40 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4B4156074CC1;
        Thu, 30 May 2019 09:23:38 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 7gYQFNzHwAQ9; Thu, 30 May 2019 09:23:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7DEF36074CC0;
        Thu, 30 May 2019 09:23:36 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SYWKd5C5gmcb; Thu, 30 May 2019 09:23:36 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 397BB6074CC1;
        Thu, 30 May 2019 09:23:36 +0200 (CEST)
Date:   Thu, 30 May 2019 09:23:36 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel <linux-kernel@vger.kernel.org>, linux-imx@nxp.com,
        festevam@gmail.com, kernel <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>, shawnguo@kernel.org,
        davem@davemloft.net, david <david@sigma-star.at>
Message-ID: <2084969721.73871.1559201016164.JavaMail.zimbra@nod.at>
In-Reply-To: <20190530023357.2mrjtslnka4i6dbl@gondor.apana.org.au>
References: <20190529224844.25203-1-richard@nod.at> <20190530023357.2mrjtslnka4i6dbl@gondor.apana.org.au>
Subject: Re: [RFC PATCH 1/2] crypto: Allow working with key references
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.8_GA_3025 (ZimbraWebClient - FF60 (Linux)/8.8.8_GA_1703)
Thread-Topic: crypto: Allow working with key references
Thread-Index: 6TFlo+ksej+abko/FbMI4LB7xy79pA==
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Herbert Xu" <herbert@gondor.apana.org.au>
> An: "richard" <richard@nod.at>
> CC: "Linux Crypto Mailing List" <linux-crypto@vger.kernel.org>, linux-arm-kernel@lists.infradead.org, "linux-kernel"
> <linux-kernel@vger.kernel.org>, linux-imx@nxp.com, festevam@gmail.com, "kernel" <kernel@pengutronix.de>, "Sascha Hauer"
> <s.hauer@pengutronix.de>, shawnguo@kernel.org, davem@davemloft.net, "david" <david@sigma-star.at>
> Gesendet: Donnerstag, 30. Mai 2019 04:33:57
> Betreff: Re: [RFC PATCH 1/2] crypto: Allow working with key references

> On Thu, May 30, 2019 at 12:48:43AM +0200, Richard Weinberger wrote:
>> Some crypto accelerators allow working with secure or hidden keys.
>> This keys are not exposed to Linux nor main memory. To use them
>> for a crypto operation they are referenced with a device specific id.
>> 
>> This patch adds a new flag, CRYPTO_TFM_REQ_REF_KEY.
>> If this flag is set, crypto drivers should tread the key as
>> specified via setkey as reference and not as regular key.
>> Since we reuse the key data structure such a reference is limited
>> by the key size of the chiper and is chip specific.
>> 
>> TODO: If the cipher implementation or the driver does not
>> support reference keys, we need a way to detect this an fail
>> upon setkey.
>> How should the driver indicate that it supports this feature?
>> 
>> Signed-off-by: Richard Weinberger <richard@nod.at>
> 
> We already have existing drivers doing this.  Please have a look
> at how they're doing it and use the same paradigm.  You can grep
> for paes under drivers/crypto.

Thanks for the pointer.
So the preferred way is defining a new crypto algorithm prefixed with
"p" and reusing setkey to provide the key reference.

Thanks,
//richard
