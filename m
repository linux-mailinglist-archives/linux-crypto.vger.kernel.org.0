Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5955424CD0B
	for <lists+linux-crypto@lfdr.de>; Fri, 21 Aug 2020 06:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725855AbgHUEzu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 21 Aug 2020 00:55:50 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49792 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725270AbgHUEzt (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 21 Aug 2020 00:55:49 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1k8z5f-0000iw-Bc; Fri, 21 Aug 2020 14:55:48 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 21 Aug 2020 14:55:47 +1000
Date:   Fri, 21 Aug 2020 14:55:47 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: hifn_795x - Remove 64-bit build-time check
Message-ID: <20200821045547.GA4243@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

As we're already using Kconfig to disable 64-bit builds for this
driver, there is no point in doing it again in the source code.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/hifn_795x.c b/drivers/crypto/hifn_795x.c
index 3363ca4b1a98..bfc4ac0e4ac4 100644
--- a/drivers/crypto/hifn_795x.c
+++ b/drivers/crypto/hifn_795x.c
@@ -2645,9 +2645,6 @@ static int __init hifn_init(void)
 	unsigned int freq;
 	int err;
 
-	/* HIFN supports only 32-bit addresses */
-	BUILD_BUG_ON(sizeof(dma_addr_t) != 4);
-
 	if (strncmp(hifn_pll_ref, "ext", 3) &&
 	    strncmp(hifn_pll_ref, "pci", 3)) {
 		pr_err("hifn795x: invalid hifn_pll_ref clock, must be pci or ext");
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
