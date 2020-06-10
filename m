Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 083961F58D2
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Jun 2020 18:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgFJQOp (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 10 Jun 2020 12:14:45 -0400
Received: from sonic303-2.consmr.mail.bf2.yahoo.com ([74.6.131.41]:36447 "EHLO
        sonic303-2.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727948AbgFJQOo (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 10 Jun 2020 12:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1591805682; bh=DPYuw2gUpgtMJzJhlH/AVmRGu2wSKCY1C+f8nOCoxu0=; h=Date:From:Reply-To:Subject:References:From:Subject; b=TNWjcv7C7KEz0MkGAWu6QC+YdnrTRykP4RDIlidGdONRf4iDAqpbUp1tBP5YyZ/YwQS+nrKyV/Z86AfdhuOkoCyKUD1WC4a+NRBo9oi43b7zoYZgUoGVs3CAlg0K8+/BNAMnry7u4a3QaccGLU3s6nq/uOQ9U7DJB3E5tfVjkI1Y/nf8CYpfdY81MlkHDIIXMPNnkSrdcWjj31DXPvw2Q0Lxf9q4WOpQMAp1ewlzNt30xU7Kk/Ljf7orTYgW1wNZwG7arJ7cgUU/FXYgo+hz+z3un7iKr8HZHuwswjnqpYTbaG7LHkGiN/qd9l+NoRnC7APFEpwEOq2Q7ZwCQbur3w==
X-YMail-OSG: tfIaHOgVM1n5muWHqH.9_jYistyMCWrxnxlnQuGL42SSe0FMETfe3p14bVlqbkU
 uxS5T66zUilzhcUayx23LPfPtY..Sd7q6HLYy0Mjrvyuu9zBMs7BhYn0TWbbzHl3bvmf2X1cXRfi
 zmlrlY49_4QdlROvYb4kbLrHvjQppNkqzHK9m1xSGtdB8zluStHuY2hOCS2rxjjKGHZhszJ5i3Sw
 me9uycqZVl27yJa8hCWnE1gmJRK7b_gscSvXsvLq_YNwhJoCue21KOBG9Dm3T1Rp5nqBFunq4P23
 fpiRRblwusSbekme1q50Uy2jqOU.pWjtf8NIjgmhIr198kUnjmX0pw_R9p0wpTSBRgXrCDdlOesK
 FVPDVIT0ZhQv_ic..3RqfQGmOmZptBF3u.zNoE81O8f7u5oMVM0akLNbCPWUr3j9dPHerrvaQIuU
 QwSiHyubk4Zo7WgwkWZ.pL3fjHxZikgluK2M4RK9Uxg.JXH0wemI_TboJwSRCzcbn5xCEuBxiVwU
 zHUKaa6OI8pWN6Q76mbpX8kNzmEKlvbgcfForQtZ5b7Rjo_8ATnhUebld2XW2td_0OVXHyCXLL7t
 a8IyDcvBxvqhAnfS.mBAGVtB8PVqfTxIlLffm_L6SaChRXv42Jn4t0tC9EAAghCqBrZ9tkzpgsF6
 tDUmbPCI1zw8ItntiSgmxBoAGQzVKU_7Vm1dss_P1nLpQtp0dsP.OXCtvorwWVJ0CffbfvdZpob7
 2u_a4LtRGMYCJVA0BL0kf9VLG537aJI6OfsSfdvHxuyGCCJpUftV1bjE.frhT.FtZg7Zh2L8s.QK
 8pe0699Kc3jgPMvUlLlQL20sxP3As9bXIqILrTauk6ncu12odLi3sADa1u32sHVHgShI2lVh8BS8
 LvTDubHUjwTYXvR2Vp1dXMeFpR1DnQdexGL8jAAzjW6bahLs7ehAcuBO2646oqUIM2Z6pk0opGb4
 3OjUlZ2Ze4iOjNoTX6_1lpQKHIYiEedIN.HsKNeVZLSWzI99eBObWcI111pwEmT3jrzs15Jj.Vji
 TMDEquh93mc70jhjw5P6wWTreBEdhTi59lMjmkDaLnsd2O8hDW6HKLUAqRHZ4tXULwoNAjMQHT95
 ux1wdaElIE_lkrCJfEZm8kwTMSMDHDaanApQ3jjRrP7koo6XmgtwAgH.uRjwbY0jsJ7sNAauJAZn
 vqlT_HNMXlGsAiG_ArWA4yxywNMJtbl6jJpYKv38LL_yA7gLYMAMCG7scZdQql62Wb4UJy3pHr9X
 9PGPQa.ICiJD1eTR1fuVg_o0GnK1RVsqDx_zkSNWFopQeROJHMMJwEm9vMe8bc_JZ8t60RNSojw-
 -
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.bf2.yahoo.com with HTTP; Wed, 10 Jun 2020 16:14:42 +0000
Date:   Wed, 10 Jun 2020 16:14:38 +0000 (UTC)
From:   "Mrs. Mina A. Brunel" <brunelminaa@gmail.com>
Reply-To: mrsminaabrunel63@gmail.com
Message-ID: <1845544144.1573631.1591805678398@mail.yahoo.com>
Subject: My Dear in the lord
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1845544144.1573631.1591805678398.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16072 YMailNodin Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.97 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



My Dear in the lord


My name is Mrs. Mina A. Brunel I am a Norway Citizen who is living in Burki=
na Faso, I am married to Mr. Brunel Patrice, a politicians who owns a small=
 gold company in Burkina Faso; He died of Leprosy and Radesyge, in year Feb=
ruary 2010, During his lifetime he deposited the sum of =E2=82=AC 8.5 Milli=
on Euro) Eight million, Five hundred thousand Euros in a bank in Ouagadougo=
u the capital city of of Burkina in West Africa. The money was from the sal=
e of his company and death benefits payment and entitlements of my deceased=
 husband by his company.

I am sending you this message with heavy tears in my eyes and great sorrow =
in my heart, and also praying that it will reach you in good health because=
 I am not in good health, I sleep every night without knowing if I may be a=
live to see the next day. I am suffering from long time cancer and presentl=
y I am partially suffering from Leprosy, which has become difficult for me =
to move around. I was married to my late husband for more than 6 years with=
out having a child and my doctor confided that I have less chance to live, =
having to know when the cup of death will come, I decided to contact you to=
 claim the fund since I don't have any relation I grew up from an orphanage=
 home.

I have decided to donate this money for the support of helping Motherless b=
abies/Less privileged/Widows and churches also to build the house of God be=
cause I am dying and diagnosed with cancer for about 3 years ago. I have de=
cided to donate from what I have inherited from my late husband to you for =
the good work of Almighty God; I will be going in for an operation surgery =
soon.

Now I want you to stand as my next of kin to claim the funds for charity pu=
rposes. Because of this money remains unclaimed after my death, the bank ex=
ecutives or the government will take the money as unclaimed fund and maybe =
use it for selfishness and worthless ventures, I need a very honest person =
who can claim this money and use it for Charity works, for orphanages, wido=
ws and also build schools and churches for less privilege that will be name=
d after my late husband and my name.

I need your urgent answer to know if you will be able to execute this proje=
ct, and I will give you more information on how the fund will be transferre=
d to your bank account or online banking.

Thanks
Mrs. Mina A. Brunel
