Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64FAD2523A7
	for <lists+linux-crypto@lfdr.de>; Wed, 26 Aug 2020 00:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbgHYWbD (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 25 Aug 2020 18:31:03 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:42109 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgHYWbD (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 25 Aug 2020 18:31:03 -0400
Received: by mail-il1-f193.google.com with SMTP id t13so129765ile.9;
        Tue, 25 Aug 2020 15:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=h4tUZsr/X9gXdVhjxFy0H5zbHwJI3zcI8QcQyVbx9I0=;
        b=BYeU26WnEyFyiEUpa1ObGVU8Cieng4GsC0PE3Edo4Nd2gxEsty8cCPUR0H6gSZeBPD
         amQ90NYep4ca/QnCdEn9uPX7t4yh9hGR4r+xzQKVHo385fWPzaNEwcfUJJ8jpY8WGYk1
         YXPRTYXML3yynA8/H/x3iAlTjvJGUlCz7+E1KYBjp8yYjovuRjWKTyHARFQ1smZg2JA4
         PcOH6nbCdllOCVuK32GSZh6k8no2CK/LrphD1lEB46W4XiMVo9fSvua4KojbaqYrEGz9
         qAH8hQmVbq+boqaWqST7GP7W0R/Rk+o/Wul1zjoOFQl0pdL+sL50woyFXIr/w31Jdd80
         sieQ==
X-Gm-Message-State: AOAM532jcl5534yUybbepobD5rD/EfkrIFnfHpFVeGqYlwAPun4OxSed
        vZ3NO0KPHIku+p2fVk6gAQ==
X-Google-Smtp-Source: ABdhPJyazsdm1gv2zMikw/TSnPVcGsz9EOATW/XvykrPwtm7YbAyy6DyuYhm/XRYFuQtuAc863QAUw==
X-Received: by 2002:a92:d2c1:: with SMTP id w1mr9794907ilg.273.1598394662161;
        Tue, 25 Aug 2020 15:31:02 -0700 (PDT)
Received: from xps15 ([64.188.179.249])
        by smtp.gmail.com with ESMTPSA id d12sm234579ilq.34.2020.08.25.15.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 15:31:01 -0700 (PDT)
Received: (nullmailer pid 1464307 invoked by uid 1000);
        Tue, 25 Aug 2020 22:31:00 -0000
Date:   Tue, 25 Aug 2020 16:31:00 -0600
From:   Rob Herring <robh@kernel.org>
To:     Atte Tommiska <atte.tommiska@xiphera.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v2 1/3] dt-bindings: vendor-prefixes: Add Xiphera vendor
 prefix
Message-ID: <20200825223100.GA1464277@bogus>
References: <cover.1597914503.git.atte.tommiska@xiphera.com>
 <70cc429f5e7e8f3213b86e4b97999580953db877.1597914503.git.atte.tommiska@xiphera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <70cc429f5e7e8f3213b86e4b97999580953db877.1597914503.git.atte.tommiska@xiphera.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, 20 Aug 2020 13:51:20 +0300, Atte Tommiska wrote:
> Xiphera is an FPGA-based cryptographic solutions provider based in
> Finland.
> Website of the company: https://xiphera.com/
> 
> Signed-off-by: Atte Tommiska <atte.tommiska@xiphera.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>  1 file changed, 2 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
