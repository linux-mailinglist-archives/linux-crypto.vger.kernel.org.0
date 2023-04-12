Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D290C6DF8B8
	for <lists+linux-crypto@lfdr.de>; Wed, 12 Apr 2023 16:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231660AbjDLOiD (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 12 Apr 2023 10:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231747AbjDLOhw (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 12 Apr 2023 10:37:52 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE39D83D7
        for <linux-crypto@vger.kernel.org>; Wed, 12 Apr 2023 07:37:34 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id e20so11950146lji.6
        for <linux-crypto@vger.kernel.org>; Wed, 12 Apr 2023 07:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681310250; x=1683902250;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A6JQjgUDE1SxlvUoKtzIbQ0h23DC8XvuP/VCa8o54TI=;
        b=T5gVRz4Dc5KkcYBRMTO3Po3Y/Jqm6hyY1UrtYzE0dxYJ38xdEv3nJ1nFuNUDrpbhd7
         RNgRLwMHtzt0DzDbN3swjPAX5sFSULh7G0L/mS8jYCSz+Yn8V1SWxIJjMsqmY7URRPqR
         6pfchuuNmhi+5Ew7AXeZExKYYPxp19JU/dXUxX0Xj8jT96vYLSycjfbIGDJ/tKIjFZG6
         rOW+9wOj3FgC0JZqLRVMTii779WLdJNyz+DH7o2mtdRz6m/qhJ68KBa2Spcqd3gWOgU9
         /YiYMjSsno7/ZDyPDTfkGd9r8RrvN9L8vb9/esOkd26cTuefLJL95sFMNvFtHcAytB0f
         chfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681310250; x=1683902250;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A6JQjgUDE1SxlvUoKtzIbQ0h23DC8XvuP/VCa8o54TI=;
        b=vVD1GzMB/XKVMYHKAd7l6d1PE/n5BBCdWNM49OUe0DPAwMvBQu3PNTSe5rgSa4ZeR5
         rJmbPrfvs6dTrlCgTgdBk3HuDL7YCiifF5tfBqj7b+K02TjMaw6R1FsL4GaaGFE5+Bqp
         r7fVLlafr3NM/zx++eEVvs5eCkDNmzj9FwyyzQnYirbNinED5qL/+lDvHkuyVcJA5veT
         oIqB75Z2j/mWGsudsAXzVlQVir+nhD0yZwnhDljit1RApEy6+U8SKY1/mdx/+dEvfZON
         MZpLoMphqE9UEij30mZ4qKOUKhmdtfKtAw2CNbowogBCGNr6ZY0R1FnzD4HDqQy4/8Hr
         MjbA==
X-Gm-Message-State: AAQBX9cS0nYXSnmo+aw+aCdQyvqEb4c73UFAQ1w3w7R1sNH6AtRHK3eQ
        /TrWi0hTZ+wO3LWzO2gtQRgcp53+VQpHklRVdsY=
X-Google-Smtp-Source: AKy350ZMB7xmZArlXds342LhbqvO03z4y8KYoVn2Ehm0KzQXMeAS3wzAjEn9G5bllFV37DghsVT7Dtvf+FzGXMb/nXA=
X-Received: by 2002:a2e:9842:0:b0:2a7:828c:591b with SMTP id
 e2-20020a2e9842000000b002a7828c591bmr2814071ljj.10.1681310249425; Wed, 12 Apr
 2023 07:37:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:a3c9:0:b0:295:a2a6:905 with HTTP; Wed, 12 Apr 2023
 07:37:28 -0700 (PDT)
Reply-To: robertcurran39@gmail.com
From:   ROBERT CURRAN <muhammadshuwa51@gmail.com>
Date:   Wed, 12 Apr 2023 15:37:28 +0100
Message-ID: <CAFSt9Ug99tiW0Q3eZ0EXWqWin=Qc88Q6Yq1xBka74p2S2j=qKA@mail.gmail.com>
Subject: URGENT
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

ATTENTION:

The International Monetary Fund (IMF) in conjunction with the WORLD
BANK have approved your pending inheritor funds and hereby brings this
information to your notice.

You are required to contact this office as you receive this
notification as your recipient's email is listed in our central
database. so that we can normalize documents on your behalf and advise
you on how to make a claim.

Truly,
Robert Curran
Coordinator, International Settlements Unit
