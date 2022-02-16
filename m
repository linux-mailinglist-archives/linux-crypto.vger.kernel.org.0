Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1794B93C3
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Feb 2022 23:19:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbiBPWUC (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 16 Feb 2022 17:20:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbiBPWUC (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 16 Feb 2022 17:20:02 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB6D22219E
        for <linux-crypto@vger.kernel.org>; Wed, 16 Feb 2022 14:19:49 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id m3so377263eda.10
        for <linux-crypto@vger.kernel.org>; Wed, 16 Feb 2022 14:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=/t4x0utWdS3tLn2CYrDWJUFjQ4mOqUROeNRJxccvFgs=;
        b=GrgKVUyxOMllAHMzmhQUm5Frip2jvgWgPwN4tuAORaxRgfifKJxzknrW4/MdaqFOsW
         ndgjGkfzqVlPl4hZXbAv9Uug2Kqv3pXx1cTpe8pdRi0sYqHISxtPFAO5SWNgp2Z7MvD8
         JhVsesfsZ4Nd+5D15MurzFDFuU/fGi3VzxxqvpDZP13fDiTz44LCa0mMnQKdf6UFs5Uq
         1f/6BvDtP2jGye+amm5/9OLWAsxYIMc/covNk0sYAu+SShE7N1+lvDy5LmyQ4ybJafs4
         2hvudvyuyXbi0U9psX9Fo395GZ311Y+JCCOCo59VACRsYgYyEoH/21tQ5bEsA/S3QNHC
         akog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=/t4x0utWdS3tLn2CYrDWJUFjQ4mOqUROeNRJxccvFgs=;
        b=Ssxn/TnJjpKV/Pa1NzbCSh0ecJ0F3GfPFWih1zxf0Th9ohk6f/FkLBZUSAGRNUvSsf
         YiRfr7RqrZ6LxeqHJTaPpA3LEsLl2dVujPaw4VkJvcTqASHym49fuVjUo49Ilo+ez1UF
         Cks5DrONhFRCH45HicN4zswDId7/z4MW5rpPBvrdL0g2TK6lBjl61sRHH4rNo0bgo/PO
         FRjDud4hchmOgL096sgyzRtsvdYkEu3r/ubwl+vt2arrMiiA1CPzzqPovD7hG511ZPBY
         jM1ATN7jFQEQ/PEHexrMyCBAGmOQ4fjWWL64fTClhPy3GJuEJgaO8L3sXi0iDRw1n/oQ
         rJLA==
X-Gm-Message-State: AOAM5327WsIOZ1OHmvc2ZgcGdhF9YssWXVD4dBQg/96+9DJ7TNAYW9Aq
        FMogmTWTAZlHPPKZQW6hAGVT12kydLct0cx8rFY=
X-Google-Smtp-Source: ABdhPJzqrh7VCWkBQ+5NcaRgI0kiCapeojIQGZ32AJyuopWDgAevmFxdKP3baFy+aiFw9pT8Uz3gu8eyw6PByoFg+UQ=
X-Received: by 2002:aa7:c982:0:b0:406:3862:a717 with SMTP id
 c2-20020aa7c982000000b004063862a717mr5377872edt.358.1645049988084; Wed, 16
 Feb 2022 14:19:48 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a17:906:9f1a:0:0:0:0 with HTTP; Wed, 16 Feb 2022 14:19:46
 -0800 (PST)
From:   Ikuku Ajunwa <ikukuajunwa@gmail.com>
Date:   Wed, 16 Feb 2022 14:19:46 -0800
Message-ID: <CABueqtAKJke4MVFVy2ir4A72pJr0Rk8TrRcvaRrWy8DwEA_eSw@mail.gmail.com>
Subject: waiting transfer
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLY,
        LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Valued Attention Sir!
Our recent record   indicates that you are eligible to receive an
optional repayment of cash fund!! $750,000.00 which has been found in
the security vault registered in your favor under your email account
waiting to be dispatch without claims.
the account is set up under your email address  can only be obtained
by you (receiver),all  you have to do is to provide
Your full Name.....................
Direct Telephone: ..............
And delivery address........... For immediate shipment
Thanks and anticipating your urgent respond
finaccial@citromail.hu
Yours faithfully,
ikuku
Section assistance and   Verification committee
USAfro-Euro   Debit Reconciliation Office
ID 4475 UK London
