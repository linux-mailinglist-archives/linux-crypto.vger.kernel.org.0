Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6076E5CC8F
	for <lists+linux-crypto@lfdr.de>; Tue,  2 Jul 2019 11:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfGBJX0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 2 Jul 2019 05:23:26 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:50270 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbfGBJX0 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 2 Jul 2019 05:23:26 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 45dJgt0lkkz9tyW5;
        Tue,  2 Jul 2019 11:23:22 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=eXf1y6ts; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id C_iwf4exc7f3; Tue,  2 Jul 2019 11:23:22 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 45dJgs6n7Gz9tyW2;
        Tue,  2 Jul 2019 11:23:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1562059401; bh=gVoERgHKIFk4OuIIk75HX0yexcvpcXiFS6/Z652gKOw=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=eXf1y6tseVQAs4TEQD11CqLfSxdQlnYWjn+j76vNRu8bfRbKoZREH4ty5W+7+2UB0
         55ISWPeXYaBpsQwxsORmoSj/bRb2XPN1Di3NGj3RQzhLcuUDqP/HuYne6UnewbkrEI
         8G/drzNyxlqXW9DHHFS5B++DE5bYHmBhcpSm7sTw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D1AE88B7E5;
        Tue,  2 Jul 2019 11:23:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TU2F78_MYv5d; Tue,  2 Jul 2019 11:23:23 +0200 (CEST)
Received: from [192.168.4.90] (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CAFE58B7E1;
        Tue,  2 Jul 2019 11:23:22 +0200 (CEST)
Subject: Re: [PATCH v5 0/4] Additional fixes on Talitos driver
From:   Christophe Leroy <christophe.leroy@c-s.fr>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, horia.geanta@nxp.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
References: <cover.1561360551.git.christophe.leroy@c-s.fr>
Message-ID: <e011f5a3-2be3-90c9-4723-a2b16d6d56ac@c-s.fr>
Date:   Tue, 2 Jul 2019 11:23:22 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <cover.1561360551.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hi Herbert,

Le 24/06/2019 à 09:21, Christophe Leroy a écrit :
> This series is the last set of fixes for the Talitos driver.

Do you plan to apply this series, or are you expecting anythink from 
myself ?

Thanks
Christophe

> 
> We now get a fully clean boot on both SEC1 (SEC1.2 on mpc885) and
> SEC2 (SEC2.2 on mpc8321E) with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS:
> 
> [    3.385197] bus: 'platform': really_probe: probing driver talitos with device ff020000.crypto
> [    3.450982] random: fast init done
> [   12.252548] alg: No test for authenc(hmac(md5),cbc(aes)) (authenc-hmac-md5-cbc-aes-talitos-hsna)
> [   12.262226] alg: No test for authenc(hmac(md5),cbc(des3_ede)) (authenc-hmac-md5-cbc-3des-talitos-hsna)
> [   43.310737] Bug in SEC1, padding ourself
> [   45.603318] random: crng init done
> [   54.612333] talitos ff020000.crypto: fsl,sec1.2 algorithms registered in /proc/crypto
> [   54.620232] driver: 'talitos': driver_bound: bound to device 'ff020000.crypto'
> 
> [    1.193721] bus: 'platform': really_probe: probing driver talitos with device b0030000.crypto
> [    1.229197] random: fast init done
> [    2.714920] alg: No test for authenc(hmac(sha224),cbc(aes)) (authenc-hmac-sha224-cbc-aes-talitos)
> [    2.724312] alg: No test for authenc(hmac(sha224),cbc(aes)) (authenc-hmac-sha224-cbc-aes-talitos-hsna)
> [    4.482045] alg: No test for authenc(hmac(md5),cbc(aes)) (authenc-hmac-md5-cbc-aes-talitos)
> [    4.490940] alg: No test for authenc(hmac(md5),cbc(aes)) (authenc-hmac-md5-cbc-aes-talitos-hsna)
> [    4.500280] alg: No test for authenc(hmac(md5),cbc(des3_ede)) (authenc-hmac-md5-cbc-3des-talitos)
> [    4.509727] alg: No test for authenc(hmac(md5),cbc(des3_ede)) (authenc-hmac-md5-cbc-3des-talitos-hsna)
> [    6.631781] random: crng init done
> [   11.521795] talitos b0030000.crypto: fsl,sec2.2 algorithms registered in /proc/crypto
> [   11.529803] driver: 'talitos': driver_bound: bound to device 'b0030000.crypto'
> 
> v2: dropped patch 1 which was irrelevant due to a rebase weirdness. Added Cc to stable on the 2 first patches.
> 
> v3:
>   - removed stable reference in patch 1
>   - reworded patch 1 to include name of patch 2 for the dependency.
>   - mentionned this dependency in patch 2 as well.
>   - corrected the Fixes: sha1 in patch 4
>   
> v4:
>   - using scatterwalk_ffwd() instead of opencodying SG list forwarding.
>   - Added a patch to fix sg_copy_to_buffer() when sg->offset() is greater than PAGE_SIZE,
>   otherwise sg_copy_to_buffer() fails when the list has been forwarded with scatterwalk_ffwd().
>   - taken the patch "crypto: talitos - eliminate unneeded 'done' functions at build time"
>   out of the series because it is independent.
>   - added a helper to find the header field associated to a request in flush_channe()
>   
> v5:
>   - Replacing the while loop by a direct shift/mask operation, as suggested by Herbert in patch 1.
> 
> Christophe Leroy (4):
>    lib/scatterlist: Fix mapping iterator when sg->offset is greater than
>      PAGE_SIZE
>    crypto: talitos - move struct talitos_edesc into talitos.h
>    crypto: talitos - fix hash on SEC1.
>    crypto: talitos - drop icv_ool
> 
>   drivers/crypto/talitos.c | 102 +++++++++++++++++++----------------------------
>   drivers/crypto/talitos.h |  28 +++++++++++++
>   lib/scatterlist.c        |   9 +++--
>   3 files changed, 74 insertions(+), 65 deletions(-)
> 
