Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AA320D65A
	for <lists+linux-crypto@lfdr.de>; Mon, 29 Jun 2020 22:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729229AbgF2TTR (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 29 Jun 2020 15:19:17 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59760 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730297AbgF2TTK (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 29 Jun 2020 15:19:10 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jpolk-0003w0-60; Mon, 29 Jun 2020 18:04:01 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 29 Jun 2020 18:04:00 +1000
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Mon, 29 Jun 2020 18:04:00 +1000
Subject: [PATCH 4/7] hwrng: bcm2835 - Fix W=1 unused variable warning
References: <20200629080316.GA11246@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Message-Id: <E1jpolk-0003w0-60@fornost.hmeau.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch fixes an unused variable warning when this driver is
built with CONFIG_OF=n.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 drivers/char/hw_random/bcm2835-rng.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/char/hw_random/bcm2835-rng.c b/drivers/char/hw_random/bcm2835-rng.c
index cbf5eaea662c5..eec26329d1ea7 100644
--- a/drivers/char/hw_random/bcm2835-rng.c
+++ b/drivers/char/hw_random/bcm2835-rng.c
@@ -139,7 +139,6 @@ static int bcm2835_rng_probe(struct platform_device *pdev)
 {
 	const struct bcm2835_rng_of_data *of_data;
 	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
 	const struct of_device_id *rng_id;
 	struct bcm2835_rng_priv *priv;
 	int err;
@@ -166,7 +165,7 @@ static int bcm2835_rng_probe(struct platform_device *pdev)
 	priv->rng.cleanup = bcm2835_rng_cleanup;
 
 	if (dev_of_node(dev)) {
-		rng_id = of_match_node(bcm2835_rng_of_match, np);
+		rng_id = of_match_node(bcm2835_rng_of_match, dev->of_node);
 		if (!rng_id)
 			return -EINVAL;
 
