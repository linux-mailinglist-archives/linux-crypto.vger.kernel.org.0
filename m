Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C044A565725
	for <lists+linux-crypto@lfdr.de>; Mon,  4 Jul 2022 15:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234562AbiGDNaZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 4 Jul 2022 09:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiGDN3U (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 4 Jul 2022 09:29:20 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF4B13DD3
        for <linux-crypto@vger.kernel.org>; Mon,  4 Jul 2022 06:24:26 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id z21so15735960lfb.12
        for <linux-crypto@vger.kernel.org>; Mon, 04 Jul 2022 06:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=RNT9aO9JuvdHPRG7M+oG+iA92P02fztEckYlKzdbtWk=;
        b=goIT3mIoOXZ1tEnLN0KoLs+MFO30aOWa+0GKJOXxdwZNeSDCArmGkoyUh8fIev5x/z
         Qug3lcw63e3gPQ0nE3/zSAxI55yjQPSyZbJLpa3a5ynYVw1it9MUcSJ1UT2f6q2hKKfx
         zwyeaP+DT9VF+B9o0hhNeyzg3LO0ebs7y+RCHc1JdT5ztYyv1B9SK9YxwAENpJoMr2v1
         6FieZtxCNELxPK3uOWddJcy9kAea/XO/fax+qMStILE1gDEfykMgVqjv+hrXyzpvc20g
         kw7ejXZAe7ZWf+TZBM40ZLTvegNmfKstvQeOyCdjXi3oP9LXyBtg40LzMScab1Sc/6DV
         iW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=RNT9aO9JuvdHPRG7M+oG+iA92P02fztEckYlKzdbtWk=;
        b=tKNM/7gHTZjMWLQNObfxZoJbk4QYvyokvGo/0qymOr4rhDc4oXEHplkPcmtLDT1QGM
         xIRlMtoF7MrOuK+Qet3KcDcuCsenHmveWsg76aAhXkD9vydWtvlc2qZGbBrXoXK6Cb2q
         ynbalyRsSvgT94oEX5DgNRit/bHfxXNXlD5sP8rmUJBjeqlJxjb8imbktqCRgl5vL2Jy
         tatLzSWaz4FHD32q0lxLo+LDb7XcbKKW5wQjWxGJcbdfholZIXiNqrJRWHBc/RPugXgj
         xvRBsDKTqRHfMhYv+s48UbmSkHDyo1W/Qd5hfI35CGFvPeINRjcIEqBm6Hoa0T+BTCf9
         211A==
X-Gm-Message-State: AJIora9UC0SthNYWWPPYOXXoRRr5sqv133S0vfcoQKSG5oiK6zyB4YlC
        99aCYxMqPuxalosHfB9MPWqs6zvlDsjdsBbxbAk=
X-Google-Smtp-Source: AGRyM1tSzit3UnnRP+gvHwSsh+VUqiIJ7H/BhM/4HCaQiM+JotCg2fRB9rM3aNYy8UL+ZuY1AjagPdbxhf8y9rMwTUU=
X-Received: by 2002:a05:6512:3d0d:b0:47f:b8eb:86ae with SMTP id
 d13-20020a0565123d0d00b0047fb8eb86aemr19820646lfv.78.1656941063637; Mon, 04
 Jul 2022 06:24:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6512:2829:0:0:0:0 with HTTP; Mon, 4 Jul 2022 06:24:23
 -0700 (PDT)
Reply-To: nadagelassou@gmail.com
From:   Ms Nadage Lassou <maxigbikpi5@gmail.com>
Date:   Mon, 4 Jul 2022 07:24:23 -0600
Message-ID: <CA+2vryquZfuBCJfNb2VP2e0R9A=RDg7ix_iexp=begyc9TzShg@mail.gmail.com>
Subject: REPLY FOR DETAILS.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [maxigbikpi5[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [maxigbikpi5[at]gmail.com]
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
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Greetings.

I have a something important to tell you for your benefit,Reply back
to my email to have the details,
Thanks for your time and  Attention,

Ms Nadage Lassou
