Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D29573B3A18
	for <lists+linux-crypto@lfdr.de>; Fri, 25 Jun 2021 02:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233053AbhFYAT2 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 24 Jun 2021 20:19:28 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50874 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232930AbhFYATJ (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 24 Jun 2021 20:19:09 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lwZWa-0008Ee-A5; Fri, 25 Jun 2021 08:16:48 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lwZWT-0006Dx-1P; Fri, 25 Jun 2021 08:16:41 +0800
Date:   Fri, 25 Jun 2021 08:16:41 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-crypto@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Subject: Re: [PATCH 2/2] crypto: mxs_dcp: Use sg_mapping_iter to copy data
Message-ID: <20210625001640.GA23887@gondor.apana.org.au>
References: <20210618211411.1167726-1-sean.anderson@seco.com>
 <20210618211411.1167726-2-sean.anderson@seco.com>
 <20210624065644.GA7826@gondor.apana.org.au>
 <dfe6dc8d-8e26-643e-1e29-6bf05611e9db@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfe6dc8d-8e26-643e-1e29-6bf05611e9db@seco.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Jun 24, 2021 at 10:58:48AM -0400, Sean Anderson wrote:
>
> What exactly is the warning here? dst_iter.length is a size_t, and
> actx->fill is a u32. So fill will be converted to a size_t before the
> comparison, which is lossless.

It's just the way min works.  If you want to shut it up, you can
either use a cast or min_t.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
