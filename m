Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB33137A78
	for <lists+linux-crypto@lfdr.de>; Sat, 11 Jan 2020 01:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbgAKARM (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 10 Jan 2020 19:17:12 -0500
Received: from frisell.zx2c4.com ([192.95.5.64]:41161 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbgAKARM (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 10 Jan 2020 19:17:12 -0500
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 63d7c969;
        Fri, 10 Jan 2020 23:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=8rcos00mpgiRgNOZRS7kR9yv6aU=; b=3ZFX7e
        JQz0q1Reo4TNVsXrYcB2CvEEem6Lb3wEyjS9clPkpnZ0Is6Hk+VG0cqQxK/plTau
        nbLvcRR9nMmsVSKvznc3+ZosjQLz1c1BbkK1Vu+HdBYaZi9dxJh93SGu40p9uqYY
        iVz5NyjkLClLYlkBjVKSv2Uqj2YT4sNQG7+cmtnwGspJnZKEUHvjzI/ZoD9qJE4s
        6Zrs1TIuN/5xi0QI5Y6IK8WhrOaODxFY0AGXefRIoONyI9mc9QnAve6rh3psG6Dt
        tLWg1sDG4wC2d9CN2b3d/h+6SGbIVwxuv8JUncT1Wcm9yRDyCb36BcbqVxSEqE+Y
        DeZacrrIGVn0kZuQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4971434f (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 10 Jan 2020 23:17:33 +0000 (UTC)
Received: by mail-ot1-f53.google.com with SMTP id a15so3716687otf.1;
        Fri, 10 Jan 2020 16:17:08 -0800 (PST)
X-Gm-Message-State: APjAAAVUBp7jDkXp8GYlZICWL6yexG3jeiGxeMJhx4pPhFGWlxO/eRHp
        IZauBlutsY6UsTIW46DpcL5CZSS61cDbMVzSnHo=
X-Google-Smtp-Source: APXvYqy7XgL1zSl8e2cFgPv6d1rIDwTEU7p9SGp27oiQ68yGfUA9pFOWs9Go7vhAr4VtyzD/DJj20B/NMxGZEd6UjlM=
X-Received: by 2002:a05:6830:1141:: with SMTP id x1mr5050155otq.120.1578701827660;
 Fri, 10 Jan 2020 16:17:07 -0800 (PST)
MIME-Version: 1.0
References: <20200107133547.44000-1-yuehaibing@huawei.com> <CAHmME9pg4KWw1zNVybxn1WLGusyGCjqeAHLQXY=Dr4zznUM82g@mail.gmail.com>
 <20200108043735.hkhkyq47neatatt4@gondor.apana.org.au>
In-Reply-To: <20200108043735.hkhkyq47neatatt4@gondor.apana.org.au>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 10 Jan 2020 19:16:56 -0500
X-Gmail-Original-Message-ID: <CAHmME9pOq8DCpvozendC0NTBct9EQgFzJaNP1xzRbkcWtcXYWA@mail.gmail.com>
Message-ID: <CAHmME9pOq8DCpvozendC0NTBct9EQgFzJaNP1xzRbkcWtcXYWA@mail.gmail.com>
Subject: Re: [v2 PATCH] crypto: curve25519 - Fix selftest build error
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        David Miller <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Thanks for the analysis.

Reviewed-by: Jason A. Donenfeld <Jason@zx2c4.com>
