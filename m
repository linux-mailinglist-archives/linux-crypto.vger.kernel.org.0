Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28545660B3D
	for <lists+linux-crypto@lfdr.de>; Sat,  7 Jan 2023 02:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236733AbjAGBFQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 6 Jan 2023 20:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbjAGBFP (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 6 Jan 2023 20:05:15 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25B898463C
        for <linux-crypto@vger.kernel.org>; Fri,  6 Jan 2023 17:05:15 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id r11so2453934oie.13
        for <linux-crypto@vger.kernel.org>; Fri, 06 Jan 2023 17:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C56Q+YV0i1VwzqpPgsaApjf/2tDIDNvnJyLhwVpmM08=;
        b=dhbWfKx3+tphoLft8yp93ilp6qmQ6eNIla9WQDBjDjjJDK76Tt20R+zw4O2llYy6sF
         aVP5vHT4rRfSggNhYCNDqqx6Gqfm5sqtCtZeIQNNnGngvqWWiuIteVRKCa3Onn/JMwiU
         3U+ego9jAnKNvpPpQLDY4IGc9+xu5EiuaY2ByClw5z3c7ZzrZfDohZeWmgsIhQCqGdLb
         enZeVVAL1YvJTh98QAJWW+gNLc3w8gOlMx7EHMI9W8YW86tbddd3R7pMzvlyzJ3yn/oZ
         kqDsRiBdZ3KacTEaWPkj20wTWsrTHo+aa1UjB1prz5y9+maRvd0fXgf/0jAiUhIpwF9V
         7v6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C56Q+YV0i1VwzqpPgsaApjf/2tDIDNvnJyLhwVpmM08=;
        b=Ad91GSbJHWcO9DJKAF/BDLMbzFI7nKK/wtXz1W3v5+TB0ZvLYBTYJdeIHkk9Jm06tS
         zQeo802LpFXTRD3OitMk8je4UliCQYKkGLJbQu/YLYDkuxTq+O2ErEYMCfv033PvytY5
         SC97H4+GIi/tjJ+5F2MZ1Z5M2awbj8PWbqY0Z+YDFwxPwO3hCHTHv3m9E8tKDpMCIZUn
         +mNpu9mwJUQ4XuUUsbUalkM2xIkxNM2KE65fM926UwMBMl8FGRwm8Q2TaLRhzWyo2Nk6
         LV+MRc0wbpzDEHfFPnuxhnZK9sI2Dox6oAGxucSJ3V1XSdPJqU6XrBW67Rz79Pxx9vOk
         gk8A==
X-Gm-Message-State: AFqh2kpr4VJZ41Nf5Wj/Ne/fdbmbM5S/f7Okf0stOtDk9deIW7/n2YYx
        Tt+assLK9ujCSHZgA+mHU9Wmhw36vWqNAg/o+1s=
X-Google-Smtp-Source: AMrXdXvn2i6HaIrfxddXHKW8uWfQuesdmK+R5uaTXFkKyLxV5lBf/AzsFhSKu18KoIrf3P17GGps6b+Anq4ODv4dN14=
X-Received: by 2002:aca:1b0a:0:b0:354:7fcd:4e27 with SMTP id
 b10-20020aca1b0a000000b003547fcd4e27mr2936736oib.239.1673053514472; Fri, 06
 Jan 2023 17:05:14 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6808:2387:0:0:0:0 with HTTP; Fri, 6 Jan 2023 17:05:14
 -0800 (PST)
Reply-To: jamesaissy13@gmail.com
From:   James AISSY <samueltia200@gmail.com>
Date:   Fri, 6 Jan 2023 17:05:14 -0800
Message-ID: <CAOD2y7m3GtkyXk8hC+jFv8Y+=dwA8sv5hep4ho_YLE7RWk+hVg@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hello My Dear,

I hope this message finds you in good Health.

My name is Mr. James AISSY. I am looking for a partner who is willing to
team up with me for potential investment opportunities. I shall provide the
FUND for the investment, and upon your acknowledgment of receiving this
Message I will therefore enlighten you with the Full Details of my
investment proposal.

I'm awaiting your Response.

My regards,
Mr. James AISSY.
