Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B98835EAF45
	for <lists+linux-crypto@lfdr.de>; Mon, 26 Sep 2022 20:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbiIZSKO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 26 Sep 2022 14:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbiIZSJt (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 26 Sep 2022 14:09:49 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7EADBF
        for <linux-crypto@vger.kernel.org>; Mon, 26 Sep 2022 10:56:08 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-3450a7358baso76384537b3.13
        for <linux-crypto@vger.kernel.org>; Mon, 26 Sep 2022 10:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date;
        bh=C237qwozOvl8aPF+8xhmIlNpmWxUmRobeuzg2CJNr44=;
        b=jK9TIq59DfZy+e0VB0TfKuF6yiZ8typeT26sk3FTsMZ/iq8EhrSI723dfVxB+IS2IA
         FGPGJDkqOVxKxBHJC1VBzhUeu+zLbDhWuWo0oixyLYIr/JW5+EwtzK4JslCoAA/c+JGp
         QYAorVZRxMQ4YN2daexX30OjoexEkxAijJA4wVvvyRgqsK52CypPdxcnHCJb9n14d2RK
         GZEaxg/ak/CQSqqldtLuwIamnqd3u63D2B9Bq63AEKgMs6pAneJE6pB07x5WNeQd1/11
         0xJe/HLoGdmc1IyGsZcXdrjmwFuJGuG2s+fBwFXoMvzfm0cMV/QwJOk3BK0TaqYNcVYF
         Y3ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=C237qwozOvl8aPF+8xhmIlNpmWxUmRobeuzg2CJNr44=;
        b=DuOVBAspNmw2BAviIQ+Spe9Zm55fCSsN5Wfn4VxpN8wwY/IfvYxohEntEEhUpg/eo5
         fUbp5iaQin9A3L8Xkpi61F5naljMroLUMSqc0NQKlWXQV7L0f9ybtLLcAcvUx3qZxNr1
         zQPruKN9apn7jiA31xIm5LAWoKp4roRPDknWT3J3V1q36vJGn+AKKr9u+HPaoSifibsd
         lCfEoGYwO36MIdgZadQvI9OZkh3yV9HbB1n7JXiXFrWAfoRxJtLQRWYoe3PQWLwnbLwP
         KA/q0dnx9B1c0tsby6KIOQE4Ep/o7F4J23rAACQ/sQ9gnuSxQ3sYgXDv16VukxcMlv6F
         FV2g==
X-Gm-Message-State: ACrzQf3gq4cYj/7RQjgSNnvbyaSK8VplD9BiHM5WSYCe3j3I2RDgCvQb
        QCOFMPvg9yapfIuPnWA6wqZF629SCeZXYgvrzKQ=
X-Google-Smtp-Source: AMsMyM5Wzb+D7h/EreAlhLLPx6MDCi30wWnhTJDrJZHV9AQPPKu7J6IrI5GX+FEg9+1OSeOnWC9bPco2G8YFUQrCjCY=
X-Received: by 2002:a81:ecd:0:b0:345:6208:da9b with SMTP id
 196-20020a810ecd000000b003456208da9bmr21131516ywo.3.1664214967814; Mon, 26
 Sep 2022 10:56:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:7150:0:0:0:0 with HTTP; Mon, 26 Sep 2022 10:56:07
 -0700 (PDT)
Reply-To: pointerscott009@gmail.com
From:   Abdulkareem Ademola <adeomoade123g@gmail.com>
Date:   Mon, 26 Sep 2022 18:56:07 +0100
Message-ID: <CALzsaxsQBTC+7XDzFanW-Ma1yKJ4NDGwPBKm=C5dyVACh9uJyA@mail.gmail.com>
Subject: =?UTF-8?Q?Bussines_offer_Gesch=C3=A4ftsangebot=2E?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

--=20

Hello, Do you have a projects that need urgent loan??
Granting out loans today in 10,000 / 500 Million to Interested
Investors, Companies & Private Individuals.
Revert back if you interested.


Hallo, haben Sie Projekte, die dringend einen Kredit ben=C3=B6tigen?
Vergeben Sie heute Kredite in H=C3=B6he von 10.000 / 500 Millionen an
interessierte Investoren, Unternehmen und Privatpersonen.
Kommen Sie zur=C3=BCck, wenn Sie interessiert sind.
