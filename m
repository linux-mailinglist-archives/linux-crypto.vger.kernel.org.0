Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B57FD7D9EC7
	for <lists+linux-crypto@lfdr.de>; Fri, 27 Oct 2023 19:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjJ0RVU (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 27 Oct 2023 13:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJ0RVT (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 27 Oct 2023 13:21:19 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D6BAB;
        Fri, 27 Oct 2023 10:21:16 -0700 (PDT)
Received: from pps.filterd (m0109334.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39RE5kTZ022252;
        Fri, 27 Oct 2023 10:21:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=meyfm7ywmNGzWlB/VUOTW0VBH2eox+o4emKC8Hdsiag=;
 b=W/vjAiGpTOu4te4K171ny35M7xFgHfGSE+8iAZC/NqpxBTb0/atyfxcrAuELBJE+9vxQ
 M9BDcFMwnuIYG1jpJNkXLH+vKqc7S3DkwkIgqnUZ4xs68MQwcDMQfwMXKeubnlgpeaLO
 1Pr1w69Zp8ZmYp5pkkgxHlEaClslfhuofJcVCsOBZ91zADmYZj0ru/Le853cklghUhec
 vlP6kzs9lv05A5KVj6kX+mRcZJGln+wmnKyXP8LQlNKyTpyowTx9tVx0Jfxk+mmHtYxR
 d4nDVYB5ygs46c66iL5WNfkjS5/VxLVFU4qR0yGFFS1ZdOgp5+j15/T0VHPMGvEmOqU8 Cw== 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3tywr4026a-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 27 Oct 2023 10:21:04 -0700
Received: from devvm4158.cln0.facebook.com (2620:10d:c0a8:1b::30) by
 mail.thefacebook.com (2620:10d:c0a8:83::8) with Microsoft SMTP Server id
 15.1.2507.34; Fri, 27 Oct 2023 10:21:02 -0700
From:   Vadim Fedorenko <vadfed@meta.com>
To:     Jakub Kicinski <kuba@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Mykola Lysenko <mykolal@fb.com>
CC:     Vadim Fedorenko <vadfed@meta.com>, <bpf@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Subject: [PATCH bpf-next v2 1/2] bpf: add skcipher API support to TC/XDP programs
Date:   Fri, 27 Oct 2023 10:20:38 -0700
Message-ID: <20231027172039.1365917-1-vadfed@meta.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [2620:10d:c0a8:1b::30]
X-Proofpoint-GUID: ooJ6drjA1zjPDmFrIKFGca68n8465CnM
X-Proofpoint-ORIG-GUID: ooJ6drjA1zjPDmFrIKFGca68n8465CnM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-27_16,2023-10-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Add crypto API support to BPF to be able to decrypt or encrypt packets
in TC/XDP BPF programs. Only symmetric key ciphers are supported for
now. Special care should be taken for initialization part of crypto algo
because crypto_alloc_sync_skcipher() doesn't work with preemtion
disabled, it can be run only in sleepable BPF program. Also async crypto
is not supported because of the very same issue - TC/XDP BPF programs
are not sleepable.

Signed-off-by: Vadim Fedorenko <vadfed@meta.com>

---
v1 -> v2:
- use kmalloc in sleepable func, suggested by Alexei
- use __bpf_dynptr_is_rdonly() to check destination, suggested by Jakub
- use __bpf_dynptr_data_ptr() for all dynptr accesses

 include/linux/bpf.h   |   2 +
 kernel/bpf/Makefile   |   3 +
 kernel/bpf/crypto.c   | 279 ++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/helpers.c  |   4 +-
 kernel/bpf/verifier.c |   1 +
 5 files changed, 287 insertions(+), 2 deletions(-)
 create mode 100644 kernel/bpf/crypto.c

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d3c51a507508..5ad1e83394b3 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1222,6 +1222,8 @@ enum bpf_dynptr_type {
 
 int bpf_dynptr_check_size(u32 size);
 u32 __bpf_dynptr_size(const struct bpf_dynptr_kern *ptr);
+enum bpf_dynptr_type bpf_dynptr_get_type(const struct bpf_dynptr_kern *ptr);
+bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr);
 
 #ifdef CONFIG_BPF_JIT
 int bpf_trampoline_link_prog(struct bpf_tramp_link *link, struct bpf_trampoline *tr);
diff --git a/kernel/bpf/Makefile b/kernel/bpf/Makefile
index f526b7573e97..e14b5834c477 100644
--- a/kernel/bpf/Makefile
+++ b/kernel/bpf/Makefile
@@ -41,6 +41,9 @@ obj-$(CONFIG_BPF_SYSCALL) += bpf_struct_ops.o
 obj-$(CONFIG_BPF_SYSCALL) += cpumask.o
 obj-${CONFIG_BPF_LSM} += bpf_lsm.o
 endif
+ifeq ($(CONFIG_CRYPTO_SKCIPHER),y)
+obj-$(CONFIG_BPF_SYSCALL) += crypto.o
+endif
 obj-$(CONFIG_BPF_PRELOAD) += preload/
 
 obj-$(CONFIG_BPF_SYSCALL) += relo_core.o
diff --git a/kernel/bpf/crypto.c b/kernel/bpf/crypto.c
new file mode 100644
index 000000000000..bfe658499e16
--- /dev/null
+++ b/kernel/bpf/crypto.c
@@ -0,0 +1,279 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (c) 2023 Meta, Inc */
+#include <linux/bpf.h>
+#include <linux/bpf_mem_alloc.h>
+#include <linux/btf.h>
+#include <linux/btf_ids.h>
+#include <linux/filter.h>
+#include <linux/scatterlist.h>
+#include <linux/skbuff.h>
+#include <crypto/skcipher.h>
+
+/**
+ * struct bpf_crypto_skcipher_ctx - refcounted BPF sync skcipher context structure
+ * @tfm:	The pointer to crypto_sync_skcipher struct.
+ * @rcu:	The RCU head used to free the crypto context with RCU safety.
+ * @usage:	Object reference counter. When the refcount goes to 0, the
+ *		memory is released back to the BPF allocator, which provides
+ *		RCU safety.
+ */
+struct bpf_crypto_skcipher_ctx {
+	struct crypto_sync_skcipher *tfm;
+	struct rcu_head rcu;
+	refcount_t usage;
+};
+
+__diag_push();
+__diag_ignore_all("-Wmissing-prototypes",
+		  "Global kfuncs as their definitions will be in BTF");
+
+static void *__bpf_dynptr_data_ptr(const struct bpf_dynptr_kern *ptr)
+{
+	enum bpf_dynptr_type type;
+
+	if (!ptr->data)
+		return NULL;
+
+	type = bpf_dynptr_get_type(ptr);
+
+	switch (type) {
+	case BPF_DYNPTR_TYPE_LOCAL:
+	case BPF_DYNPTR_TYPE_RINGBUF:
+		return ptr->data + ptr->offset;
+	case BPF_DYNPTR_TYPE_SKB:
+		return skb_pointer_if_linear(ptr->data, ptr->offset, __bpf_dynptr_size(ptr));
+	case BPF_DYNPTR_TYPE_XDP:
+	{
+		void *xdp_ptr = bpf_xdp_pointer(ptr->data, ptr->offset, __bpf_dynptr_size(ptr));
+		if (!IS_ERR_OR_NULL(xdp_ptr))
+			return xdp_ptr;
+
+		return NULL;
+	}
+	default:
+		WARN_ONCE(true, "unknown dynptr type %d\n", type);
+		return NULL;
+	}
+}
+
+/**
+ * bpf_crypto_skcipher_ctx_create() - Create a mutable BPF crypto context.
+ *
+ * Allocates a crypto context that can be used, acquired, and released by
+ * a BPF program. The crypto context returned by this function must either
+ * be embedded in a map as a kptr, or freed with bpf_crypto_skcipher_ctx_release().
+ *
+ * bpf_crypto_skcipher_ctx_create() allocates memory using the BPF memory
+ * allocator, and will not block. It may return NULL if no memory is available.
+ * @algo: bpf_dynptr which holds string representation of algorithm.
+ * @key:  bpf_dynptr which holds cipher key to do crypto.
+ */
+__bpf_kfunc struct bpf_crypto_skcipher_ctx *
+bpf_crypto_skcipher_ctx_create(const struct bpf_dynptr_kern *palgo,
+			       const struct bpf_dynptr_kern *pkey, int *err)
+{
+	struct bpf_crypto_skcipher_ctx *ctx;
+	char *algo;
+
+	if (__bpf_dynptr_size(palgo) > CRYPTO_MAX_ALG_NAME) {
+		*err = -EINVAL;
+		return NULL;
+	}
+
+	algo = __bpf_dynptr_data_ptr(palgo);
+
+	if (!crypto_has_skcipher(algo, CRYPTO_ALG_TYPE_SKCIPHER, CRYPTO_ALG_TYPE_MASK)) {
+		*err = -EOPNOTSUPP;
+		return NULL;
+	}
+
+	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx) {
+		*err = -ENOMEM;
+		return NULL;
+	}
+
+	memset(ctx, 0, sizeof(*ctx));
+
+	ctx->tfm = crypto_alloc_sync_skcipher(algo, 0, 0);
+	if (IS_ERR(ctx->tfm)) {
+		*err = PTR_ERR(ctx->tfm);
+		ctx->tfm = NULL;
+		goto err;
+	}
+
+	*err = crypto_sync_skcipher_setkey(ctx->tfm, __bpf_dynptr_data_ptr(pkey),
+					   __bpf_dynptr_size(pkey));
+	if (*err)
+		goto err;
+
+	refcount_set(&ctx->usage, 1);
+
+	return ctx;
+err:
+	if (ctx->tfm)
+		crypto_free_sync_skcipher(ctx->tfm);
+	kfree(ctx);
+
+	return NULL;
+}
+
+static void crypto_free_sync_skcipher_cb(struct rcu_head *head)
+{
+	struct bpf_crypto_skcipher_ctx *ctx;
+
+	ctx = container_of(head, struct bpf_crypto_skcipher_ctx, rcu);
+	crypto_free_sync_skcipher(ctx->tfm);
+	kfree(ctx);
+}
+
+/**
+ * bpf_crypto_skcipher_ctx_acquire() - Acquire a reference to a BPF crypto context.
+ * @ctx: The BPF crypto context being acquired. The ctx must be a trusted
+ *	     pointer.
+ *
+ * Acquires a reference to a BPF crypto context. The context returned by this function
+ * must either be embedded in a map as a kptr, or freed with
+ * bpf_crypto_skcipher_ctx_release().
+ */
+__bpf_kfunc struct bpf_crypto_skcipher_ctx *
+bpf_crypto_skcipher_ctx_acquire(struct bpf_crypto_skcipher_ctx *ctx)
+{
+	refcount_inc(&ctx->usage);
+	return ctx;
+}
+
+/**
+ * bpf_crypto_skcipher_ctx_release() - Release a previously acquired BPF crypto context.
+ * @ctx: The crypto context being released.
+ *
+ * Releases a previously acquired reference to a BPF cpumask. When the final
+ * reference of the BPF cpumask has been released, it is subsequently freed in
+ * an RCU callback in the BPF memory allocator.
+ */
+__bpf_kfunc void bpf_crypto_skcipher_ctx_release(struct bpf_crypto_skcipher_ctx *ctx)
+{
+	if (refcount_dec_and_test(&ctx->usage))
+		call_rcu(&ctx->rcu, crypto_free_sync_skcipher_cb);
+}
+
+static int bpf_crypto_skcipher_crypt(struct crypto_sync_skcipher *tfm,
+				     const struct bpf_dynptr_kern *src,
+				     struct bpf_dynptr_kern *dst,
+				     const struct bpf_dynptr_kern *iv,
+				     bool decrypt)
+{
+	struct skcipher_request *req = NULL;
+	struct scatterlist sgin, sgout;
+	int err;
+
+	if (crypto_sync_skcipher_get_flags(tfm) & CRYPTO_TFM_NEED_KEY)
+		return -EINVAL;
+
+	if (__bpf_dynptr_is_rdonly(dst))
+		return -EINVAL;
+
+	if (!__bpf_dynptr_size(dst) || !__bpf_dynptr_size(src))
+		return -EINVAL;
+
+	if (__bpf_dynptr_size(iv) != crypto_sync_skcipher_ivsize(tfm))
+		return -EINVAL;
+
+	req = skcipher_request_alloc(&tfm->base, GFP_ATOMIC);
+	if (!req)
+		return -ENOMEM;
+
+	sg_init_one(&sgin, __bpf_dynptr_data_ptr(src), __bpf_dynptr_size(src));
+	sg_init_one(&sgout, __bpf_dynptr_data_ptr(dst), __bpf_dynptr_size(dst));
+
+	skcipher_request_set_crypt(req, &sgin, &sgout, __bpf_dynptr_size(src),
+				   __bpf_dynptr_data_ptr(iv));
+
+	err = decrypt ? crypto_skcipher_decrypt(req) : crypto_skcipher_encrypt(req);
+
+	skcipher_request_free(req);
+
+	return err;
+}
+
+/**
+ * bpf_crypto_skcipher_decrypt() - Decrypt buffer using configured context and IV provided.
+ * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
+ * @src:	bpf_dynptr to the encrypted data. Must be a trusted pointer.
+ * @dst:	bpf_dynptr to the buffer where to store the result. Must be a trusted pointer.
+ * @iv:		bpf_dynptr to IV data to be used by decryptor.
+ *
+ * Decrypts provided buffer using IV data and the crypto context. Crypto context must be configured.
+ */
+__bpf_kfunc int bpf_crypto_skcipher_decrypt(struct bpf_crypto_skcipher_ctx *ctx,
+					    const struct bpf_dynptr_kern *src,
+					    struct bpf_dynptr_kern *dst,
+					    const struct bpf_dynptr_kern *iv)
+{
+	return bpf_crypto_skcipher_crypt(ctx->tfm, src, dst, iv, true);
+}
+
+/**
+ * bpf_crypto_skcipher_encrypt() - Encrypt buffer using configured context and IV provided.
+ * @ctx:	The crypto context being used. The ctx must be a trusted pointer.
+ * @src:	bpf_dynptr to the plain data. Must be a trusted pointer.
+ * @dst:	bpf_dynptr to buffer where to store the result. Must be a trusted pointer.
+ * @iv:		bpf_dynptr to IV data to be used by decryptor.
+ *
+ * Encrypts provided buffer using IV data and the crypto context. Crypto context must be configured.
+ */
+__bpf_kfunc int bpf_crypto_skcipher_encrypt(struct bpf_crypto_skcipher_ctx *ctx,
+					    const struct bpf_dynptr_kern *src,
+					    struct bpf_dynptr_kern *dst,
+					    const struct bpf_dynptr_kern *iv)
+{
+	return bpf_crypto_skcipher_crypt(ctx->tfm, src, dst, iv, false);
+}
+
+__diag_pop();
+
+BTF_SET8_START(crypt_skcipher_init_kfunc_btf_ids)
+BTF_ID_FLAGS(func, bpf_crypto_skcipher_ctx_create, KF_ACQUIRE | KF_RET_NULL | KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_crypto_skcipher_ctx_release, KF_RELEASE)
+BTF_ID_FLAGS(func, bpf_crypto_skcipher_ctx_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
+BTF_SET8_END(crypt_skcipher_init_kfunc_btf_ids)
+
+static const struct btf_kfunc_id_set crypt_skcipher_init_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &crypt_skcipher_init_kfunc_btf_ids,
+};
+
+BTF_SET8_START(crypt_skcipher_kfunc_btf_ids)
+BTF_ID_FLAGS(func, bpf_crypto_skcipher_decrypt, KF_RCU)
+BTF_ID_FLAGS(func, bpf_crypto_skcipher_encrypt, KF_RCU)
+BTF_SET8_END(crypt_skcipher_kfunc_btf_ids)
+
+static const struct btf_kfunc_id_set crypt_skcipher_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set   = &crypt_skcipher_kfunc_btf_ids,
+};
+
+BTF_ID_LIST(crypto_skcipher_dtor_ids)
+BTF_ID(struct, bpf_crypto_skcipher_ctx)
+BTF_ID(func, bpf_crypto_skcipher_ctx_release)
+
+static int __init crypto_skcipher_kfunc_init(void)
+{
+	int ret;
+	const struct btf_id_dtor_kfunc crypto_skcipher_dtors[] = {
+		{
+			.btf_id	      = crypto_skcipher_dtor_ids[0],
+			.kfunc_btf_id = crypto_skcipher_dtor_ids[1]
+		},
+	};
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_CLS, &crypt_skcipher_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_SCHED_ACT, &crypt_skcipher_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_XDP, &crypt_skcipher_kfunc_set);
+	ret = ret ?: register_btf_kfunc_id_set(BPF_PROG_TYPE_UNSPEC, &crypt_skcipher_init_kfunc_set);
+	return  ret ?: register_btf_id_dtor_kfuncs(crypto_skcipher_dtors,
+						   ARRAY_SIZE(crypto_skcipher_dtors),
+						   THIS_MODULE);
+}
+
+late_initcall(crypto_skcipher_kfunc_init);
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 62a53ebfedf9..2020884fca3d 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -1429,7 +1429,7 @@ static const struct bpf_func_proto bpf_kptr_xchg_proto = {
 #define DYNPTR_SIZE_MASK	0xFFFFFF
 #define DYNPTR_RDONLY_BIT	BIT(31)
 
-static bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr)
+bool __bpf_dynptr_is_rdonly(const struct bpf_dynptr_kern *ptr)
 {
 	return ptr->size & DYNPTR_RDONLY_BIT;
 }
@@ -1444,7 +1444,7 @@ static void bpf_dynptr_set_type(struct bpf_dynptr_kern *ptr, enum bpf_dynptr_typ
 	ptr->size |= type << DYNPTR_TYPE_SHIFT;
 }
 
-static enum bpf_dynptr_type bpf_dynptr_get_type(const struct bpf_dynptr_kern *ptr)
+enum bpf_dynptr_type bpf_dynptr_get_type(const struct bpf_dynptr_kern *ptr)
 {
 	return (ptr->size & ~(DYNPTR_RDONLY_BIT)) >> DYNPTR_TYPE_SHIFT;
 }
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index bb58987e4844..75d2f47ca3cb 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -5184,6 +5184,7 @@ BTF_ID(struct, prog_test_ref_kfunc)
 BTF_ID(struct, cgroup)
 BTF_ID(struct, bpf_cpumask)
 BTF_ID(struct, task_struct)
+BTF_ID(struct, bpf_crypto_skcipher_ctx)
 BTF_SET_END(rcu_protected_types)
 
 static bool rcu_protected_object(const struct btf *btf, u32 btf_id)
-- 
2.39.3

