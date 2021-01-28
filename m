Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0CED3073F3
	for <lists+linux-crypto@lfdr.de>; Thu, 28 Jan 2021 11:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhA1Kke (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 28 Jan 2021 05:40:34 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:52578 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231226AbhA1Kk2 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 28 Jan 2021 05:40:28 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l54hh-0000Ph-4Z; Thu, 28 Jan 2021 21:39:10 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Thu, 28 Jan 2021 21:39:08 +1100
Date:   Thu, 28 Jan 2021 21:39:08 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Meng Yu <yumeng18@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Zaibo Xu <xuzaibo@huawei.com>, wangzhou1@hisilicon.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        "Khurana, Prabhjot" <prabhjot.khurana@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>
Subject: Re: [PATCH v7 4/7] crypto: add ecc curve and expose them
Message-ID: <20210128103908.GA32495@gondor.apana.org.au>
References: <1611299395-675-1-git-send-email-yumeng18@huawei.com>
 <1611299395-675-5-git-send-email-yumeng18@huawei.com>
 <20210128050354.GA30874@gondor.apana.org.au>
 <CAMj1kXHvY9JveFyhtETALCH=AFGMGVbGGFMNDGc6ZVngEKbyDQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHvY9JveFyhtETALCH=AFGMGVbGGFMNDGc6ZVngEKbyDQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jan 28, 2021 at 11:30:23AM +0100, Ard Biesheuvel wrote:
>
> But this also begs the question which ecdh-nist-pXXX implementations
> we actually need? Why are we exposing these curves in the first place?

Once they're distinct algorithms, we can then make sure that only
the ones that are used in the kernel is added, even if some hardware
may support more curves.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
