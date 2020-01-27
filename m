Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62A8714A782
	for <lists+linux-crypto@lfdr.de>; Mon, 27 Jan 2020 16:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729422AbgA0PuY (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 27 Jan 2020 10:50:24 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34618 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728783AbgA0PuY (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 27 Jan 2020 10:50:24 -0500
Received: by mail-ot1-f68.google.com with SMTP id a15so8806053otf.1;
        Mon, 27 Jan 2020 07:50:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=beqY/DCoJ59EhwodDnm/pkcRiaCO+zbELfu5AXa7uk4=;
        b=TXXFCw9+jMWKAavB9RkhUdFuk+bN5PCWEGWja2zUXCZv/PDRdNaOeRbaH0ojgWUitF
         4uL11ZiaP/VFkCjWRuzAVP7DG0pmtcBhFkut2CmX8R8N1xPG51CKHmL39KN4/ZAyD8iQ
         2dKx0CBEC7C+YBcN9iE67c9+n0N1j08GKGjcr2a6qCvJtzjk5SAIW7mMj3g3O/UXNJAU
         ZTr1drABsZ1d7C9OQLhsQMZJWDwYvQ2vPgZ4J8WisEom+8LyVoCtnS7Iaz241+cRhcuV
         R/wv0OrTd41yGy62almCt6ZIHQC+2hEOiHhNeAv4H1f3Lh1tM2Hm3nFENBvU3gztD9yR
         C3BQ==
X-Gm-Message-State: APjAAAUZmUbo6f7Fq7tyxheyyDwsxkokK3qiOi49nJjLXx8G6wp5oK1a
        EptXgoaUs9/J85CqHWCE2Q==
X-Google-Smtp-Source: APXvYqyn0BH6mGOr5Sh0ZRs/MHfVUVRkxZjQe26RelsSGtz2sJEWvA4FuKGh6M47f/plr8u4qbEHcg==
X-Received: by 2002:a05:6830:1094:: with SMTP id y20mr5291444oto.12.1580140223624;
        Mon, 27 Jan 2020 07:50:23 -0800 (PST)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t203sm4894791oig.39.2020.01.27.07.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 07:50:22 -0800 (PST)
Received: (nullmailer pid 19844 invoked by uid 1000);
        Mon, 27 Jan 2020 15:50:21 -0000
Date:   Mon, 27 Jan 2020 09:50:21 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kalyani Akula <kalyani.akula@xilinx.com>
Cc:     herbert@gondor.apana.org.au, davem@davemloft.net, monstr@seznam.cz,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, git-dev <git-dev@xilinx.com>,
        Mohan Marutirao Dhanawade <mohand@xilinx.com>,
        Sarat Chand Savitala <saratcha@xilinx.com>,
        Harsh Jain <harshj@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Kalyani Akula <kalyania@xilinx.com>
Subject: Re: [PATCH V5 2/4] dt-bindings: crypto: Add bindings for ZynqMP
 AES-GCM driver
Message-ID: <20200127155021.GA16897@bogus>
References: <1579777877-10553-1-git-send-email-kalyani.akula@xilinx.com>
 <1579777877-10553-3-git-send-email-kalyani.akula@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579777877-10553-3-git-send-email-kalyani.akula@xilinx.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jan 23, 2020 at 04:41:15PM +0530, Kalyani Akula wrote:
> Add documentation to describe Xilinx ZynqMP AES-GCM driver bindings.
> 
> Signed-off-by: Kalyani Akula <kalyani.akula@xilinx.com>
> ---
> 
> V5 Changes:
> - Moved dt-bindings patch from 1/4 to 2/4
> - Converted dt-bindings from .txt to .yaml format.
> 
>  .../bindings/crypto/xlnx,zynqmp-aes.yaml           | 37 ++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.yaml
> 
> diff --git a/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.yaml b/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.yaml
> new file mode 100644
> index 0000000..b2bca4b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/crypto/xlnx,zynqmp-aes.yaml
> @@ -0,0 +1,37 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license new bindings:

(GPL-2.0-only OR BSD-2-Clause)

With that,

Reviewed-by: Rob Herring <robh@kernel.org>
