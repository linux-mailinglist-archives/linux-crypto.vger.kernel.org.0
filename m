Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D949D32B053
	for <lists+linux-crypto@lfdr.de>; Wed,  3 Mar 2021 04:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239368AbhCCBgi (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 2 Mar 2021 20:36:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579864AbhCBRLN (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 2 Mar 2021 12:11:13 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802A4C06178B;
        Tue,  2 Mar 2021 08:40:15 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id l12so20570115wry.2;
        Tue, 02 Mar 2021 08:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Of4F23NNKce5gfmN88FbH9n4wRKKkZM/CgqdVgfmWao=;
        b=NUxAsNQueA2GU08D+B6HbbpuTEK2OI0fpewkFnlD4xoc38FEX+fJyIPxfFnzAFIGCn
         U97jbRBzrHvEw2ZJs6kfWi9qIZBYPnub76iuhFQKKZKTe3+zgFSqPARErc5Ij+I4Kv/V
         FWQ94fQ9068WzSM2ytaJPpS6q+DEtPycjsBtL8uQHrNc9aKsOUByYLsW1Qhsk1RVe5AZ
         Lsd3Ch33LZot4oELWVzXukK4abe1ADD91k0YXStwODpIaKNY2HfRTuZpYCcmrDzkBwKr
         PmXwQ4UGQBYdRa238AnQ/0yHbiPlMVYYfDPgGfM2jxNq7ct1RXzPbsqm+8tehPuR4zds
         ZS8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Of4F23NNKce5gfmN88FbH9n4wRKKkZM/CgqdVgfmWao=;
        b=nTjbYklAZkOZsU1ap9LcUoGbPVr+tw7q6ozEbdkFNhTBvLTHnFekYmX0QVWdFaVLln
         8zRg3Ka9XMci2RwkIURv/am6vhbc0wNd3PJQp+tnrcmh4Tk+bdvYJul83PHWnip2YJIM
         Mfuc5gEKDjKU6/57ERFPCDpytCtcMR2giPRWvKQZbmpkNDUUpcUfVZ0UIIhSluLGIOX9
         ihZr3mYbeLPeiSMuLQCpwxozd1xwFPK3/ZYveE2IF3sWplRS1wwMBLTvpOAKYbm2iSnT
         TxT4iMbBvneodWBVV28pPS/rlKjtLBaJCyZnKpYvuIrSVvhIobvrnp0YESMqxmkxhNSE
         OGjQ==
X-Gm-Message-State: AOAM5302k3sHgFEIKwd9AVdcBmhu2bmSBORcBphlhQa6zjYD2/ORfcGF
        /hit/IV+EW6zIEEXmvdgnOg=
X-Google-Smtp-Source: ABdhPJy6pwerM85qbie+LwP0wYj3W50IxjOI6418idqDaVxytP6LQvv2m6zQbEQ/1AjKIVhSiR2I6A==
X-Received: by 2002:adf:a4d0:: with SMTP id h16mr22591930wrb.52.1614703214272;
        Tue, 02 Mar 2021 08:40:14 -0800 (PST)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id i8sm17823373wrx.43.2021.03.02.08.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 08:40:13 -0800 (PST)
Date:   Tue, 2 Mar 2021 17:40:11 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Colin King <colin.king@canonical.com>
Cc:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: sun8i-ss: Fix memory leak of object d when
 dma_iv fails to map
Message-ID: <YD5qa/rCkJJgSN8K@Red>
References: <20210302163446.21047-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210302163446.21047-1-colin.king@canonical.com>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Le Tue, Mar 02, 2021 at 04:34:46PM +0000, Colin King a écrit :
> From: Colin Ian King <colin.king@canonical.com>
> 
> In the case where the dma_iv mapping fails, the return error path leaks
> the memory allocated to object d.  Fix this by adding a new error return
> label and jumping to this to ensure d is free'd before the return.
> 
> Addresses-Coverity: ("Resource leak")
> Fixes: ac2614d721de ("crypto: sun8i-ss - Add support for the PRNG")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---

Acked-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Thanks!
