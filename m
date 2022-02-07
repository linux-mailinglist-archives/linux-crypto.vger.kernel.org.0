Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3AB4AB880
	for <lists+linux-crypto@lfdr.de>; Mon,  7 Feb 2022 11:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236326AbiBGKNr (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 7 Feb 2022 05:13:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245652AbiBGKC1 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 7 Feb 2022 05:02:27 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5DF2C043181
        for <linux-crypto@vger.kernel.org>; Mon,  7 Feb 2022 02:02:24 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o12so25660270lfg.12
        for <linux-crypto@vger.kernel.org>; Mon, 07 Feb 2022 02:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=5/sAtrtXAxiLSOFIbur9L0YbxuEh3t+bQyTbkqJmxzs=;
        b=P9JCi7djAHMxX0MsCO20BzCvQNgLzlVAbJfCDtkOTb7pbDaPEqKGJAjyrQccx8eIJ0
         qlxW2pJhZK1J+KF7XYisqEeW7sL67rMQuoyDTOgvAT3b/sy9dK2MFLTZJ2FBkuccjYT+
         v517WOU+hUQfSwLdMr/s9oOxSaChaSRtpOp1qE4/TJ7mylVwDneMS9q/OhmgaiCJBSJC
         JSLGfufSPBOhB08Gs3FFdMPYNj7PWZ4RiGgWUmDgPSNI1AzfRBGkvK1FzJVIXbhGAEYl
         IG0QV4LZ42GbBWQvzQc5kJuBVKP8NtzPH1I/EUsMhgd2X50lUGskudEsLIedRzJV0k2t
         g5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=5/sAtrtXAxiLSOFIbur9L0YbxuEh3t+bQyTbkqJmxzs=;
        b=XlLMUwWZue6YLnlaAHwRLlKlp1ydOOig8SfFA+vvRuSj0WSXtlWVjFwIe18Ly6KCCq
         mIbmgbaW3a6fzGiGQFCi9PLN0mme1pqmkrlz7wxfrm0yWk0OA7YElOtPoCfj2yhc4a4l
         JRjMhqdPj1vP36UXpqQ7kWl51U9n/WBs3FS9Kt5tLqwAz82K9k2rB8W33MBsEfZT69gr
         qH2T2v/Ch05leX4c1AUyoyznf5TSOGP3HEfIrrEr7pUFPIQeqbPQ0f+NZJnBf7oGqQMd
         SEcio+Wu2mDw4JyIx3wEYDm8PKAh5ax8OAGrSW6ZxQd170903eIt4wlm1U3YGFoBTktV
         WYTg==
X-Gm-Message-State: AOAM532uSGO789aICmYFHXZr0/ObYjgbtzdeGPER4j59zeaHmkwg4r2f
        l2zWRB7jBSP6tOUn8ffDk0lU55xdAIVegNYt7FA=
X-Google-Smtp-Source: ABdhPJyzM/xmNoiBrdsz4n+GuU6BfDmxXzazZF2akTYyJNwey7T8abiEVDx7rmjtxddADqS2XLImmUjMc7Ir5z9LAU8=
X-Received: by 2002:a19:f806:: with SMTP id a6mr8007968lff.27.1644228143261;
 Mon, 07 Feb 2022 02:02:23 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a19:7517:0:0:0:0:0 with HTTP; Mon, 7 Feb 2022 02:02:22 -0800 (PST)
Reply-To: heatherwiilliams19@gmail.com
From:   Heather Williams <ayefouninestor@gmail.com>
Date:   Mon, 7 Feb 2022 10:02:22 +0000
Message-ID: <CADoQv959pKF2Z7iUtb_R6OkL9F6a+ELKSkiF-gm+MZM5D024Vw@mail.gmail.com>
Subject: Re
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_FREEM autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

-- 
How are you doing? My name is Heather Williams from the State, please
can I have a chat with you if you wouldn't mind? Have a nice day and
stay safe.
