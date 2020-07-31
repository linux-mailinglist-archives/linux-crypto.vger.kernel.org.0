Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1882C234A93
	for <lists+linux-crypto@lfdr.de>; Fri, 31 Jul 2020 19:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729753AbgGaR71 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 31 Jul 2020 13:59:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:36712 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729657AbgGaR71 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 31 Jul 2020 13:59:27 -0400
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EA9922B40
        for <linux-crypto@vger.kernel.org>; Fri, 31 Jul 2020 17:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596218366;
        bh=oQMcmu2PZj2wfwbQ7DATHrWxwELAS0HKL9xiYJcaaUI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=0xEZn/fAIsKSzfon8OXBEc8pOMSUK2PYltLMbpi0hiYX00isD5w2ruU8yh9kqJERJ
         0b2Qb0HyWxxKz5FQd4piTTs3z5NOoDNRFaapW+82iDnheXXw9Ivkayy8oMA+8Ik436
         9VWq1yJEu6/hCl9gD2iwUauarcamc2jsuQ5PwpSg=
Received: by mail-ot1-f41.google.com with SMTP id v6so12511547ota.13
        for <linux-crypto@vger.kernel.org>; Fri, 31 Jul 2020 10:59:26 -0700 (PDT)
X-Gm-Message-State: AOAM530UMx3e5P2shbOhEzIWZ+mFcByOoTrRCOh2DYpA4EmRwn+jENN1
        VStAL2iXB68rMoYbyNiRNzuHcIaJDZmhERUQQg==
X-Google-Smtp-Source: ABdhPJyaL+6siyOp0kkLSX7v+e1+TGBG5/NgphWIZ3qdJlRZRdFE2eH6CEepAd+gDNfaUjP5JckmNDdSrAh70gUhVjk=
X-Received: by 2002:a9d:3425:: with SMTP id v34mr5673otb.129.1596218365762;
 Fri, 31 Jul 2020 10:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200713083427.30117-1-t-kristo@ti.com> <20200713083427.30117-2-t-kristo@ti.com>
In-Reply-To: <20200713083427.30117-2-t-kristo@ti.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 31 Jul 2020 11:59:14 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLcY90MRRi4NAVUwLyYXuHxqApbkuTGh_UjVqym5ecCSw@mail.gmail.com>
Message-ID: <CAL_JsqLcY90MRRi4NAVUwLyYXuHxqApbkuTGh_UjVqym5ecCSw@mail.gmail.com>
Subject: Re: [PATCHv6 1/7] dt-bindings: crypto: Add TI SA2UL crypto
 accelerator documentation
To:     Tero Kristo <t-kristo@ti.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        David Miller <davem@davemloft.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>, Keerthy <j-keerthy@ti.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Jul 13, 2020 at 2:35 AM Tero Kristo <t-kristo@ti.com> wrote:
>
> From: Keerthy <j-keerthy@ti.com>
>
> The Security Accelerator Ultra Lite (SA2UL) subsystem provides hardware
> cryptographic acceleration for the following use cases:
>
> * Encryption and authentication for secure boot
> * Encryption and authentication of content in applications
>   requiring DRM (digital rights management) and
>   content/asset protection
>
> SA2UL provides support for number of different cryptographic algorithms
> including SHA1, SHA256, SHA512, AES, 3DES, and various combinations of
> the previous for AEAD use.
>
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> [t-kristo@ti.com: converted documentation to yaml]
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  .../devicetree/bindings/crypto/ti,sa2ul.yaml  | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/ti,sa2ul.yaml

You left off the DT list so no checks ran:

/builds/robherring/linux-dt-bindings/Documentation/devicetree/bindings/crypto/ti,sa2ul.example.dt.yaml:
example-0: crypto@4e00000:reg:0: [0, 81788928, 0, 4608] is too long

The default cell sizes are 1. Please fix.

Rob
