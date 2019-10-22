Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05A41DFD63
	for <lists+linux-crypto@lfdr.de>; Tue, 22 Oct 2019 08:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730962AbfJVF7f (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 22 Oct 2019 01:59:35 -0400
Received: from sonic307-10.consmr.mail.ne1.yahoo.com ([66.163.190.33]:41846
        "EHLO sonic307-10.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726024AbfJVF7f (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 22 Oct 2019 01:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1571723974; bh=sgFa7Cs4ss6n8sA+brLiAjHMpjB11xRWsbVGUlCB1X4=; h=Date:From:Reply-To:Subject:From:Subject; b=cJfc5DKTY036mtOVS6jV4Wy1Blp86A4/+7I0knul/lL25Jt5JNJA3oH9tnkN1Zh7J0fdO+OQp5Z4twLhu5W5vnX8ynCnMEHMBJaKj1r0nsNPoRJTtEE3dJ7bQaxoUDTY86bVX6haJWYqPhbqZIrg1wjR3v0s/l+uu38xPbQOVi7VQe9KS4I1VfP+8Osj80QNb5TbVo98VCif1wLbD/TcYqMGx38Mny9zWRhZunXgqRTlkdFCYRF0Q+Uopv5OntnRbPz3GcIu7bVTIWXUyJLno8Wik8paOCQ/PJztdVajRvn1azO98cctlLQt7L7Z/m1DBzwIFbIs8Cd891DaVwyyjQ==
X-YMail-OSG: o4gbiz0VM1l60ASzreMZl9rMCzMNdQw9rsVmyUng8SBmnEV3F4LTYlIAlsnxqWs
 y0JFPN10srPtZVYtD6mFdGMhK.Oi_Zrzz7qsz6w3_euhUZ.Ii0jbA6HUkxfm4LWce3gQi9eObdrQ
 G2Ze2PPV5d9M4jmzMRjiO8E.8wR9ZT3VjdCEDNjG9s1VBJuSoqmMCz84qTqE8J9agC2AmEJ79_xM
 7hD3KSsDIHyjXenYI8tCxIKe1UwJr250A37pLa5jaODGDhnhBcRs6N4a8Q6gTb1ND.saBCPbz69L
 7yfTIC0sB2kHYYSfYBoMzkb0rTImlYSYiXNaHDH0H6nSKhJ1bB29NgPWWmNe4q_xWXISUPe..Kwc
 AM2p21AjiH5Ahs0xAIytRklOEYQAEd2EFQj9Sah5.ZDmJBXso6kTyFFXWWJ6iRBw2KDHXVGvQ_H9
 niYkn78w.OXRVas2pQM1CkJmsTU1M6mw0IfumECBXZACLsySi2ot7ds9VOYZmrl0ThBs7hn11qHR
 AyPGWtIrfYiamMl2LTWC7sYNX4rwuIPtT7GXz9sUHjAr2KEER_6WlPqJ6fh5lIrfpAG9byxR_0fu
 8F69L5SCG1cqqx23Is2WVnfMGtJUXHQ0q9mLNuHud1tsY8.0D5.LW2lefMJfGGLbETnvHfZ.lCxK
 upivinkhBbIFB76SSp95EgrcpUBzMnhOi8ffTN26us4CvbDKrmw1J6SRWXL48h129a7jTr7k6n6u
 9XXl1RnZjkVIJLKNBqPuJF9KnQAsFVtvYIL9di7ts2cB0ldqtJMRAgwk77D1wt.BQK3Mgoi4ZgJa
 bje3nxi_WQSqewxrtSpqm3sQ8nVsz0VzGwH_IM6TTA.KrYWv3PHLDeYEn4UhoOifJZ9T_b1y_ooA
 SwDBVpPMMU9T.Lkh9g4qeNmRTmp9R_yy5JelCO.2hjMoYKIyx1wX92BPbA3Ypcv0RMRKInP3PoVd
 f0ASRUQrqZNsXgKsf.KIeOVtZ7Q_iilrPyq6ZiyuHp8gwdaK983t1DXMURwYQzw5LKNeZjIJX.YZ
 O3PyqWTt2aTWzlhj8HaNh_3Nqx5w40CwKEbEU3gK6zweC6Ar9O2170KdsZBEQeCHvbFEyik9_I_2
 waE7vRyEA6TcQIKezAUpa0Iub48ZOu7aEkzmYZOdntLAZlO88MgbkOuJaBeRI_mNT2P8t8mUWnur
 nE.rDm3jbcwnfqsAWl7A8wGhu.4mOtZXsI1hBrp.Gov_lcPOzXnkxGhW4GJ_pNoMSjFGrm0FmRig
 moQq73BhpBCtGgwleadc0MWnI46ftoJCz.ka8Pfc5LmOwN5dB.yEFBZjkFW3oR2hKo3Tg0NzUfFK
 Vp5w0h24-
Received: from sonic.gate.mail.ne1.yahoo.com by sonic307.consmr.mail.ne1.yahoo.com with HTTP; Tue, 22 Oct 2019 05:59:34 +0000
Date:   Tue, 22 Oct 2019 05:59:34 +0000 (UTC)
From:   "Dr.Youssef Bakary" <mrs.nathaliehamon777@gmail.com>
Reply-To: dr.youssefbakary1960@gmail.com
Message-ID: <192586276.188201.1571723974056@mail.yahoo.com>
Subject: Dear Friend
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Dear Friend

I am Dr. Youssef Bakary, I Have a Business Proposal of $5.3 million For You=
.
I am aware of the unsafe nature of the internet, and was compelled to use t=
his medium due to the nature of this project. I have access to very vital i=
nformation that can be used to transfer this huge amount of money, which ma=
y culminate into the investment of the said=20
funds into your company or any lucrative venture in your country.
If you will like to assist me as a partner then indicate your interest, aft=
er which we shall both discuss the modalities and the sharing percentage.Up=
on receipt of your reply on your expression of Interest
 I will give you full details, on how the business will be executed I am op=
en for negotiation.=20
Thanks for your anticipated cooperation.
Note you might receive this message in your inbox or spam or junk folder, d=
epends on your web host or server network.

Thanks=E2=80=99
Best Regards
Dr. Youssef Bakary,
