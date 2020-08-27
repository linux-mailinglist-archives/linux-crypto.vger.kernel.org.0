Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E235254723
	for <lists+linux-crypto@lfdr.de>; Thu, 27 Aug 2020 16:41:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgH0Ok7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 27 Aug 2020 10:40:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726794AbgH0Okz (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 27 Aug 2020 10:40:55 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC927C061264;
        Thu, 27 Aug 2020 07:40:54 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u18so5406398wmc.3;
        Thu, 27 Aug 2020 07:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=MeVXhKzNMW9u6vseTSVuEbBXrSmw96cHMTkiXl0zqYk=;
        b=QmGw8VNypziYny1x6qbmDt84qfty89cZyYsrUjtRAuSRP5M/VCKgMiC+oTbb/8aE87
         OuNI6V4qbubmZ3FkH1fvdus7AZQho5I/g3IwKAcS5nstXl/NXqdB1U9KujPKqaAd1ebu
         s7vjpIP7FyOPywA+u9p1uI9e94q9Ep8VxCiswfMmHZmRnljo9HOypzixVuZHln5PTy6m
         3P6+9NGbLpESIODEf+NgICOhPvS8fvb/NASrDzfjmmQE3Bq2O2NTOE0m5SnL330kjPMU
         TIjTBkxZiOR7NV9YZy2LXds3eY7OP2MtDggn2laQxl3OC4M7b1ioX9Mtkt/XtLcUtnH+
         MNSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=MeVXhKzNMW9u6vseTSVuEbBXrSmw96cHMTkiXl0zqYk=;
        b=gbFw9iQ3NwazNyXvfibeJTzx0dPqQAe1DERsPA0QeyCP65ubGntYtwSswr+GQTy7Vf
         BuxgIzsj+dbI5sLiwSzLthErXMsZJhKTN8k0JFWzH45xRA7maphlGef/RFCaF71NE62b
         +Li0wxE2ZpqJ2uCfHJ+nSBDW9X0rfz55XuJ07WrHkE/59/v7uEuPd8MvhwV6h6BP3xXY
         swD6x2oEksQNH7Law3sos3pWxPoQZidq0a4W9mAXHAUFhK+W/qgTFNHrB2+O60gTzzSb
         /E7/La157UE56L9ZaiKDybSc7UAeNnpKjeJEyeojFO/UARxPmaVotjkyhqD4QoRgDW+h
         xTCA==
X-Gm-Message-State: AOAM533YcusJttBauOmLhFutY1Yk0vwyDJkE/KPT6mwdgsS1E5Grh/Rc
        KR+BCoGlyVdnv9BUsdadDX1XEgwHjHk=
X-Google-Smtp-Source: ABdhPJw+vBEbmPinngFABln8wbNAHLb3Wn9i5UQlAjsuWndFPpmjFkhNbidAkLKa4Vox6RJN4qMhMQ==
X-Received: by 2002:a7b:ce86:: with SMTP id q6mr9564666wmj.163.1598539253489;
        Thu, 27 Aug 2020 07:40:53 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id 92sm6953073wra.19.2020.08.27.07.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 07:40:52 -0700 (PDT)
Date:   Thu, 27 Aug 2020 16:40:51 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Denis Efremov <efremov@linux.com>
Cc:     linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] crypto: sun8i-ce - use kfree_sensitive()
Message-ID: <20200827144051.GA11280@Red>
References: <20200827064402.7130-1-efremov@linux.com>
 <20200827064402.7130-4-efremov@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200827064402.7130-4-efremov@linux.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Aug 27, 2020 at 09:44:01AM +0300, Denis Efremov wrote:
> Use kfree_sensitive() instead of open-coding it.
> 
> Signed-off-by: Denis Efremov <efremov@linux.com>
> ---
>  .../crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c   | 15 +++------------
>  1 file changed, 3 insertions(+), 12 deletions(-)
> 

Acked-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Thanks
