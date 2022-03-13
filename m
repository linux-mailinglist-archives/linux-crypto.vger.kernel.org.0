Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C324D7244
	for <lists+linux-crypto@lfdr.de>; Sun, 13 Mar 2022 04:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbiCMDL6 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 12 Mar 2022 22:11:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiCMDL6 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 12 Mar 2022 22:11:58 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84F3F70CF8
        for <linux-crypto@vger.kernel.org>; Sat, 12 Mar 2022 19:10:50 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id l1-20020a05600c4f0100b00389645443d2so7606897wmq.2
        for <linux-crypto@vger.kernel.org>; Sat, 12 Mar 2022 19:10:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=p4GORicRfKYMmuTaUvzvYC0X6pcYWYL8sK1k4bp9fMA=;
        b=CW3WqYBXDcrfLy3J0altxzkAoarRdTo7xKYoHgB2xy9LETLTNrp63m1uxZJpQIXGpq
         vrSOwISRf8ko5OUhoWONCmn3YbUmJfB32kOZvYCD8qVbfjiN3K7pVhuLuADhM7DG697I
         f4oDv4mmWuh+9xOS/wk6QSuuD4ezDKHEEoulcqET1Mn1844ft51gwXEt45j+ZE0GlkIV
         FzDxB55HsANTVS49ZirDizlyXZfw9SYjTf040ZDzU/48+qFi/OfIWApx4CpHbM1HCYim
         M2toHYph39SdtG/Vm88oML6JuhEvUujhTDICG1uF56owCEt9THdEw2udxMTySzEZQ+Z/
         +KQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=p4GORicRfKYMmuTaUvzvYC0X6pcYWYL8sK1k4bp9fMA=;
        b=bj0G4+i04ZyKufQqHvp3CfJWFIiujmstrZyTRznEAcWgR9l5wNHaBD8lhYoIJQZrM7
         Qse0PpBp6kAL6bFwNgPTkAm7Y/HrMgc3d7ayDKZ6o3+YvhRo5I+aYUXDZzk2lUGvXgeg
         +DEhRjsH87ndhndOpH5eX0W7ysBI60JjHkFbUKEWDpQD8/4LRw9I2kB+JbuFnEgdf6RB
         qiwGyZ2jWu48RThTy0EhD2q1v1MBU7oVpYS9I1DglX82nQmfvBdpzVQ6rvETZXoRJ4NH
         DSygSSe3Lq5zjJnqXSvl2BgsV+7wNMc22lcQo1Z9LTg7IGpSD+7GsQGKYtXpYlOkYci3
         5smg==
X-Gm-Message-State: AOAM530w1QenqVSWniiqF/fJe6A7HGDJsnSaG2TYYr4RoJc/nrA2YGY1
        sAAzbNcF2XS2S4+h2MbGRN0LP9oW8l2YVg==
X-Google-Smtp-Source: ABdhPJxLkD078n405mOjfXX2KEdEATUlu0MdCEjoCEM1le/eA5pjKo0tx5sFT3jI4lGeQtW4qJO8lw==
X-Received: by 2002:a05:600c:4f8f:b0:389:eae9:90bb with SMTP id n15-20020a05600c4f8f00b00389eae990bbmr8388312wmq.97.1647141048660;
        Sat, 12 Mar 2022 19:10:48 -0800 (PST)
Received: from DESKTOP-26CLNVD.localdomain ([102.91.5.233])
        by smtp.gmail.com with ESMTPSA id g11-20020a5d554b000000b001f0326a23ddsm10049455wrw.70.2022.03.12.19.10.43
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 12 Mar 2022 19:10:47 -0800 (PST)
Message-ID: <622d60b7.1c69fb81.96c40.94e8@mx.google.com>
From:   Mrs Maria Elisabeth Schaeffler <deargideon04@gmail.com>
X-Google-Original-From: Mrs Maria Elisabeth Schaeffler  <info@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Spende
To:     Recipients <info@gmail.com>
Date:   Sat, 12 Mar 2022 19:10:38 -0800
Reply-To: mariaelisabethschaeffler88@gmail.com
X-Spam-Status: No, score=2.1 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        HK_NAME_FM_MR_MRS,LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org


Hallo,

Ich bin Frau Maria Elisabeth Schaeffler, eine deutsche Wirtschaftsmagnatin,=
 Investorin und Philanthropin. Ich bin der Vorsitzende von Wipro Limited. I=
ch habe 25 Prozent meines pers=F6nlichen Verm=F6gens f=FCr wohlt=E4tige Zwe=
cke ausgegeben. Und ich habe auch versprochen, die restlichen 25% dieses Ja=
hr 2022 an Einzelpersonen zu verschenken. Ich habe mich entschieden, 1.500.=
000,00 Euro an Sie zu spenden. Wenn Sie an meiner Spende interessiert sind,=
 kontaktieren Sie mich f=FCr weitere Informationen.

Unter folgendem Link k=F6nnen Sie auch mehr =FCber mich lesen

https://www.forbes.com/profile/maria-elisabeth-schaeffler-thumann/#443b4a6e=
19c7

Gr=FC=DFe
Gesch=E4ftsf=FChrer Wipro Limited
Maria-Elisabeth_Schaeffler
Email:mariaelisabethschaeffler88@gmail.com

