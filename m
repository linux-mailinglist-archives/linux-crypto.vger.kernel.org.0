Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E778B12EF8
	for <lists+linux-crypto@lfdr.de>; Fri,  3 May 2019 15:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbfECNZw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 3 May 2019 09:25:52 -0400
Received: from [5.180.42.13] ([5.180.42.13]:38092 "EHLO deadmen.hmeau.com"
        rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
        id S1727920AbfECNZw (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 3 May 2019 09:25:52 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hMRP4-0005mb-Fy; Fri, 03 May 2019 14:10:38 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hMRP2-0003Dn-1r; Fri, 03 May 2019 14:10:36 +0800
Date:   Fri, 3 May 2019 14:10:36 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Horia Geanta <horia.geanta@nxp.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 0/3] crypto: caam/qi2 - ahash fixes for 5.2
Message-ID: <20190503061035.buzkjhquxg7x7wky@gondor.apana.org.au>
References: <20190425145223.28603-1-horia.geanta@nxp.com>
 <VI1PR0402MB34858A47B8E703B556AC1EAA983D0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <VI1PR0402MB34858A47B8E703B556AC1EAA983D0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Apr 25, 2019 at 06:43:58PM +0000, Horia Geanta wrote:
> On 4/25/2019 5:52 PM, Horia Geantă wrote:
> > ahash implementation in caam/jr driver has undergone a few
> > DMA API related fixes.
> > 
> > This patch set contains similar fixes for ahash implementation
> > in caam/qi2 driver.

All applied.  Thanks.

> Sorry, I meant "for 5.1" - of course, if it's still possible.

I think it's a bit late for fixes like these.  They weren't exactly
introduced in 5.1 anyway so I've pushed them into cryptodev.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
