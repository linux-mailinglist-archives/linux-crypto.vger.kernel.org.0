Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65F3B505CA4
	for <lists+linux-crypto@lfdr.de>; Mon, 18 Apr 2022 18:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346411AbiDRQsn (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 18 Apr 2022 12:48:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346407AbiDRQsm (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 18 Apr 2022 12:48:42 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93DB626ACC
        for <linux-crypto@vger.kernel.org>; Mon, 18 Apr 2022 09:46:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id c6so18060118edn.8
        for <linux-crypto@vger.kernel.org>; Mon, 18 Apr 2022 09:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6N6Bzc7Co9vBma952u0rB5ztm908YSlcIGZvYmyCGes=;
        b=h7gS9hBLMEDNvZocY+FdL2FlnH37wUDz5sEVXOtAOehbslTD8hdEaokGthI1JxFVPI
         tyJ1d/XX6pVoZcRIsY/IEitT0oSYhY6Ahp4mQrHvGIT3kEVr0UIui+cj+oLoy4sbDDrV
         sKkVh9pTMiNBKpccd01lqcnQmetC0WBlACLssgBhBBS5UFOGQGgIMJ6AGN+dLWF5dr1j
         ow4kpvvun4QQV+nUFl8ORMRBpY0eSm6wBJbvP+oDBwGYAYW5w0SknBM7NAHHXeta7Oul
         jw+TH03oHLnkGx/8Udq07mtJsImMacagvKqRpNjtbOBK1512KW3LwEvKaZ7pp3R7/fY5
         FhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6N6Bzc7Co9vBma952u0rB5ztm908YSlcIGZvYmyCGes=;
        b=IOKZmBPbiLu2554hIS994UU00WJdN8wIfidhIyRkpAJIX3fUVM7A3oxPppAfTb9CAs
         3Y1teuvBvu/H6j4VlgxThotFSwLaLB/MRim1jUvLgWQNwdojzUPxRCazPLqxTaLEKe88
         VRuRWlZ+1MmvHtF/ZR5Fyqprhry8u8ARQYGK+/Pp+m09bxc+LZwVIZdETUIGs80jxwXr
         b9hIBoXGn/gN3eT6Uem4KYKQVy1fieKrf11l1mo77Jnw+do3s9UU5ZFlEndI5W7xkIhq
         qzc8PFPHCvda3wGYdojtBH2yeq+zUuKc/WCjEn9ST8TOyCyPi49kSUpCaMOPNIdGBwc7
         1xMg==
X-Gm-Message-State: AOAM533+1TqG8Ccbv18pwal1Msacf+0n80+Uxes2ELrd5rwniDLdTcXY
        vsaKCk0qR93ZXo65ROSX1VqoB2vkInY+hCIlIMY=
X-Google-Smtp-Source: ABdhPJwcssNilOcYCmVFoMDr/kfaeaRcczVbk7LnMIOB3yhSnD0pNplEAIVyuq2wU6TQzJ9JBwksMVAb63MDoCjLzpw=
X-Received: by 2002:a05:6402:51d2:b0:41c:e157:84f1 with SMTP id
 r18-20020a05640251d200b0041ce15784f1mr13160538edd.135.1650300362071; Mon, 18
 Apr 2022 09:46:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220416135412.4109213-1-festevam@gmail.com> <AM9PR04MB82115516947967193216FE60E8F19@AM9PR04MB8211.eurprd04.prod.outlook.com>
 <CAOMZO5BX9JhqJapqfqup9DdzL=nUvO1qBjg_H9R8Ly+hs92ErQ@mail.gmail.com>
 <AS8PR04MB89485964ED3248A45D7ADB27F3F39@AS8PR04MB8948.eurprd04.prod.outlook.com>
 <AM9PR04MB82116FD8C00D305A4955E105E8F39@AM9PR04MB8211.eurprd04.prod.outlook.com>
In-Reply-To: <AM9PR04MB82116FD8C00D305A4955E105E8F39@AM9PR04MB8211.eurprd04.prod.outlook.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Mon, 18 Apr 2022 13:45:50 -0300
Message-ID: <CAOMZO5C4gdY=0+yEVxs_cUg8C_6GcEFi=JNumn0gPEpFambiWQ@mail.gmail.com>
Subject: Re: [EXT] [PATCH v2] crypto: caam - fix i.MX6SX entropy delay value
To:     Varun Sethi <V.Sethi@nxp.com>
Cc:     Vabhav Sharma <vabhav.sharma@nxp.com>,
        "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
        Horia Geanta <horia.geanta@nxp.com>,
        Gaurav Jain <gaurav.jain@nxp.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        Fabio Estevam <festevam@denx.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Apr 18, 2022 at 12:36 PM Varun Sethi <V.Sethi@nxp.com> wrote:

> Fabio,
> We feel that it would be better to have a provision to provide entropy delay parameter via device tree. This offers more flexibility.
>  For i.M6SX we can follow the approach proposed by you but at the same time we can still have the device tree provision.

Yes, agreed.
