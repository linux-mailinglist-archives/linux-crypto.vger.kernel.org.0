Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A660249103
	for <lists+linux-crypto@lfdr.de>; Wed, 19 Aug 2020 00:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgHRWjS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 18 Aug 2020 18:39:18 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:57770 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbgHRWjR (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 18 Aug 2020 18:39:17 -0400
Received: from [192.168.254.6] (unknown [50.34.202.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 648A613C2B0;
        Tue, 18 Aug 2020 15:39:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 648A613C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1597790356;
        bh=PBmYFasOCVtx+UPxbhUdhy7A+e7F9Z0a3A+8NonFu+k=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=SG/8WyFRelQ+Ar2iZWg6PuR+Gbw4kYvvuyiVphy+ppi/L4LQqmSmjCplGNcQQMo7d
         An8xcxGdVvql6WGZtxPs/U8xETfe4wCRBGWrgB91kC5jxK+VPih3HH3Ce3EBXqy19+
         eE/yuApxaKgNydC+2/3/2UIZSh1A1Jed+41cV1ak=
Subject: Re: [PATCH 0/5] crypto: Implement cmac based on cbc skcipher
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@kernel.org>
References: <20200802090616.1328-1-ardb@kernel.org>
 <20200818082410.GA24497@gondor.apana.org.au>
 <CAMj1kXFOZJFUR0N+6i2O4XGZ462Mcs8pq7y_MYScfLf-Tfy3QQ@mail.gmail.com>
 <20200818135128.GA25652@gondor.apana.org.au>
 <2aad9569-877e-4398-88ef-e40d9bbf7656@candelatech.com>
 <20200818140532.GA25807@gondor.apana.org.au>
 <be188471-b75f-d2e2-d657-265a1cd9831b@candelatech.com>
 <20200818221550.GA27421@gondor.apana.org.au>
 <20200818222719.GA27622@gondor.apana.org.au>
 <bee1a9ce-25d1-2520-5f6a-3966bfa501d2@candelatech.com>
 <20200818223359.GA27712@gondor.apana.org.au>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <8b248ef3-d4c7-43fd-6ae4-1c3381597579@candelatech.com>
Date:   Tue, 18 Aug 2020 15:39:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818223359.GA27712@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 8/18/20 3:33 PM, Herbert Xu wrote:
> On Tue, Aug 18, 2020 at 03:31:10PM -0700, Ben Greear wrote:
>>
>> I don't think it has been discussed recently, but mac80211 is already
>> a complicated beast, so if this added any significant complexity
>> it might not be worth it.
> 
> Any bulk data path should be using the async interface, otherwise
> performance will seriously suffer should SIMD be unavailable.  I
> think someone should look at converting wireless to async like IPsec.

Most users in most cases are using hw crypt, so that is likely why
it hasn't gotten a huge amount of effort to optimize the software
crypt path.

If someone wants to give this async api a try for mac80211, I can
test, and I can sponsor the work, but I don't have time to try
to implement it myself.

Thanks,
Ben

> 
>> Truth is though, I know very little about what changes would be
>> needed to make it do async decrypt, so maybe it would be a simple
>> matter?
> 
> IPsec was actually quite straightforward.
> 
> Cheers,
> 


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
