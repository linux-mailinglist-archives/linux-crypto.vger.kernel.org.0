Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19D0C545691
	for <lists+linux-crypto@lfdr.de>; Thu,  9 Jun 2022 23:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240064AbiFIVko (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 9 Jun 2022 17:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232719AbiFIVkm (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 9 Jun 2022 17:40:42 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10B54EA2A
        for <linux-crypto@vger.kernel.org>; Thu,  9 Jun 2022 14:40:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id w13-20020a17090a780d00b001e8961b355dso492204pjk.5
        for <linux-crypto@vger.kernel.org>; Thu, 09 Jun 2022 14:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=ZkYftyRGpMcveXvJMpgQmrhv/AK+OIR38U0gj7+k5ToXazsjt8DA47VgB7wH22vUOK
         M9aLAz6MZ8Ji+ZonR0ZSDY7evDSyDH0u/u0b+RCfUHZrlsu67gqbVifLnBg31WKMJxH4
         xcynhzC6bydaokSx01xdrt+i4Jy1OLTt/y8ZYV0y2McFs0hO5wCMkxJJMBWqCbWqsToM
         xP344HcvBx8v9Px/I/SS5E6eIKEGcjZe+HDvAiFszmdAZF8Z/nZKAzYf4hBT3R5qoqVg
         y+SnNDPebj5YKuwntNgQHSf5KgWpHGG8XE4Qlo3+wNXrLKiJXr5hbcwcAajdubUFRJ33
         l+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=mZ3wqB4NmL7z6lpFr/h15h1rYqsZKafJnUpMVahbEPg=;
        b=29C8TMi6wgEcxypwQDbZIn4Ic7hB8/HCmJ9sF/6nD1AjnQxTbrjq7GCgGu6Pc/0iDf
         2QJRCO2PZ/jENVorc3bNtnyjrTIhY+3+q5IMpp0lkVl9DqB14qlfu9IUIUJWF18NGH1X
         SxV19qq5g96sd53mStyHy7k9etUu5SMEsG3DLxenekNGP3HR+F8z6LYFiG1NetjKUpaO
         /uxXm5wbnv5e605zVYLUZ4b5xqrVIMRCfg8DqOJ6vgKLBkJYXO9N4RhYnjAKpChI1BMU
         IviBxl/Y5VPoXtCd92QKRhni4j0SGHal3C8bsSIEkLBYSuVcooosG8tviKGuqtApdoSe
         5hmg==
X-Gm-Message-State: AOAM531L+1w9xx9w1GsiPVTkrEBPLTw7XqGFDXuMkYkoRPpuXvG1bxgc
        izf6QM5OEnu9tkBlj4iFctOhEUfhWmvNaSYYxjo=
X-Google-Smtp-Source: ABdhPJyvXzC7vzoiAK5Hno87Wsj+tz7diAQck7L3KllSWvCqdiCm6FzxfaW7MwzjdTVidsQ2kFUxqe/C4WwHSPk5zDI=
X-Received: by 2002:a17:90a:14a6:b0:1dc:f64f:ff2c with SMTP id
 k35-20020a17090a14a600b001dcf64fff2cmr5310519pja.161.1654810841155; Thu, 09
 Jun 2022 14:40:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:902:8345:b0:167:8960:e2d1 with HTTP; Thu, 9 Jun 2022
 14:40:40 -0700 (PDT)
Reply-To: wen305147@gmail.com
From:   Tony Wen <weboutloock4@gmail.com>
Date:   Fri, 10 Jun 2022 05:40:40 +0800
Message-ID: <CAE2_YrA41yWrKODFfwcbqBbUpXMTLrM5z10qZAzkP_7r3_uvOQ@mail.gmail.com>
Subject: services
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_40,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Can I engage your services?
