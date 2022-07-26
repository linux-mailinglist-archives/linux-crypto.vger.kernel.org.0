Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BF1581ADE
	for <lists+linux-crypto@lfdr.de>; Tue, 26 Jul 2022 22:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239905AbiGZUQd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 26 Jul 2022 16:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239858AbiGZUQV (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 26 Jul 2022 16:16:21 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CA3232470
        for <linux-crypto@vger.kernel.org>; Tue, 26 Jul 2022 13:16:11 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id b21-20020a05600c4e1500b003a32bc8612fso17317wmq.3
        for <linux-crypto@vger.kernel.org>; Tue, 26 Jul 2022 13:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GWR8XbBS1oy+lmPSjXOdFIQ7ZMLcTchWH7fRG8D5Oe4=;
        b=LyKNGMWZNujT6s9/QUWJ2JVBwtpyqqQwZJlDQaKuI+upIlpRhAy3Nj9WwePSSu8pUl
         yA3q3wn8gtvE5mz8rffc9gM4xJMJrCu8GPLJvcn6Mn+O9ZZAgFc3GCzL64tC11ct6TmK
         PtQjdgAMGzKrapZECA0xSYFxrtDcXAsfd/IzTcjArOvGuVkEP4LGMSY4fWdrEnyQW4fN
         J2BOgLkTRSIKF+kKYCweRPV0ABuWIEOrUjWwqN3/Aaegd6rAWAOw6wGm0RtJdgPX/pJv
         0RLBc24wp3AJaUS1Jd7q4puaPs4XkhODkccEz8DTMVRjj1HEvj3e5YP5EqWuR+eX339l
         li5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GWR8XbBS1oy+lmPSjXOdFIQ7ZMLcTchWH7fRG8D5Oe4=;
        b=zeZOHue1BULCBEtVHyl3Trdu8K7LO+lxqM7Hp/07MZ16J0eAki4jE/4ZQ20qS+7O5H
         jlK96m+Ec681KycIjGFWMpu6Zgm2lWtEW9dRVhOieTnOiaTgKJjqQ2O94NLtSnbw8MP6
         UgMCjsphtSOemIRIuUkeowb4g2eLd8ZalyDV1eI2f1lTDgH45gmj2pESO3WSXjf0o7+5
         dErGRXlP6t0XYDBOuWXVEeQ+dWMhLfmmHm8DBpntJ7P//r/J7/XemESDuVV7g6Tv2Dnn
         ZJyyxBgMqf/qwmTzl67WiBT+/7YJCy3UqrhqT1RKKlgNkgM31hPSGdNoD9IsvF4+iPrr
         OE0A==
X-Gm-Message-State: AJIora8QHDfd8A/la+atYaVLusiuWgYvBfIBuimz/Yg9n9byKRh0eiXc
        S86v0flJU/mFrDe7Mwama7tBtA==
X-Google-Smtp-Source: AGRyM1sTDJOnzvOn5GuKOaCCikjaJbFUgi0rTM+scygEVQdwUbMQzlcukhe0K/rXy0i8Vr8g6LcDsg==
X-Received: by 2002:a7b:c7d1:0:b0:3a3:1890:3495 with SMTP id z17-20020a7bc7d1000000b003a318903495mr591785wmk.18.1658866569657;
        Tue, 26 Jul 2022 13:16:09 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m6-20020a05600c3b0600b003a320e6f011sm28073wms.1.2022.07.26.13.16.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 13:16:09 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Francesco Ruggeri <fruggeri@arista.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Leonard Crestez <cdleonard@gmail.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Salam Noureddine <noureddine@arista.com>,
        netdev@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: [PATCH 2/6] crypto_pool: Add crypto_pool_reserve_scratch()
Date:   Tue, 26 Jul 2022 21:15:56 +0100
Message-Id: <20220726201600.1715505-3-dima@arista.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220726201600.1715505-1-dima@arista.com>
References: <20220726201600.1715505-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Instead of having build-time hardcoded constant, reallocate scratch
area, if needed by user. Different algos, different users may need
different size of temp per-CPU buffer. Only up-sizing supported for
simplicity.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 crypto/Kconfig        |  6 ++++
 crypto/crypto_pool.c  | 65 +++++++++++++++++++++++++++++++------------
 include/crypto/pool.h |  3 +-
 3 files changed, 54 insertions(+), 20 deletions(-)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index aeddaa3dcc77..e5865be483be 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -2134,6 +2134,12 @@ config CRYPTO_POOL
 	help
 	  Per-CPU pool of crypto requests ready for usage in atomic contexts.
 
+config CRYPTO_POOL_DEFAULT_SCRATCH_SIZE
+	hex "Per-CPU default scratch area size"
+	depends on CRYPTO_POOL
+	default 0x100
+	range 0x100 0x10000
+
 source "drivers/crypto/Kconfig"
 source "crypto/asymmetric_keys/Kconfig"
 source "certs/Kconfig"
diff --git a/crypto/crypto_pool.c b/crypto/crypto_pool.c
index c668c02499b7..8ad6415fa817 100644
--- a/crypto/crypto_pool.c
+++ b/crypto/crypto_pool.c
@@ -1,13 +1,14 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
 #include <crypto/pool.h>
+#include <linux/cpu.h>
 #include <linux/kref.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/percpu.h>
 #include <linux/workqueue.h>
 
-static unsigned long scratch_size = DEFAULT_CRYPTO_POOL_SCRATCH_SZ;
+static unsigned long scratch_size = CONFIG_CRYPTO_POOL_DEFAULT_SCRATCH_SIZE;
 static DEFINE_PER_CPU(void *, crypto_pool_scratch);
 
 struct crypto_pool_entry {
@@ -19,28 +20,60 @@ struct crypto_pool_entry {
 
 #define CPOOL_SIZE (PAGE_SIZE/sizeof(struct crypto_pool_entry))
 static struct crypto_pool_entry cpool[CPOOL_SIZE];
-static int last_allocated;
+static unsigned int last_allocated;
 static DEFINE_MUTEX(cpool_mutex);
 
-static int crypto_pool_scratch_alloc(void)
+static void __set_scratch(void *scratch)
 {
-	int cpu;
+	kfree(this_cpu_read(crypto_pool_scratch));
+	this_cpu_write(crypto_pool_scratch, scratch);
+}
 
-	lockdep_assert_held(&cpool_mutex);
+/* Slow-path */
+/**
+ * crypto_pool_reserve_scratch - re-allocates scratch buffer, slow-path
+ * @size: request size for the scratch/temp buffer
+ */
+int crypto_pool_reserve_scratch(unsigned long size)
+{
+	int cpu, err = 0;
 
+	mutex_lock(&cpool_mutex);
+	if (size <= scratch_size) {
+		for_each_possible_cpu(cpu) {
+			if (per_cpu(crypto_pool_scratch, cpu))
+				continue;
+			goto allocate_scratch;
+		}
+		mutex_unlock(&cpool_mutex);
+		return 0;
+	}
+allocate_scratch:
+	cpus_read_lock();
 	for_each_possible_cpu(cpu) {
-		void *scratch = per_cpu(crypto_pool_scratch, cpu);
+		void *scratch;
 
-		if (scratch)
-			continue;
+		scratch = kmalloc_node(size, GFP_KERNEL, cpu_to_node(cpu));
+		if (!scratch) {
+			err = -ENOMEM;
+			break;
+		}
 
-		scratch = kmalloc_node(scratch_size, GFP_KERNEL,
-				       cpu_to_node(cpu));
-		if (!scratch)
-			return -ENOMEM;
-		per_cpu(crypto_pool_scratch, cpu) = scratch;
+		if (!cpu_online(cpu)) {
+			kfree(per_cpu(crypto_pool_scratch, cpu));
+			per_cpu(crypto_pool_scratch, cpu) = scratch;
+			continue;
+		}
+		err = smp_call_function_single(cpu, __set_scratch, scratch, 1);
+		if (err) {
+			kfree(scratch);
+			break;
+		}
 	}
-	return 0;
+
+	cpus_read_unlock();
+	mutex_unlock(&cpool_mutex);
+	return err;
 }
 
 static void crypto_pool_scratch_free(void)
@@ -139,10 +172,6 @@ int crypto_pool_alloc_ahash(const char *alg)
 
 	/* slow-path */
 	mutex_lock(&cpool_mutex);
-	err = crypto_pool_scratch_alloc();
-	if (err)
-		goto out;
-
 	for (i = 0; i < last_allocated; i++) {
 		if (cpool[i].alg && !strcmp(cpool[i].alg, alg)) {
 			kref_get(&cpool[i].kref);
diff --git a/include/crypto/pool.h b/include/crypto/pool.h
index 2c61aa45faff..c7d817860cc3 100644
--- a/include/crypto/pool.h
+++ b/include/crypto/pool.h
@@ -4,8 +4,6 @@
 
 #include <crypto/hash.h>
 
-#define DEFAULT_CRYPTO_POOL_SCRATCH_SZ	128
-
 struct crypto_pool {
 	void *scratch;
 };
@@ -20,6 +18,7 @@ struct crypto_pool_ahash {
 	struct ahash_request *req;
 };
 
+int crypto_pool_reserve_scratch(unsigned long size);
 int crypto_pool_alloc_ahash(const char *alg);
 void crypto_pool_add(unsigned int id);
 void crypto_pool_release(unsigned int id);
-- 
2.36.1

