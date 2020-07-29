Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 220F92321D7
	for <lists+linux-crypto@lfdr.de>; Wed, 29 Jul 2020 17:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726839AbgG2Ppi (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 29 Jul 2020 11:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbgG2Pph (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 29 Jul 2020 11:45:37 -0400
Received: from mail-wr1-x449.google.com (mail-wr1-x449.google.com [IPv6:2a00:1450:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CDFC061794
        for <linux-crypto@vger.kernel.org>; Wed, 29 Jul 2020 08:45:37 -0700 (PDT)
Received: by mail-wr1-x449.google.com with SMTP id z1so6811278wrn.18
        for <linux-crypto@vger.kernel.org>; Wed, 29 Jul 2020 08:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZgKWuNcyq0Jw8RjrL7LGIbiWgvHy7KUaVF4Ewz+VObo=;
        b=CgAYVJguBYNtEkAQlMUHxp50ZJDEEAE5SMLeWevDNqHKsIlHCB00DbHRcuadBtJJL7
         KWA3flSODrE0Q4Nq0ahUFgXabL30LROz7Yn90SNq003QeMxcg3kjNJWVCg7T/eNaa4nW
         xU6xtzgwl9aldZzJU0xcuzmdb9KJ9EEynai4UiAZ2/acQfaO8rirEDC7JkdL0f4NZnkd
         f8dCGIxCpo2zeoNjUdpPlaGvKGZvBgplxEkrCxbpPMl0ftvuwZenezyDDTsCIO6bSgG+
         oVknFrtFJ4gt2BT8lVsIvA3068Jjzvx7vwxrdqw//q/aguJQeujerxo+KWhXQlr6kwBi
         HS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZgKWuNcyq0Jw8RjrL7LGIbiWgvHy7KUaVF4Ewz+VObo=;
        b=dnkmJ9neCmSL8w1g9L8hQPsZDJVQ0RPbPKUAR5Yu6lxlSVig4GE9miIhlp6iJJRlaS
         ZDJUpQbpdVPaTuHG6PKzG+yVtHZ3JrYQwlzLFDrihujJbjfOOyjM/jSw1cmKXF1S5Mu1
         76RQJfpa69y7EsaVAi9I+h1C7XDFftLOdWbZ0zGs/oTmDuDSrZ8Jq4rzoIpwekyXMb+e
         c28kDy1paCXN0pzEEwbRtVtC0tk4NATQ6trZBUKRSOHMmn6rQ6sdECHHP5y2/ces0II1
         qcfOMBnIWFRW+yRFG1MnG9ZsnTAXbLx98vx2fHY3lR5ytp3ntRXz8PrGwYvxqKFv1j7r
         maIg==
X-Gm-Message-State: AOAM531UnNMI30/jLY4WLGmC5MgBYmEOP047PhWxclhzJLqp5P9FCywN
        ubxGdZGQWpuTc3kUzeDaEUxWBxM6m62HYm8+uzD64n8Rzl1k2bgwvVZNAxbUii5lidxaFGwMkiU
        PfUeBRc0ibiYkuQnDeSXzg9THNo8rpKeN98XyUSbcgAAfJCa8HR973tBs+iMku52x3+qNKMte
X-Google-Smtp-Source: ABdhPJwnXTRkCpYVkyD/bOdNGutk57tMe3eM10y4GE3dhSrn18M7rs6JiI6iZA6DJfms70AmhI0wGtgWribd
X-Received: by 2002:a5d:4bd2:: with SMTP id l18mr29001722wrt.119.1596037535483;
 Wed, 29 Jul 2020 08:45:35 -0700 (PDT)
Date:   Wed, 29 Jul 2020 16:45:01 +0100
In-Reply-To: <20200728173603.GD4053562@gmail.com>
Message-Id: <20200729154501.2461888-1-lenaptr@google.com>
Mime-Version: 1.0
References: <20200728173603.GD4053562@gmail.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v4] crypto: af_alg - add extra parameters for DRBG interface
From:   Elena Petrova <lenaptr@google.com>
To:     linux-crypto@vger.kernel.org
Cc:     Elena Petrova <lenaptr@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "=?UTF-8?q?Stephan=20M=C3=BCller?=" <smueller@chronox.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Extend the user-space RNG interface:
  1. Add entropy input via ALG_SET_DRBG_ENTROPY setsockopt option;
  2. Add additional data input via sendmsg syscall.

This allows DRBG to be tested with test vectors, for example for the
purpose of CAVP testing, which otherwise isn't possible.

To prevent erroneous use of entropy input, it is hidden under
CRYPTO_USER_API_CAVP_DRBG config option and requires CAP_SYS_ADMIN to
succeed.

Signed-off-by: Elena Petrova <lenaptr@google.com>
---

Updates in v4:
  1) setentropy returns 0 or error code (used to return length);
  2) bigfixes suggested by Eric.

Updates in v3:
  1) More details in commit message;
  2) config option name is now CRYPTO_USER_API_CAVP_DRBG;
  3) fixed a bug of not releasing socket locks.

