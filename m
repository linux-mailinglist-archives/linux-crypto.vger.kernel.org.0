Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31396392DF
	for <lists+linux-crypto@lfdr.de>; Sat, 26 Nov 2022 01:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiKZA4F (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 25 Nov 2022 19:56:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiKZA4E (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 25 Nov 2022 19:56:04 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB34859146
        for <linux-crypto@vger.kernel.org>; Fri, 25 Nov 2022 16:56:03 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id g12so8891091wrs.10
        for <linux-crypto@vger.kernel.org>; Fri, 25 Nov 2022 16:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KLS2zcruSlKyOQ1OBKYSyr+7+6zj0YKBqr4fpDhq6DI=;
        b=Ow/sBv2XrjAM5n31pTKGC3ViyQoMrIrDaECdeStboRtCl16QsOFYEzrvd6AErhCjzj
         XdCbMMz4Sfk65eWZIctyx5Y5eIDe0ltp2QbuSc1aI2jrTqlYgMfe4Rd+E+Oa9rx9sBs/
         zDU8imT92T4YdIveCsMkbHrWGFLz216vYF7OAL03CHnBCSoKW3VHF5QuE54/BmujLQ1X
         nikLr1AJtA/Pn0SBIWQ4l/Qt3K1gzTzeScQBEPblfA0UDAp+fREE/7uAK7JJL4pSSfO0
         o3vNaJJXH9GdGCnDDT0L2leToRLAvPs7SVRvoPVGp5sVNdJiWlqu8a+PnB6yCUQvRiap
         SKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KLS2zcruSlKyOQ1OBKYSyr+7+6zj0YKBqr4fpDhq6DI=;
        b=j4D+MdYVONrGi3PZUrLRlFH/krGt7o9c9reehe9dS4pCnB5E+sM9IukBfp1+xUjKsD
         31V3aqelCk6ubXogpOanWByMYcYDXX1XTsPeAM9+sVgYuB0jJCjn7nYAFf4dmTE5Qsx+
         vmcGvxXv6c5IojmH+6XNSVENPLsXuP2/XWRukfiAFADtL7iwiRoItHytj4Ew1aHolT4d
         z1mTzRJq/nHddP2+0G+mQ2J6W+Ng6GTJTSb9TAFaPpiEZgPVyPp5nmcmXIi+G+3teHWB
         N2GWbcPMA/HNlqbfoLc6q4wzWa6B8qxNvzYN2K+VT2E1vZBLhVskUbjbBxCH1gWEpmMT
         pfZA==
X-Gm-Message-State: ANoB5plZ9CkUJX7UdIM9pFUTvCsOzTtbqF9qwbiMdL47M/tSJbIVKnB3
        snACmjO6ziLOd0jMq9RZuNKSI3bm0Be5/uZvyI8=
X-Google-Smtp-Source: AA0mqf6M4pYblzsaDZhjy2J+gTy1QCXdqEk3txVRIBdst+10dfaLmWI/UsvSmRuhOX5JDSfYdLJ4j4r1rDH6nNymDdg=
X-Received: by 2002:a05:6000:18c1:b0:236:5d8c:97fd with SMTP id
 w1-20020a05600018c100b002365d8c97fdmr25590919wrq.473.1669424162097; Fri, 25
 Nov 2022 16:56:02 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:adf:d1cf:0:0:0:0:0 with HTTP; Fri, 25 Nov 2022 16:56:01
 -0800 (PST)
Reply-To: samsonvichisunday@gmail.com
From:   Aminu Bello <aminuadamuvitaform@gmail.com>
Date:   Sat, 26 Nov 2022 01:56:01 +0100
Message-ID: <CADwEiSsWRKFoNbMGU-Sn_jO39ncA1Vq+v72LHnZzRZ8=xizjVw@mail.gmail.com>
Subject: INVITATION TO THE GREAT ILLUMINATI SOCIETY.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=7.0 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FILL_THIS_FORM,
        FILL_THIS_FORM_LONG,FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_FILL_THIS_FORM_LOAN,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5111]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:441 listed in]
        [list.dnswl.org]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [aminuadamuvitaform[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.0 FILL_THIS_FORM Fill in a form with personal information
        *  2.0 FILL_THIS_FORM_LONG Fill in a form with personal information
        *  0.0 T_FILL_THIS_FORM_LOAN Answer loan question(s)
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

--=20
INVITATION TO THE GREAT ILLUMINATI SOCIETY
CONGRATULATIONS TO YOU....
You have been chosen among the people given the opportunity this
November to become rich and popular by joining the Great ILLUMINATI.
This is an open invitation for you to become part of the world's
biggest conglomerate and reach the peak of your career. a worthy goal
and motivation to reach those upper layers of the pyramid to become
one among the most Successful, Richest, Famous, Celebrated, Powerful
and most decorated Personalities in the World???
If you are interested, please respond to this message now with =E2=80=9CI
ACCEPT" and fill the below details to get the step to join the
Illuminati.
KINDLY FILL BELOW DETAILS AND RETURN NOW.....
Full names: ....................
Your Country: .................
State/ City: .............
Age: ....................
Marital status: ....................
Occupation: ....................
Monthly income: ....................
WhatsApp Number: ......
Postal Code: .....
Home / House Address: .....
NOTE: That you are not forced to join us, it is on your decision to
become part of the world's biggest conglomerate and reach the peak of
your career.
Distance is not a barrier.
