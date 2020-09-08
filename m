Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92DEB261629
	for <lists+linux-crypto@lfdr.de>; Tue,  8 Sep 2020 19:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbgIHREu (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 8 Sep 2020 13:04:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731884AbgIHREh (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 8 Sep 2020 13:04:37 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6594AC061573
        for <linux-crypto@vger.kernel.org>; Tue,  8 Sep 2020 10:04:36 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id c3so6473035edm.7
        for <linux-crypto@vger.kernel.org>; Tue, 08 Sep 2020 10:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc:content-transfer-encoding;
        bh=l1xA3m7pHn18x9WP3U+dX7wB444QYu+TqO+onsV9tX0=;
        b=tJ2BJYj7LKOkN9ivL75Ek5OZK+s/YLVkQyMyOyu2rXdnpH35jwFp9A//RX95vZwBHv
         FWDW3veDcB+qB5adTObRg6PMXV6aUdJigZAImBX9xqsqW+PNCkYtYnHyWQ3Z1vDw+pf1
         WMQqPrHgjCs5i+wClnyizpuXKxpo+Ewf9Iinwh6b1ECwLVx0W82P+lmnSjEx6HS0kKy/
         bHViHBfYUWgsgwfJbmKHj0VKDtPPgYvH8AoRdzujcmHE80h9DiMzc7nb1qj5GU2uiQnT
         5bMEWX97mkyictphWJa8D2YX6UetmiTtR3bNS+hiNnHI9MvwMoeKcKUdgbrlCPtXS+21
         Pg9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=l1xA3m7pHn18x9WP3U+dX7wB444QYu+TqO+onsV9tX0=;
        b=YV/UiylRoy88/vLj3BYBmk5ECx3KileoH1RoH4yDRudw9IDvWc6AZxoVSWaXCUdzQN
         /9RipqRQZuHnUaoAUmo61oG0JbmyjkmD/X3MXcas9n4lYeefQ2nin8gneyR9fdds6XqO
         5c7/cxpgnnlptWBWfAsJPiwdcmpr/nQ7jrf9pJVeKtZ7nEA1VxxYpJ+TTfmcAj7So3kN
         7HKYp0ptI+beP62YHM9E2F3NhyAUzenvUrGeo0npRp09N1buWEB4759IQ5fX+d1H1dlX
         RY+coAZEDNneUcZ1CJZBOVbvIvl8bCsIeQ+NRkUVV/NWoO1jVD5/VyRm1M85hQz92r+C
         W1gA==
X-Gm-Message-State: AOAM531xDxblK06HKlMxTXA7mur+i+A8Z0L8I6WIAbeZJK+aZrwMgePh
        hy572ffCPrgIroXP3DWnC06utqKVo4Yf8Y33iD3oqL53gTwUrTSaq84H0Mf30Y6FdPTzCQjov2A
        ns3rkK1/pq0Iqyz5MYejmpJnOMeCGguvyGhC8RfPtzWzb2frTDFUhwQXTYcGwKzBBo4LGpzq0
X-Google-Smtp-Source: ABdhPJwUT455HkO5yo+dJkYhrqFTNXchDI7Ae7iWRvYMSUqofYl+dQpEoaUdJu/Q4BJnBxtpOjjNwtzmIaeS
X-Received: from lenaptr.lon.corp.google.com ([2a00:79e0:d:210:f693:9fff:fef4:29c9])
 (user=lenaptr job=sendgmr) by 2002:a17:906:d11a:: with SMTP id
 b26mr25946327ejz.191.1599584674552; Tue, 08 Sep 2020 10:04:34 -0700 (PDT)
Date:   Tue,  8 Sep 2020 18:04:03 +0100
In-Reply-To: <20200821042443.GA25695@gondor.apana.org.au>
Message-Id: <20200908170403.2625295-1-lenaptr@google.com>
Mime-Version: 1.0
References: <20200821042443.GA25695@gondor.apana.org.au>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH v6] crypto: af_alg - add extra parameters for DRBG interface
From:   Elena Petrova <lenaptr@google.com>
To:     linux-crypto@vger.kernel.org
Cc:     Elena Petrova <lenaptr@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        "=?UTF-8?q?Stephan=20M=C3=BCller?=" <smueller@chronox.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jeffrey Vander Stoep <jeffv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
CRYPTO_USER_API_RNG_CAVP config option and requires CAP_SYS_ADMIN to
succeed.

Signed-off-by: Elena Petrova <lenaptr@google.com>
Acked-by: Stephan M=C3=BCller <smueller@chronox.de>
---

Updates in v6:
  1) Kconfig option renamed to CRYPTO_USER_API_RNG_CAVP and is now bool ins=
