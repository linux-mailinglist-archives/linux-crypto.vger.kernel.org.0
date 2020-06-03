Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8B7C1ED906
	for <lists+linux-crypto@lfdr.de>; Thu,  4 Jun 2020 01:22:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbgFCXWX (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 3 Jun 2020 19:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725863AbgFCXWW (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 3 Jun 2020 19:22:22 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9405FC08C5C0
        for <linux-crypto@vger.kernel.org>; Wed,  3 Jun 2020 16:22:22 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id er17so2045275qvb.8
        for <linux-crypto@vger.kernel.org>; Wed, 03 Jun 2020 16:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=Xs1c6/A8GmpgdbMBrIroEWmoFbf3qfcFFbhS2ULR81Q=;
        b=kzeDpVKvTaxqv1Hw9U1YcCf1w9AveZoMQlfBBSMn15TfEhKT+ObTIIutqSQzt1tUqP
         7iiKufIUI5yECjau+nlm3Gjdk5C1ENqeL78c6vAifsGgeiJloFVBeguB2xjdd2KRRrs1
         +01NPlsb4Wu11fhFqOvPkPsTHw1f+RaHsiivfv5aPllCJP9lAihXqibTc2Zfc10IcfBt
         vD7S7+8kkUt1CrwxELDEx0M/v5vvTV8cY18smM/38JiieagAeBYf+w/gCrppaI6nuBQi
         Oc/fc3owYzpm+gT8IoUY2+BiYEiQND73TdmSwc//cRLnsPK8fOs4kTONbDwFVg7RbOal
         E4MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=Xs1c6/A8GmpgdbMBrIroEWmoFbf3qfcFFbhS2ULR81Q=;
        b=r1NHYifyZXZXhf+l2OY7DaAoxibVg6D94Xix/H/nyf0LDCMdPSED/T3W3RK+jJqjEP
         4xwvMxNmx07xSYCPCSfTGlwMajkqv1MVtljtVrT/gqC3Lv/UdYCJkX4H/xiYB8unmW8s
         rix6ZT7AaSNeYdJOqLLptkau4gYAC+x3MZwvMyn4OuuszxmYs4k5ZxoCA7ckF3hKt0RF
         xfMycDOAXDP8qUK7jZ09EtiMkNLZenYQ5+748sKwfgDiu2rlrKCrMcNBwi3/5+fDYUfQ
         RRYJr3VjfpDn/m4eVR/syW8gauhwB4MVfCEpFFvxAw0aU2Z3tnc8h7bhEkOEaSwK35h7
         YRTA==
X-Gm-Message-State: AOAM531fa0cSGWRtTpzOnzYDQdfdyGh/Bn/l566vGpgGFJOsNj/8ajgD
        k+z7kOVc6VIg2AKULLOZmpWn9vHPUDV8qX+SYz4=
X-Google-Smtp-Source: ABdhPJx0fiJOCT59iWG77WB7levxMaxsZvnmXrcjOESgBLMnIJ3viupdsVDDJkFYsU4QDtimbWZKpWHD/C1S9et7OsM=
X-Received: by 2002:ad4:43cc:: with SMTP id o12mr2265835qvs.62.1591226541815;
 Wed, 03 Jun 2020 16:22:21 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrahmedmuzashah@gmail.com
Received: by 2002:a05:6214:412:0:0:0:0 with HTTP; Wed, 3 Jun 2020 16:22:20
 -0700 (PDT)
From:   "Mr.Ahmed Muzashah" <ahmedmuzashah@gmail.com>
Date:   Thu, 4 Jun 2020 00:22:20 +0100
X-Google-Sender-Auth: flg2ccOBLRjhSS469XxddBfmD1k
Message-ID: <CAMYmOn72BsDGj-E2jXruN7HxMXsttYQ4A3zgM4DxjzcF77pJgA@mail.gmail.com>
Subject: From: Mr.Ahmed Muzashah.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Good Day,

Please accept my apologies for writing you a surprise letter.I am Mr.
Ahmed Muzashah, account Manager with an investment bank here in
Burkina Faso.I have a very important business I want to discuss with
you.There is a draft account opened in my firm by a long-time client
of our bank.I have the opportunity of transferring the left over fund
(15.8 Million UsDollars)Fiftheen Million Eight Hundred Thousand United
States of American Dollars of one of my Bank clients who died at the
collapsing of the world trade center at the United States on September
11th 2001.

I want to invest this funds and introduce you to our bank for this
deal.All I require is your honest co-operation and I guarantee you
that this will be executed under a legitimate arrangement that will
protect us from any breach of the law.I agree that 40% of this money
will be for you as my foreign partner,50% for me while 10% is for
establishing of foundation for the less privilleges in your country.If
you are really interested in my proposal further details of the
Transfer will be forwarded unto you as soon as I receive your
willingness mail for a successful transfer.

Yours Sincerely,
Mr.Ahmed Muzashah,
