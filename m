Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A8B88248725
	for <lists+linux-crypto@lfdr.de>; Tue, 18 Aug 2020 16:17:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgHRORl (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 18 Aug 2020 10:17:41 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:38644 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgHRORh (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 18 Aug 2020 10:17:37 -0400
Received: from [192.168.254.6] (unknown [50.34.202.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id CEE1713C2B0;
        Tue, 18 Aug 2020 07:17:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com CEE1713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1597760257;
        bh=KIzHoTBPXScNDkgRBTc//Tk16Di90O2SsNKgcbkuZ1U=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=AddjnMMAxZ4vFknsl9XObrE7Crma/60tHxNqctl22V1inhwUXWI/OIoepriL39C+p
         NLoKuL/Gdj7ewEp526iXfngfZ87HmvGzpv9Sj0QGR+N47E5O40HQwQO2F7S9phB5Pj
         hXlqMlydf7Wfx+bIslG/Hq1XOz4UVMx+Ej2ujDSI=
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
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
Message-ID: <be188471-b75f-d2e2-d657-265a1cd9831b@candelatech.com>
Date:   Tue, 18 Aug 2020 07:17:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200818140532.GA25807@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 8/18/20 7:05 AM, Herbert Xu wrote:
> On Tue, Aug 18, 2020 at 06:56:12AM -0700, Ben Greear wrote:
>>
>> Herbert, thanks for working on this.  If I apply the patches you posted,
>> that is expected to provide wifi aes decryption speedup similar to what
>> the original patch I sent does?  Or, are additional patches needed?
> 
> It depends on whether the wifi code uses the async ahash interface,
> if not it probably won't make much of an impact at all.
> 
> I just checked and if the code you're using is net/mac80211/aes_cmac.c
> then it's using shash so it won't really benefit from this.  However,
> there's no reason why mac80211 can't be converted over to async as
> we did for IPsec.

I think converting it to async is beyond what I have time to work on
and not sure if it would be accepted upstream anyway.

Is there any easy way to use your work to make shash fast for aesni?  I
basically just want it to perform as well as it used to with my patch.

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
