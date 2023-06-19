Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6749735CCF
	for <lists+linux-crypto@lfdr.de>; Mon, 19 Jun 2023 19:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjFSRMi (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 19 Jun 2023 13:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjFSRMi (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 19 Jun 2023 13:12:38 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E9F124
        for <linux-crypto@vger.kernel.org>; Mon, 19 Jun 2023 10:12:37 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f87592eccfso1054851e87.2
        for <linux-crypto@vger.kernel.org>; Mon, 19 Jun 2023 10:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687194755; x=1689786755;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=vQAUOrPXn6hnyW1xGNKR90NL5F/m065xQVWM8YyKMeE=;
        b=AoevGuGQDz2HpIbVq0HvNaChcf04+3QxXQWiH/NxuzOnO6vsRcFanPjRVZ6hChoRgF
         8BjOB7c6ELCac0+GsyQjGRt6axNk8HDSQO14Ib/9f4k+i3KDdHJZH4r+qRXMer+WRwmw
         N4Pr0/3SsRfraQF19opzy0LcEm2NwTSTmnfzmaik3reTc6032ddjipifckLIaCVULrVK
         2mqoMUXW99BUn+DsdMB1lLhwo3xOzMnz87wAZlBl+ok3Tkm6JCAbcaOJ/T6uj0lB1mUN
         j90MBkGw2+LNRZ/g1M0HBujJl2fcMAr9knikZEZrJcSo5a/N8YLTZl3i/9O5/vkM0dRu
         mnmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687194755; x=1689786755;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vQAUOrPXn6hnyW1xGNKR90NL5F/m065xQVWM8YyKMeE=;
        b=YBPdjCHs3rS81M+kv6nCoac5qfjYYUtn4taNnCmHguSFZxCNt8yld176cpNWXRu1mU
         U8mpWYooTj4JxXZkac4P9ed1lU4Npdkx/WlJjtXcgvoWVGPSuAqC1se0dWEgQi5PGUAo
         UKAoyGV+/MSLyChysDmNhdWLHkGtlPxJJalMNrmTPr6+YLUdldz0c0t4bduOm2CAGjJs
         yEe5dRQWVpdqlP7dMCNS1lHJlFcl3xKPk66cdHeKmexsJjymWWnnti2ny8fm2Xx9J23E
         3Edf+WBy7UWmXK61Vd6VyY8S5BNWSW2wQD4f3+SmybwUJz3o/N6YnbhHhlSbE3Ivuo2R
         fNAw==
X-Gm-Message-State: AC+VfDwNkg0quYaiDzv/wc/0eYJPU7OSSe3+GzLowRS4xZXixyQLLRUD
        5h2v+LOh4XeiW9iRwrckKB3iSw+6PyY8uvTKvdw=
X-Google-Smtp-Source: ACHHUZ7gplRm8NLFL1CVHe3fAW2eWNwAFjuYEOEHEMvPdAnKJFFe8iSA5bnSJ0L4gIuFJpQS2byg4MGQBOJWgxHAwr0=
X-Received: by 2002:a05:6512:1c5:b0:4f1:3eea:eaf9 with SMTP id
 f5-20020a05651201c500b004f13eeaeaf9mr6235527lfp.24.1687194755016; Mon, 19 Jun
 2023 10:12:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a54:3650:0:b0:21d:fa84:1814 with HTTP; Mon, 19 Jun 2023
 10:12:34 -0700 (PDT)
From:   Lending-club Corp <noahlin39@gmail.com>
Date:   Mon, 19 Jun 2023 10:12:34 -0700
Message-ID: <CAKLJvuZneTsLwsmG-ERJAV6gdqw+w-qA=Hv_n3u3vnp6xpkkOQ@mail.gmail.com>
Subject: RE:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hello Investor,

Greetings,

My name is Tom Casey, I'm a Financial Lender. I offer personal Loans,
Real Estate, Business Loans, Bridge Loans, Commercial loans to
individuals/companies who can utilize it well and make good returns
within the maximum time duration of 10 years and amortized over 30
years at 5% interest rate.

Minimum Financing: $20,000.00
Maximum Financing: $50,000,000

If interested in my service you email the executive summary with your
business plan.

Below:

Name: Johannes Willem
Email: jeswillem01@proton.me
Direct Line: (810)243-4877

Kindest regards,

Tom Casey (Mr.)
Chief Financial Officer
Lending-club Corp
