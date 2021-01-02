Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD762E8899
	for <lists+linux-crypto@lfdr.de>; Sat,  2 Jan 2021 22:02:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbhABVBa (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sat, 2 Jan 2021 16:01:30 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:37072 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727037AbhABVBa (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Sat, 2 Jan 2021 16:01:30 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kvo0z-0008Lv-5v; Sun, 03 Jan 2021 08:00:46 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Sun, 03 Jan 2021 08:00:45 +1100
Date:   Sun, 3 Jan 2021 08:00:45 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Longfang Liu <liulongfang@huawei.com>
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] crypto: hisilicon - enable new algorithms of SEC
Message-ID: <20210102210044.GA1514@gondor.apana.org.au>
References: <1607598607-8728-1-git-send-email-liulongfang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1607598607-8728-1-git-send-email-liulongfang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Dec 10, 2020 at 07:10:01PM +0800, Longfang Liu wrote:
> Add support for new algorithms of SEC accelerator on Kunpeng930,
> the driver and test case needs to be updated
> 
> Longfang Liu (5):
>   crypto: hisilicon/sec - add new type of sqe for Kunpeng930
>   crypto: hisilicon/sec - add new skcipher mode for SEC
>   crypto: hisilicon/sec - add new AEAD mode for SEC

Did you run the fuzz tests on these additions?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
