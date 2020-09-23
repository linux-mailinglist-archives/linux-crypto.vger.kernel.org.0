Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5019274EBF
	for <lists+linux-crypto@lfdr.de>; Wed, 23 Sep 2020 03:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgIWB5F (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 22 Sep 2020 21:57:05 -0400
Received: from mail-il1-f195.google.com ([209.85.166.195]:45385 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbgIWB5F (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 22 Sep 2020 21:57:05 -0400
Received: by mail-il1-f195.google.com with SMTP id h2so19285152ilo.12;
        Tue, 22 Sep 2020 18:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=34pMhFQ28SHC3mzxbMUDtsJGYufWbe2RlD1uSSeVBbQ=;
        b=ngMgJreq97y7VSnZSbgLuwuw8XXk9scYsIiN/FDI/FpB+Uh9Jm2ggdhPKP1PGGSOdd
         1Yq1LcelwojMnbwmBZ1m7WA9fBgWSI7jU3q9VV9XrbqAf9/2BGSMkpriLJQukqD15FJi
         aQiAT9JARR4dgHue/eO3oHbhX+TAewFmPSZMJ5U2XiYtnKWvOgKVlR4QH9JdH3tbSrla
         lpb7uatxq+R4z7yPqkf8hrXMOFUGSFL2Byp5ca4Pbn50YQRq0dz2fGFzOLImUeeDRe6W
         hKgT6lyCyfRbKPgsw5dBdA+cFI7yKVnwyuDKIo8+LNMKnQvI/AkCzGyw6jb5Ta0qE8fO
         SSYA==
X-Gm-Message-State: AOAM533Q+bOanVzc1sV/xf3sQ0eeePcO05pzg597y9ZafSOA8Fsz+KN9
        f7vB0+ALzTmJw+Z86+gTqg==
X-Google-Smtp-Source: ABdhPJw/o4PwxGTeqWV+adBWTIEGsOkRpZod6MJ/eFAMyAZXrL7UJ3MpPMRsbXfGwT/zjEc/YHa5jQ==
X-Received: by 2002:a92:c7b0:: with SMTP id f16mr6998290ilk.137.1600826224427;
        Tue, 22 Sep 2020 18:57:04 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id j77sm10254679ili.31.2020.09.22.18.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2020 18:57:03 -0700 (PDT)
Received: (nullmailer pid 3701896 invoked by uid 1000);
        Wed, 23 Sep 2020 01:57:02 -0000
Date:   Tue, 22 Sep 2020 19:57:02 -0600
From:   Rob Herring <robh@kernel.org>
To:     Gilad Ben-Yossef <gilad@benyossef.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: crypto: update ccree optional params
Message-ID: <20200923015702.GA3676455@bogus>
References: <20200916071950.1493-1-gilad@benyossef.com>
 <20200916071950.1493-2-gilad@benyossef.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916071950.1493-2-gilad@benyossef.com>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Wed, Sep 16, 2020 at 10:19:49AM +0300, Gilad Ben-Yossef wrote:
> Document ccree driver supporting new optional parameters allowing to
> customize the DMA transactions cache parameters and ACE bus sharability
> properties.
> 
> Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> ---
>  Documentation/devicetree/bindings/crypto/arm-cryptocell.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt b/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
> index 6130e6eb4af8..1a1603e457a8 100644
> --- a/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
> +++ b/Documentation/devicetree/bindings/crypto/arm-cryptocell.txt
> @@ -13,6 +13,10 @@ Required properties:
>  Optional properties:
>  - clocks: Reference to the crypto engine clock.
>  - dma-coherent: Present if dma operations are coherent.
> +- awcache: Set write transactions cache attributes
> +- arcache: Set read transactions cache attributes

dma-coherent already implies these are 011x, 101x or 111x. In my limited 
experience configuring these (Calxeda SATA and ethernet), writeback, 
write-allocate was pretty much always optimal. 

> +- awdomain: Set write transactions ACE sharability domain (712, 703, 713 only)
> +- ardomain: Set read transactions ACE sharability domain (712, 703, 713 only)

This probably needs something common. We may need something for Mali, 
too. I don't think different settings for read and write makes much 
sense nor does anything beyond IS or OS. 

These could also just be implied by the compatible string (and requiring 
an SoC specific one).

Rob
