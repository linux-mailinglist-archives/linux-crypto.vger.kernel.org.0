Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 927AF69B58B
	for <lists+linux-crypto@lfdr.de>; Fri, 17 Feb 2023 23:33:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjBQWdz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 17 Feb 2023 17:33:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbjBQWdy (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 17 Feb 2023 17:33:54 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915D712BCE
        for <linux-crypto@vger.kernel.org>; Fri, 17 Feb 2023 14:33:45 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id s10so986427iop.4
        for <linux-crypto@vger.kernel.org>; Fri, 17 Feb 2023 14:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n46NWXqE/DHCpPFKbULbQWqCUMDw5M0Cu5SsAcT5pL8=;
        b=TOvlsqNJNUB8L79xwwau1bESUH+MkDgAISP956Jeon99Ga7B19qWClP6PAFmtAEUnr
         1lThCLCzK9s97Xx9fahssuZob9Br07jEX+L6tzUocIy01cvcm54uaJpyQhBUtpnNFN5W
         3Kk5/h5RkIqTY/P4oe3u5Jtc1j58t/tjgPAL2js+wJu05Tk0R08yLJd8b0yRy/oYlsQ8
         yMPUOjklvAC9gb5PZB9lHKb2KVay+Z5Hf7oG4X2AMm87kHcBOBPHDINVUqlvmvKANcvw
         fogCz1UsSansq9ppAoLJDsfSV3eJq0c2IwwR87uGO03dff/7gxVzlPb0yM3oMdSWOMS7
         VDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n46NWXqE/DHCpPFKbULbQWqCUMDw5M0Cu5SsAcT5pL8=;
        b=6kinDssjNRag2RI4UGurWesYZ6MKrZrVxc1ndUVeRBt+5TiLWQZvi1hbDvQvHrYTzW
         CvFUZnmAaTRhtMcJvr+Tim8N13oSE83Oor/KoClieKB3Ryt5KESlfcdbbkiT3VaVjUer
         xz9iKZjSBD4dKJQGp5Gx2am4Ukc31Ed9kxbX9z8EV+DrA5JrhtKozvjSik9pnlNvLOi0
         wBn6sX6LE9/aBue9KkXYIS4cihnu0yqKoWam8WtVUomCvVJZBDDrOqih/2ypYMestge6
         Abz2xMVA0RXxBYm/qlNAxhwso7cKXL1C5slOHSxJgeROylAkmpm/tXo8ZQ49B9+0jEyZ
         2YwA==
X-Gm-Message-State: AO0yUKX8ErHgxwd+ZpHNhXAwV9JBct8KSoRsHkj8OjFb8oOrPgeBDbHY
        eFqoWKsiVYxGzuMeNkzY1eJWYFS02WGhpio3FRijk2vJYRk=
X-Google-Smtp-Source: AK7set+oskjW2qZzqXRZcoq/kczXKR7sqHr8ihB4ojBEKvA21ysho82hEZfvFWM7Grsr+t1Ic5E/UFmKoZloT2rv5TY=
X-Received: by 2002:a02:93e6:0:b0:3b7:9d19:fec7 with SMTP id
 z93-20020a0293e6000000b003b79d19fec7mr758750jah.0.1676673224513; Fri, 17 Feb
 2023 14:33:44 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a92:8e03:0:b0:315:6b38:30f1 with HTTP; Fri, 17 Feb 2023
 14:33:43 -0800 (PST)
Reply-To: williamsdrtracy@gmail.com
From:   Dr trancywilliam <yameogoseverine5@gmail.com>
Date:   Fri, 17 Feb 2023 14:33:43 -0800
Message-ID: <CAOgDavutzNDeO-ZMRdW0BBpq1_qCHQo8YfjMc_KLhgaqC5g4hw@mail.gmail.com>
Subject: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

How are you today? I hope you are doing great.
It is my great pleasure to contact you,I want to make a new and
special friend, I hope you don't mind.

My name is Tracy Williams from the United States,
Am of French and English nationality. I will give you pictures and
more details about my self as soon as i hear from you

Thanks
Tracy
