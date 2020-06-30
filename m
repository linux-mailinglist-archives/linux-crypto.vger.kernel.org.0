Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D18FD20F007
	for <lists+linux-crypto@lfdr.de>; Tue, 30 Jun 2020 09:58:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbgF3H6o (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 30 Jun 2020 03:58:44 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:34386 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730067AbgF3H6n (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 30 Jun 2020 03:58:43 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 05U7wV0k054893;
        Tue, 30 Jun 2020 02:58:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1593503911;
        bh=nvfL5poyGys3W+9W9HLXNoQ7ZHq7SSfDdzA2HrYk/Ek=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=JnlsUt/z10Wzq/ogg6QDAsjOxeiUS1QF/z4UM0YKpgz+cajUR6Y7VNGJlXlsYbuye
         mVUE4R33nqR04+qPZlVcW7zxRiOWHK4CEOUx9UJGARJx6Coq/LM2PvDs51ztezVySc
         +93o7JOdPOmWHcIwE4RyVfLjbmvH50iqM9zx5+cU=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 05U7wVG7015191
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jun 2020 02:58:31 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 30
 Jun 2020 02:58:31 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 30 Jun 2020 02:58:31 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 05U7wSUt096565;
        Tue, 30 Jun 2020 02:58:29 -0500
Subject: Re: [PATCHv4 3/7] crypto: sa2ul: add sha1/sha256/sha512 support
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     <davem@davemloft.net>, <linux-crypto@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <j-keerthy@ti.com>
References: <20200615071452.25141-1-t-kristo@ti.com>
 <20200615071452.25141-4-t-kristo@ti.com>
 <20200626043155.GA2683@gondor.apana.org.au>
 <2a89ea86-3b9e-06b5-fa8e-9dc6e5ad9aeb@ti.com>
 <20200630044936.GA22565@gondor.apana.org.au>
 <b8c209cd-2b5d-54e4-9b64-94e5d1f0e60c@ti.com>
 <20200630074645.GA2449@gondor.apana.org.au>
 <ea76dad4-a29d-d211-edee-52f3699c8ab7@ti.com>
 <20200630075435.GA3885@gondor.apana.org.au>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <0a07585c-af4a-f08b-af5a-232cb4c351d4@ti.com>
Date:   Tue, 30 Jun 2020 10:58:28 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200630075435.GA3885@gondor.apana.org.au>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 30/06/2020 10:54, Herbert Xu wrote:
> On Tue, Jun 30, 2020 at 10:52:57AM +0300, Tero Kristo wrote:
>>
>> How about making the buffer size configurable during probe time via module
>> param, and/or runtime via sysfs parameter? This would allow system designers
>> to tune it based on expected usecases.
> 
> Why do you even need to support this? What's the use-case?

Openssl uses init->update->final sequencing, and it would be nice to 
have this use crypto accelerator. Otherwise we basically support cipher 
acceleration from openssl, but not hashing.

> FWIW IPsec only uses digest.

IPSec only uses digest yes, this is not an issue.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
