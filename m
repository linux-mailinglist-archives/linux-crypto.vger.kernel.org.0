Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DA791F7E5C
	for <lists+linux-crypto@lfdr.de>; Fri, 12 Jun 2020 23:22:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726329AbgFLVWF (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 12 Jun 2020 17:22:05 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:62953
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726290AbgFLVWF (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 12 Jun 2020 17:22:05 -0400
X-IronPort-AV: E=Sophos;i="5.73,504,1583190000"; 
   d="scan'208";a="351462289"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 23:22:02 +0200
Date:   Fri, 12 Jun 2020 23:22:02 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Keerthy <j-keerthy@ti.com>
cc:     Tero Kristo <t-kristo@ti.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        kbuild-all@lists.01.org
Subject: [PATCH] crypto: sa2ul: fix odd_ptr_err.cocci warnings
Message-ID: <alpine.DEB.2.22.394.2006122320210.8158@hadrien>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: kernel test robot <lkp@intel.com>

PTR_ERR should normally access the value just tested by IS_ERR

Generated by: scripts/coccinelle/tests/odd_ptr_err.cocci

Fixes: 5b8516f3bedb ("crypto: sa2ul: Add crypto driver")
CC: Keerthy <j-keerthy@ti.com>
Signed-off-by: kernel test robot <lkp@intel.com>
Signed-off-by: Julia Lawall <julia.lawall@inria.fr>
---

tree:   git://git.ti.com/ti-linux-kernel/ti-linux-kernel.git ti-linux-5.4.y
head:   134a1b1f8814115e2dd115b67082321bf9e63cc1
commit: 5b8516f3bedb3e1c273e7747b6e4a85c6e47907a [2369/7050] crypto: sa2ul: Add crypto driver
:::::: branch date: 3 hours ago
:::::: commit date: 5 months ago

 sa2ul.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/crypto/sa2ul.c
+++ b/drivers/crypto/sa2ul.c
@@ -1252,14 +1252,14 @@ static int sa_dma_init(struct sa_crypto_
 	dd->dma_rx2 = dma_request_chan(dd->dev, "rx2");
 	if (IS_ERR(dd->dma_rx2)) {
 		dma_release_channel(dd->dma_rx1);
-		if (PTR_ERR(dd->dma_rx1) != -EPROBE_DEFER)
+		if (PTR_ERR(dd->dma_rx2) != -EPROBE_DEFER)
 			dev_err(dd->dev, "Unable to request rx2 DMA channel\n");
 		return PTR_ERR(dd->dma_rx2);
 	}

 	dd->dma_tx = dma_request_chan(dd->dev, "tx");
 	if (IS_ERR(dd->dma_tx)) {
-		if (PTR_ERR(dd->dma_rx1) != -EPROBE_DEFER)
+		if (PTR_ERR(dd->dma_tx) != -EPROBE_DEFER)
 			dev_err(dd->dev, "Unable to request tx DMA channel\n");
 		ret = PTR_ERR(dd->dma_tx);
 		goto err_dma_tx;
