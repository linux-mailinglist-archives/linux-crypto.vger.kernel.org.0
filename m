Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A085B82E6
	for <lists+linux-crypto@lfdr.de>; Wed, 14 Sep 2022 10:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiINI2T (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 14 Sep 2022 04:28:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiINI2R (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 14 Sep 2022 04:28:17 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B586527C
        for <linux-crypto@vger.kernel.org>; Wed, 14 Sep 2022 01:28:16 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id a14so15183223ljj.8
        for <linux-crypto@vger.kernel.org>; Wed, 14 Sep 2022 01:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=pkxNv55YcC3pLEICxq5urys55gAyEBXI4ELv7dNSxqs=;
        b=BfsAFLjwRW7dm9/lY+7TZpO7KLJ6u9Cr4RSmyiXPAvAi4JUZrutpreac5O90PuaMlY
         0y1C0Kvfa7MJ9uYswtCGuMXBzOW4QkviMm0jglbKqxePdGc5INfrD5c80dOI3jbzRKJN
         RFavpxdeAIFgegZ0E973wYsSsM5p0u2ZjcJ5ktcNBF7WSKKE+GfgeAc+6kI+urUpP6Bb
         MiB4zccrGzu4czUkhhVCGseOBrXaIjTYVcHLAH0/ZL0Jvol7Gbw0zlhHrJWGPFV8Kyqs
         fyT3xx2V9heBKSdDUYsfZ5jJAr8txVbrwfll1YrPtpMnbHlqN4Bdx3mcYIieq7Ul+SbM
         +Rhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=pkxNv55YcC3pLEICxq5urys55gAyEBXI4ELv7dNSxqs=;
        b=tfM2djIkQCzCKIoig7MjYZ5n+HuHTTyyKGhBpjI9ijlx9Jf+/ljdwKWxw+6WZIDnpr
         XbS/y8pxFhmmWM10zDsNyffG/mOpvVtUO+JEVCYbDvLaDibl7hi7l+tJJZyo5Q8B+Vln
         FwVxvbiF68zc7mOWFnjguOou0s0Tt9bNIcP/hCfKFm1/nTDWvzM7iac3Jy82KmBa+Lx0
         lK9gP8U2rLd26AWWpG1weWdKUvlaGZ6QNPukol8lQjkqoscA2HRL7VuQr7ZGpDFtSfq/
         Z1GMv7zWggdgH7R1BoXE5KwZ5tmvHwFtGRqj8yECeDkLoBrzhCT5PASglDkw8t9sqNXe
         PZcg==
X-Gm-Message-State: ACgBeo1qh6EvNJ/vP5yrlNxxaqokmWr4DITr0Zzzpiv3sR/6hWz9a5QC
        FBwUsk+cwVVAtNgj649LDMEEAT8yguyQzZOpX5Q=
X-Google-Smtp-Source: AA6agR7+JSNqk5SgfDV3K9a+RglA/vwbcg/Y2WgCK1wHGC0APxxJpk1stVR3QiVnO4sEXVjHaC6PatD5iNVvIwe5ZZs=
X-Received: by 2002:a2e:844e:0:b0:26b:f5ee:b2bb with SMTP id
 u14-20020a2e844e000000b0026bf5eeb2bbmr6003441ljh.403.1663144094523; Wed, 14
 Sep 2022 01:28:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6512:2391:0:0:0:0 with HTTP; Wed, 14 Sep 2022 01:28:13
 -0700 (PDT)
Reply-To: xiuying.qiang212@gmail.com
From:   Xiuying Qiang <jerushakinya88@gmail.com>
Date:   Wed, 14 Sep 2022 16:28:13 +0800
Message-ID: <CACkApWdk9eXYaq8s7F5jpRH1nvp+TobRkyLQsR94uUXaUNqhow@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_Nazywam_si=C4=99?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:243 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [jerushakinya88[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [jerushakinya88[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [xiuying.qiang212[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  1.4 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  0.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

--=20
Nazywam si=C4=99 Qiang Xiuying, jestem starszym pracownikiem w publicznym
banku w Wing Hang Bank w Hongkongu i mam 18 991 674 USD. =C5=BCe chc=C4=99
wyjecha=C4=87 z kraju. Potrzebuj=C4=99 dobrego partnera, kogo=C5=9B, komu m=
og=C4=99
zaufa=C4=87. Jest wolny od ryzyka i legalny. Odpowiedz, aby uzyska=C4=87 wi=
=C4=99cej
informacji:
Pan Qiang Xiuying
