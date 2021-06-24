Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83CC83B2776
	for <lists+linux-crypto@lfdr.de>; Thu, 24 Jun 2021 08:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbhFXGhw (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 24 Jun 2021 02:37:52 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:50836 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231132AbhFXGhu (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 24 Jun 2021 02:37:50 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtp (Exim 4.92 #5 (Debian))
        id 1lwIxW-0005HY-IB; Thu, 24 Jun 2021 14:35:30 +0800
Received: from herbert by gondobar with local (Exim 4.92)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1lwIxV-0000YX-Q8; Thu, 24 Jun 2021 14:35:29 +0800
Date:   Thu, 24 Jun 2021 14:35:29 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Tero Kristo <t-kristo@ti.com>
Cc:     Ira Weiny <ira.weiny@intel.com>
Subject: [PATCH] crypto: omap - Drop obsolete PageSlab check
Message-ID: <20210624063529.GA2057@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

As it is now legal to call flush_dcache_page on slab pages we
no longer need to do the check in the omap driver.  This patch
also uses flush_dcache_page instead of flush_kernel_dcache_page
because the page we're writing to could be anything.

Reported-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/omap-crypto.c b/drivers/crypto/omap-crypto.c
index 94b2dba90f0d..31bdb1d76d11 100644
--- a/drivers/crypto/omap-crypto.c
+++ b/drivers/crypto/omap-crypto.c
@@ -183,8 +183,7 @@ static void omap_crypto_copy_data(struct scatterlist *src,
 
 		memcpy(dstb, srcb, amt);
 
-		if (!PageSlab(sg_page(dst)))
-			flush_kernel_dcache_page(sg_page(dst));
+		flush_dcache_page(sg_page(dst));
 
 		kunmap_atomic(srcb);
 		kunmap_atomic(dstb);
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
