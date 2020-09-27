Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F3427A3D7
	for <lists+linux-crypto@lfdr.de>; Sun, 27 Sep 2020 22:03:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726424AbgI0UCZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 27 Sep 2020 16:02:25 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:14476
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726697AbgI0UCY (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 27 Sep 2020 16:02:24 -0400
X-Greylist: delayed 428 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Sep 2020 16:02:23 EDT
X-IronPort-AV: E=Sophos;i="5.77,311,1596492000"; 
   d="scan'208";a="360169490"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES256-SHA256; 27 Sep 2020 21:55:12 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Matt Mackall <mpm@selenic.com>
Cc:     =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Joe Perches <joe@perches.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        kernel-janitors@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-crypto@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/18] hwrng: stm32 - use semicolons rather than commas to separate statements
Date:   Sun, 27 Sep 2020 21:12:14 +0200
Message-Id: <1601233948-11629-5-git-send-email-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
References: <1601233948-11629-1-git-send-email-Julia.Lawall@inria.fr>
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Replace commas with semicolons.  What is done is essentially described by
the following Coccinelle semantic patch (http://coccinelle.lip6.fr/):

// <smpl>
@@ expression e1,e2; @@
e1
-,
+;
e2
... when any
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/char/hw_random/stm32-rng.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/hw_random/stm32-rng.c b/drivers/char/hw_random/stm32-rng.c
index 38324c2ddda1..bc22178f83e8 100644
--- a/drivers/char/hw_random/stm32-rng.c
+++ b/drivers/char/hw_random/stm32-rng.c
@@ -145,12 +145,12 @@ static int stm32_rng_probe(struct platform_device *ofdev)
 
 	dev_set_drvdata(dev, priv);
 
-	priv->rng.name = dev_driver_string(dev),
+	priv->rng.name = dev_driver_string(dev);
 #ifndef CONFIG_PM
-	priv->rng.init = stm32_rng_init,
-	priv->rng.cleanup = stm32_rng_cleanup,
+	priv->rng.init = stm32_rng_init;
+	priv->rng.cleanup = stm32_rng_cleanup;
 #endif
-	priv->rng.read = stm32_rng_read,
+	priv->rng.read = stm32_rng_read;
 	priv->rng.priv = (unsigned long) dev;
 	priv->rng.quality = 900;
 

