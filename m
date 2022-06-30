Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E07AA561519
	for <lists+linux-crypto@lfdr.de>; Thu, 30 Jun 2022 10:31:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233839AbiF3Ias (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 30 Jun 2022 04:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233788AbiF3Iaq (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 30 Jun 2022 04:30:46 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC0C15FF7
        for <linux-crypto@vger.kernel.org>; Thu, 30 Jun 2022 01:30:45 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x20so10784317plx.6
        for <linux-crypto@vger.kernel.org>; Thu, 30 Jun 2022 01:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4McIKk3Fy71FEBWbTbShi+eMKu+z9V5xzjqx5MIKVvw=;
        b=TMHea2JAk1M6WzSofcjJoKfA+33i0AgIltZzhoBGekWsYnqvYCPxG+WtizGQ6qNR4I
         qU1ESZLC94mGR4qzwfENvKbUe26LGvsxIpFPFegDJonDSi9mSjEEYDRPqCzVA1oVhrS7
         KDkqWIoY6LI59ab4rUCoOi6VxlvALxn+S2voTr7tYMCB0Rl+nCOiuZlK31+x4at5Sy31
         nlUhKiyrn+PCzHbGuseeHfYCDsao+xkt2MRHaL8ZZm85GkvRYo1Y3dL/lqIdRkmxSOvH
         YeOCS9HHPGm5QJfHTBa2UzjrNRGo5U1pX30V4xMcC4foNQxeGcGQcC3pyKJjweUffrvP
         1wVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=4McIKk3Fy71FEBWbTbShi+eMKu+z9V5xzjqx5MIKVvw=;
        b=tWxMOzkMChMVmIcipsW10n6m9n24tAm+lOq1EIB0deGcuQvZfoZUbB8MPWLd2T8Whu
         /cF1QWGm0KrdLnVw0u4hvACwKKonlBb4WduUWFNb7Wa1GVETtW4LYkFbpmpRwOc8HHWG
         7GCa3sfLtv5ctQahlR//hT2bTX+4olJYJnVQBAq5D5m9veTt/K+/nZy/tCjP/RWN/ond
         8qoYUUmVcwElognp1Zyk5lmTukBx/qdMmLubOvYxyBLm8d1AN0PYjGstgVOCVdR1yMv3
         YZUxVYmNSO2SaDxq9zellvkGsmPhw++l2T7L670WNqr6HrTLLHM15Pz3RipeVLpctLsW
         Zshw==
X-Gm-Message-State: AJIora8596mjCesXMDW+ThiM00lrYmnAVlSweTzWFzKqNwlaOrO/n22i
        5R/mAq6MdFvkRsTt4EATbgJ4lyjef3rqTQ==
X-Google-Smtp-Source: AGRyM1u0TWreHmpYyOxwUKfR9/FcgtAJxlpQGult60YsdnTIcDCQ2DJgKuzrKXs7fbRKxQMvRqs8Rg==
X-Received: by 2002:a17:90b:164a:b0:1ec:b991:b69 with SMTP id il10-20020a17090b164a00b001ecb9910b69mr10608367pjb.173.1656577845253;
        Thu, 30 Jun 2022 01:30:45 -0700 (PDT)
Received: from [10.76.43.148] ([61.120.150.78])
        by smtp.gmail.com with ESMTPSA id r10-20020a17090a1bca00b001e2f892b352sm1199219pjr.45.2022.06.30.01.30.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Jun 2022 01:30:44 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v2 0/4] virtio-crypto: support ECDSA algorithm
From:   Lei He <helei.sig11@bytedance.com>
In-Reply-To: <Yr1TuPM8yvJUoV9r@gondor.apana.org.au>
Date:   Thu, 30 Jun 2022 16:30:39 +0800
Cc:     Lei He <helei.sig11@bytedance.com>, davem@davemloft.net,
        dhowells@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        berrange@redhat.com, pizhenwei@bytedance.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <CC761178-556D-44F6-9479-5151C69476C8@bytedance.com>
References: <20220623070550.82053-1-helei.sig11@bytedance.com>
 <Yr1JvG1aJUp4I/fP@gondor.apana.org.au>
 <C7191BC8-5BE0-47CB-A302-735BBD1CBED0@bytedance.com>
 <Yr1TuPM8yvJUoV9r@gondor.apana.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org


> On Jun 30, 2022, at 3:41 PM, Herbert Xu <herbert@gondor.apana.org.au> =
wrote:
>=20
> The things is I don't see any driver support in the kernel for
> ECDSA.
>=20

I have explained above why we need a driver that supports ECDSA, and =
this patch
enables virtio-crypto to support ECDSA. I think this is a good time to =
support ECDSA
in the kernel crypto framework, and there will be more drivers =
supporting ECDSA in the=20
future.
Looking forward to your opinion :-).

