Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCEB612F3C1
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Jan 2020 05:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbgACEFG (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 2 Jan 2020 23:05:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:39522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726292AbgACEFG (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 2 Jan 2020 23:05:06 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 026B8222C3
        for <linux-crypto@vger.kernel.org>; Fri,  3 Jan 2020 04:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578024306;
        bh=o4OzcvqIdyJ6YIW9hU9gmpOjoV0BHrX/rhFquRitSjY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=VhqmIvW8D/CI+nkHmZ26RnIBK+3o5vZaftBGfarEu5jLR1P9M1QOQH5dHPS3obY37
         gPR5m00PskJvjsNSJRRDkWIwQCR+727knykPZwAwmiK/3CbX7oi9jPeyuU0/RbhhTL
         es2ULXDbP6macfNGHQJlcowdcXhpEV2Skd/lC5zs=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: [PATCH v2 1/6] crypto: hash - add support for new way of freeing instances
Date:   Thu,  2 Jan 2020 20:04:35 -0800
Message-Id: <20200103040440.12375-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200103040440.12375-1-ebiggers@kernel.org>
References: <20200103040440.12375-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Add support to shash and ahash for the new way of freeing instances
(already used for skcipher, aead, and akcipher) where a ->free() method
is installed to the instance struct itself.  These methods are more
strongly-typed than crypto_template::free(), which they replace.

This will allow removing support for the old way of freeing instances.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/ahash.c                 | 13 +++++++++++++
 crypto/shash.c                 | 13 +++++++++++++
 include/crypto/internal/hash.h |  2 ++
 3 files changed, 28 insertions(+)

diff --git a/crypto/ahash.c b/crypto/ahash.c
index c77717fcea8e..61e374d76b04 100644
--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -511,6 +511,18 @@ static unsigned int crypto_ahash_extsize(struct crypto_alg *alg)
 	return crypto_alg_extsize(alg);
 }
 
+static void crypto_ahash_free_instance(struct crypto_instance *inst)
+{
+	struct ahash_instance *ahash = ahash_instance(inst);
+
+	if (!ahash->free) {
+		inst->tmpl->free(inst);
+		return;
+	}
+
+	ahash->free(ahash);
+}
+
 #ifdef CONFIG_NET
 static int crypto_ahash_report(struct sk_buff *skb, struct crypto_alg *alg)
 {
@@ -547,6 +559,7 @@ static void crypto_ahash_show(struct seq_file *m, struct crypto_alg *alg)
 static const struct crypto_type crypto_ahash_type = {
 	.extsize = crypto_ahash_extsize,
 	.init_tfm = crypto_ahash_init_tfm,
+	.free = crypto_ahash_free_instance,
 #ifdef CONFIG_PROC_FS
 	.show = crypto_ahash_show,
 #endif
diff --git a/crypto/shash.c b/crypto/shash.c
index 4d6ccb59e126..2f6adb49727b 100644
--- a/crypto/shash.c
+++ b/crypto/shash.c
@@ -423,6 +423,18 @@ static int crypto_shash_init_tfm(struct crypto_tfm *tfm)
 	return 0;
 }
 
+static void crypto_shash_free_instance(struct crypto_instance *inst)
+{
+	struct shash_instance *shash = shash_instance(inst);
+
+	if (!shash->free) {
+		inst->tmpl->free(inst);
+		return;
+	}
+
+	shash->free(shash);
+}
+
 #ifdef CONFIG_NET
 static int crypto_shash_report(struct sk_buff *skb, struct crypto_alg *alg)
 {
@@ -459,6 +471,7 @@ static void crypto_shash_show(struct seq_file *m, struct crypto_alg *alg)
 static const struct crypto_type crypto_shash_type = {
 	.extsize = crypto_alg_extsize,
 	.init_tfm = crypto_shash_init_tfm,
+	.free = crypto_shash_free_instance,
 #ifdef CONFIG_PROC_FS
 	.show = crypto_shash_show,
 #endif
diff --git a/include/crypto/internal/hash.h b/include/crypto/internal/hash.h
index c84b7cb29887..c550386221bb 100644
--- a/include/crypto/internal/hash.h
+++ b/include/crypto/internal/hash.h
@@ -30,6 +30,7 @@ struct crypto_hash_walk {
 };
 
 struct ahash_instance {
+	void (*free)(struct ahash_instance *inst);
 	union {
 		struct {
 			char head[offsetof(struct ahash_alg, halg.base)];
@@ -40,6 +41,7 @@ struct ahash_instance {
 };
 
 struct shash_instance {
+	void (*free)(struct shash_instance *inst);
 	union {
 		struct {
 			char head[offsetof(struct shash_alg, base)];
-- 
2.24.1

