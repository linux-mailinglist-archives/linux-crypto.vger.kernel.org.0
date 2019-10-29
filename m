Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6207E9222
	for <lists+linux-crypto@lfdr.de>; Tue, 29 Oct 2019 22:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfJ2Ves (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 29 Oct 2019 17:34:48 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46579 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728567AbfJ2Ves (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 29 Oct 2019 17:34:48 -0400
Received: by mail-oi1-f195.google.com with SMTP id c2so126693oic.13;
        Tue, 29 Oct 2019 14:34:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=xKnMFA8khBrgWosC3rLpBnkIJRXhAp6FK2NOqhcPbYw=;
        b=UYA3GOAhCXRpDTw5MvqgZM3HKhzGw9Xr+mUh7Y5SZ/JYbTL1eyytayURK9JRm5aNWo
         /LouV0Vo690wotZDXAKMBGPk5BZeBT40fojKL41gUma7D+X2zllReHXhT/sN9L+3KxRK
         3pD8cpmg9IVDSs4AE5cv8bjGrq1Eoyk0dB1uvTFSY4fwnrQpzzXwVAGUQf+A1WZhWyY+
         AAlUoOlsrBfNgtYuzzIVU5ojml2vwnjg/qppw96ovMRdnQrNO9UipQj4LvS5yi8qxtop
         LjlTApTJu7VExSB20XmV1Ly60XTpxJYJnNr2UHlvMFMNZpvTZY3fcx8lfJVry1rJmuX6
         q5dw==
X-Gm-Message-State: APjAAAVdsNDbq2L2UW6BIsiXji/JzlVlGgd6Ere2brb1YfzQuvTvQGO/
        8nBP8AXWRNucFoavvH886pYRxqM=
X-Google-Smtp-Source: APXvYqyFk3qlj8sA9FQfR00eawHaunkPpkZvCBKKxoWVP3TT0JlnTrtIaOyo0Zk5UoJLfGt6z9xs8Q==
X-Received: by 2002:aca:b03:: with SMTP id 3mr6118637oil.103.1572384887426;
        Tue, 29 Oct 2019 14:34:47 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a88sm80434otb.0.2019.10.29.14.34.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2019 14:34:46 -0700 (PDT)
Date:   Tue, 29 Oct 2019 16:34:45 -0500
From:   Rob Herring <robh@kernel.org>
To:     Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        mpm@selenic.com, herbert@gondor.apana.org.au, robh+dt@kernel.org,
        mark.rutland@arm.com, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, ludovic.desroches@microchip.com,
        arnd@arndb.de, Tudor.Ambarus@microchip.com,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: Re: [PATCH 1/2] dt-bindings: rng: atmel-trng: add new compatible
Message-ID: <20191029213445.GA7474@bogus>
References: <20191024170452.2145-1-codrin.ciubotariu@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024170452.2145-1-codrin.ciubotariu@microchip.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, 24 Oct 2019 20:04:51 +0300, Codrin Ciubotariu wrote:
> Add compatible for new IP found on sam9x60 SoC.
> 
> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
> ---
>  Documentation/devicetree/bindings/rng/atmel-trng.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
