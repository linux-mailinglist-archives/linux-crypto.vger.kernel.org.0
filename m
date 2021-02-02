Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8BB30B6CE
	for <lists+linux-crypto@lfdr.de>; Tue,  2 Feb 2021 06:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbhBBFPQ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 2 Feb 2021 00:15:16 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:43898 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229850AbhBBFO6 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 2 Feb 2021 00:14:58 -0500
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1l6o0Y-0001Ei-Md; Tue, 02 Feb 2021 16:13:47 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Tue, 02 Feb 2021 16:13:46 +1100
Date:   Tue, 2 Feb 2021 16:13:46 +1100
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Daniele Alessandrelli <daniele.alessandrelli@linux.intel.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>, Meng Yu <yumeng18@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Zaibo Xu <xuzaibo@huawei.com>, wangzhou1@hisilicon.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Gross <mgross@linux.intel.com>,
        "Khurana, Prabhjot" <prabhjot.khurana@intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>
Subject: Re: [PATCH v7 4/7] crypto: add ecc curve and expose them
Message-ID: <20210202051346.GB27641@gondor.apana.org.au>
References: <1611299395-675-1-git-send-email-yumeng18@huawei.com>
 <1611299395-675-5-git-send-email-yumeng18@huawei.com>
 <20210128050354.GA30874@gondor.apana.org.au>
 <CAMj1kXHvY9JveFyhtETALCH=AFGMGVbGGFMNDGc6ZVngEKbyDQ@mail.gmail.com>
 <20210128103908.GA32495@gondor.apana.org.au>
 <c3c3d47edbfd61c338deea5a10a4fb39e2ace68a.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3c3d47edbfd61c338deea5a10a4fb39e2ace68a.camel@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Mon, Feb 01, 2021 at 05:09:41PM +0000, Daniele Alessandrelli wrote:
> What's the downside of letting device drivers enable all the curves
> supported by the HW (with the exception of obsolete curves /
> algorithms), even if there is (currently) no user of such curves in the
> kernel? Code size and maintainability?

The issue is that we always require a software implementation for
any given hardware algorithm.  As otherwise kernel users cannot
rely on the algorithm to work.

Of course we don't want to add every single algorithm out there
to the kernel so that's why require there to be an actual in-kernel
user before adding a given algorithm.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
