Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF04EC336
	for <lists+linux-crypto@lfdr.de>; Fri,  1 Nov 2019 13:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbfKAMwf (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 1 Nov 2019 08:52:35 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:50208 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfKAMwf (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 1 Nov 2019 08:52:35 -0400
Received: by mail-wm1-f65.google.com with SMTP id 11so9262900wmk.0;
        Fri, 01 Nov 2019 05:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5kDHdGaAqZVxVSO+DPwW99XZq8iYZVkob3e0AtdnlHc=;
        b=ICZ8mx+Utk3tKzJbdssh1f2AJtQ+KDk1XnZX+N4wsPjRdi5IRTCH7IcVOIIRk4dk4h
         J6Chf67SdhbX+qhKHNl1eB1HJfeCYlovuviQEwLTUXeO8Y3IZBKQilrL2Hmm+N0cUuCw
         t4VDIFa13bjoPB3G33VJdZmhRpPootgEVPG99Wx9y6Y5RhgRRtyYkI+sNyRHgrHINM7x
         Re2p2pPHaAfzt2uvFRpwEePm0oq0F14t/bjcBQhvzi3W6LksPuMU77u+lRVuGXhuXFyD
         l2ZJ6GIwhXnqndT8X7hXN2YMpVfsgFwZuVSwJyu9f4gA5Sx8px8RMQtYzXrreuRcRX8q
         85tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5kDHdGaAqZVxVSO+DPwW99XZq8iYZVkob3e0AtdnlHc=;
        b=SuozDL9hWAGah0qi/qjcUN9CMbwwFJg/Qi4P0YOw/4F0jQO7qD3nql+P49aQ/aOD99
         zZyi4eDRzPZr5UK9XZYW5FhAsthQ71Xyw2SgMugiyJC07PiQ70HmgUchFsxAxfF1NPm/
         46nQKTxEFI7h7nA96i2QPqgbVGI4OZ66+mGJUBleXQTXlw/zVXpQPC0b9KB8gvuxHD4w
         OZvX2FCg5a6BCcOCDkQ3d6x+tbhk/RnryfE8zT9azGysFvvQmRx9vaC25UXBzSbqknYH
         cL+ScN1z51izmmFNo87/WjLqR4ElWgWjZw01EXeERj+5U6DJl3Kbyp6e/vjNmpB8YjQG
         Qy6A==
X-Gm-Message-State: APjAAAUpkxCZJx7Bx6KuHWjUzCt7kXWDToYDBii4AySlTa1vhNTDwiRi
        3qhs20XCbgCpwSc9PLcQr+c=
X-Google-Smtp-Source: APXvYqyu7fVT4MGxfs1QnkZRpSmE0DSsyd+HoLtvpv2yrj8wf2G85zypZsTEptRDAJoMKjihJoqwvw==
X-Received: by 2002:a1c:60d7:: with SMTP id u206mr10600674wmb.101.1572612751565;
        Fri, 01 Nov 2019 05:52:31 -0700 (PDT)
Received: from Red ([2a01:cb1d:147:7200:2e56:dcff:fed2:c6d6])
        by smtp.googlemail.com with ESMTPSA id p15sm7907642wrs.94.2019.11.01.05.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2019 05:52:31 -0700 (PDT)
Date:   Fri, 1 Nov 2019 13:52:21 +0100
From:   Corentin Labbe <clabbe.montjoie@gmail.com>
To:     Julia Lawall <julia.lawall@lip6.fr>
Cc:     kbuild-all@lists.01.org, linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] crypto: fix memdup.cocci warnings
Message-ID: <20191101125221.GB3904@Red>
References: <alpine.DEB.2.21.1911010953590.2883@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1911010953590.2883@hadrien>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Nov 01, 2019 at 09:55:34AM +0100, Julia Lawall wrote:
> From: kbuild test robot <lkp@intel.com>
> 
> Use kmemdup rather than duplicating its implementation
> 
> Generated by: scripts/coccinelle/api/memdup.cocci
> 
> Fixes: f08fcced6d00 ("crypto: allwinner - Add sun8i-ss cryptographic offloader")
> CC: Corentin Labbe <clabbe.montjoie@gmail.com>
> Signed-off-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Julia Lawall <julia.lawall@lip6.fr>
> ---

Corentin Labbe <clabbe.montjoie@gmail.com>

Thanks
