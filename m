Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A5182D0989
	for <lists+linux-crypto@lfdr.de>; Mon,  7 Dec 2020 04:48:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbgLGDp7 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 6 Dec 2020 22:45:59 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:42182 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgLGDp7 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 6 Dec 2020 22:45:59 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1km7SZ-0006fH-I8; Mon, 07 Dec 2020 14:45:12 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 07 Dec 2020 14:45:11 +1100
Date:   Mon, 7 Dec 2020 14:45:11 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     liulongfang <liulongfang@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] crypto: hisilicon/sec - add new type of sqe for
 Kunpeng930
Message-ID: <20201207034511.GA10526@gondor.apana.org.au>
References: <1606357086-9785-1-git-send-email-liulongfang@huawei.com>
 <1606357086-9785-3-git-send-email-liulongfang@huawei.com>
 <20201204070359.GA26438@gondor.apana.org.au>
 <dd219ba4-b96d-7434-34d5-5b046f24775f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd219ba4-b96d-7434-34d5-5b046f24775f@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Dec 07, 2020 at 11:43:38AM +0800, liulongfang wrote:
>
> Can I use __attribute__((aligned(n))) instead of #pragma pack(n)?

We normally just use __aligned(n) in the kernel.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
