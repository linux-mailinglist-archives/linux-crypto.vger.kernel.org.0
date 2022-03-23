Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372C14E5334
	for <lists+linux-crypto@lfdr.de>; Wed, 23 Mar 2022 14:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244309AbiCWNiD (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 23 Mar 2022 09:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244326AbiCWNiC (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 23 Mar 2022 09:38:02 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44FA5F8D6
        for <linux-crypto@vger.kernel.org>; Wed, 23 Mar 2022 06:36:31 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id u26so1829128eda.12
        for <linux-crypto@vger.kernel.org>; Wed, 23 Mar 2022 06:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=eoJL8/ssTz//H6D1ky8wIdZCZtyYwQOapMLC4rpTJK4=;
        b=bNAXkMThypJ8Fp6kfoI5Ak+DXC/qipME9qq62aGmE5rQINI4bXll1STdm+yJBTY1XJ
         MAB6Colidi9wkqYkm7XWQwOKwYmnk4N/8QwaoLXdCBDgbO31bDjqhqNM7981z02PuoO3
         M5L7fKggjZfAXBPxbyqoGJX8NduefdgX+vtezqdHOYoYD18Z5xNXH5mk1vIXUsDfCfO/
         dURe8v8nEofP406hTLidblrYU8cfLUmEEdN7mt1/VBpZE2j2IUxhkmXtSwrxT0EowZJY
         MteICWcMF6ES9/2/i6lSw8Gu7YZwdZjcjbUzz6HU0lS5Vrt7EMjMCphuPwK0KJ+6ciVZ
         NmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=eoJL8/ssTz//H6D1ky8wIdZCZtyYwQOapMLC4rpTJK4=;
        b=7fhLUcK1PjZEOJ/AbcD4rh2P/5uwJ5GUc/mwVXRoAJ12Di7FuKzkNpcoSnvCIiOM2x
         5IXdS7YoUn4rsBYgLsOR8mUXOfizJUr32CGQ+wyO5CZR7SoRo4Xc3gaHPKOeZSm4bm9z
         iWZUYgX5AMzM0LOsTcJiSuWXkSOpk+C5YjgbbB9UPnTR5pcpb2nXi7jyVJLXpRfZ9GCk
         1MmtRvXiMx1R3vzr7U9roocXTU2GVmfOEA1eaGIjgVq9HdAt/BKzirAIlC0d1AZxlLu0
         ksineq9xBdrStG5H1LRHdpGgMpSuWPPSSYhGrhodXKJ57zjKFglDwSSiWpFN7FqRuMju
         dsgw==
X-Gm-Message-State: AOAM530GVsGl/x+t/HU38W+LFSmRarRRDGpGrjbbBi0Ta+1WNJ5EgT3x
        5QQ9GSgFwfiW/OawkpVVkUybJQbTeqaSaQVSGiM=
X-Google-Smtp-Source: ABdhPJwFcJm7rfKsAySs+0vGMiLsgkerhO1IJaAaoI5nIsMNewFDbxma8gXpcBnrN9wIhl6vxQwOyxG97McgmzXPrzY=
X-Received: by 2002:a50:99cd:0:b0:418:d6c2:2405 with SMTP id
 n13-20020a5099cd000000b00418d6c22405mr67804edb.342.1648042590389; Wed, 23 Mar
 2022 06:36:30 -0700 (PDT)
MIME-Version: 1.0
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Wed, 23 Mar 2022 13:36:22 +0000
Message-ID: <CAHpNFcM8p5hZ=wC5s+5JOw03yJbC-ZqApX0Cqpa48p=QdszTeg@mail.gmail.com>
Subject: Nostalgic TriBand : Independence RADIO : Send : Receive :Rebel-you
 trade markerz ***** Dukes Of THRUST ******
To:     torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

***** Dukes Of THRUST ******

Nostalgic TriBand : Independence RADIO : Send : Receive :Rebel-you trade markerz

Nostalgic TriBand 5hz banding 2 to 5 bands, Close proximity..
Interleaved channel BAND.

Microchip clock abd 50Mhz Risc Rio processor : 8Bit : 16Bit : 18Bit
Coprocessor digital channel selector &

channel Key selection based on unique..

Crystal time Quartz with Synced Tick (Regulated & modular)

All digital interface and resistor ring channel & sync selector with
micro band tuning firmware.

(c)Rupert S

***** Dukes Of THRUST ******

Autism, Deafness & the hard of hearing : In need of ANC & Active audio
clarification or correction 2022-01

Sony & a few others make noise cancelling headphones that are suitable
for people with Acute disfunction to brain function for ear drums ...
Attention deficit or Autism,
The newer Sony headsets are theoretically enablers of a clear
confusion free world for Autistic people..
Reaching out to a larger audience of people simply annoyed by a
confusing world; While they listen to music..
Can and does protect a small percentage of people who are confused &
harassed by major discord located in all jurisdictions of life...

Crazy noise levels, Or simply drowned in HISSING Static:

Search for active voice enhanced noise cancellation today.

Rupert S https://science.n-helix.com


https://science.n-helix.com/2021/11/wave-focus-anc.html

https://science.n-helix.com/2021/10/noise-violation-technology-bluetooth.html


https://www.orosound.com/

https://www.consumerreports.org/noise-canceling-headphone/best-noise-canceling-headphones-of-the-year-a1166868524/
