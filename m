Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F08B33AB76
	for <lists+linux-crypto@lfdr.de>; Mon, 15 Mar 2021 07:12:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbhCOGLz (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Mon, 15 Mar 2021 02:11:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13168 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhCOGLc (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Mon, 15 Mar 2021 02:11:32 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4DzQwf73DvzlQyL;
        Mon, 15 Mar 2021 14:09:06 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.498.0; Mon, 15 Mar 2021 14:11:23 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <herbert@gondor.apana.org.au>, <mpm@selenic.com>
CC:     <linux-crypto@vger.kernel.org>
Subject: [PATCH] hwrng: intel - Fix included header from 'asm
Date:   Mon, 15 Mar 2021 14:12:04 +0800
Message-ID: <1615788724-10979-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

This commit fixes the checkpatch warning:
WARNING: Use #include <linux/io.h> instead of <asm/io.h>
34: FILE: drivers/char/hw_random/intel-rng.c:34:

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/char/hw_random/intel-rng.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/hw_random/intel-rng.c b/drivers/char/hw_random/intel-rng.c
index eb7db27..d740b88 100644
--- a/drivers/char/hw_random/intel-rng.c
+++ b/drivers/char/hw_random/intel-rng.c
@@ -25,13 +25,13 @@
  */
 
 #include <linux/hw_random.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/stop_machine.h>
 #include <linux/delay.h>
 #include <linux/slab.h>
-#include <asm/io.h>
 
 
 #define PFX	KBUILD_MODNAME ": "
-- 
2.7.4

