Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FB693B4C19
	for <lists+linux-crypto@lfdr.de>; Sat, 26 Jun 2021 05:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhFZDDU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 25 Jun 2021 23:03:20 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50888 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhFZDDT (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 25 Jun 2021 23:03:19 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lwyYz-0004dF-AE; Sat, 26 Jun 2021 11:00:57 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lwyYs-0007fP-Gz; Sat, 26 Jun 2021 11:00:50 +0800
Date:   Sat, 26 Jun 2021 11:00:50 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-crypto@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
        Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>
Subject: Re: [PATCH 2/2] crypto: mxs_dcp: Use sg_mapping_iter to copy data
Message-ID: <20210626030050.GC29383@gondor.apana.org.au>
References: <20210618211411.1167726-1-sean.anderson@seco.com>
 <20210618211411.1167726-2-sean.anderson@seco.com>
 <20210624065644.GA7826@gondor.apana.org.au>
 <dfe6dc8d-8e26-643e-1e29-6bf05611e9db@seco.com>
 <20210625001640.GA23887@gondor.apana.org.au>
 <f3117c42-7918-3d32-059e-4e6c338a781a@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3117c42-7918-3d32-059e-4e6c338a781a@seco.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jun 25, 2021 at 10:49:08AM -0400, Sean Anderson wrote:
>
> What version of sparse are you using? With sparse 0.6.2, gcc 9.3.0, and
> with C=1 and W=2 I don't see this warning.

Oh it could be my sparse being out-of-date, I'll get it another go.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
