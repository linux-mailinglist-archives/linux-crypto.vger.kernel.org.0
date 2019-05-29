Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3AAFC2E1F6
	for <lists+linux-crypto@lfdr.de>; Wed, 29 May 2019 18:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfE2QHe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-crypto@lfdr.de>); Wed, 29 May 2019 12:07:34 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:23747 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726062AbfE2QHe (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 29 May 2019 12:07:34 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45DbFw05xMz9tyRL;
        Wed, 29 May 2019 18:07:32 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id T_NoBVU2oEcz; Wed, 29 May 2019 18:07:31 +0200 (CEST)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45DbFv6Lrkz9tyRF;
        Wed, 29 May 2019 18:07:31 +0200 (CEST)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
        id A00D183C; Wed, 29 May 2019 18:07:31 +0200 (CEST)
Received: from 37.170.135.142 ([37.170.135.142]) by messagerie.si.c-s.fr
 (Horde Framework) with HTTP; Wed, 29 May 2019 18:07:31 +0200
Date:   Wed, 29 May 2019 18:07:31 +0200
Message-ID: <20190529180731.Horde.NGHeOXuCgw23pVdGqjc0fw9@messagerie.si.c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Pascal Van Leeuwen <pvanleeuwen@insidesecure.com>
Cc:     linux-crypto@vger.kernel.org,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: Re: Conding style question regarding configuration
References: <AM6PR09MB3523ADF4617CB97D59904616D21E0@AM6PR09MB3523.eurprd09.prod.outlook.com>
 <CAKv+Gu8bReGWAUm4GrCg7kefVR7U0Z8XBt_GVV4WEvgOpCtjpA@mail.gmail.com>
 <AM6PR09MB3523B77DE66DD5353F08A687D21E0@AM6PR09MB3523.eurprd09.prod.outlook.com>
In-Reply-To: <AM6PR09MB3523B77DE66DD5353F08A687D21E0@AM6PR09MB3523.eurprd09.prod.outlook.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Pascal Van Leeuwen <pvanleeuwen@insidesecure.com> a écrit :

>> > Quick question regarding how to configure out code depending on a
>> CONFIG_xxx
>> > switch. As far as I understood so far, the proper way to do this is
>> not by
>> > doing an #ifdef but by using a regular if with IS_ENABLED like so:
>> >
>> > if (IS_ENABLED(CONFIG_PCI)) {
>> > }
>> >
>> > Such that the compiler can still check the code even if the switch is
>> > disabled. Now that all works fine and dandy for statements within a
>> > function, but how do you configure out, say, global variable
>> definitions
>> > referencing types that are tied to this configuration switch? Or
>> should
>> > I just leave them in, depending on the compiler to optimize them away?
>> >
>> > Obviously the code depends on those variables again, so if it's not
>> > done consistently the compiler will complain somehow if the switch is
>> not
>> > defined ...
>> >
>> > Also, with if (IS_ENABLED()) I cannot remove my function prototypes,
>> > just the function body. Is that really how it's supposed to be done?
>> >
>>
>> Yes. Code and data with static linkage will just be optimized away by
>> the compiler if the CONFIG_xx option is not enabled, so all you need
>> to guard are the actual statements, function calls etc.
>>
> Ok, makes sense. Then I'll just config out the relevant function bodies
> and assume the compiler will do the rest ...
>

No need to config out function bodies when they are static.
If not, it's better to group then in a C file and associate that file  
to the config symbol through Makefile

Christophe

> Thanks,
> Pascal van Leeuwen
> Silicon IP Architect, Multi-Protocol Engines @ Inside Secure
> www.insidesecure.com


