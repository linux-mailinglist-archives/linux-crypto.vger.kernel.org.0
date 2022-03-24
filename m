Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E654E5E85
	for <lists+linux-crypto@lfdr.de>; Thu, 24 Mar 2022 07:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238260AbiCXGMM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 24 Mar 2022 02:12:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbiCXGMM (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 24 Mar 2022 02:12:12 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E1B5AEEE
        for <linux-crypto@vger.kernel.org>; Wed, 23 Mar 2022 23:10:40 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id b5so4750728ljf.13
        for <linux-crypto@vger.kernel.org>; Wed, 23 Mar 2022 23:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=LqfrhH7nLLN1gFNpfkxdVh8qEuR20wWFYGhJe9S517U=;
        b=iSWT8vdc0yh8SYKvhuJvzQ6NVn1IxgAjTuZEFO1ykT13+epT5g7ufWwM+n3wVsMIvD
         Oqa49d/1hG5loWRMKTYhQOkaVSnaNjItyxyOYSMTJMJs/zuJQXhvGrOHJFLXc+bbgZMu
         v79J4bMOv3va4ogUV7REzdILG6gdDR0x4hLTUzfd7j5HZgbaLEoiEETYlRSBNiHRdBSO
         WmUlOgf8FbQ2nXVQ2b9U3xjfYrpBQ2BXts7IuMGxPyESeSJpNy1yCtV6ls6OP5T7pX6j
         vy1abDaGxQsndufKA+scn/28b6MIFlN5SQsIZWDVeK7dsxiX2+TyV1mdvi6Krs6BJj41
         egBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=LqfrhH7nLLN1gFNpfkxdVh8qEuR20wWFYGhJe9S517U=;
        b=5+aAJIC2Z3SPovR6LALtpZ63EZv0HBHofKWKuwYFrg1k7OwZvmeYU/ttO+WOxk7Mt4
         nrJ3uDwgEnpiIkSrypugGDhdZUU00OPd4xZAwF4xkjAd93HRXgLrgXiz+ETn27emUIwc
         i3mPPKojzOiqNkwtiDL+SmsQvPBdLn0YRop/Mhii+jiisTCYgauwKI6RJSE0c0C6eXFc
         554wDwMr7vq/1a0sOK6aYmiV+PyX+im0v7dddSL5qquuADQhiG0W8nKXE0nM/7ZLwkDN
         yUO2H4U5BSfGhmTpkWV/5kMUXVAzJVTJgBEVh8fn07981KYuHU36ale3Baiz8fSDBaWu
         LqEg==
X-Gm-Message-State: AOAM531botw0vRe2GpV8/YJLrgJBRv3KsM/3Bru4Q7uOq69+FHnveihg
        nbV29E0dVTkHSs7p0ADtKuAbxRVyHKJBepRwcsRdE8tcwLQ=
X-Google-Smtp-Source: ABdhPJxps7xqXnoV2uIjIdahK9iCgECSWiv/DVl810GrTW+CDJ/GIRCdZsh6a1y5kiT7yU2NJiq1Gf/2jmTzKPhEYEM=
X-Received: by 2002:a2e:7f13:0:b0:247:ef72:9e8b with SMTP id
 a19-20020a2e7f13000000b00247ef729e8bmr2812996ljd.205.1648102238526; Wed, 23
 Mar 2022 23:10:38 -0700 (PDT)
MIME-Version: 1.0
From:   Sandy Harris <sandyinchina@gmail.com>
Date:   Thu, 24 Mar 2022 14:10:26 +0800
Message-ID: <CACXcFm=UTJ_wJL0w4=4kD5xcN+n-oi_4zmaxQqPunQGsPqhO1g@mail.gmail.com>
Subject: Entropy as a Service?
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, "Ted Ts'o" <tytso@mit.edu>
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

NIST have a project called Entropy as a Service; the main goal seems
to be to provide adequate entropy even on IoT devices which may have
various limitations.
https://csrc.nist.gov/projects/entropy-as-a-service

I have not yet looked at all the details but -- since Linux runs on
many IoT devices and on some of them random(4) encounters difficulties
-- I wonder to what extent this might be relevant for Linux.
