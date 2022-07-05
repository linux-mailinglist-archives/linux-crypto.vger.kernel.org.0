Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BA756752C
	for <lists+linux-crypto@lfdr.de>; Tue,  5 Jul 2022 19:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiGERGx (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 5 Jul 2022 13:06:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbiGERGx (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 5 Jul 2022 13:06:53 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3FBE1AF12
        for <linux-crypto@vger.kernel.org>; Tue,  5 Jul 2022 10:06:51 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id i17so10548599ljj.12
        for <linux-crypto@vger.kernel.org>; Tue, 05 Jul 2022 10:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=dGlJ2b6dTdxtV9BGYneAT3iQJU7I0ErF0JUELERQqlE=;
        b=lRlsNPIc2EWzBLrrYSm1+Ka8MHIlzVTqQ/osvSQMzFQp4RdtEMbRKNTCRio/bIj8Ws
         3T0wUQF363xs+/uQXzBmUNTFH6POoeybEzHQ7BY0JMiJ0hORzt4hDRU4aEHJo+Lc99wJ
         Qajnfk+wscn9+3m1WVT4yR9nZqEagDzIYmSyn4R8W2zKe8jODWj+77xm7OhsfaJgP6o7
         hawMKSDlcfbukvovxGcs2llAQI9i5IrMDnneQvrJj7iMo+McNs319eBxlFd1WNlffWbV
         +a9GgNJNa+e0AJrPMZpkccbLPRYhy/khzhc1N+i4V/t/L8bVQbdO9J9Nj+hGJ3cWerGp
         gFjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=dGlJ2b6dTdxtV9BGYneAT3iQJU7I0ErF0JUELERQqlE=;
        b=uLK0e0Dhh6bnYQ/Uss4D7GNUVx2JlfgFW0aSDEF8hNFG0DfKi8kFEedsv5j6XLsgEm
         Hmp6GQQixM8BsMtm8QJKIlJsQPyCoSIXhjjjXSSDONRI3EX42dFQ4r3mdgbpdU4HAsW8
         fDGrv2EBV3DuiSYMwopg09cismoJ5JupDLY4oUMuF5ulb/Hx1az54pgftwGc6zfkZ/1Y
         cnbzPCdIBsL/MsQW6yagt4+SbDFKlWD9W9efnvOxmWw2BiiRrle4BNqJ8vkyyw80G+0i
         ttWMsyq/zaB1eqv5E1Y/xMWcZmvvLX5ATgLCqvVnALQcl8t8dxk4KaEhUw1NqN6Sq99m
         CEZA==
X-Gm-Message-State: AJIora9K3+jiICwPwJeapKaO5ykoLIS/Mewc2nk8J6fHsXFMbb3Q/Gte
        1vpVALfYxm5T/+cqpGlDMN3ytynsRtK6UARWgKk=
X-Google-Smtp-Source: AGRyM1sr/Y3yK21hndc+LLtkfsWJfBlXbc4IcO2/5cpyQegGgQoTQET+AICrvmhu3W7e0EwpJqYpEdncP7bYClvRw9M=
X-Received: by 2002:a2e:8e8c:0:b0:25a:76dc:e4e8 with SMTP id
 z12-20020a2e8e8c000000b0025a76dce4e8mr20535722ljk.529.1657040809966; Tue, 05
 Jul 2022 10:06:49 -0700 (PDT)
MIME-Version: 1.0
Sender: flovedaivd@gmail.com
Received: by 2002:a05:6520:2dce:b0:1f2:b7e2:c24b with HTTP; Tue, 5 Jul 2022
 10:06:49 -0700 (PDT)
From:   "Doris.David" <mrs.doris.david02@gmail.com>
Date:   Tue, 5 Jul 2022 10:06:49 -0700
X-Google-Sender-Auth: METqjsLk6rh1F8ABaSEAQozmsuE
Message-ID: <CAHYMczTtB5YcNP2ZmA3PYjarfAwSJ13JF2CpPpTjtN+f79dJog@mail.gmail.com>
Subject: Re: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.1 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_60,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:230 listed in]
        [list.dnswl.org]
        *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6549]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [flovedaivd[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Greetings,

I sent this mail praying it will find you in a good condition, since I
myself am in a very critical health condition in which I sleep every
night  without knowing if I may be alive to see the next day. I am Mrs
doris david, a widow suffering from a long time illness. I have
some funds I  inherited from my late husband, the sum of
($11,000,000.00) my Doctor told me recently that I have serious
sickness which is a cancer problem. What disturbs me most is my stroke
sickness. Having known my condition, I decided to donate this fund to
a good person that will utilize it the way I am going to instruct
herein. I need a very honest God.

fearing a person who can claim this money and use it for Charity
works, for orphanages, widows and also build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained. I do not want a situation where this money will be used in
an ungodly manner. That's why I' making this decision. I'm not afraid
of death so I know where I'm going. I accept this decision because I
do not have any child who will inherit this money after I die. Please
I want your sincere and urgent answer to know if you will be able to
execute this project, and I will give you more information on how
thunder will be transferred to your bank account. I am waiting for
your reply.

May God Bless you,
Mrs doris david,