Updates in v2:
  1) Adding CONFIG_CRYPTO_CAVS_DRBG around setentropy.
  2) Requiring CAP_SYS_ADMIN for entropy reset.
  3) Locking for send and recv.
  4) Length checks added for send and setentropy; send and setentropy now return
     number of bytes accepted.
  5) Minor code style corrections.

libkcapi patch for testing:
  https://github.com/Len0k/libkcapi/commit/6f095d270b982008f419078614c15caa592cb531

 Documentation/crypto/userspace-if.rst |  17 +++-
 crypto/Kconfig                        |   8 ++
 crypto/af_alg.c                       |   8 ++
 crypto/algif_rng.c                    | 130 ++++++++++++++++++++++++--
 include/crypto/if_alg.h               |   1 +
 include/uapi/linux/if_alg.h           |   1 +
 6 files changed, 152 insertions(+), 13 deletions(-)

diff --git a/Documentation/crypto/userspace-if.rst b/Documentation/crypto/userspace-if.rst
index ff86befa61e0..ef7132802c2d 100644
--- a/Documentation/crypto/userspace-if.rst
+++ b/Documentation/crypto/userspace-if.rst
@@ -296,15 +296,23 @@ follows:
 
     struct sockaddr_alg sa = {
         .salg_family = AF_ALG,
-        .salg_type = "rng", /* this selects the symmetric cipher */
-        .salg_name = "drbg_nopr_sha256" /* this is the cipher name */
+        .salg_type = "rng", /* this selects the random number generator */
+        .salg_name = "drbg_nopr_sha256" /* this is the RNG name */
     };
 
 
 Depending on the RNG type, the RNG must be seeded. The seed is provided
 using the setsockopt interface to set the key. For example, the
 ansi_cprng requires a seed. The DRBGs do not require a seed, but may be
-seeded.
+seeded. The seed is also known as a *Personalization String* in DRBG800-90A
+standard.
+
+For the purpose of CAVP testing, the concatenation of *Entropy* and *Nonce*
+can be provided to the RNG via ALG_SET_DRBG_ENTROPY setsockopt interface. This
+requires a kernel built with CONFIG_CRYPTO_USER_API_CAVP_DRBG, and
+CAP_SYS_ADMIN permission.
+
+*Additional Data* can be provided using the send()/sendmsg() system calls.
 
 Using the read()/recvmsg() system calls, random numbers can be obtained.
 The kernel generates at most 128 bytes in one call. If user space
@@ -377,6 +385,9 @@ mentioned optname:
    provided ciphertext is assumed to contain an authentication tag of
    the given size (see section about AEAD memory layout below).
 
+-  ALG_SET_DRBG_ENTROPY -- Setting the entropy of the random number generator.
+   This option is applicable to RNG cipher type only.
+
 User space API example
 ----------------------
 
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 091c0a0bbf26..aa2b3085a431 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1896,6 +1896,14 @@ config CRYPTO_STATS
 config CRYPTO_HASH_INFO
 	bool
 
+config CRYPTO_USER_API_CAVP_DRBG
+	tristate "Enable CAVP testing of DRBG"
+	depends on CRYPTO_USER_API_RNG && CRYPTO_DRBG
+	help
+	  This option enables the resetting of DRBG entropy via the user-space
+	  interface. This should only be enabled for CAVP testing. You should say
+	  no unless you know what this is.
+
 source "lib/crypto/Kconfig"
 source "drivers/crypto/Kconfig"
 source "crypto/asymmetric_keys/Kconfig"
diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index b1cd3535c525..27d6248ca447 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -260,6 +260,14 @@ static int alg_setsockopt(struct socket *sock, int level, int optname,
 		if (!type->setauthsize)
 			goto unlock;
 		err = type->setauthsize(ask->private, optlen);
+		break;
+	case ALG_SET_DRBG_ENTROPY:
+		if (sock->state == SS_CONNECTED)
+			goto unlock;
+		if (!type->setentropy)
+			goto unlock;
+
+		err = type->setentropy(ask->private, optval, optlen);
 	}
 
 unlock:
