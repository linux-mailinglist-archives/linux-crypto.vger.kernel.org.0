Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F49920D65C
	for <lists+linux-crypto@lfdr.de>; Mon, 29 Jun 2020 22:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729522AbgF2TTT (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 29 Jun 2020 15:19:19 -0400
Received: from helcar.hmeau.com ([216.24.177.18]:59760 "EHLO fornost.hmeau.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730297AbgF2TTS (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 29 Jun 2020 15:19:18 -0400
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.0.7])
        by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
        id 1jpolm-0003w9-IT; Mon, 29 Jun 2020 18:04:03 +1000
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation); Mon, 29 Jun 2020 18:04:02 +1000
From:   "Herbert Xu" <herbert@gondor.apana.org.au>
Date:   Mon, 29 Jun 2020 18:04:02 +1000
Subject: [PATCH 5/7] hwrng: st - Fix W=1 unused variable warning
References: <20200629080316.GA11246@gondor.apana.org.au>
To:     Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Message-Id: <E1jpolm-0003w9-IT@fornost.hmeau.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch fixes an unused variable warning when this driver is
built-in with CONFIG_OF=n.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---

 drivers/char/hw_random/st-rng.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/st-rng.c b/drivers/char/hw_random/st-rng.c
index 783c24e3f8b7f..15ba1e6fae4d2 100644
--- a/drivers/char/hw_random/st-rng.c
+++ b/drivers/char/hw_random/st-rng.c
@@ -12,6 +12,7 @@
 #include <linux/delay.h>
 #include <linux/hw_random.h>
 #include <linux/io.h>
+#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -121,7 +122,7 @@ static int st_rng_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id st_rng_match[] = {
+static const struct of_device_id st_rng_match[] __maybe_unused = {
 	{ .compatible = "st,rng" },
 	{},
 };
