Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF7CA5E690
	for <lists+linux-crypto@lfdr.de>; Wed,  3 Jul 2019 16:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbfGCO06 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 3 Jul 2019 10:26:58 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:52086 "EHLO deadmen.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfGCO06 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 3 Jul 2019 10:26:58 -0400
Received: from gondobar.mordor.me.apana.org.au ([192.168.128.4] helo=gondobar)
        by deadmen.hmeau.com with esmtps (Exim 4.89 #2 (Debian))
        id 1higDo-0000Zb-L4; Wed, 03 Jul 2019 22:26:56 +0800
Received: from herbert by gondobar with local (Exim 4.89)
        (envelope-from <herbert@gondor.apana.org.au>)
        id 1higDl-0000Tn-Lf; Wed, 03 Jul 2019 22:26:53 +0800
Date:   Wed, 3 Jul 2019 22:26:53 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Lionel Debieve <lionel.debieve@st.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: crypto: stm32/hash - Fix incorrect printk modifier for size_t
Message-ID: <20190703142653.rosdz3lx2igrtfpy@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch fixes a warning when compiling stm32 because %d is being
used on a size_t argument instead of %zd.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/stm32/stm32-hash.c b/drivers/crypto/stm32/stm32-hash.c
index 33a0612efa57..7c81f0f234ae 100644
--- a/drivers/crypto/stm32/stm32-hash.c
+++ b/drivers/crypto/stm32/stm32-hash.c
@@ -352,7 +352,7 @@ static int stm32_hash_xmit_cpu(struct stm32_hash_dev *hdev,
 
 	len32 = DIV_ROUND_UP(length, sizeof(u32));
 
-	dev_dbg(hdev->dev, "%s: length: %d, final: %x len32 %i\n",
+	dev_dbg(hdev->dev, "%s: length: %zd, final: %x len32 %i\n",
 		__func__, length, final, len32);
 
 	hdev->flags |= HASH_FLAGS_CPU;
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
