Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A48376E2E
	for <lists+linux-crypto@lfdr.de>; Sat,  8 May 2021 03:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230330AbhEHBwg (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 7 May 2021 21:52:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:18367 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhEHBwf (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 7 May 2021 21:52:35 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FcVc51mDQzlbxB;
        Sat,  8 May 2021 09:49:25 +0800 (CST)
Received: from huawei.com (10.174.28.241) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.498.0; Sat, 8 May 2021
 09:51:24 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <cuibixuan@huawei.com>, Haren Myneni <haren@us.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Michael Ellerman <mpe@ellerman.id.au>
CC:     <linux-crypto@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] crypto: nx842: add missing MODULE_DEVICE_TABLE
Date:   Sat, 8 May 2021 11:14:55 +0800
Message-ID: <20210508031455.53541-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.28.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 drivers/crypto/nx/nx-842-pseries.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/nx/nx-842-pseries.c b/drivers/crypto/nx/nx-842-pseries.c
index cc8dd3072b8b..8ee547ee378e 100644
--- a/drivers/crypto/nx/nx-842-pseries.c
+++ b/drivers/crypto/nx/nx-842-pseries.c
@@ -1069,6 +1069,7 @@ static const struct vio_device_id nx842_vio_driver_ids[] = {
 	{"ibm,compression-v1", "ibm,compression"},
 	{"", ""},
 };
+MODULE_DEVICE_TABLE(vio, nx842_vio_driver_ids);
 
 static struct vio_driver nx842_vio_driver = {
 	.name = KBUILD_MODNAME,

