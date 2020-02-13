Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3201715BB86
	for <lists+linux-crypto@lfdr.de>; Thu, 13 Feb 2020 10:20:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgBMJUr (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 13 Feb 2020 04:20:47 -0500
Received: from helcar.hmeau.com ([216.24.177.18]:42356 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729576AbgBMJUr (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 13 Feb 2020 04:20:47 -0500
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1j2Afs-00048F-K0; Thu, 13 Feb 2020 17:20:44 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1j2Afq-0006o5-V6; Thu, 13 Feb 2020 17:20:42 +0800
Date:   Thu, 13 Feb 2020 17:20:42 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Valentin Ciocoi Radulescu <valentin.ciocoi@nxp.com>
Cc:     "davem@davemloft.net" <davem@davemloft.net>,
        Horia Geanta <horia.geanta@nxp.com>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>
Subject: Re: [PATCH] crypto: caam/qi - optimize frame queue cleanup
Message-ID: <20200213092042.5yt5unuwbcxj7o2a@gondor.apana.org.au>
References: <1580480151-1299-1-git-send-email-valentin.ciocoi@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1580480151-1299-1-git-send-email-valentin.ciocoi@nxp.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

On Fri, Jan 31, 2020 at 02:15:56PM +0000, Valentin Ciocoi Radulescu wrote:
> Add reference counter incremented for each frame enqueued in CAAM
> and replace unconditional sleep in empty_caam_fq() with polling the
> reference counter.
> 
> When CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y boot time on LS1043A
> platform with this optimization decreases from ~1100s to ~11s.
> 
> Signed-off-by: Valentin Ciocoi Radulescu <valentin.ciocoi@nxp.com>
> ---
>  drivers/crypto/caam/qi.c | 60 +++++++++++++++++++++++++++++++-----------------
>  drivers/crypto/caam/qi.h |  4 +++-
>  2 files changed, 42 insertions(+), 22 deletions(-)

Patch applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
