Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1278225D33D
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Sep 2020 10:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726425AbgIDIL0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Sep 2020 04:11:26 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:42644 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgIDILY (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Sep 2020 04:11:24 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kE6oc-00013g-6D; Fri, 04 Sep 2020 18:11:23 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 04 Sep 2020 18:11:22 +1000
Date:   Fri, 4 Sep 2020 18:11:22 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Corentin Labbe <clabbe.montjoie@gmail.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: sun8i-ce - Fix big-endian read of t_common_ctl
Message-ID: <20200904081122.GA23618@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The field t_common_ctl is supposed to be little-endian and indeed
when it is filled in we've already done a cpu_to_le32 on it.
However, in sun8i_ce_run_task it is taken as CPU-endian which is
obviously wrong on BE.  This patch fixes it.

Fixes: 93c7f4d357de ("crypto: sun8i-ce - enable working on big...")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
index 138759dc8190..703a60d4e2f6 100644
--- a/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
+++ b/drivers/crypto/allwinner/sun8i-ce/sun8i-ce-core.c
@@ -120,7 +120,7 @@ int sun8i_ce_run_task(struct sun8i_ce_dev *ce, int flow, const char *name)
 	/* Be sure all data is written before enabling the task */
 	wmb();
 
-	v = 1 | (ce->chanlist[flow].tl->t_common_ctl & 0x7F) << 8;
+	v = 1 | (le32_to_cpu(ce->chanlist[flow].tl->t_common_ctl) & 0x7F) << 8;
 	writel(v, ce->base + CE_TLR);
 	mutex_unlock(&ce->mlock);
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
