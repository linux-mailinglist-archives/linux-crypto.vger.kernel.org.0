Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0586912F3A8
	for <lists+linux-crypto@lfdr.de>; Fri,  3 Jan 2020 05:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbgACEB0 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 2 Jan 2020 23:01:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:33570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727134AbgACEB0 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 2 Jan 2020 23:01:26 -0500
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net [24.5.143.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 128BF227BF
        for <linux-crypto@vger.kernel.org>; Fri,  3 Jan 2020 04:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578024086;
        bh=axmFbQoKU2rhg2ddd/chkcLSQ3CDgMpshQeAmkY/HBg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=dTXmBsa4WZYDOVhaSjGS7BGg4HJJdIewngN5AMdehOUhtpvMdiSWa106kOfNS49i3
         MYODsULkcun9F30jiPr25+VvN6E+6I5KtwpXwwvPajQF/sysykqfkREiuXgN1TOAue
         2nte0hBLetUAduwlShWCbqE6fWjmIX+4inb6qiLU=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-crypto@vger.kernel.org
Subject: [PATCH v2 10/28] crypto: ahash - introduce crypto_grab_ahash()
Date:   Thu,  2 Jan 2020 19:58:50 -0800
Message-Id: <20200103035908.12048-11-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200103035908.12048-1-ebiggers@kernel.org>
References: <20200103035908.12048-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Currently, ahash spawns are initialized by using ahash_attr_alg() or
crypto_find_alg() to look up the ahash algorithm, then calling
crypto_init_ahash_spawn().

This is different from how skcipher, aead, and akcipher spawns are
initialized (they use crypto_grab_*()), and for no good reason.  This
difference introduces unnecessary complexity.

The crypto_grab_*() functions used to have some problems, like not
holding a reference to the algorithm and requiring the caller to
initialize spawn->base.inst.  But those problems are fixed now.

So, let's introduce crypto_grab_ahash() so that we can convert all
templates to the same way of initializing their spawns.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 crypto/ahash.c                 |  9 +++++++++
 include/crypto/internal/hash.h | 10 ++++++++++
 2 files changed, 19 insertions(+)

diff --git a/crypto/ahash.c b/crypto/ahash.c
index 181bd851b429..e98a1398ed7f 100644
--- a/crypto/ahash.c
+++ b/crypto/ahash.c
@@ -556,6 +556,15 @@ const struct crypto_type crypto_ahash_type = {
 };
 EXPORT_SYMBOL_GPL(crypto_ahash_type);
 
+int crypto_grab_ahash(struct crypto_ahash_spawn *spawn,
+		      struct crypto_instance *inst,
+		      const char *name, u32 type, u32 mask)
+{
+	spawn->base.frontend = &crypto_ahash_type;
+	return crypto_grab_spawn(&spawn->base, inst, name, type, mask);
+}
+EXPORT_SYMBOL_GPL(crypto_grab_ahash);
+
 struct crypto_ahash *crypto_alloc_ahash(const char *alg_name, u32 type,
 					u32 mask)
 {
diff --git a/include/crypto/internal/hash.h b/include/crypto/internal/hash.h
index 4d1a0d8e4f3a..e1024fa0032f 100644
--- a/include/crypto/internal/hash.h
+++ b/include/crypto/internal/hash.h
@@ -109,11 +109,21 @@ int crypto_init_ahash_spawn(struct crypto_ahash_spawn *spawn,
 			    struct hash_alg_common *alg,
 			    struct crypto_instance *inst);
 
+int crypto_grab_ahash(struct crypto_ahash_spawn *spawn,
+		      struct crypto_instance *inst,
+		      const char *name, u32 type, u32 mask);
+
 static inline void crypto_drop_ahash(struct crypto_ahash_spawn *spawn)
 {
 	crypto_drop_spawn(&spawn->base);
 }
 
+static inline struct hash_alg_common *crypto_spawn_ahash_alg(
+	struct crypto_ahash_spawn *spawn)
+{
+	return __crypto_hash_alg_common(spawn->base.alg);
+}
+
 struct hash_alg_common *ahash_attr_alg(struct rtattr *rta, u32 type, u32 mask);
 
 int crypto_register_shash(struct shash_alg *alg);
-- 
2.24.1

