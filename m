Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5224A95A5
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Feb 2022 09:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240523AbiBDI5J (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Feb 2022 03:57:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbiBDI5I (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Feb 2022 03:57:08 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E4ADC061714
        for <linux-crypto@vger.kernel.org>; Fri,  4 Feb 2022 00:57:08 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id z10-20020a17090acb0a00b001b520826011so12485786pjt.5
        for <linux-crypto@vger.kernel.org>; Fri, 04 Feb 2022 00:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=rEZHPtTYwYFHcaoydcDiytoYayWweLfiDiLNuPR2XCY=;
        b=O2wzTg3LycXOUpnlqFGmYSObICBLs0OHtrXMQypjN0bBWEdnN9nvf5wTwS1c1n/o4n
         vRWVPOARojQ1pVVQw87UzxDyH8vHuMHp4dBLIyvu3K8oTJMo7ksCztD1041UIy2nUuXs
         ZwbBPwSeuNbrTEPlrTD4B20naavQ8v8O9MK+IxYcCfas1fBUU1srFTSA03THqlj1Oilh
         9tOefarjzjM6rIOYOCrClGS2JnNPtLtauZ01xilAgAO9q/iFs965s4YcxApdhfS0vhxm
         RFUiS06sVTQ2ReQ+LCffEvcl0XBx42CjzlPEIQzVidJEQPSptc2u2d55rwIWF/KLIPH0
         tuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=rEZHPtTYwYFHcaoydcDiytoYayWweLfiDiLNuPR2XCY=;
        b=TBKQCls6M4FAFTY9Z/WRVNXEshD3BCNEKkMYPdCAtzI80gZ2JG3E2yKp2PVQ4BBU1P
         3q4h7miH0uFBEv/PqtTIRC8uzXXf35xUdbENOH0MpLIDa6F7hPcmRmB3iOExNTyrsSHh
         sWv84k0zguPxZTTGsRZM37vFpQXtdyJ3TM4vBXcEficcZIruo43jjNnLQnFJ1pyhYvke
         DvNvUEt5aQeOrftSnQDtGaJYl2bWN/9AqRaU4EavjWEFA4FGHXRaI+27rEe4jcXQhMTJ
         h14qaqsz51587/QWEXyFI6blsl/AO5OUDMUEzApqdRsatEO9/DLojPqy9vKdoUL7R4B2
         hraw==
X-Gm-Message-State: AOAM533T7ROFIcdzFW1Lks0ZOnBlSYycEoafvxyx/HAiH3dsJyTaTZQ6
        Y//hgUI2wP3G3IoRv1ej95Gh4RGiPkYYbAc9O+M=
X-Google-Smtp-Source: ABdhPJxhkTCQLxEVQjLa0C00JPcwgv1yG6FKMmvcMHbENi/LUmcj88WbtYVksHnZAJciODIj/PvUdg+DUu2m5TR+hCA=
X-Received: by 2002:a17:90a:5304:: with SMTP id x4mr2017983pjh.64.1643965028065;
 Fri, 04 Feb 2022 00:57:08 -0800 (PST)
MIME-Version: 1.0
Sender: rosejohncarlson@gmail.com
Received: by 2002:a05:6a10:e208:0:0:0:0 with HTTP; Fri, 4 Feb 2022 00:57:07
 -0800 (PST)
From:   Mrs Carlsen monika <carlsen.monika@gmail.com>
Date:   Fri, 4 Feb 2022 09:57:07 +0100
X-Google-Sender-Auth: k_3nPBEcddR6570GZGuiX-CZ0ao
Message-ID: <CACeO-SmwS2g7F1GnDhdFtk+-+MEinQ3+nxc1cmLp7DiYr7785g@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hello

  I sent this mail praying it will found you in a good condition of
health,since I myself are in a very critical health condition in which
I sleep every night without knowing if I may be alive to see the next
day.am Mrs.Monika John Carlsen,wife of late Mr John Carlsen, a widow
suffering from long time illness.I have some funds I inherited from my
late husband,the sum of($11.000.000,eleven million dollars) my Doctor
told me recently that I have serious sickness  which is cancer
problem.What disturbs me most is my stroke sickness.Having known my
condition,I decided to donate this fund to a good person that will
utilize it the way am going to instruct herein.I need a very honest
and God fearing person who can claim this money and use it for Charity
works,for orphanages,widows and also build schools for less privileges
that will be named after my late husband if possible and to promote
the word of God and the effort that the house of God is maintained.

  I do not want a situation where this money will be used in an
ungodly manner.That's why am taking this decision.am not afraid of
death so I know where am going.I accept this decision because I do not
have any child who will inherit this money after I die.Please I want
your sincerely and urgent answer to know if you will be able to
execute this project,and I will give you more information on how the
fund will be transferred to your bank account.am waiting for your
reply.

Best Regards, Mrs.Monika John Carlsen
