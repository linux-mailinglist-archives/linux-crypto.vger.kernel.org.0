Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B8627A3DD
	for <lists+linux-crypto@lfdr.de>; Sun, 27 Sep 2020 22:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgI0UCc (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Sun, 27 Sep 2020 16:02:32 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:14481
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726722AbgI0UC3 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Sun, 27 Sep 2020 16:02:29 -0400
X-IronPort-AV: E=Sophos;i="5.77,311,1596492000"; 
   d="scan'208";a="360169494"
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
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/18] hwrng: mxc-rnga - use semicolons rather than commas to separate statements
Date:   Sun, 27 Sep 2020 21:12:17 +0200
Message-Id: <1601233948-11629-8-git-send-email-Julia.Lawall@inria.fr>
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
 drivers/char/hw_random/mxc-rnga.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/char/hw_random/mxc-rnga.c b/drivers/char/hw_random/mxc-rnga.c
index 025083c838f5..008763c988ed 100644
--- a/drivers/char/hw_random/mxc-rnga.c
+++ b/drivers/char/hw_random/mxc-rnga.c
@@ -143,9 +143,9 @@ static int __init mxc_rnga_probe(struct platform_device *pdev)
 	mxc_rng->dev = &pdev->dev;
 	mxc_rng->rng.name = "mxc-rnga";
 	mxc_rng->rng.init = mxc_rnga_init;
-	mxc_rng->rng.cleanup = mxc_rnga_cleanup,
-	mxc_rng->rng.data_present = mxc_rnga_data_present,
-	mxc_rng->rng.data_read = mxc_rnga_data_read,
+	mxc_rng->rng.cleanup = mxc_rnga_cleanup;
+	mxc_rng->rng.data_present = mxc_rnga_data_present;
+	mxc_rng->rng.data_read = mxc_rnga_data_read;
 
 	mxc_rng->clk = devm_clk_get(&pdev->dev, NULL);
 	if (IS_ERR(mxc_rng->clk)) {

