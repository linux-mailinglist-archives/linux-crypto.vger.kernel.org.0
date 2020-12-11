Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53C152D6DB5
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Dec 2020 02:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729384AbgLKBnz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 10 Dec 2020 20:43:55 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:8989 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390028AbgLKBnX (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 10 Dec 2020 20:43:23 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4CsYS33QgBzhqPl;
        Fri, 11 Dec 2020 09:42:11 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Fri, 11 Dec 2020 09:42:35 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <gilad@benyossef.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>
Subject: [PATCH] crypto: ccree - remove unused including <linux/version.h>
Date:   Fri, 11 Dec 2020 09:42:47 +0800
Message-ID: <1607650967-31321-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Remove including <linux/version.h> that don't need it.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/crypto/ccree/cc_driver.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/ccree/cc_driver.h b/drivers/crypto/ccree/cc_driver.h
index 5f1d460..f49579a 100644
--- a/drivers/crypto/ccree/cc_driver.h
+++ b/drivers/crypto/ccree/cc_driver.h
@@ -23,7 +23,6 @@
 #include <crypto/authenc.h>
 #include <crypto/hash.h>
 #include <crypto/skcipher.h>
-#include <linux/version.h>
 #include <linux/clk.h>
 #include <linux/platform_device.h>
 
-- 
2.7.4

