Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19A151ED035
	for <lists+linux-crypto@lfdr.de>; Wed,  3 Jun 2020 14:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725948AbgFCMxM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 3 Jun 2020 08:53:12 -0400
Received: from lelv0142.ext.ti.com ([198.47.23.249]:49034 "EHLO
        lelv0142.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFCMxM (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 3 Jun 2020 08:53:12 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 053Cr7ir112440;
        Wed, 3 Jun 2020 07:53:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1591188787;
        bh=0OGsFADQRIEJ+pAa1MD7cm0xqXOql1SA1/wVh+jJtlU=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=ZfR6RnHaKN3SQLpqPrPM3JLgo/vKQ7EqBf03kzH1yyUJaVV25jt2dFbWOlnFsMseD
         kVPZyLr7wXVhXRXqtZb1N3b6XMdae9T7ah+wMA+6xtn0HhOTI+skrf452HWE+MNnQ0
         ZoKIOCUPAUG4ZwMfQrRBTvMdBFX7sNtYfIeVqjVw=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 053Cr7V3092900;
        Wed, 3 Jun 2020 07:53:07 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 3 Jun
 2020 07:53:06 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Wed, 3 Jun 2020 07:53:06 -0500
Received: from [127.0.0.1] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 053Cr4Rp115475;
        Wed, 3 Jun 2020 07:53:05 -0500
Subject: Re: [PATCHv3 1/7] dt-bindings: crypto: Add TI SA2UL crypto
 accelerator documentation
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     Rob Herring <robh@kernel.org>, <davem@davemloft.net>,
        Keerthy <j-keerthy@ti.com>, <devicetree@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>
References: <20200511215343.GA10123@bogus>
 <20200514125005.23641-1-t-kristo@ti.com> <20200528152341.GA103581@bogus>
 <a75b48ad-ecc0-89bc-f6a2-7149bc3fefb0@ti.com>
 <20200603122726.GB31719@gondor.apana.org.au>
 <18c28e88-e3a7-2ec4-1d0c-f4d4163aff1c@ti.com>
 <20200603123914.GA31840@gondor.apana.org.au>
From:   Tero Kristo <t-kristo@ti.com>
Message-ID: <7ab12b04-6cea-38a7-4c0c-56aefaebf3d4@ti.com>
Date:   Wed, 3 Jun 2020 15:53:03 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603123914.GA31840@gondor.apana.org.au>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On 03/06/2020 15:39, Herbert Xu wrote:
> On Wed, Jun 03, 2020 at 03:38:03PM +0300, Tero Kristo wrote:
>>
>> Also I guess this should be posted against 5.8-rc1 once it is out, as merge
>> window is already open. Or are you planning to pick it up for 5.8 already?
> 
> Sorry this is going to be in the next merge window.
> 

Ok np, I will re-post once 5.8-rc1 is out.

-Tero
--
Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki. Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