diff --git a/crypto/algif_rng.c b/crypto/algif_rng.c
index 087c0ad09d38..21e8201844bf 100644
--- a/crypto/algif_rng.c
+++ b/crypto/algif_rng.c
@@ -38,6 +38,7 @@
  * DAMAGE.
  */
 
+#include <linux/capability.h>
 #include <linux/module.h>
 #include <crypto/rng.h>
 #include <linux/random.h>
@@ -53,20 +54,35 @@ struct rng_ctx {
 #define MAXSIZE 128
 	unsigned int len;
 	struct crypto_rng *drng;
+	u8 *addtl;
+	size_t addtl_len;
 };
 
+struct rng_parent_ctx {
+	struct crypto_rng *drng;
+	u8 *entropy;
+};
+
+static void rng_reset_addtl(struct rng_ctx *ctx)
+{
+	kzfree(ctx->addtl);
+	ctx->addtl = NULL;
+	ctx->addtl_len = 0;
+}
+
 static int rng_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 		       int flags)
 {
 	struct sock *sk = sock->sk;
 	struct alg_sock *ask = alg_sk(sk);
 	struct rng_ctx *ctx = ask->private;
-	int err;
+	int err = 0;
 	int genlen = 0;
 	u8 result[MAXSIZE];
 
+	lock_sock(sock->sk);
 	if (len == 0)
-		return 0;
+		goto unlock;
 	if (len > MAXSIZE)
 		len = MAXSIZE;
 
@@ -82,13 +98,48 @@ static int rng_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	 * seeding as they automatically seed. The X9.31 DRNG will return
 	 * an error if it was not seeded properly.
 	 */
-	genlen = crypto_rng_get_bytes(ctx->drng, result, len);
-	if (genlen < 0)
-		return genlen;
+	genlen = crypto_rng_generate(ctx->drng, ctx->addtl, ctx->addtl_len,
+				     result, len);
+	if (genlen < 0) {
+		err = genlen;
+		goto unlock;
+	}
 
 	err = memcpy_to_msg(msg, result, len);
 	memzero_explicit(result, len);
+	rng_reset_addtl(ctx);
 
+unlock:
+	release_sock(sock->sk);
+	return err ? err : len;
+}
+
+static int rng_sendmsg(struct socket *sock, struct msghdr *msg, size_t len)
+{
+	int err;
+	struct alg_sock *ask = alg_sk(sock->sk);
+	struct rng_ctx *ctx = ask->private;
+
+	lock_sock(sock->sk);
+	if (len > MAXSIZE)
+		len = MAXSIZE;
+
+	rng_reset_addtl(ctx);
+	ctx->addtl = kmalloc(len, GFP_KERNEL);
+	if (!ctx->addtl) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	err = memcpy_from_msg(ctx->addtl, msg, len);
+	if (err) {
+		rng_reset_addtl(ctx);
+		goto unlock;
+	}
+	ctx->addtl_len = len;
+
+unlock:
+	release_sock(sock->sk);
 	return err ? err : len;
 }
 
@@ -106,21 +157,41 @@ static struct proto_ops algif_rng_ops = {
 	.bind		=	sock_no_bind,
 	.accept		=	sock_no_accept,
 	.setsockopt	=	sock_no_setsockopt,
-	.sendmsg	=	sock_no_sendmsg,
 	.sendpage	=	sock_no_sendpage,
 
 	.release	=	af_alg_release,
 	.recvmsg	=	rng_recvmsg,
+	.sendmsg	=	rng_sendmsg,
 };
 
 static void *rng_bind(const char *name, u32 type, u32 mask)
 {
-	return crypto_alloc_rng(name, type, mask);
+	struct rng_parent_ctx *pctx;
+	struct crypto_rng *rng;
+
+	pctx = kzalloc(sizeof(*pctx), GFP_KERNEL);
+	if (!pctx)
+		return ERR_PTR(-ENOMEM);
+
+	rng = crypto_alloc_rng(name, type, mask);
+	if (IS_ERR(rng)) {
+		kfree(pctx);
+		return ERR_CAST(rng);
+	}
+
+	pctx->drng = rng;
+	return pctx;
 }
 
 static void rng_release(void *private)
 {
-	crypto_free_rng(private);
+	struct rng_parent_ctx *pctx = private;
+
+	if (unlikely(!pctx))
+		return;
+	crypto_free_rng(pctx->drng);
+	kzfree(pctx->entropy);
+	kzfree(pctx);
 }
 
 static void rng_sock_destruct(struct sock *sk)
