Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1005A88FC
	for <lists+linux-crypto@lfdr.de>; Thu,  1 Sep 2022 00:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiHaW11 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 31 Aug 2022 18:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiHaW10 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 31 Aug 2022 18:27:26 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDCBF23FB
        for <linux-crypto@vger.kernel.org>; Wed, 31 Aug 2022 15:27:25 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id q15so10415742pfn.11
        for <linux-crypto@vger.kernel.org>; Wed, 31 Aug 2022 15:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=bHtvVuvZrK8uzIZMh2KLQe7LmhlFcgk20dbkjCziIhU=;
        b=fL1jeVHd1g+xxVXfv2Af7UJs0xCM0kiccIefmL8uR9rDuKanoAy2wVVhT3lcH32+Ax
         v8umklOvJkpiS7s/SY3t4Y86MLyeKrZYNVo8sfwJXu0RIi2hyk0SQyqX+tg48URUwjzk
         6ajWmrn4QeKMegh17H/HSilL8w+poukJM5OEhj69Aj0SVGvImhIPtsfXMR0n5O3d4Qt2
         bB/Av1lVNt0PeqiHmf9jUSDfjJohT55b+zuyYMG96u2dVQ1kzNtVlaVAfUs/i2XxqPMx
         iy1vVISQA65e9xYTQ70giApplDGx6KLV+7vCwHhMvTLkQLRhSQjFFozdmf6+f5N21bYo
         51cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=bHtvVuvZrK8uzIZMh2KLQe7LmhlFcgk20dbkjCziIhU=;
        b=bm0GnumWHLwG1QPfyX0fhR6oJTGfPrwT/wiIRwlWEKerd8eoSnO02ng2LHVVUbtyyO
         OOSN2VartbCVC4EQQ4cSSBxybev/XFXdyN3TZg9HX82QQi+fGcGILA9Z1TTMG2NMUe1n
         kr0+/ZgV9hzoH1Cl9jfE3wMa6Z4MhP+sCHWk75VE7RZkLfcjHe2QlswsH5WBBBZW/Dtm
         GnddgXduGtfI5gsC+OT2TeYas66IKprH5qb5GmP1Ny/TkT0TEA2ZKWWfOZORIpeayrJD
         aFWnQ+lFARghWkiXAk7IGjLgZS2Ww+vjN2GnGOjFzNQcncAxrbSGY60RxlzQPc8J0D2r
         krTQ==
X-Gm-Message-State: ACgBeo2pu0UBciYwe01CcyvMs1JIW/J2WyF2GU/7RyzjvDWb0/k3JHaf
        lKSL9iNsD0maZaJaFSIdarEYqHLRy2ZpEbQEEWY=
X-Google-Smtp-Source: AA6agR6dFIRZtYWeCjDQ+dKXt2+cRcoaSsnVvmlW7Egymhmnql+AqwhJ3qxbo1duK7wj3ZhVAGnSSMsDH/p4SQCSC44=
X-Received: by 2002:a63:914c:0:b0:42b:a8fa:eb47 with SMTP id
 l73-20020a63914c000000b0042ba8faeb47mr17575664pge.267.1661984845260; Wed, 31
 Aug 2022 15:27:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7022:252b:b0:43:8b67:16a0 with HTTP; Wed, 31 Aug 2022
 15:27:24 -0700 (PDT)
Reply-To: Illuminatilord1945@gmail.com
From:   Gomez Sanana <gomezsanana21@gmail.com>
Date:   Wed, 31 Aug 2022 23:27:24 +0100
Message-ID: <CAHa5-kS_EMTS62O8GE8Hx8uFK2r-OPn6sRKyX7pNAKRuj6SXVw@mail.gmail.com>
Subject: WELCOME TO THE ILLUMINATI..
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:435 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5245]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [illuminatilord1945[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [gomezsanana21[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [gomezsanana21[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.2 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

-- 
WELCOME TO THE WORLD OF THE ILLUMINATI...

Congratulations To You...
You have been selected among those given the Opportunity of coming
rich and famous by joining the Illuminati Society this week, Kindly
get the below informations to the below Illuminati email.

Full Names:
Country:
Age:
Occupation:
Monthly Income:
Marital Status:
Whatsapp Number

EMAIL: Illuminatilord1945@gmail.com