tead
     of tristate;
  2) run-time switch of proto_ops depending on whether the entropy was set;
  3) corrected the NIST standard name;
  4) rebased onto the tip of the tree;
  5) documentation clarified;

Updates in v5:
  1) use __maybe_unused instead of #ifdef;
  2) separate code path for a testing mode;
  3) only allow Additional Data input in a testing mode.

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
  4) Length checks added for send and setentropy; send and setentropy now r=
eturn
     number of bytes accepted.
  5) Minor code style corrections.

libkcapi patch for testing:
  https://github.com/Len0k/libkcapi/commit/6f095d270b982008f419078614c15caa=
592cb531

 Documentation/crypto/userspace-if.rst |  19 ++-
 crypto/Kconfig                        |   9 ++
 crypto/af_alg.c                       |  14 ++-
 crypto/algif_rng.c                    | 175 ++++++++++++++++++++++++--
 include/crypto/if_alg.h               |   1 +
 include/uapi/linux/if_alg.h           |   1 +
 6 files changed, 204 insertions(+), 15 deletions(-)

diff --git a/Documentation/crypto/userspace-if.rst b/Documentation/crypto/u=
serspace-if.rst
index 52019e905900..6a542b0cf22c 100644
--- a/Documentation/crypto/userspace-if.rst
+++ b/Documentation/crypto/userspace-if.rst
@@ -296,15 +296,16 @@ follows:
=20
     struct sockaddr_alg sa =3D {
         .salg_family =3D AF_ALG,
-        .salg_type =3D "rng", /* this selects the symmetric cipher */
-        .salg_name =3D "drbg_nopr_sha256" /* this is the cipher name */
+        .salg_type =3D "rng", /* this selects the random number generator =
*/
+        .salg_name =3D "drbg_nopr_sha256" /* this is the RNG name */
     };
=20
=20
 Depending on the RNG type, the RNG must be seeded. The seed is provided
 using the setsockopt interface to set the key. For example, the
 ansi_cprng requires a seed. The DRBGs do not require a seed, but may be
-seeded.
+seeded. The seed is also known as a *Personalization String* in NIST SP 80=
0-90A
+standard.
=20
 Using the read()/recvmsg() system calls, random numbers can be obtained.
 The kernel generates at most 128 bytes in one call. If user space
@@ -314,6 +315,15 @@ WARNING: The user space caller may invoke the initiall=
y mentioned accept
 system call multiple times. In this case, the returned file descriptors
 have the same state.
=20
+Following CAVP testing interfaces are enabled when kernel is built with
+CRYPTO_USER_API_RNG_CAVP option:
+
+-  the concatenation of *Entropy* and *Nonce* can be provided to the RNG v=
ia
+   ALG_SET_DRBG_ENTROPY setsockopt interface. Setting the entropy requires
+   CAP_SYS_ADMIN permission.
+
+-  *Additional Data* can be provided using the send()/sendmsg() system cal=
ls.
+
 Zero-Copy Interface
 -------------------
=20
@@ -377,6 +387,9 @@ mentioned optname:
    provided ciphertext is assumed to contain an authentication tag of
    the given size (see section about AEAD memory layout below).
=20
+-  ALG_SET_DRBG_ENTROPY -- Setting the entropy of the random number genera=
tor.
+   This option is applicable to RNG cipher type only.
+
 User space API example
 ----------------------
=20
diff --git a/crypto/Kconfig b/crypto/Kconfig
index 1b57419fa2e7..070a88ec1ba8 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -1870,6 +1870,15 @@ config CRYPTO_USER_API_RNG
 	  This option enables the user-spaces interface for random
 	  number generator algorithms.
