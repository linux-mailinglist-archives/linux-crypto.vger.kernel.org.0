Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A36D4BE63A
	for <lists+linux-crypto@lfdr.de>; Mon, 21 Feb 2022 19:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355578AbiBULRG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 21 Feb 2022 06:17:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355965AbiBULPl (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 21 Feb 2022 06:15:41 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF6AF5FCF
        for <linux-crypto@vger.kernel.org>; Mon, 21 Feb 2022 02:55:03 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id h9so31058854qvm.0
        for <linux-crypto@vger.kernel.org>; Mon, 21 Feb 2022 02:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=agx76WiKUJ0kEWV4KQGw41yeHdxUAdPKb8aKMVI6l5Q=;
        b=iI6RZfHx7mLYiLTb8nh1zJgHGFjkvCE+d9+ki6tgYACqi6zViNYjchzFNt20a+nzLM
         KwlIa19GU00ThwpDXN0md/uDwB4bW4Vp0yicKWckUz2sLexUZEs7dfzNP4LVKQ8kEj+y
         F8V+893JzEoVxrxMMkGT43RlYrkxORkbWJ38en/EobVmtvudtn3rTgKriGmG+ifXJ8cq
         G9lC8EJGY0gPNp3/v0CkZXwwoZmyXQpLh2BJJ2XpfeGeCszZj/C5xZRRupGZc5WscADw
         if0tZixNZCLICi3JpTGwNBrbpHAkqPr8wTGD1BHohAU8TX5rYcFjbFqIpsIQlUk+B4Vy
         CS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=agx76WiKUJ0kEWV4KQGw41yeHdxUAdPKb8aKMVI6l5Q=;
        b=tFfySFLDaSbEHtDZEffCk3433A5zfENpF0mpGOmUIjWnLWDkB/D+4swQ3cxSURfeSc
         yBxo+mQbF9O4IregVRvpye/u5gU+hBKYgWULEO22yc3T+ecOutHirUATuw2iwJWoix/k
         BloYhYKz5tUkPoL3qjjH4Lx1ft42bRVdOqolA5bGFjgiWfyoeUuwUU0KD0KOrvWGzDWe
         Bw+Gngv69CNfHfZqTDVakxMQxTwW0KeBZF8sM/oH58nfo7WrM1dW03NKCc6ydkp6onaV
         kG7q9Bcia9vhVYWNwRSrWksCZw1I9uL818QLDeJV+1QSv706jMgXAy/15lam3E9ev9IF
         snRw==
X-Gm-Message-State: AOAM5314zm5P7sApkKyi1M2yu3D7I0NW8VNSDbhPwprHRoDXS1fwx3Pc
        H2LdTaER4Kb1SD7akCV0Mdb1uzbw6UYNqARhyuM=
X-Google-Smtp-Source: ABdhPJwpAub9l3PBMRXuLTrgcBPYDsILekplfNHb+cDuU/3bLH06RTrnXJl167m+7VKgmtYVGU1poV6y1optv25wdmY=
X-Received: by 2002:a05:6214:23cf:b0:42c:a789:146 with SMTP id
 hr15-20020a05621423cf00b0042ca7890146mr15285807qvb.89.1645440902833; Mon, 21
 Feb 2022 02:55:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:ad4:4e6f:0:0:0:0:0 with HTTP; Mon, 21 Feb 2022 02:55:02
 -0800 (PST)
Reply-To: byunghunl76@gmail.com
From:   Hassan Gilbert <pfazzabin014@gmail.com>
Date:   Mon, 21 Feb 2022 11:55:02 +0100
Message-ID: <CAPjrFYsMsdgOuPrk7x5+u7MppQncmtUhCWxTO3BXpn=Dsey14w@mail.gmail.com>
Subject: Please Read!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:f32 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [pfazzabin014[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [byunghunl76[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [pfazzabin014[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.5 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hello,

How are you doing today?.

I am Gilbert Hassan, the financial and legal adviser to AL MAKTOUM

FOUNDATION which is founded and owned by Sheikh Hamdan bin Mohammed

bin Rashid Al Maktoum (Crown Prince Hamdan Fazza of Dubai).

Can we seek you be our ambassador?

Can you join our charity foundation?

Can you join us in making the world a better place for living for the

less privileged, the poor and the orphans?

Can we seek your consent in establishing charity work and investment

in your country with the funds Sheikh Hamdan bin Mohammed bin Rashid

Al Maktoum (Crown Prince Hamdan Fazza of Dubai) deposited in a bank?

In your interest, get back to me for more details.

Awaits your response.

Reagrds,
Hassan Gilbert
