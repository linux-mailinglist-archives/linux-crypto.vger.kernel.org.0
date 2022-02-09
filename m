Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 105674AEF70
	for <lists+linux-crypto@lfdr.de>; Wed,  9 Feb 2022 11:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiBIKjV (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 9 Feb 2022 05:39:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiBIKjT (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 9 Feb 2022 05:39:19 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4F5E14A956
        for <linux-crypto@vger.kernel.org>; Wed,  9 Feb 2022 02:26:33 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id c188so2465920iof.6
        for <linux-crypto@vger.kernel.org>; Wed, 09 Feb 2022 02:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=77VjFaGrxTZdHEhKSutyk5vNMmVEbAhzGOhaVYMGrnI=;
        b=j/p0q2baaQ9kN9+RGa5Rsq9j27PuAHtHddGjzgyHXr1uxlramz+Zrw7DceqgECL79+
         XXuSFCLNypcx9TsOsplvAS31hh3Cyjz78wey4gyEK3qJHJKRM9Bgd+TznURJ0/vDXJJK
         wYQLZNFm5fICnrlXKieLgZRTie01kN6P61lga5bTQI+LamXxPKH3gRyJS+FZlIRUM0dd
         MkePq/XR/zNl8R0W7lTiUQvCiDk2M5vrhUo4q4o4CmbtKa2DTp1L1hLuK7Qlvf/eIoD2
         phNChB87z6di3KDh72c5v6fgElEvebcjHnFcB4el1Bg0ksBDribNb+ehtk6AXlOCAb8S
         kbig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=77VjFaGrxTZdHEhKSutyk5vNMmVEbAhzGOhaVYMGrnI=;
        b=UtQ/FsMRF0j9f3dJoufnMlTB2wmaYRAp9cTd6WBuckr2w00FvJ03Z3U9/gKSKgo8xR
         Ey4KuJ4cUpU+liAYWrg2p+2EYJUZBa7yTZp+IlSBxb/NAVpFtlOtd7jXpb8UL+ZBezqX
         j9hPc74Ita6WmNN0wE4xex9hvX7E2VPx4gqvRpQBR3e0VIV9aVsWVoeJNyo4+GXUhR44
         am0PCE1gblc3/wXUdwkuhpxMEWuuaK85Am5HHzR+VjQLrE9v+LsP7c/Qf0rw5V3bM30m
         w5Iu0jBTMqIxdd2ihkDN4Vh2Urgu6NzlJ7fbt3PIPJ2ORf4pt8UwA6hG4GTvVrGdYNYz
         bsxg==
X-Gm-Message-State: AOAM532se38v+44Gl/U5eA8fgV9e2pnakf4zCcnSnflwNSFdsD8MQRcG
        G6DmSWqgkitRQOdAFoTVBHNEjkdoYnGaT4DzZ48=
X-Google-Smtp-Source: ABdhPJw1Fpm1Kf2G+20QneVdfiLncgcklyM+EY8VLk6IvkMENzdagKxf8sPi5U5uqdiMUjeXVFIRU8jSWGCW7YblL0w=
X-Received: by 2002:a05:6638:22b1:: with SMTP id z17mr671098jas.194.1644402389688;
 Wed, 09 Feb 2022 02:26:29 -0800 (PST)
MIME-Version: 1.0
Sender: hfgfjifjfhdfdfsgshijd@gmail.com
Received: by 2002:a5d:8d14:0:0:0:0:0 with HTTP; Wed, 9 Feb 2022 02:26:29 -0800 (PST)
From:   "mrs.sophia.robin" <mrs.sophiar.robin424@gmail.com>
Date:   Wed, 9 Feb 2022 11:26:29 +0100
X-Google-Sender-Auth: UdKOBpVnmj5y6yqA2fiMUUTDJl4
Message-ID: <CACG7aJNXjds-aj+W6cNnF8rBVYPoP=_A+rT1cLijUM3WYpZMQA@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.9 required=5.0 tests=ADVANCE_FEE_5_NEW_FRM_MNY,
        BAYES_50,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FILL_THIS_FORM,FILL_THIS_FORM_LONG,FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,
        MONEY_FRAUD_5,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_FILL_THIS_FORM_LOAN,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY,URG_BIZ autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d41 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5066]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [hfgfjifjfhdfdfsgshijd[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.6 URG_BIZ Contains urgent matter
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.1 HK_SCAM No description available.
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
        *  0.0 T_FILL_THIS_FORM_LOAN Answer loan question(s)
        *  0.0 ADVANCE_FEE_5_NEW_FRM_MNY Advance Fee fraud form and lots of
        *      money
        *  3.3 UNDISC_MONEY Undisclosed recipients + money/fraud signs
        *  0.3 MONEY_FRAUD_5 Lots of money and many fraud phrases
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hello

  i'm Mrs.Sophia Robin, a citizen of the united state of America, I
work at HSBC Bank in Milan Italy, as Telex Manager charge of wire
transfer department, i'm contacting you personally for investment
assistance and a long term business relationship in your Country. i'm
contacting you for an important and urgent business transaction, I
want the bank to transfer the money left by Dr.Cheng Chao, a Chinese
Politician who died, March 17th 2020, without any trace of his family
members, he used our bank to launder money overseas through the help
of their Political advisers. and most of the funds which they
transferred out of the shores of China, were gold and oil money that
was supposed to have been used to develop the continent.

Can you invest this money and also help the poor? The amount value at
$15.5million Dollars($US15,500,000),left in his account still
unclaimed,if you know that you are capable to invest this fund into
any profitable business in your country kindly send me your details
information as listed below to enable me draft you an application form
of claim along with the deposit certificate which you are going to
fill with your bank account detail necessary and contact the HSBC Bank
in Italy for immediate transfer of the Amounted sum into your bank
account direct. Percentage share will be 60,for me/40,for you.

(1) Your full name.....................
(2) Your address................
(3) Your Nationality...............
(4) Your Age/Sex.....................
(5) Your  Occupation.......................
(6) Your marital status........................
(7) Your direct telephone number..................
(8) Your photo..................

Thanks with my best regards.
Mrs.Sophia Robin, Telex Manager Milan Italy,(H.S.B.C)
