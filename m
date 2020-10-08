Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3922871F6
	for <lists+linux-crypto@lfdr.de>; Thu,  8 Oct 2020 11:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgJHJue (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 8 Oct 2020 05:50:34 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:53074 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729335AbgJHJud (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 8 Oct 2020 05:50:33 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C6RK24H26z9v0Jc;
        Thu,  8 Oct 2020 11:50:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id NUF0HJv3mLwk; Thu,  8 Oct 2020 11:50:30 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C6RK23TBvz9v0JY;
        Thu,  8 Oct 2020 11:50:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EE6C68B834;
        Thu,  8 Oct 2020 11:50:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id a4SYqGEfJIvK; Thu,  8 Oct 2020 11:50:30 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E45208B833;
        Thu,  8 Oct 2020 11:50:27 +0200 (CEST)
Subject: Re: [PATCH] crypto: talitos - Fix sparse warnings
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Kim Phillips <kim.phillips@arm.com>, linuxppc-dev@ozlabs.org
References: <20201002115236.GA14707@gondor.apana.org.au>
 <be222fed-425b-d55c-3efc-9c4e873ccf8e@csgroup.eu>
 <20201002124223.GA1547@gondor.apana.org.au>
 <20201002124341.GA1587@gondor.apana.org.au>
 <20201003191553.Horde.qhVjpQA-iJND7COibFfWZQ7@messagerie.c-s.fr>
 <20201007065048.GA25944@gondor.apana.org.au>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <1716ab93-cd9d-bbb3-a954-f3f8378da437@csgroup.eu>
Date:   Thu, 8 Oct 2020 11:50:21 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <20201007065048.GA25944@gondor.apana.org.au>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



Le 07/10/2020 à 08:50, Herbert Xu a écrit :
> On Sat, Oct 03, 2020 at 07:15:53PM +0200, Christophe Leroy wrote:
>>
>> The following changes fix the sparse warnings with less churn:
> 
> Yes that works too.  Can you please submit this patch?
> 

This fixed two independant commits from the past. I sent out two fix patches.

Christophe
