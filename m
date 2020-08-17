Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B8F2478E8
	for <lists+linux-crypto@lfdr.de>; Mon, 17 Aug 2020 23:34:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbgHQVet (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 17 Aug 2020 17:34:49 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:33181 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgHQVeq (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 17 Aug 2020 17:34:46 -0400
Received: by mail-il1-f196.google.com with SMTP id r13so11411876iln.0;
        Mon, 17 Aug 2020 14:34:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=M17OJ6k51qxI3ec/ySrRyXYB06yaGD5CoRfH7xHKp+Q=;
        b=O+uxKdr/WmdPod41FKEZ4HC2dh1VfyARrXrsQoZScOhOKULelYl4a3s3AyL4gBt0vi
         7G2JAdUGed734p7To/Ckoob4j8OMzPIYIGG127Jvk55wBTZYa34ed2UVu+2auMQhroCq
         qdpGPWtf7D/UE03f5hVf82KuWgzUTYXqRhOIs7nKSUbzuAmMH1TnbRqiqYZOjqJdS8kt
         6fDeLQ3RkPvrxngmXgOVnT0Og7ev//BkaYm4q/Fjhi+y43PWM+RGQ5Ys6pG99ZdNLOlt
         2Wi4fMsVU+sdAMtbIzoY4GTsqHu6ae6+BSYZ/IwfmbskXztzdmxuGnH83cYVzvqjteiy
         cV7Q==
X-Gm-Message-State: AOAM532MLSyW+gpTvWlxitYDJ0CNskyiXDGuIGC1ZFlL9wYyXvmQ5cL/
        no9PzvYCPYZg+oHmVrFP+Q==
X-Google-Smtp-Source: ABdhPJxQbJ20eP2dxZaWGNcGWNFQy3RfTLGBs6D+3dMQARE7ctR6XhuOf2CzwwEt95w6FAGFcjA4Vg==
X-Received: by 2002:a05:6e02:13ac:: with SMTP id h12mr14963174ilo.153.1597700085465;
        Mon, 17 Aug 2020 14:34:45 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id m7sm10148537ilq.45.2020.08.17.14.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 14:34:44 -0700 (PDT)
Received: (nullmailer pid 1606763 invoked by uid 1000);
        Mon, 17 Aug 2020 21:34:43 -0000
Date:   Mon, 17 Aug 2020 15:34:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <Anson.Huang@nxp.com>
Cc:     linux-crypto@vger.kernel.org, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, s.hauer@pengutronix.de,
        s.trumtrar@pengutronix.de, devicetree@vger.kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org, Linux-imx@nxp.com,
        marex@denx.de, linux-kernel@vger.kernel.org, festevam@gmail.com,
        kernel@pengutronix.de, herbert@gondor.apana.org.au
Subject: Re: [PATCH 3/3] dt-bindings: crypto: Convert i.MX sahara to
 json-schema
Message-ID: <20200817213443.GA1606655@bogus>
References: <1596595410-26921-1-git-send-email-Anson.Huang@nxp.com>
 <1596595410-26921-3-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1596595410-26921-3-git-send-email-Anson.Huang@nxp.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, 05 Aug 2020 10:43:30 +0800, Anson Huang wrote:
> Convert the i.MX sahara binding to DT schema format using json-schema.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  .../devicetree/bindings/crypto/fsl-imx-sahara.txt  | 15 ----------
>  .../devicetree/bindings/crypto/fsl-imx-sahara.yaml | 35 ++++++++++++++++++++++
>  2 files changed, 35 insertions(+), 15 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/crypto/fsl-imx-sahara.txt
>  create mode 100644 Documentation/devicetree/bindings/crypto/fsl-imx-sahara.yaml
> 

Applied, thanks!
