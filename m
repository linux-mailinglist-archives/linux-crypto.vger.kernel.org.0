Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C225A359E
	for <lists+linux-crypto@lfdr.de>; Sat, 27 Aug 2022 09:36:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbiH0Hf7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 27 Aug 2022 03:35:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiH0Hf6 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 27 Aug 2022 03:35:58 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95D22BE4F9
        for <linux-crypto@vger.kernel.org>; Sat, 27 Aug 2022 00:35:57 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-11c896b879bso4827078fac.3
        for <linux-crypto@vger.kernel.org>; Sat, 27 Aug 2022 00:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=41kW5fOWjdzzcQ6HaiOHsjJFnjWCo4jg2HDR0g9ZrRI=;
        b=dAXunxeJtedN6oCL6p4rLOwmkFHgQ1KxbJs+c8v5hEsmoaJdTSLV/36dhA3M1j4Tsn
         ACJlIOlJakrgIEeXxEkfYVevV7gWXtCndwrLTjAfe5QVHJDURv4Lrr1tPfH2W8JYVgof
         NHZxI39DOF71qABpCYJfozNZrjNBudd2dMfindC/dTSmkIcGYFaJnv12Vw8S4cHmJ8Dp
         vpuHfZKY5DQi5ujSDOBH9fPcKQfJ0PcsdeH1R5uasn1MAX1vPocRijxkzQqyAfVhABuR
         SGE8u8glOnlIa6yyjo0cB2/mcfZpKNhBUpP9Ytz5vYlJ3g/u4WUhg+Ngc+gR9H07+Xg4
         /G3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=41kW5fOWjdzzcQ6HaiOHsjJFnjWCo4jg2HDR0g9ZrRI=;
        b=Gght8lhmJfZXTHGNs6zpI4pGd3nSA+XQg8GH8DYBghvd8juon4pKF/lmjEAOs4K3iJ
         xfOXqlLwKh5sPrdC/vwOLJnxDb+QFk4hJ+7W+IeFbYqF/6TruUVZ0Xf5+SCbM3Pm6TV5
         Bso6shZ4n0fKzzftMJHxGp19GSI0IcfjeZU1ShA0cRxPqcsrQJwGH8jmUSsU06Qmn3lT
         XI7PcdmLgafqqd0XavatLZFpdWqjBhkgcsf6cQx4QKiVgNUWtTpMpj5uc7qadu9JMMBN
         cKnnnvBOvHA6M3czGmzxsisR+S94GaJCSHhCeNXGqkssqKrZYhz3ALTjV0Zi1c9/lwf1
         Wumg==
X-Gm-Message-State: ACgBeo1hR+nhpI3awwf7YUetY8eCglIxxTwjD5aBTS60q/9pGYJ9pX1j
        uLrTKAZJWb+a8yUhjshPNQpKJ1IoOpB0+bcPMu5NW+t8Qffz+Q==
X-Google-Smtp-Source: AA6agR4kbk3SFhqfdVjEgNMgde0NJS3XNGbMq7EgVhjETqvq+fK5aW3rEdx1Ie3ex+Z0nhmvWfctCcJhq+IYFoVoMKc=
X-Received: by 2002:a05:6808:309b:b0:342:f6b0:1b53 with SMTP id
 bl27-20020a056808309b00b00342f6b01b53mr3046980oib.293.1661585429810; Sat, 27
 Aug 2022 00:30:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6850:604c:b0:32a:7951:35f0 with HTTP; Sat, 27 Aug 2022
 00:30:29 -0700 (PDT)
Reply-To: abdwabbom447@gmail.com
From:   Maddah Hussain <klimowiczd0@gmail.com>
Date:   Sat, 27 Aug 2022 00:30:29 -0700
Message-ID: <CA+ARbHQ1F9uMj=hjtKRQ-zqdj92FU=O2vf3va6VVPBYiPexuNQ@mail.gmail.com>
Subject: Get Back to me (URGENT)
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SCC_BODY_URI_ONLY,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2001:4860:4864:20:0:0:0:34 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4999]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [abdwabbom447[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [klimowiczd0[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [klimowiczd0[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.5 SCC_BODY_URI_ONLY No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

-- 
Dear,
I had sent you a mail but i don't think you received it that's why am
writing you again.It is important you get back to me as soon as you
can.
Maddah Hussain
