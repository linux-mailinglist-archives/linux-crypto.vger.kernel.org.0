Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7FE41BA1
	for <lists+linux-crypto@lfdr.de>; Wed, 12 Jun 2019 07:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbfFLFwS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 12 Jun 2019 01:52:18 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:64620 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725601AbfFLFwS (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 12 Jun 2019 01:52:18 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45NwxW2rMFz9v0lc;
        Wed, 12 Jun 2019 07:52:15 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=RBdMUJ9B; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id dBgxHB_AY2Yx; Wed, 12 Jun 2019 07:52:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45NwxW1jKtz9v0lL;
        Wed, 12 Jun 2019 07:52:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1560318735; bh=ohAp/YSXJJ0PS41E8peTUSFPOADBTv6CNhYclehwS+E=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=RBdMUJ9BIMIA2W6herx08iJdndrXtUWfahMDw0rDznctgcLh8nTtHlc62fud6SoT8
         iHNTY4o8nkhRbj1Ihknh4gnAqKO3IydSH/cBO22/OEN+erLaCu5smSuTLuwhUbO7Hy
         ZLV0v/g1glyhL9n8M6tbWaEGPr5dt1ZnvYe8Augc=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1D6468B802;
        Wed, 12 Jun 2019 07:52:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id BBvVVHRFsBJn; Wed, 12 Jun 2019 07:52:16 +0200 (CEST)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.230.107])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EB1C68B75A;
        Wed, 12 Jun 2019 07:52:15 +0200 (CEST)
Subject: Re: [PATCH v2 0/4] Additional fixes on Talitos driver
To:     Horia Geanta <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
References: <cover.1560263641.git.christophe.leroy@c-s.fr>
 <VI1PR0402MB34853CAF031426F4183FE29B98ED0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <0cb7c534-6e48-5284-899c-c0ef85c3c126@c-s.fr>
 <VI1PR0402MB3485AD965F36709F27EFB72698ED0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <58787543-76d3-e0db-9517-ccd0f6494d85@c-s.fr>
Date:   Wed, 12 Jun 2019 07:52:13 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <VI1PR0402MB3485AD965F36709F27EFB72698ED0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



Le 11/06/2019 à 18:30, Horia Geanta a écrit :
> On 6/11/2019 6:40 PM, Christophe Leroy wrote:
>>
>>
>> Le 11/06/2019 à 17:37, Horia Geanta a écrit :
>>> On 6/11/2019 5:39 PM, Christophe Leroy wrote:
>>>> This series is the last set of fixes for the Talitos driver.
>>>>
>>>> We now get a fully clean boot on both SEC1 (SEC1.2 on mpc885) and
>>>> SEC2 (SEC2.2 on mpc8321E) with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS:
>>>>
>>> I am getting below failures on a sec 3.3.2 (p1020rdb) for hmac(sha384) and
>>> hmac(sha512):
>>
>> Is that new with this series or did you already have it before ?
>>
> Looks like this happens with or without this series.

Found the issue, that's in 
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=b8fbdc2bc4e71b62646031d5df5f08aafe15d5ad

CONFIG_CRYPTO_DEV_TALITOS_SEC2 should be CONFIG_CRYPTO_DEV_TALITOS2 instead.

Just sent a patch to fix it.

Thanks
Christophe

> 
> I haven't checked the state of this driver for quite some time.
> Since I've noticed increased activity, I thought it would be worth
> actually testing the changes.
> 
> Are changes in patch 2/4 ("crypto: talitos - fix hash on SEC1.")
> strictly for sec 1.x or they affect all revisions?
> 
>> What do you mean by "fuzz testing" enabled ? Is that
>> CONFIG_CRYPTO_MANAGER_EXTRA_TESTS or something else ?
>>
> Yes, it's this config symbol.
> 
> Horia
> 
