Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBBD5225E33
	for <lists+linux-crypto@lfdr.de>; Mon, 20 Jul 2020 14:10:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgGTMKx (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 20 Jul 2020 08:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728058AbgGTMKx (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 20 Jul 2020 08:10:53 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B11CC061794;
        Mon, 20 Jul 2020 05:10:53 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f18so24914342wml.3;
        Mon, 20 Jul 2020 05:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kiFsKqdenQ6M+Ki6hUNi9K05l9XI4Eg+Gebp8xMKzMw=;
        b=ijuH+wJ+VQiKAJAAxyUSf+HdmWw2Vnl0ZihGfGcaKZDP3YJYUm8iMcvkOLGsV47EGZ
         GIMkjvcSkOKXtvVTcvoNnCvU7a4la+C/GKPVoRG+8w6zKECscZG1DCW7QOiKelLpoSHH
         d9m0AaefM4BLDzY63gLTY8DrdhY/ZAjAm3eJ5i7yVmCV6IlbCB5mWqHkB7SYvZqroZXB
         9WveUHpzpzSXHBiL4MWeq6Q2Cbhu/cQ94cbmVwWkthaIiqdTyG6A7h1W80mxcrvknLco
         dNPOJu9RJcZkkcX3+bPQShxyX5RYreVo449Ml8uocLOw6q9jR1LhISc49Gq/58dTGTYq
         QVfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kiFsKqdenQ6M+Ki6hUNi9K05l9XI4Eg+Gebp8xMKzMw=;
        b=QYUfgelk2NdVvHFkrHvuo9BoJSN9/T0k4BzhKrhKf6SM2l8T0QwM645Eae1cZJonen
         jZDQttqAG0stx55zM682frkgFPY4Zau1ENUc7cm24jOBnyWyLSeye+lo6gHJTiqxwq96
         fi+SN7P6tdjjq8+isc5y5cjGPZFPPp5aeg63NTVM6Gf8nF3J99xA5O1MBAiHB/fK9dL3
         6D373lwCk66QC4KzKnjevjDfLw+VzWxxbmW7kmKyNaQ7piDB1o0nPau8RUGFhiu80O2p
         iNesibRQVOp7CCRpPFoq0vhj6IY3mlvttXpkKhWRU7ZcYhGRsPkw5evpl18pWIljrEVJ
         37Ng==
X-Gm-Message-State: AOAM5306ROoYcCMYLsCRwBngWJiEMWMJVP+srbH6EViIgjurof2sMVBQ
        sLgkjghUaXTtse0JQOw4+PE=
X-Google-Smtp-Source: ABdhPJwP6uEFQQc59KaTAg/z0iRqcgTtz5XaGJY208w8WPajtj/1hF/elUokaoXfCGgHAE3Vxt+i+g==
X-Received: by 2002:a1c:c3c5:: with SMTP id t188mr22438141wmf.53.1595247050414;
        Mon, 20 Jul 2020 05:10:50 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id 138sm31127834wmb.1.2020.07.20.05.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 05:10:49 -0700 (PDT)
Date:   Mon, 20 Jul 2020 14:10:48 +0200
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Qinglang Miao <miaoqinglang@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] crypto: allwinner - Convert to
 DEFINE_SHOW_ATTRIBUTE
Message-ID: <20200720121048.GA27316@Red>
References: <20200716090632.14124-1-miaoqinglang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200716090632.14124-1-miaoqinglang@huawei.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jul 16, 2020 at 05:06:32PM +0800, Qinglang Miao wrote:
> From: Chen Huang <chenhuang5@huawei.com>
> 
> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Chen Huang <chenhuang5@huawei.com>
> ---
>  drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c | 15 ++-------------
>  drivers/crypto/allwinner/sun8i-ss/sun8i-ss-core.c | 15 ++-------------
>  2 files changed, 4 insertions(+), 26 deletions(-)
> 

Acked-by: Corentin Labbe <clabbe.montjoie@gmail.com>
Tested-by: Corentin Labbe <clabbe.montjoie@gmail.com>

Thanks
