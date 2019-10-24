Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAD7AE34D6
	for <lists+linux-crypto@lfdr.de>; Thu, 24 Oct 2019 15:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393829AbfJXN4l (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 24 Oct 2019 09:56:41 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:55966 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727811AbfJXN4l (ORCPT <rfc822;linux-crypto@vger.kernel.orG>);
        Thu, 24 Oct 2019 09:56:41 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1iNdbO-0007K6-8b; Thu, 24 Oct 2019 21:56:34 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1iNdbJ-00063o-9V; Thu, 24 Oct 2019 21:56:29 +0800
Date:   Thu, 24 Oct 2019 21:56:29 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Zhou Wang <wangzhou1@hisilicon.com>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:HARDWARE RANDOM NUMBER GENERATOR CORE" 
        <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH 1/2] crypto: hisilicon - select NEED_SG_DMA_LENGTH in qm
 Kconfig
Message-ID: <20191024135629.vs43o3rz3xe2hg2c@gondor.apana.org.au>
References: <1570792690-74597-1-git-send-email-wangzhou1@hisilicon.com>
 <CAKv+Gu-6BBC4KQ6Ld+=8XBSdxmyJkBu-3ur_=XAkhSOJnhRcwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-6BBC4KQ6Ld+=8XBSdxmyJkBu-3ur_=XAkhSOJnhRcwQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Thu, Oct 24, 2019 at 03:22:50PM +0200, Ard Biesheuvel wrote:
> 
> If you are fixing a COMPILE_TEST failure, just add NEED_SG_DMA_LENGTH
> as a dependency, or drop the COMPILE_TEST altogether (why was that
> added in the first place?)

Because we want to maximise compiler coverage so that build failures
can be caught at the earliest opportunity.

But a better fix would be to use

	sg_dma_len(sg)

instead of

	sg->dma_length

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
