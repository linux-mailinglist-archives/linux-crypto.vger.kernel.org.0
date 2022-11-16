Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D16562C3C9
	for <lists+linux-crypto@lfdr.de>; Wed, 16 Nov 2022 17:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiKPQRU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 16 Nov 2022 11:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234897AbiKPQRH (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 16 Nov 2022 11:17:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5DD156EDD;
        Wed, 16 Nov 2022 08:17:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7550DB81DA7;
        Wed, 16 Nov 2022 16:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B540C433C1;
        Wed, 16 Nov 2022 16:17:03 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="BnW7RkGC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1668615421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v24y1wfuWLq5Cu92sfEtPK6DD/spL3fwX1JCpyFIa2M=;
        b=BnW7RkGC9Fcq2ZG1RT/d/CIyFvNnzxI+y3tkfmX8qqtcxb7VHTah3KU6Df9TGBZnCjZL2h
        0CUAvsVt5vYzI7yOSV8tJkqq+2g8cFt4djJoqXUmtnOVb/wACoUWpyZt3MGKLIMK91kcRG
        YJqSKfBTQd6IdUnDbhvx9XW3ApqlwBA=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id fb4bb795 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Nov 2022 16:17:01 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-efi@vger.kernel.org, linux-crypto@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Lennart Poettering <lennart@poettering.net>,
        Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Subject: [PATCH RFC v1 2/6] vsprintf: initialize siphash key using notifier
Date:   Wed, 16 Nov 2022 17:16:38 +0100
Message-Id: <20221116161642.1670235-3-Jason@zx2c4.com>
In-Reply-To: <20221116161642.1670235-1-Jason@zx2c4.com>
References: <20221116161642.1670235-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Rather than polling every second, use the new notifier to do this at
exactly the right moment.

Cc: Mike Galbraith <efault@gmx.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Petr Mladek <pmladek@suse.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 lib/vsprintf.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 24f37bab8bc1..70aa5de3c330 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -41,6 +41,7 @@
 #include <linux/siphash.h>
 #include <linux/compiler.h>
 #include <linux/property.h>
+#include <linux/notifier.h>
 #ifdef CONFIG_BLOCK
 #include <linux/blkdev.h>
 #endif
@@ -752,26 +753,21 @@ early_param("debug_boot_weak_hash", debug_boot_weak_hash_enable);
 
 static bool filled_random_ptr_key __read_mostly;
 static siphash_key_t ptr_key __read_mostly;
-static void fill_ptr_key_workfn(struct work_struct *work);
-static DECLARE_DELAYED_WORK(fill_ptr_key_work, fill_ptr_key_workfn);
 
-static void fill_ptr_key_workfn(struct work_struct *work)
+static int fill_ptr_key(struct notifier_block *nb, unsigned long action, void *data)
 {
-	if (!rng_is_initialized()) {
-		queue_delayed_work(system_unbound_wq, &fill_ptr_key_work, HZ  * 2);
-		return;
-	}
-
 	get_random_bytes(&ptr_key, sizeof(ptr_key));
 
 	/* Pairs with smp_rmb() before reading ptr_key. */
 	smp_wmb();
 	WRITE_ONCE(filled_random_ptr_key, true);
+	return 0;
 }
 
 static int __init vsprintf_init_hashval(void)
 {
-	fill_ptr_key_workfn(NULL);
+	static struct notifier_block fill_ptr_key_nb = { .notifier_call = fill_ptr_key };
+	notify_on_rng_initialized(&fill_ptr_key_nb);
 	return 0;
 }
 subsys_initcall(vsprintf_init_hashval)
-- 
2.38.1