@@ -128,6 +199,7 @@ static void rng_sock_destruct(struct sock *sk)
 	struct alg_sock *ask = alg_sk(sk);
 	struct rng_ctx *ctx = ask->private;
 
+	rng_reset_addtl(ctx);
 	sock_kfree_s(sk, ctx, ctx->len);
 	af_alg_release_parent(sk);
 }
@@ -135,6 +207,7 @@ static void rng_sock_destruct(struct sock *sk)
 static int rng_accept_parent(void *private, struct sock *sk)
 {
 	struct rng_ctx *ctx;
+	struct rng_parent_ctx *pctx = private;
 	struct alg_sock *ask = alg_sk(sk);
 	unsigned int len = sizeof(*ctx);
 
@@ -150,7 +223,9 @@ static int rng_accept_parent(void *private, struct sock *sk)
 	 * state of the RNG.
 	 */
 
-	ctx->drng = private;
+	ctx->drng = pctx->drng;
+	ctx->addtl = NULL;
+	ctx->addtl_len = 0;
 	ask->private = ctx;
 	sk->sk_destruct = rng_sock_destruct;
 
@@ -159,18 +234,53 @@ static int rng_accept_parent(void *private, struct sock *sk)
 
 static int rng_setkey(void *private, const u8 *seed, unsigned int seedlen)
 {
+	struct rng_parent_ctx *pctx = private;
 	/*
 	 * Check whether seedlen is of sufficient size is done in RNG
 	 * implementations.
 	 */
-	return crypto_rng_reset(private, seed, seedlen);
+	return crypto_rng_reset(pctx->drng, seed, seedlen);
+}
+
+#ifdef CONFIG_CRYPTO_USER_API_CAVP_DRBG
+static int rng_setentropy(void *private, const u8 *entropy, unsigned int len)
+{
+	struct rng_parent_ctx *pctx = private;
+	u8 *kentropy = NULL;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (pctx->entropy)
+		return -EINVAL;
+
+	if (len > MAXSIZE)
+		return -EMSGSIZE;
+
+	if (len) {
+		kentropy = memdup_user(entropy, len);
+		if (IS_ERR(kentropy))
+			return PTR_ERR(kentropy);
+	}
+
+	crypto_rng_alg(pctx->drng)->set_ent(pctx->drng, kentropy, len);
+	/*
+	 * Since rng doesn't perform any memory management for the entropy
+	 * buffer, save kentropy pointer to pctx now to free it after use.
+	 */
+	pctx->entropy = kentropy;
+	return 0;
 }
+#endif
 
 static const struct af_alg_type algif_type_rng = {
 	.bind		=	rng_bind,
 	.release	=	rng_release,
 	.accept		=	rng_accept_parent,
 	.setkey		=	rng_setkey,
+#ifdef CONFIG_CRYPTO_USER_API_CAVP_DRBG
+	.setentropy	=	rng_setentropy,
+#endif
 	.ops		=	&algif_rng_ops,
 	.name		=	"rng",
 	.owner		=	THIS_MODULE
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index 56527c85d122..9e5c8ac53c59 100644
--- a/include/crypto/if_alg.h
+++ b/include/crypto/if_alg.h
@@ -46,6 +46,7 @@ struct af_alg_type {
 	void *(*bind)(const char *name, u32 type, u32 mask);
 	void (*release)(void *private);
 	int (*setkey)(void *private, const u8 *key, unsigned int keylen);
+	int (*setentropy)(void *private, const u8 *entropy, unsigned int len);
 	int (*accept)(void *private, struct sock *sk);
 	int (*accept_nokey)(void *private, struct sock *sk);
 	int (*setauthsize)(void *private, unsigned int authsize);
diff --git a/include/uapi/linux/if_alg.h b/include/uapi/linux/if_alg.h
index bc2bcdec377b..60b7c2efd921 100644
--- a/include/uapi/linux/if_alg.h
+++ b/include/uapi/linux/if_alg.h
@@ -35,6 +35,7 @@ struct af_alg_iv {
 #define ALG_SET_OP			3
 #define ALG_SET_AEAD_ASSOCLEN		4
 #define ALG_SET_AEAD_AUTHSIZE		5
+#define ALG_SET_DRBG_ENTROPY		6
 
 /* Operations */
 #define ALG_OP_DECRYPT			0
-- 
2.28.0.rc0.142.g3c755180ce-goog

