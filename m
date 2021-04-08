Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E485357AB1
	for <lists+linux-crypto@lfdr.de>; Thu,  8 Apr 2021 05:21:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhDHDVq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 7 Apr 2021 23:21:46 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15958 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhDHDVp (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 7 Apr 2021 23:21:45 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FG61k1nkkzyNXH;
        Thu,  8 Apr 2021 11:19:22 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.498.0; Thu, 8 Apr 2021 11:21:26 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, Tian Tao <tiantao6@hisilicon.com>,
        "Zhiqi Song" <songzhiqi1@huawei.com>
Subject: [PATCH] crypto: cavium - remove unused including <linux/version.h>
Date:   Thu, 8 Apr 2021 11:21:51 +0800
Message-ID: <1617852111-26441-1-git-send-email-tiantao6@hisilicon.com>
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
Signed-off-by: Zhiqi Song <songzhiqi1@huawei.com>
---
 drivers/crypto/cavium/zip/common.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/cavium/zip/common.h b/drivers/crypto/cavium/zip/common.h
index 58fb3ed..54f6fb0 100644
--- a/drivers/crypto/cavium/zip/common.h
+++ b/drivers/crypto/cavium/zip/common.h
@@ -56,7 +56,6 @@
 #include <linux/seq_file.h>
 #include <linux/string.h>
 #include <linux/types.h>
-#include <linux/version.h>
 
 /* Device specific zlib function definitions */
 #include "zip_device.h"
-- 
2.7.4

