Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01CDF4DD231
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Mar 2022 02:01:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbiCRBCO (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 17 Mar 2022 21:02:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiCRBCN (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 17 Mar 2022 21:02:13 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18C4B2571B1
        for <linux-crypto@vger.kernel.org>; Thu, 17 Mar 2022 18:00:56 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n35so2460969wms.5
        for <linux-crypto@vger.kernel.org>; Thu, 17 Mar 2022 18:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=/c0Iug26q6VjeWZuRvSdzvpLlZxwZvT/Nmzo+p+K+ao=;
        b=IJzDw1LUzjMz/SaCdpKDlH51qxNhMMrObMRC+x2ibspiWEG5MgXQ67f5+sXOcivbTk
         JYaYmJMfuSAMx0PEutir5WkgDREg0xQ25ofVLj+DTNEgj2Q4FUJlNNrbeevbsMjLAUI7
         s0L8PiEUPKFP2foM2CgUdQK0FJxUDUcAIuRljVvBLa3Cdcfq5PgNpl8bBhoORK/1L0nt
         eCli1UJ1+URUqy7o3ZLW61DViNH2QXTJmYo2UsqE9z6j/DE3CqusTSOIPqAyeg1elXxy
         P5JM9+BNoKMkoOpUyfLQU393L21n1YqcAAQSrmrz6TIf65Qy+SnuX5FFN1DTU6SlVMEl
         GfpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=/c0Iug26q6VjeWZuRvSdzvpLlZxwZvT/Nmzo+p+K+ao=;
        b=0udTsgW1YaL+SaRIYVIDlh6QuG5VuPF3nQuu4fpohGsxMfQB6h/vFOwE5LIg0DzV0Q
         kmgjN0ySutSANNEFrPEUhiRPtdTYwucYo3G6ZdGN+0vgSLkvnO6p9Cr7QJvFrKiTWrGD
         WMYbWblJAqTHTDV8AYVTGFAd7nsNJUAPKGTxwFIYxzI4p/3tXRIPD+KCWLbc0CPQGK3Z
         xN9FePnVUL6wfnZw6/Az1F0LuZBWaI7GF9+UbKhZSJz2uZacW51bRKLv1o/W0qSw8XaJ
         FaWKv+5vD6wBf0OFRkP58dSq6v8L5jUwtkSqSBlwF0U3tMYe9U7/FyB8Y3WxcfxG4Pdv
         N55Q==
X-Gm-Message-State: AOAM531ChMgQ/x6kJHjm7RDlYz7TFa1sWqwgQ4WIuId44r8D2QVFpK7F
        46DrqPjmVt0zs2N3JU24e1s=
X-Google-Smtp-Source: ABdhPJyEMeE0UGjSC77iQUloGWW4P6RbZ113iGQSdPYEKjr8NM1soyC9ymxgQRB2G/jMSj1wvKNPSQ==
X-Received: by 2002:a05:600c:4f07:b0:38c:72f0:1c30 with SMTP id l7-20020a05600c4f0700b0038c72f01c30mr7404801wmq.204.1647565254752;
        Thu, 17 Mar 2022 18:00:54 -0700 (PDT)
Received: from DESKTOP-26CLNVD.localdomain ([197.210.53.144])
        by smtp.gmail.com with ESMTPSA id s2-20020a1cf202000000b0038977146b28sm5560062wmc.18.2022.03.17.18.00.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 17 Mar 2022 18:00:54 -0700 (PDT)
Message-ID: <6233d9c6.1c69fb81.acce4.6ebd@mx.google.com>
From:   Barbara Finance Company <aondoyimatyoakaa@gmail.com>
X-Google-Original-From: Barbara Finance Company <info@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Schnelles Kreditangebot
To:     Recipients <info@gmail.com>
Date:   Thu, 17 Mar 2022 18:00:39 -0700
Reply-To: barbarafinancecompany@gmail.com
X-Spam-Status: No, score=1.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Hallo

Ben=F6tigen Sie dringend einen Kredit?? Wir sind ein zuverl=E4ssiger, vertr=
auensw=FCrdiger Kreditgeber. Wir verleihen Unternehmen und Privatpersonen K=
redite zu einem niedrigen und erschwinglichen Zinssatz von 3 %. Antworten S=
ie uns unten mit Details, wenn Sie interessiert sind. Vollst=E4ndiger Name,=
 ben=F6tigter Kreditbetrag, Kreditdauer, Land, Telefonnummer, kontaktieren =
Sie uns jetzt unter: barbarafinancecompany@gmail.com
