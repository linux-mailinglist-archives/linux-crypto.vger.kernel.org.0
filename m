Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DF82517EA8
	for <lists+linux-crypto@lfdr.de>; Tue,  3 May 2022 09:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232195AbiECHWm (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 3 May 2022 03:22:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232052AbiECHWY (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 3 May 2022 03:22:24 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E674286C3
        for <linux-crypto@vger.kernel.org>; Tue,  3 May 2022 00:18:53 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a1so18899372edt.3
        for <linux-crypto@vger.kernel.org>; Tue, 03 May 2022 00:18:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=29xFCebUVJXjkMUXmm/ZAe/1iG/qqpmKTNgtZIQ1CdA=;
        b=dgUhMnYzhTOX/HUQoJiLK1D5tNzF8K7qnFLQ7ag40oQ2iiVlsPoOmFJ0dQM3Opn4qZ
         VPUeblOO5vu+m/NLa0RwlZSndZiLyl4PeTz5qMMQtUkj2JBISnzocPg1MJmZK+T0WWkT
         phSTgma//p1906SfOwh90O5/QsN3SG1RrqD0llB1DPPDrdPYZVaVzYcTdNPG9iOWr1pd
         5+KeKcj2ePSRt1qM6JYQu0gtInTI8K8WYUqfSmgNT6VDTWQohVw7Hi41qudGcKntV4YU
         zRt2KNT9p+IcCHZfRwa3gU/QPUzrkz5gfDbrmz9GYuSNHQEewXJsieGrSmrO3BGrJtlm
         Klfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=29xFCebUVJXjkMUXmm/ZAe/1iG/qqpmKTNgtZIQ1CdA=;
        b=wgqGy/C7rSvxwmrXu5YVM2kRkvlWwRtoa+c9s0VDr3f4VJXXU9Bv391eNmVjxClRKu
         D8cVaLjD4nlvtJguzkLTRELmm7gCjhbyEHXYKfe0M2jrnURhwjDqbFTRIAHpONOHjzYT
         G6pPnarc0lhJrrpIm/+WRkBb8V7wtl4svP1U68GwP8ky74kurOGQEAfZUZ6fd0sovkQW
         MBkJhFHOLdc9BQ3VDBo4WKbVADvTuS06PywSdCN10375aOowjxlnvAfp2aTXWDNbL/Jn
         XusNzbmtHdG4g1hqgQN41KAMgJ46aWgh8LUoaKv8jWd29xvQlcFzPvkjlh54X90FeDv6
         Rteg==
X-Gm-Message-State: AOAM533mFt3VZSzh4Re/cOf1DdTKsJXOG3c4YoNzvzSathoIwSMb7cge
        kG267KPbnZLHGYEJ3mW0uyE6ajEnC0lF2Q2SSZc=
X-Google-Smtp-Source: ABdhPJyWBtzS6Akwba08hEyp3iVY7rkILSDzoOhmSnmuFmPmJ8QwKsvLpSB7dbA83NfbtFUNr90sBtyx0wBsteId8bw=
X-Received: by 2002:a05:6402:190a:b0:427:bbd8:40c3 with SMTP id
 e10-20020a056402190a00b00427bbd840c3mr10704985edz.245.1651562331694; Tue, 03
 May 2022 00:18:51 -0700 (PDT)
MIME-Version: 1.0
Reply-To: carterannette557@gmail.com
Sender: kafandoii450@gmail.com
Received: by 2002:a50:6982:0:0:0:0:0 with HTTP; Tue, 3 May 2022 00:18:51 -0700 (PDT)
From:   "Mrs. Anne" <annl10390c@gmail.com>
Date:   Tue, 3 May 2022 09:18:51 +0200
X-Google-Sender-Auth: jO9giHVijtXRWcXCUH4MA3k3Tk0
Message-ID: <CAC5WJY6n_9jwXk=kfnYVF8t1kFF82X8rEdZofgh9zxHMuqeGZg@mail.gmail.com>
Subject: Partnership deal
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        HK_NAME_FM_MR_MRS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5003]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [carterannette557[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [annl10390c[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [kafandoii450[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 HK_NAME_FM_MR_MRS No description available.
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

Greetings to you and how is your family? Excuse the way I'm addressing
you here, but that's because I have no other choice. I am Mrs. Anne
from UK. My story is connected with the war between Russia and
Ukraine. There is a great business opportunity that I would like to
share with you. If you're interested, it's something that will make us
both millions of dollars. I want you to reply me, I will give you more
details about me and the business. I will be waiting for your reply
soon.

Kind regards,
Mrs. Anne
