Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 129C9293A15
	for <lists+linux-crypto@lfdr.de>; Tue, 20 Oct 2020 13:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392324AbgJTLdi (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 20 Oct 2020 07:33:38 -0400
Received: from sonic311-23.consmr.mail.ne1.yahoo.com ([66.163.188.204]:34585
        "EHLO sonic311-23.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392316AbgJTLdi (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 20 Oct 2020 07:33:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603193617; bh=YfdJmkgyAelV91TRnp6plxiix9tzbdDcoL6irU7Kg4w=; h=Date:From:Reply-To:Subject:References:From:Subject; b=nRmxdcUDQ6C+z2V0tbNcebtzFcJfTxOi9pjMtQ5XBFdPESaqM1SkDVT84aU7jl0XOHcvCaVKzVU5rUCJzjetCP1/A0ArICMh37fLazikzP2f6p5jS81iia72CSSokhLAfkrDa11/+4Id7mU8HFi1LlN4piipuISw4qhFYqdn05DVLyUrzjySFrWPu1FuBWvztWZZLgOVlYihBC/CsfNUZMd4tXkz3tcIiaLgG/zpknXD0RD0PxXQU5LB/jiavg6/Z8gDjmtsVaOTTjE+B62iWdZF942cAaA0RetzMsZp64F1CY5u4GsZNkS1CwqvWs4jAUoGUcExnNzv/MSZqa/XeQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1603193617; bh=pp60LanEF6VuvbiIlVH3SP5+hqV1MDnoM/MmlNAivLF=; h=Date:From:Subject; b=fX6s7YSpYk6pAayoX7kNGO6lHJJC2Ju16QQqK0KEw0yMlqWrWO1LOhchtTDZO87cmf/Of8r4vKBRNqUMiYtC2o6IsXvZ1XgyxJSds3OqteCG63DgUenlbJjBPFg8OvU5v/cfrkfOysZ1YztWeU7HmKC0rREEYCmRZ6oSQrRrAqyFDSUC88pxP1iijM2eCNiKlLIcBO+3VqnT333zQit3ZTgR5fkVKK1p+LZhDgTDkWoqQIce/pB5vOQGfWd1zF+R1kmc8ON6MpFy+LIaYuuqtNPMPAnzk4XIfdI0SpTkf59ERYu7yHvQPPUTanjUXh3BARKPFgvylvTKxO1Y8V7K5w==
X-YMail-OSG: 2_wY0eUVM1mKOgrmm2ZaVbNo.t6uQFvKTekNmyrzST4V2Tw0qvjwKe0zY9np1rL
 6J4qs3dh9jYcqCDApYfupAnbvxYoXSbSmzTd0h8VceWwQLSz5kmI3vQcuQBecFMbOJ7kylGAZPSn
 un_88LpO4HvzqLXMg9f4uxe5OsaIG.EqfmQeJXlJ9nDBQTHMMjqJf.LdmoqdE4ZZ_Jbi1GcW62pj
 XNIi0j_MNGZIPtbcF._7XqKQVRJZRzHp3aP.Dpy56_LCXd0uqSR8SkGN9Eg7WDvBK0.YnnRmxIMJ
 hjU1joeXBTPiGZHeEoDDZxzbPpzY.KR2aLY7BP6GX.Uqlpt2VMHwbfrCuKcYp2xWy7Et1bi_fsss
 5F8sZCGOmMIYH.PG5St3e49Olz2SL9UckqOw4VhPcfM_jT.ikeuUFySKpjkeUyvFxrWnf_YpRqxY
 3MCQNyPtAOrHLtdh4YVe2Af1VAE4HAWAH7KFe92B7me3R37Ju4e5eQVPYzhicVr1Ign3K5kanNmG
 c3Bh9gXnulIvBS0RVAnz0TQDptUFOxsmmXsCVxnIshuFy_jzNI4PKfq_VHJ4DxkFWAhpR7hpxUFf
 Nm_eGJpPfMECKoABevEYvuSLjwPEAVo4KfvRZJg8ridmfQxiUDgZaSro5d9mCKKtZEQwZbnSYdZp
 d3XpKJ_LcGKKESa49yec7T6YJr6jHIKmFNb2udUrtGt4mzPvSnxgS7ox6IBCMzS_zshSqLHOmzz6
 sLzhJ4zUYn9Gr5Z0zi0LqHsUZ7GFVBj5CbadKQWjPWuACw5zqIjAEcfclNGeJgY5V9ecznU0FnrS
 j6.RlOk2LYtMy7Q_IzFqiZoCK7oPhV7qo1FLPey4ljD04tD.6ZDi6WXD3DNV7wZeyFltBbymYl7B
 8gEKzCf_3XUlv8nm5MGPLkiGeIHleLD_57b_Bu8W_3ewOo8aPddph5_ScaUqTsXx3u0hEU_98KC3
 53NNsE9vGaAFGE09fhJtVUaDLlCixPyTyURKUr7QIZ.7cCg1IEJz09FF6Db4WtQuMNTUYiec35wm
 hEI1LQV4d570MlsxQ63lxh_Q71YjvpcUjFci.aEFoUu5Iq5NgwRyqau9i5.W7Bp0MJQ5p02Rpujs
 1WHB68B7.1_5MF8aSvjEqO9.5VHLVtn0Q5eV50dBb__sqyUpvyp25WBMrYik8B0.jbmXqy7G6_ht
 tkRpPAgcjbt1tXtRNSQOe7NvP3zhADjp_eVL1IMm2fcyf.wnUbRtfw626cBavd_bqmkNWMfHBDZJ
 LDX042HWFLNZDOP0Q_sQHf8CjVyullmEqimT0GWQ4q8Bfm30Wp8L3xyiqqc637.Zl1I4ixImDeAf
 SLf4uczA__Q53ECtkCTlLHkWD42JofLM8P5vd6sdHsYWJcaNyS9EmjgqYyc4omrho__wadAYwISn
 lP3RoE8vqV13L9klCnMiOdaXOETbjLqJgiTHwHp1Ipus.
Received: from sonic.gate.mail.ne1.yahoo.com by sonic311.consmr.mail.ne1.yahoo.com with HTTP; Tue, 20 Oct 2020 11:33:37 +0000
Date:   Tue, 20 Oct 2020 11:33:35 +0000 (UTC)
From:   "Mr.Mohammed Emdad" <gerasimmelkumyan9@gmail.com>
Reply-To: mohammedemdadmohammedemdad77@gmail.com
Message-ID: <1222225440.1441422.1603193615526@mail.yahoo.com>
Subject: URGENT
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
References: <1222225440.1441422.1603193615526.ref@mail.yahoo.com>
X-Mailer: WebService/1.1.16868 YMailNodin Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/86.0.4240.75 Safari/537.36
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org



Dear Friend,


My name is Mr.Mohammed Emdad, I am working with one of the prime bank in Bu=
rkina Faso. Here in this bank there is existed dormant account for many yea=
rs, which belong to one of our late foreign customer. The amount in this ac=
count stands at $13,500,000.00 (Thirteen Million FiveHundred Thousand USA D=
ollars).

I need a foreign account where the bank will transfer this fund. I know you=
 would be surprised to read this message, especially from someone relativel=
y unknown to you But do not worry yourself so much.This is a genuine, risk =
free and legal business transaction. I am aware of the unsafe nature of the=
 internet, and was compelled to use this medium due to the nature of this p=
roject.

There is no risk involved; the transaction will be executed under a legitim=
ate arrangement that will protect you from any breach of law. It is better =
that we claim the money, than allowing the bank directors to take it, they =
are rich already. I am not a greedy person, Let me know your mind on this a=
nd please do treat this information highly confidential. I will review furt=
her information=E2=80=99s / details to you as soon as i receive your positi=
ve reply.

If you are really sure of your integrity, trust worthy and confidentiality,=
 kindly get back to me urgently.

Note you might receive this message in your inbox or spam or junk folder, d=
epends on your web host or server network.

Best regards,

I wait for your positive response.

Mr. Mohammed Emdad
