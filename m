Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40CE94C8F4
	for <lists+linux-crypto@lfdr.de>; Thu, 20 Jun 2019 10:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726122AbfFTIG1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 20 Jun 2019 04:06:27 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:43588 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbfFTIG1 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 20 Jun 2019 04:06:27 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1hds5N-0002E7-Qu; Thu, 20 Jun 2019 16:06:21 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1hds5I-0007W7-Ja; Thu, 20 Jun 2019 16:06:16 +0800
Date:   Thu, 20 Jun 2019 16:06:16 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Daniel Axtens <dja@axtens.net>
Cc:     mpe@ellerman.id.au, ebiggers@kernel.org,
        linux-crypto@vger.kernel.org, marcelo.cerri@canonical.com,
        Stephan Mueller <smueller@chronox.de>,
        leo.barbosa@canonical.com, linuxppc-dev@lists.ozlabs.org,
        nayna@linux.ibm.com, pfsmorigo@gmail.com, leitao@debian.org,
        gcwilson@linux.ibm.com, omosnacek@gmail.com
Subject: Re: [PATCH] crypto: vmx - Document CTR mode counter width quirks
Message-ID: <20190620080616.73fb2bq4yeeso4ia@gondor.apana.org.au>
References: <20190611015431.26772-1-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190611015431.26772-1-dja@axtens.net>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Tue, Jun 11, 2019 at 11:54:31AM +1000, Daniel Axtens wrote:
> The CTR code comes from OpenSSL, where it does a 32-bit counter.
> The kernel has a 128-bit counter. This difference has lead to
> issues.
> 
> Document it.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> ---
>  drivers/crypto/vmx/aesp8-ppc.pl | 22 ++++++++++++++++++++--
>  1 file changed, 20 insertions(+), 2 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
