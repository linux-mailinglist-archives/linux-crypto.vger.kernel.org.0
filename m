Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095911E6601
	for <lists+linux-crypto@lfdr.de>; Thu, 28 May 2020 17:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404366AbgE1P1y (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 28 May 2020 11:27:54 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:39473 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404080AbgE1P1w (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 28 May 2020 11:27:52 -0400
Received: by mail-io1-f68.google.com with SMTP id c8so10039880iob.6;
        Thu, 28 May 2020 08:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B9AjAF204kGqafZ8qch9ULXofKx7NjkIMEqK2VlDI5g=;
        b=MYjj5xLbgy6dECgPz8JNt5yEeLUlHnQ7V0mFoy7ch6yyrkFta5bRACQ4SlLVXFpIIX
         DJ7xMT01ZdQqvX0/XmMm1w5XwA+y9RJLHgfwI7EWIXXu/osIUjE1iAKtdK8/2A2VA/6G
         nTKjmHUUvhIPBBVWQTVd4O5rjUmQBzBxsTxA3WVVRImcxizqrjLWYJ0x0JVHJsfqCe8z
         G5HbOivFUOg2jji3UMFDk/ffUCBrGrBEz/Jk880uOx1eirY4XB/MFlxCTr396agJnpJt
         pPd2buU/+EKnUJwKtGwh4LUub7U0TTv/oCt72e9IQfj76of/QH1ODYMtSZWA+iFlVqZf
         yCNQ==
X-Gm-Message-State: AOAM532h92LTzNC9JKG4vZu21TwYwr6ljcqZBpliwHnYoJgVcdVrELq1
        Mtgs8ocgEVSxeaewDIk/kQ==
X-Google-Smtp-Source: ABdhPJy07N+4IrsKSktm0ndsurbG5LTql9W08jU7Y9tQsWYLTpgglW+dKz7oQ4cI8JXhUDU6+gzvPg==
X-Received: by 2002:a02:6d0a:: with SMTP id m10mr3013911jac.133.1590679672105;
        Thu, 28 May 2020 08:27:52 -0700 (PDT)
Received: from xps15 ([64.188.179.252])
        by smtp.gmail.com with ESMTPSA id l3sm2846942iow.55.2020.05.28.08.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 08:27:51 -0700 (PDT)
Received: (nullmailer pid 112685 invoked by uid 1000);
        Thu, 28 May 2020 15:27:50 -0000
Date:   Thu, 28 May 2020 09:27:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Tero Kristo <t-kristo@ti.com>
Cc:     linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        mpm@selenic.com, herbert@gondor.apana.org.au, robh+dt@kernel.org
Subject: Re: [PATCH 1/1] dt-bindings: rng: Convert OMAP RNG to schema
Message-ID: <20200528152750.GA108124@bogus>
References: <20200514131947.28094-1-t-kristo@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200514131947.28094-1-t-kristo@ti.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, 14 May 2020 16:19:47 +0300, Tero Kristo wrote:
> Convert TI OMAP Random number generator bindings to DT schema.
> 
> Signed-off-by: Tero Kristo <t-kristo@ti.com>
> ---
>  .../devicetree/bindings/rng/omap_rng.txt      | 38 ---------
>  .../devicetree/bindings/rng/ti,omap-rng.yaml  | 77 +++++++++++++++++++
>  2 files changed, 77 insertions(+), 38 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/rng/omap_rng.txt
>  create mode 100644 Documentation/devicetree/bindings/rng/ti,omap-rng.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
