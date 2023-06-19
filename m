Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA4F2734D7F
	for <lists+linux-crypto@lfdr.de>; Mon, 19 Jun 2023 10:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjFSIXM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 19 Jun 2023 04:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbjFSIXL (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 19 Jun 2023 04:23:11 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F4C197
        for <linux-crypto@vger.kernel.org>; Mon, 19 Jun 2023 01:23:09 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-39e9d1bf835so2030517b6e.2
        for <linux-crypto@vger.kernel.org>; Mon, 19 Jun 2023 01:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687162989; x=1689754989;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rJ/7Kbo9gs7zs3QTF5nFKkJrBjocKGAtdax9LA/wsFg=;
        b=NLf6vD/d4D6D+lJPXzleg9rbn2gKSMoq11CpAwhYkVIks3leekaXGsKXSdUAm4yZ1C
         +4YF4j6TuM18yPbH9DNO/VR5i2ViUuQiSi+YkFSky4Q25QePCkbRnJh99uhVGwMwv+8D
         GV9a1riDUUpNw0T0yAFuFDCuAu1/Hz9gD3U092Z1A3KLI+gYBs3KWHeuOFKmCk1s6O1R
         Ll6p3AQWfan4weJOR8lP1xiPKCM/eW53tKENszJdhypPVMv/eaUIzy/GKGWuaPNs7hd6
         P28/JvevALvVKLvH4tBTtIx2dMTLpT3QFNNOh9+IA2d5q+MhVmgOh9NcGIUFKBYu+P3M
         xUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687162989; x=1689754989;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rJ/7Kbo9gs7zs3QTF5nFKkJrBjocKGAtdax9LA/wsFg=;
        b=Dn/ZRoX2OGo9GG3L8b/m0P/pCgdkQWuMl0sWOuFCvYMqcFb8Eu/nz3NkUht+kV+ab6
         +DV8Rmh6S6KiIra0radZIB1T3S68fzhWLL/sWcpDLXqPWc7tENf9jjCJ6/WZr5fYh8kk
         dLCz/Gi1YaMq2PkI/qUhX2SdhjuEuP66PGrAbBiIw53sn0U40ysoAmfpwcB4WaDhCC7O
         s6kD0yg/1kn0EsC35o6lezLNaYJf18KB5kvBNyvAeCZB1Z2agt8vSJukkIh7q5Bt8c1t
         8Usb1NNX2e+HqmEskVAI9BccuwCS5j2gMk4pyELlNHhB3MpDRRoYYbIQm9iHmTy26+dw
         VvQg==
X-Gm-Message-State: AC+VfDxikhnf3kgBdxh4PGc59huyI6XHDBqqKVbibDJNCyhQsDzxrDXB
        3be1QB8xAQRkV8BIHNwjS2sNgPkx3/K7gbXmsdU=
X-Google-Smtp-Source: ACHHUZ7xXWI1tUNtP/JB2dF1+YgJ9pCGhDZ2nbjCMGY6bBUrWZGi7lemw+OtzL1PNiza9ybvjNZEOwjbA7YROhNuljY=
X-Received: by 2002:a05:6808:179f:b0:39e:df4f:e68f with SMTP id
 bg31-20020a056808179f00b0039edf4fe68fmr1411558oib.6.1687162988421; Mon, 19
 Jun 2023 01:23:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:7a03:b0:11f:4412:fc6f with HTTP; Mon, 19 Jun 2023
 01:23:07 -0700 (PDT)
From:   loan offer <skyexpressccourier@gmail.com>
Date:   Sun, 18 Jun 2023 20:23:07 -1200
Message-ID: <CAPmwR52j7zm-Awe-ot5fGOpMsqBUBT3=-J55ZhyWw_ET0GurJw@mail.gmail.com>
Subject: Greetings From Saudi Arabia
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_50,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Dear Sir,

Need funding for your project or your business ? We are looking for
foreign direct investment partners in any of the sectors stated below and we are
willing to provide financing for up to US$ ten Billion to corporate
bodies, companies, industries and entrepreneurs with profitable
business ideas and investment projects that can generate the required
ROI, so you can draw from this opportunity. We are currently providing
funds in any of the sectors stated below. Energy & Power,
construction, Agriculture, Acquisitions, Healthcare or Hospital, Real
Estate, Oil & Gas, IT, technology, transport, mining,marine
transportation and manufacturing, Education, hotels, etc. We are
willing to finance your projects. We have developed a new funding
method that does not take longer to receive funding from our
customers. If you are seriously pursuing Foreign Direct Investment or
Joint Venture for your projects in any of the sectors above or are you
seeking a Loan to expand your Business or seeking funds to finance
your business or project ? We are willing to fund your business and we
would like you to provide us with your comprehensive business plan for
our team of investment experts to review. Kindly contact me with below
email: yousefahmedalgosaibi@consultant.com

Regards
Mr. Yousef Ahmed
