Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67A6266FF3
	for <lists+linux-crypto@lfdr.de>; Fri, 12 Jul 2019 15:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727145AbfGLNXh (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 12 Jul 2019 09:23:37 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38660 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbfGLNXh (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 12 Jul 2019 09:23:37 -0400
Received: by mail-io1-f65.google.com with SMTP id j6so20266400ioa.5;
        Fri, 12 Jul 2019 06:23:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ED7nLvnywkFVSysEQZ0OXOazHI/ma8KNYWcu1c32QPE=;
        b=WMC/sPErkaF5pH850n5h+uitn0l2BoT+D6RS4kkQpGPLmvucTDCARMURUfKW+jhJze
         nO0EqG7nhfO035FsGIQo7uV1HvD3Bv76SoBq19CwQngKXRumut12PfSUhKlPetSFkGVi
         J1eez7EjkGvCsJGEZWDrUHj1nG/76oqmr6Xrq8Y4OIi0KA2wa4rpoh4rY86gKxPWr+Eu
         c+N9gefrY2FQx1lIisOQusBoNL0t3nIQHpDmF5GMEbPQyvhfrpM01TKkvmMxzRnvW5rm
         uLGb71ZWHm84HOJ0M7jp1KcHRn8R8d6lLlv5X5TgGJUVcplR/pV+qAjkMvjPCjeyiu7u
         5OFQ==
X-Gm-Message-State: APjAAAUXua+7X0UFHcsEETKrGT26jas1btuGlEM5eF3gFwsmGn9Ba/2O
        J8bkRl/xc+COUSdalQkwXg==
X-Google-Smtp-Source: APXvYqwtZSqCWcobJ/R917NbEBSOARis/jLrEID6T8BhdTU1lDdG6dMatZvDE3fwzuxxAuJm+RHdiw==
X-Received: by 2002:a5d:8416:: with SMTP id i22mr10620291ion.248.1562937816200;
        Fri, 12 Jul 2019 06:23:36 -0700 (PDT)
Received: from localhost ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id z19sm9502604ioh.12.2019.07.12.06.23.35
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 06:23:35 -0700 (PDT)
Date:   Fri, 12 Jul 2019 07:23:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-crypto@vger.kernel.org,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dt-bindings: crypto: Convert Allwinner A10 Security
 Engine to a schema
Message-ID: <20190712132335.GA14684@bogus>
References: <20190711122301.8193-1-maxime.ripard@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190711122301.8193-1-maxime.ripard@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, 11 Jul 2019 14:23:01 +0200, Maxime Ripard wrote:
> The older Allwinner SoCs have a crypto engine that is supported in Linux,
> with a matching Device Tree binding.
> 
> Now that we have the DT validation in place, let's convert the device tree
> bindings for that controller over to a YAML schemas.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> ---
>  .../crypto/allwinner,sun4i-a10-crypto.yaml    | 79 +++++++++++++++++++
>  .../devicetree/bindings/crypto/sun4i-ss.txt   | 23 ------
>  2 files changed, 79 insertions(+), 23 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/crypto/allwinner,sun4i-a10-crypto.yaml
>  delete mode 100644 Documentation/devicetree/bindings/crypto/sun4i-ss.txt
> 

Applied, thanks.

Rob
