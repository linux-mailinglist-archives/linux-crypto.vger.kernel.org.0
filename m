Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72804EC7F4
	for <lists+linux-crypto@lfdr.de>; Wed, 30 Mar 2022 17:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348028AbiC3PQ1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 30 Mar 2022 11:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345142AbiC3PQ1 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 30 Mar 2022 11:16:27 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3191480F2
        for <linux-crypto@vger.kernel.org>; Wed, 30 Mar 2022 08:14:41 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id lr4so33747917ejb.11
        for <linux-crypto@vger.kernel.org>; Wed, 30 Mar 2022 08:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=mYyVSk9hn2QhfGZiN6WiiBihN//oxVVbjeVgSfFvxW8=;
        b=e/z6Mlv3TaqpsQkkMNB8609/jYujmLZfbmgI00OqMRWkjFc7O26X5kj2w1wiH0/ZMU
         rH2o/+WH2/kUkGAHZ14ytNvtvVlX5AomwcWSZNW+ND1T4vIJKUouqgmL6/zp1uf67xKV
         +Ot9aU58Qks9absB/A3136S+vKP/HltE4pdYslnTtBiW2SSr10A5tpxNn/r2l9PIAizq
         vVUNN61xswh3iG8NL3Jkc3NI82m7ca6flQog5fX7gQfMy4cQqixmaYqkOR6WLplMLziS
         2HUoz11a5FbI+jHUaBZ+T707R3e/t89w/x8ocxZU4dJ2+kjrEFiIOfP9VYoyRQiLgtqJ
         GZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=mYyVSk9hn2QhfGZiN6WiiBihN//oxVVbjeVgSfFvxW8=;
        b=efVpxSl6VxolqoZ51LzmmH64xqnF8tnt3dSKGnwcsSpdXtId2pQhXL/U1/ocM+r1yG
         mlDCyZ25UUsIuDu5+HakYJr7LjMF8wtpTkuE0LFtrOhOkKgn0AqIe/Mzl7WWB/3j23mP
         R4sW9bkIkvFtu+DYOZhRdZE258J9xPrcEonjYrE7Y/YMB/S4MLpzhYOiWmWBfK1vgOW9
         wOZmaXguVBC9D4eeYZ7+S33VQ4c3hQmYwqHQQhXZsjRahKSfKhBfWJ76FvNaLxSwEBYr
         zEAOFIsAP8QvNpNwfXdgkXk8zPm8P5wNHoe8noMIlxt8+TMprX6qeUzi86U4wY+yACAC
         9KXA==
X-Gm-Message-State: AOAM5331VLC5ijNyPcYYoGa3PtPpZE0xNVfi4BnZhhRxgMx0I9olWcfS
        WqWa83XCvaRS2WyZuHzvMniWPNTSnEWHqWbghKQ=
X-Google-Smtp-Source: ABdhPJzIizADfkjR1qFaQG7Miuh1iUeh8jeqqyYFINbAj2YfAmfE9h94QdDtX5vCr782kh98fvg24KQlESeUp5GY7yU=
X-Received: by 2002:a17:906:1e94:b0:6cc:4382:f12e with SMTP id
 e20-20020a1709061e9400b006cc4382f12emr39839909ejj.482.1648653280496; Wed, 30
 Mar 2022 08:14:40 -0700 (PDT)
MIME-Version: 1.0
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Wed, 30 Mar 2022 16:14:35 +0100
Message-ID: <CAHpNFcOgt9eGc_aE=7FyshLMGjLM4rxa0nvsxTfWBhrU+W6O1w@mail.gmail.com>
Subject: GPRS for immediate use in all SFR SIM's & SFR Firmware & routers &
 boxes including ADSL & Fibre
To:     undisclosed-recipients:;
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

GPRS for immediate use in all SFR SIM's & SFR Firmware & routers &
boxes including ADSL & Fibre

Cloudflare Kernels & VM linux, I pretty obviously would like to be
able to utilise cloudflare Kernel & Linux & cloudflare is very special
to me

Submissions for review

RS

https://drive.google.com/drive/folders/1X5fUvsXkvBU6td78uq3EdEUJ_S6iUplA?usp=sharing

https://lore.kernel.org/lkml/20220329164117.1449-1-mario.limonciello@amd.com/
