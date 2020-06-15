Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD451F9560
	for <lists+linux-crypto@lfdr.de>; Mon, 15 Jun 2020 13:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgFOLgZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 15 Jun 2020 07:36:25 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:49136 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728285AbgFOLgY (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 15 Jun 2020 07:36:24 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jknPY-0007AU-Ss; Mon, 15 Jun 2020 21:36:21 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 15 Jun 2020 21:36:20 +1000
Date:   Mon, 15 Jun 2020 21:36:20 +1000
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Tero Kristo <t-kristo@ti.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: omap-des - Fix sparse/compiler warnings
Message-ID: <20200615113620.GA20552@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch fixes sparse endianness warnings as well as compiler
warnings on 64-bit hosts.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/omap-des.c b/drivers/crypto/omap-des.c
index 8eda43319204..c9d38bcfd1c7 100644
--- a/drivers/crypto/omap-des.c
+++ b/drivers/crypto/omap-des.c
@@ -87,7 +87,7 @@ struct omap_des_ctx {
 	struct omap_des_dev *dd;
 
 	int		keylen;
-	u32		key[(3 * DES_KEY_SIZE) / sizeof(u32)];
+	__le32		key[(3 * DES_KEY_SIZE) / sizeof(u32)];
 	unsigned long	flags;
 };
 
@@ -461,7 +461,7 @@ static int omap_des_crypt_dma_start(struct omap_des_dev *dd)
 					crypto_skcipher_reqtfm(dd->req));
 	int err;
 
-	pr_debug("total: %d\n", dd->total);
+	pr_debug("total: %zd\n", dd->total);
 
 	if (!dd->pio_only) {
 		err = dma_map_sg(dd->dev, dd->in_sg, dd->in_sg_len,
@@ -504,7 +504,7 @@ static void omap_des_finish_req(struct omap_des_dev *dd, int err)
 
 static int omap_des_crypt_dma_stop(struct omap_des_dev *dd)
 {
-	pr_debug("total: %d\n", dd->total);
+	pr_debug("total: %zd\n", dd->total);
 
 	omap_des_dma_stop(dd);
 
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
