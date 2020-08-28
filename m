Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB97B2554F4
	for <lists+linux-crypto@lfdr.de>; Fri, 28 Aug 2020 09:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbgH1HSg (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 28 Aug 2020 03:18:36 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:35276 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgH1HSg (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 28 Aug 2020 03:18:36 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1kBYef-0003fD-7X; Fri, 28 Aug 2020 17:18:34 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Fri, 28 Aug 2020 17:18:33 +1000
Date:   Fri, 28 Aug 2020 17:18:33 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH] crypto: amlogic - Fix endianness marker
Message-ID: <20200828071833.GA28003@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The endianness marking on the variable v in meson_cipher is wrong.
It is actually in CPU-order, not little-endian.

This patch fixes it.

Fixes: 3d04158814e7 ("crypto: amlogic - enable working on big...")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/amlogic/amlogic-gxl-cipher.c b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
index d93210726697..fcf3fc0c01d0 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-cipher.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-cipher.c
@@ -99,7 +99,7 @@ static int meson_cipher(struct skcipher_request *areq)
 	unsigned int keyivlen, ivsize, offset, tloffset;
 	dma_addr_t phykeyiv;
 	void *backup_iv = NULL, *bkeyiv;
-	__le32 v;
+	u32 v;
 
 	algt = container_of(alg, struct meson_alg_template, alg.skcipher);
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