=20
+config CRYPTO_USER_API_RNG_CAVP
+	bool "Enable CAVP testing of DRBG"
+	depends on CRYPTO_USER_API_RNG && CRYPTO_DRBG
+	help
+	  This option enables extra API for CAVP testing via the user-space
+	  interface: resetting of DRBG entropy, and providing Additional Data.
+	  This should only be enabled for CAVP testing. You should say
+	  no unless you know what this is.
+
 config CRYPTO_USER_API_AEAD
 	tristate "User-space interface for AEAD cipher algorithms"
 	depends on NET
diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 8be8bec07cdd..d11db80d24cd 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -254,6 +254,14 @@ static int alg_setsockopt(struct socket *sock, int lev=
el, int optname,
 		if (!type->setauthsize)
 			goto unlock;
 		err =3D type->setauthsize(ask->private, optlen);
+		break;
+	case ALG_SET_DRBG_ENTROPY:
+		if (sock->state =3D=3D SS_CONNECTED)
+			goto unlock;
+		if (!type->setentropy)
+			goto unlock;
+
+		err =3D type->setentropy(ask->private, optval, optlen);
 	}
=20
 unlock:
@@ -286,6 +294,11 @@ int af_alg_accept(struct sock *sk, struct socket *news=
ock, bool kern)
 	security_sock_graft(sk2, newsock);
 	security_sk_clone(sk, sk2);
=20
+	/*
+	 * newsock->ops assigned here to allow type->accept call to override
+	 * them when required.
+	 */
+	newsock->ops =3D type->ops;
 	err =3D type->accept(ask->private, sk2);
=20
 	nokey =3D err =3D=3D -ENOKEY;
@@ -304,7 +317,6 @@ int af_alg_accept(struct sock *sk, struct socket *newso=
ck, bool kern)
 	alg_sk(sk2)->parent =3D sk;
 	alg_sk(sk2)->type =3D type;
=20
-	newsock->ops =3D type->ops;
 	newsock->state =3D SS_CONNECTED;
=20
 	if (nokey)
diff --git a/crypto/algif_rng.c b/crypto/algif_rng.c
index 6300e0566dc5..6b1f01ca8e31 100644
--- a/crypto/algif_rng.c
+++ b/crypto/algif_rng.c
@@ -38,6 +38,7 @@
  * DAMAGE.
  */
=20
+#include <linux/capability.h>
 #include <linux/module.h>
 #include <crypto/rng.h>
 #include <linux/random.h>
@@ -53,15 +54,26 @@ struct rng_ctx {
 #define MAXSIZE 128
 	unsigned int len;
 	struct crypto_rng *drng;
+	u8 *addtl;
+	size_t addtl_len;
 };
