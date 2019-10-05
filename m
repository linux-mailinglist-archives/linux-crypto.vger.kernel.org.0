Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0FD5CCAC5
	for <lists+linux-crypto@lfdr.de>; Sat,  5 Oct 2019 17:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727980AbfJEPUr (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 5 Oct 2019 11:20:47 -0400
Received: from mout.web.de ([212.227.15.4]:39757 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725826AbfJEPUr (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 5 Oct 2019 11:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1570288821;
        bh=ZsBiWxP33gqgEWiBytp1B4ziRYQk5nXQ7/5GuWkBq3E=;
        h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
        b=rzPCXieVz001uGfTgq8V194L4msCMI1U3rZxLwTJeCBAoR7ZcCtgva/CFB4HdVgCj
         JM/VJIUz249K+SOPQjDw2bLkhx409M5vdXmYM/tiVI3HTwR0ycTyFq6wL3OXRXL+cq
         PA7lzfbqXut9VZ4rE0E6494uvZ8IH+BYcyBr5PoY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.178.111]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MfCyA-1iSNmp0fqU-00OqMQ; Sat, 05
 Oct 2019 17:20:21 +0200
Cc:     Navid Emamdoost <emamd001@umn.edu>, Kangjie Lu <kjlu@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20191004192923.17491-1-navid.emamdoost@gmail.com>
Subject: Re: [PATCH] crypto: user - fix memory leak in crypto_report
To:     Navid Emamdoost <navid.emamdoost@gmail.com>,
        linux-crypto@vger.kernel.org
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <9a7a96ce-7778-12b5-f844-25ba04e627b2@web.de>
Date:   Sat, 5 Oct 2019 17:20:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191004192923.17491-1-navid.emamdoost@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Provags-ID: V03:K1:Ov/6Jc669RyGtLr1MH3uF56NlB5JhTOyyDLjphTVS2rvAyVy1tJ
 fmseTOKWZ25Y3sWi6lVIxHiF/rq/JCTd/DASpCSxG4fBJGUmMmaLSFb8gCxfEMRvfKBD8nQ
 hNF+YyP1P/McoRhFNIMQrB4owMPr0kqiI1dX2VINF2Yho4E42VS+yutVnJ72ZLzUA9X/ip1
 OItEpi7G1qZdpd+6R4/nQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:yIzkyXYaBns=:izRFHlQR2mAGH52y9FQZ8s
 n3V6zxjOgUpkA3AGkY/0IQ/KiMVr2VrjI0Dj7mhdYLvt37rOeoUkDB+Qr28cBtEkoYylFUwdm
 Jk1cPLKIz0bfO0AHIcz2hNypISFXsOARPdSgRlAn/9tFf1Hw7Rwf+k0uicJ34T/0JR77mPdAn
 JW9dIZ1bNPrCfe+t3Q1Z8uLf8YJ1AoY1UjwoOTe5Mpyp+jqTjWTD6RwKMVSthdMi60pYcHbOf
 iZ8Ofo3sjWqbHYJww84csqQcBzTChzQztB1hvJmF6HRrvGwKvSRzg+6KieAIbYWD3XGxBTbWh
 gHsvDoMpnHS4fX8L5a7kImQQhCRC8318jLGLvnAFgC7z45DWAdIFxbsEKH6J3S5Cchvjpm2dd
 3ggqRMpPIffPZZc0oOUrUeHrFyr1o/+sJ3Lu9pUKszCX1HXxa5V7u9WoWIdFLm456MJSvq80X
 iYD0bgqqxcW4sisO/cQfqMSwgDNdohKFlX8Diswc7RPFKYRvaLXabk1kwR8u4ZUW0YXsGYId1
 RuTsJHa3FszlQmpqBEiZcMTkmtRqWekCWGhcXDKJ7mz2ciwEVIss5m9UqKNN7w+RVgebC+n6S
 SJN3UP2m7Z1vQaaf98eypr4qGWps086Qy4bjETAlHe13aSJyPu5omBPrL9NT3SR4uAgRAuLNB
 MMGPzn9pwElyT8eXlpRmqiqYpnT0Ivia2mK2hp/sbNOM3lJhQU3Ap8YwwNBA8n/x0T2BDh1Yu
 AR7VCapTqemvhPqoPj/eLPi/TNjjbecjGNOT9aULLzu4ngj6OhUANfAiLkESjxaqeb2XGp7My
 mxQmDITvh0t5BA48Pqk1D0xOwU1+RMRCGepqUQ7XI69KrrskPIgod3xfJBq9QVpfsunm6NrTz
 qT5IstJHblnOTE5nTor73ZCeOXU4j8z1lKZ/IdkLE7LG4gcXvUIY6BF90mgTrE0vKGz88LgvG
 o8CJAyzqJ8Ok0rBp4Zi4xlV+TwAdJFvmE086LThYyBhs5Su4yVifDP/A68s06ns+OzTsesFMw
 mgaV5o2qVOcLJCBT7MPhq0/0CN8cKkeOgkVc4spH54VrUI8zQujTeZ/kkkjAGNlFMDi1oaTet
 0faIcTkvbzioBZukzMKqYLZNAQvMlVVrm7Nmuz17XWtsxWDl5wER74K0yRLBUF/kShUtDdCSL
 04BnZkgcFCofqTwEIJnn4tWPAG6pyN5vcJEEQ8meivuv42zzGQgVQpWfr8vr2d59bwnml/LIR
 AB36+8ISDZxp4TH4hDDM1Z+iTlPA9UnFEUYsR2vYopRgDFgWn5XCbak/IGeM=
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

> In crypto_report, a new skb is created via nlmsg_new(). This skb should
> be released if crypto_report_alg() fails.

Please improve this change description.

Regards,
Markus
