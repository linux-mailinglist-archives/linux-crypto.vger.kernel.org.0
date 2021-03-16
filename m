Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BC7933CB39
	for <lists+linux-crypto@lfdr.de>; Tue, 16 Mar 2021 03:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233801AbhCPB7y (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 15 Mar 2021 21:59:54 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13618 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbhCPB7v (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 15 Mar 2021 21:59:51 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DzxJK4ds7z17LlX;
        Tue, 16 Mar 2021 09:57:53 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Tue, 16 Mar 2021 09:59:35 +0800
From:   chenxiang <chenxiang66@hisilicon.com>
To:     <clabbe.montjoie@gmail.com>, <clabbe@baylibre.com>,
        <gcherian@marvell.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <linuxarm@openeuler.org>,
        Xiang Chen <chenxiang66@hisilicon.com>
Subject: [PATCH v2 0/4] Fix the parameter of dma_map_sg()
Date:   Tue, 16 Mar 2021 09:55:22 +0800
Message-ID: <1615859726-57062-1-git-send-email-chenxiang66@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Xiang Chen <chenxiang66@hisilicon.com>

According to Documentation/core-api/dma-api-howto.rst, the parameters
of dma_unmap_sg() must be the same as those which are passed in to the
scatter/gather mapping API.
But for some drivers under crypto, the <nents> parameter of dma_unmap_sg()
is number of elements after mapping. So fix them.

Part of the document is as follows:

To unmap a scatterlist, just call::

        dma_unmap_sg(dev, sglist, nents, direction);
	
Again, make sure DMA activity has already finished.
	
        .. note::
		
	    The 'nents' argument to the dma_unmap_sg call must be
	    the _same_ one you passed into the dma_map_sg call,
	    it should _NOT_ be the 'count' value _returned_ from the
	    dma_map_sg call.

Change Log:
v1 -> v2: Remove changing the count passed to create_sg_component 
in driver cavium;

Xiang Chen (4):
  crypto: amlogic - Fix the parameter of dma_unmap_sg()
  crypto: cavium - Fix the parameter of dma_unmap_sg()
  crypto: ux500 - Fix the parameter of dma_unmap_sg()
  crypto: allwinner - Fix the parameter of dma_unmap_sg()

 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-cipher.c | 9 ++++++---
 drivers/crypto/allwinner/sun8i-ce/sun8i-ce-hash.c   | 3 ++-
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-cipher.c | 9 ++++++---
 drivers/crypto/allwinner/sun8i-ss/sun8i-ss-hash.c   | 3 ++-
 drivers/crypto/amlogic/amlogic-gxl-cipher.c         | 6 +++---
 drivers/crypto/cavium/nitrox/nitrox_reqmgr.c        | 9 +++++----
 drivers/crypto/ux500/cryp/cryp_core.c               | 4 ++--
 drivers/crypto/ux500/hash/hash_core.c               | 2 +-
 8 files changed, 27 insertions(+), 18 deletions(-)

-- 
2.8.1