=20
-static int rng_recvmsg(struct socket *sock, struct msghdr *msg, size_t len=
,
-		       int flags)
+struct rng_parent_ctx {
+	struct crypto_rng *drng;
+	u8 *entropy;
+};
+
+static void rng_reset_addtl(struct rng_ctx *ctx)
 {
-	struct sock *sk =3D sock->sk;
-	struct alg_sock *ask =3D alg_sk(sk);
-	struct rng_ctx *ctx =3D ask->private;
-	int err;
+	kzfree(ctx->addtl);
+	ctx->addtl =3D NULL;
+	ctx->addtl_len =3D 0;
+}
+
+static int _rng_recvmsg(struct crypto_rng *drng, struct msghdr *msg, size_=
t len,
+			u8 *addtl, size_t addtl_len)
+{
+	int err =3D 0;
 	int genlen =3D 0;
 	u8 result[MAXSIZE];
=20
@@ -82,7 +94,7 @@ static int rng_recvmsg(struct socket *sock, struct msghdr=
 *msg, size_t len,
 	 * seeding as they automatically seed. The X9.31 DRNG will return
 	 * an error if it was not seeded properly.
 	 */
-	genlen =3D crypto_rng_get_bytes(ctx->drng, result, len);
+	genlen =3D crypto_rng_generate(drng, addtl, addtl_len, result, len);
 	if (genlen < 0)
 		return genlen;
=20
@@ -92,6 +104,61 @@ static int rng_recvmsg(struct socket *sock, struct msgh=
dr *msg, size_t len,
 	return err ? err : len;
 }
=20
+static int rng_recvmsg(struct socket *sock, struct msghdr *msg, size_t len=
,
+		       int flags)
+{
+	struct sock *sk =3D sock->sk;
+	struct alg_sock *ask =3D alg_sk(sk);
+	struct rng_ctx *ctx =3D ask->private;
+
+	return _rng_recvmsg(ctx->drng, msg, len, NULL, 0);
+}
+
+static int rng_test_recvmsg(struct socket *sock, struct msghdr *msg, size_=
t len,
+			    int flags)
+{
+	struct sock *sk =3D sock->sk;
+	struct alg_sock *ask =3D alg_sk(sk);
+	struct rng_ctx *ctx =3D ask->private;
+	int ret;
+
+	lock_sock(sock->sk);
+	ret =3D _rng_recvmsg(ctx->drng, msg, len, ctx->addtl, ctx->addtl_len);
+	rng_reset_addtl(ctx);
+	release_sock(sock->sk);
+
+	return ret;
+}
+
+static int rng_test_sendmsg(struct socket *sock, struct msghdr *msg, size_=
t len)
+{
+	int err;
+	struct alg_sock *ask =3D alg_sk(sock->sk);
+	struct rng_ctx *ctx =3D ask->private;
+
+	lock_sock(sock->sk);
+	if (len > MAXSIZE)
+		len =3D MAXSIZE;
+
+	rng_reset_addtl(ctx);
+	ctx->addtl =3D kmalloc(len, GFP_KERNEL);
+	if (!ctx->addtl) {
+		err =3D -ENOMEM;
+		goto unlock;
+	}
+
+	err =3D memcpy_from_msg(ctx->addtl, msg, len);
+	if (err) {
+		rng_reset_addtl(ctx);
+		goto unlock;
+	}
+	ctx->addtl_len =3D len;
+
+unlock:
+	release_sock(sock->sk);
+	return err ? err : len;
+}
+
 static struct proto_ops algif_rng_ops =3D {
 	.family		=3D	PF_ALG,
=20
@@ -111,14 +178,55 @@ static struct proto_ops algif_rng_ops =3D {
 	.recvmsg	=3D	rng_recvmsg,
 };
=20
+static struct proto_ops __maybe_unused algif_rng_test_ops =3D {
+	.family		=3D	PF_ALG,
+
+	.connect	=3D	sock_no_connect,
+	.socketpair	=3D	sock_no_socketpair,
+	.getname	=3D	sock_no_getname,
+	.ioctl		=3D	sock_no_ioctl,
+	.listen		=3D	sock_no_listen,
+	.shutdown	=3D	sock_no_shutdown,
+	.getsockopt	=3D	sock_no_getsockopt,
+	.mmap		=3D	sock_no_mmap,
+	.bind		=3D	sock_no_bind,
+	.accept		=3D	sock_no_accept,
+	.setsockopt	=3D	sock_no_setsockopt,
+	.sendpage	=3D	sock_no_sendpage,
+
+	.release	=3D	af_alg_release,
+	.recvmsg	=3D	rng_test_recvmsg,
+	.sendmsg	=3D	rng_test_sendmsg,
+};
+
 static void *rng_bind(const char *name, u32 type, u32 mask)
 {
-	return crypto_alloc_rng(name, type, mask);
+	struct rng_parent_ctx *pctx;
+	struct crypto_rng *rng;
+
+	pctx =3D kzalloc(sizeof(*pctx), GFP_KERNEL);
+	if (!pctx)
+		return ERR_PTR(-ENOMEM);
+
+	rng =3D crypto_alloc_rng(name, type, mask);
+	if (IS_ERR(rng)) {
+		kfree(pctx);
+		return ERR_CAST(rng);
+	}
+
+	pctx->drng =3D rng;
+	return pctx;
 }
=20
 static void rng_release(void *private)
 {
-	crypto_free_rng(private);
+	struct rng_parent_ctx *pctx =3D private;
+
+	if (unlikely(!pctx))
+		return;
+	crypto_free_rng(pctx->drng);
+	kzfree(pctx->entropy);
+	kzfree(pctx);
 }
=20
 static void rng_sock_destruct(struct sock *sk)
@@ -126,6 +234,7 @@ static void rng_sock_destruct(struct sock *sk)
 	struct alg_sock *ask =3D alg_sk(sk);
 	struct rng_ctx *ctx =3D ask->private;
=20
+	rng_reset_addtl(ctx);
 	sock_kfree_s(sk, ctx, ctx->len);
 	af_alg_release_parent(sk);
 }
@@ -133,6 +242,7 @@ static void rng_sock_destruct(struct sock *sk)
 static int rng_accept_parent(void *private, struct sock *sk)
 {
 	struct rng_ctx *ctx;
+	struct rng_parent_ctx *pctx =3D private;
 	struct alg_sock *ask =3D alg_sk(sk);
 	unsigned int len =3D sizeof(*ctx);
=20
@@ -141,6 +251,8 @@ static int rng_accept_parent(void *private, struct sock=
 *sk)
 		return -ENOMEM;
=20
 	ctx->len =3D len;
+	ctx->addtl =3D NULL;
+	ctx->addtl_len =3D 0;
=20
 	/*
 	 * No seeding done at that point -- if multiple accepts are
@@ -148,20 +260,58 @@ static int rng_accept_parent(void *private, struct so=
ck *sk)
 	 * state of the RNG.
 	 */
=20
-	ctx->drng =3D private;
+	ctx->drng =3D pctx->drng;
 	ask->private =3D ctx;
 	sk->sk_destruct =3D rng_sock_destruct;
=20
+	/*
+	 * Non NULL pctx->entropy means that CAVP test has been initiated on
+	 * this socket, replace proto_ops algif_rng_ops with algif_rng_test_ops.
+	 */
+	if (pctx->entropy)
+		sk->sk_socket->ops =3D algif_rng_test_ops;
+
 	return 0;
 }
=20
 static int rng_setkey(void *private, const u8 *seed, unsigned int seedlen)
 {
+	struct rng_parent_ctx *pctx =3D private;
 	/*
 	 * Check whether seedlen is of sufficient size is done in RNG
 	 * implementations.
 	 */
-	return crypto_rng_reset(private, seed, seedlen);
+	return crypto_rng_reset(pctx->drng, seed, seedlen);
+}
+
+static int __maybe_unused rng_setentropy(void *private, const u8 *entropy,
+					 unsigned int len)
+{
+	struct rng_parent_ctx *pctx =3D private;
+	u8 *kentropy =3D NULL;
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
+		kentropy =3D memdup_user(entropy, len);
+		if (IS_ERR(kentropy))
+			return PTR_ERR(kentropy);
+	}
+
+	crypto_rng_alg(pctx->drng)->set_ent(pctx->drng, kentropy, len);
+	/*
+	 * Since rng doesn't perform any memory management for the entropy
+	 * buffer, save kentropy pointer to pctx now to free it after use.
+	 */
+	pctx->entropy =3D kentropy;
+	return 0;
 }
=20
 static const struct af_alg_type algif_type_rng =3D {
@@ -169,6 +319,9 @@ static const struct af_alg_type algif_type_rng =3D {
 	.release	=3D	rng_release,
 	.accept		=3D	rng_accept_parent,
 	.setkey		=3D	rng_setkey,
+#if IS_ENABLED(CONFIG_CRYPTO_USER_API_RNG_CAVP)
+	.setentropy	=3D	rng_setentropy,
+#endif
 	.ops		=3D	&algif_rng_ops,
 	.name		=3D	"rng",
 	.owner		=3D	THIS_MODULE
diff --git a/include/crypto/if_alg.h b/include/crypto/if_alg.h
index ee6412314f8f..e6f4a342417d 100644
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
=20
 /* Operations */
 #define ALG_OP_DECRYPT			0
--=20
2.28.0.526.ge36021eeef-goog

