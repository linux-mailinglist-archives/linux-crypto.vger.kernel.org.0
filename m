Return-Path: <linux-crypto+bounces-9362-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FD5A25CA1
	for <lists+linux-crypto@lfdr.de>; Mon,  3 Feb 2025 15:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 821153A4918
	for <lists+linux-crypto@lfdr.de>; Mon,  3 Feb 2025 14:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA8B20DD71;
	Mon,  3 Feb 2025 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BRYmNZmV"
X-Original-To: linux-crypto@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5242520DD56
	for <linux-crypto@vger.kernel.org>; Mon,  3 Feb 2025 14:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738592737; cv=none; b=rvQQh5m9doWjnO/dtDYP1gDpWMm0AvgIG4fzb4I2wpTdLEoLSscwQeXHsugEJqw/Lr7jy2NZvqE+npG7wxMVFx7mVlj3mf8bF7IT7poiiA9nTbcKPv+0aflIxYREebOhKcuP8nBn5F4X00dkzUYRDfnAS5SbZQLhjvGHZr9F82k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738592737; c=relaxed/simple;
	bh=i1nnJaOGxXmY8WHOQOhV948W4GJS9+SMTY8oqNv6t98=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YWYgcMpUgiPjf2/tSo0oSZGIXbpHXTc/GSOXcQXVoMQL24kz/iFDcGr4ceZ1B+Q6H/2x5cHuyi6eGbbU2ATtj3HaMS2uF94uC3QFdo2+dpzJcQ66RwzXfLZXHOfR/seGwynF65EvaC9UDB1Z8iMSQHeLWxOwg0Bh2ELY9UKERY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BRYmNZmV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738592734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QoRnHPyVHH1mP7o3O+/o4z7VMy+IPUKYyi7ZN6uCKZw=;
	b=BRYmNZmVKS4KbHhbaIfisj8vKJtjdk2voQb07zoWi0xMBx7CYfAghVxQ0PX/Zj9OznD2eO
	UGHzdoNLmO3T+E8qeCEImx9llsAUlD0h/f0JN9Ybad/Zn2AHEvB1y7wa+fFVbd3Xe1uSyw
	0gTfOdSZUgnLYog5J2QuyB0FEnKnnGM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-182-XrGyx-WiOdqWaxJUh6v-IQ-1; Mon,
 03 Feb 2025 09:25:33 -0500
X-MC-Unique: XrGyx-WiOdqWaxJUh6v-IQ-1
X-Mimecast-MFC-AGG-ID: XrGyx-WiOdqWaxJUh6v-IQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id BF0F8195608A;
	Mon,  3 Feb 2025 14:25:30 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66C1019560AA;
	Mon,  3 Feb 2025 14:25:26 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-afs@lists.infradead.org,
	linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 16/24] crypto/krb5: Implement the Camellia enctypes from rfc6803
Date: Mon,  3 Feb 2025 14:23:32 +0000
Message-ID: <20250203142343.248839-17-dhowells@redhat.com>
In-Reply-To: <20250203142343.248839-1-dhowells@redhat.com>
References: <20250203142343.248839-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Implement the camellia128-cts-cmac and camellia256-cts-cmac enctypes from
rfc6803.

Note that the test vectors in rfc6803 for encryption are incomplete,
lacking the key usage number needed to derive Ke and Ki, and there are
errata for this:

	https://www.rfc-editor.org/errata_search.php?rfc=6803

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: "David S. Miller" <davem@davemloft.net>
cc: Chuck Lever <chuck.lever@oracle.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: linux-nfs@vger.kernel.org
cc: linux-crypto@vger.kernel.org
cc: netdev@vger.kernel.org
---
 crypto/krb5/Kconfig            |   2 +
 crypto/krb5/Makefile           |   1 +
 crypto/krb5/internal.h         |   6 +
 crypto/krb5/krb5_api.c         |   2 +
 crypto/krb5/rfc6803_camellia.c | 237 +++++++++++++++++++++++++++++++++
 include/crypto/krb5.h          |   4 +
 6 files changed, 252 insertions(+)
 create mode 100644 crypto/krb5/rfc6803_camellia.c

diff --git a/crypto/krb5/Kconfig b/crypto/krb5/Kconfig
index 52f0ed2d7820..5b339690905c 100644
--- a/crypto/krb5/Kconfig
+++ b/crypto/krb5/Kconfig
@@ -6,12 +6,14 @@ config CRYPTO_KRB5
 	select CRYPTO_SKCIPHER
 	select CRYPTO_HASH_INFO
 	select CRYPTO_HMAC
+	select CRYPTO_CMAC
 	select CRYPTO_SHA1
 	select CRYPTO_SHA256
 	select CRYPTO_SHA512
 	select CRYPTO_CBC
 	select CRYPTO_CTS
 	select CRYPTO_AES
+	select CRYPTO_CAMELLIA
 	help
 	  Provide a library for provision of Kerberos-5-based crypto.  This is
 	  intended for network filesystems to use.
diff --git a/crypto/krb5/Makefile b/crypto/krb5/Makefile
index 7fd215ec3a85..7cbe5e5ded19 100644
--- a/crypto/krb5/Makefile
+++ b/crypto/krb5/Makefile
@@ -8,6 +8,7 @@ krb5-y += \
 	krb5_api.o \
 	rfc3961_simplified.o \
 	rfc3962_aes.o \
+	rfc6803_camellia.o \
 	rfc8009_aes2.o
 
 obj-$(CONFIG_CRYPTO_KRB5) += krb5.o
diff --git a/crypto/krb5/internal.h b/crypto/krb5/internal.h
index f537f6eb86eb..8679140ef90d 100644
--- a/crypto/krb5/internal.h
+++ b/crypto/krb5/internal.h
@@ -186,6 +186,12 @@ int rfc3961_verify_mic(const struct krb5_enctype *krb5,
 extern const struct krb5_enctype krb5_aes128_cts_hmac_sha1_96;
 extern const struct krb5_enctype krb5_aes256_cts_hmac_sha1_96;
 
+/*
+ * rfc6803_camellia.c
+ */
+extern const struct krb5_enctype krb5_camellia128_cts_cmac;
+extern const struct krb5_enctype krb5_camellia256_cts_cmac;
+
 /*
  * rfc8009_aes2.c
  */
diff --git a/crypto/krb5/krb5_api.c b/crypto/krb5/krb5_api.c
index 5b94cc5db461..02e21c8f4d14 100644
--- a/crypto/krb5/krb5_api.c
+++ b/crypto/krb5/krb5_api.c
@@ -21,6 +21,8 @@ static const struct krb5_enctype *const krb5_supported_enctypes[] = {
 	&krb5_aes256_cts_hmac_sha1_96,
 	&krb5_aes128_cts_hmac_sha256_128,
 	&krb5_aes256_cts_hmac_sha384_192,
+	&krb5_camellia128_cts_cmac,
+	&krb5_camellia256_cts_cmac,
 };
 
 /**
diff --git a/crypto/krb5/rfc6803_camellia.c b/crypto/krb5/rfc6803_camellia.c
new file mode 100644
index 000000000000..77cd4ce023f1
--- /dev/null
+++ b/crypto/krb5/rfc6803_camellia.c
@@ -0,0 +1,237 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* rfc6803 Camellia Encryption for Kerberos 5
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/slab.h>
+#include "internal.h"
+
+/*
+ * Calculate the key derivation function KDF-FEEDBACK_CMAC(key, constant)
+ *
+ *	n = ceiling(k / 128)
+ *	K(0) = zeros
+ *	K(i) = CMAC(key, K(i-1) | i | constant | 0x00 | k)
+ *	DR(key, constant) = k-truncate(K(1) | K(2) | ... | K(n))
+ *	KDF-FEEDBACK-CMAC(key, constant) = random-to-key(DR(key, constant))
+ *
+ *	[rfc6803 sec 3]
+ */
+static int rfc6803_calc_KDF_FEEDBACK_CMAC(const struct krb5_enctype *krb5,
+					  const struct krb5_buffer *key,
+					  const struct krb5_buffer *constant,
+					  struct krb5_buffer *result,
+					  gfp_t gfp)
+{
+	struct crypto_shash *shash;
+	struct krb5_buffer K, data;
+	struct shash_desc *desc;
+	__be32 tmp;
+	size_t bsize, offset, seg;
+	void *buffer;
+	u32 i = 0, k = result->len * 8;
+	u8 *p;
+	int ret = -ENOMEM;
+
+	shash = crypto_alloc_shash(krb5->cksum_name, 0, 0);
+	if (IS_ERR(shash))
+		return (PTR_ERR(shash) == -ENOENT) ? -ENOPKG : PTR_ERR(shash);
+	ret = crypto_shash_setkey(shash, key->data, key->len);
+	if (ret < 0)
+		goto error_shash;
+
+	ret = -ENOMEM;
+	K.len = crypto_shash_digestsize(shash);
+	data.len = K.len + 4 + constant->len + 1 + 4;
+	bsize = krb5_shash_size(shash) +
+		krb5_digest_size(shash) +
+		crypto_roundup(K.len) +
+		crypto_roundup(data.len);
+	buffer = kzalloc(bsize, GFP_NOFS);
+	if (!buffer)
+		goto error_shash;
+
+	desc = buffer;
+	desc->tfm = shash;
+
+	K.data = buffer +
+		krb5_shash_size(shash) +
+		krb5_digest_size(shash);
+	data.data = buffer +
+		krb5_shash_size(shash) +
+		krb5_digest_size(shash) +
+		crypto_roundup(K.len);
+
+	p = data.data + K.len + 4;
+	memcpy(p, constant->data, constant->len);
+	p += constant->len;
+	*p++ = 0x00;
+	tmp = htonl(k);
+	memcpy(p, &tmp, 4);
+	p += 4;
+
+	ret = -EINVAL;
+	if (WARN_ON(p - (u8 *)data.data != data.len))
+		goto error;
+
+	offset = 0;
+	do {
+		i++;
+		p = data.data;
+		memcpy(p, K.data, K.len);
+		p += K.len;
+		*(__be32 *)p = htonl(i);
+
+		ret = crypto_shash_init(desc);
+		if (ret < 0)
+			goto error;
+		ret = crypto_shash_finup(desc, data.data, data.len, K.data);
+		if (ret < 0)
+			goto error;
+
+		seg = min_t(size_t, result->len - offset, K.len);
+		memcpy(result->data + offset, K.data, seg);
+		offset += seg;
+	} while (offset < result->len);
+
+error:
+	kfree_sensitive(buffer);
+error_shash:
+	crypto_free_shash(shash);
+	return ret;
+}
+
+/*
+ * Calculate the pseudo-random function, PRF().
+ *
+ *	Kp = KDF-FEEDBACK-CMAC(protocol-key, "prf")
+ *	PRF = CMAC(Kp, octet-string)
+ *      [rfc6803 sec 6]
+ */
+static int rfc6803_calc_PRF(const struct krb5_enctype *krb5,
+			    const struct krb5_buffer *protocol_key,
+			    const struct krb5_buffer *octet_string,
+			    struct krb5_buffer *result,
+			    gfp_t gfp)
+{
+	static const struct krb5_buffer prfconstant = { 3, "prf" };
+	struct crypto_shash *shash;
+	struct krb5_buffer Kp;
+	struct shash_desc *desc;
+	size_t bsize;
+	void *buffer;
+	int ret;
+
+	Kp.len = krb5->prf_len;
+
+	shash = crypto_alloc_shash(krb5->cksum_name, 0, 0);
+	if (IS_ERR(shash))
+		return (PTR_ERR(shash) == -ENOENT) ? -ENOPKG : PTR_ERR(shash);
+
+	ret = -EINVAL;
+	if (result->len != crypto_shash_digestsize(shash))
+		goto out_shash;
+
+	ret = -ENOMEM;
+	bsize = krb5_shash_size(shash) +
+		krb5_digest_size(shash) +
+		crypto_roundup(Kp.len);
+	buffer = kzalloc(bsize, GFP_NOFS);
+	if (!buffer)
+		goto out_shash;
+
+	Kp.data = buffer +
+		krb5_shash_size(shash) +
+		krb5_digest_size(shash);
+
+	ret = rfc6803_calc_KDF_FEEDBACK_CMAC(krb5, protocol_key, &prfconstant,
+					     &Kp, gfp);
+	if (ret < 0)
+		goto out;
+
+	ret = crypto_shash_setkey(shash, Kp.data, Kp.len);
+	if (ret < 0)
+		goto out;
+
+	desc = buffer;
+	desc->tfm = shash;
+	ret = crypto_shash_init(desc);
+	if (ret < 0)
+		goto out;
+
+	ret = crypto_shash_finup(desc, octet_string->data, octet_string->len, result->data);
+	if (ret < 0)
+		goto out;
+
+out:
+	kfree_sensitive(buffer);
+out_shash:
+	crypto_free_shash(shash);
+	return ret;
+}
+
+
+static const struct krb5_crypto_profile rfc6803_crypto_profile = {
+	.calc_PRF		= rfc6803_calc_PRF,
+	.calc_Kc		= rfc6803_calc_KDF_FEEDBACK_CMAC,
+	.calc_Ke		= rfc6803_calc_KDF_FEEDBACK_CMAC,
+	.calc_Ki		= rfc6803_calc_KDF_FEEDBACK_CMAC,
+	.derive_encrypt_keys	= authenc_derive_encrypt_keys,
+	.load_encrypt_keys	= authenc_load_encrypt_keys,
+	.derive_checksum_key	= rfc3961_derive_checksum_key,
+	.load_checksum_key	= rfc3961_load_checksum_key,
+	.encrypt		= krb5_aead_encrypt,
+	.decrypt		= krb5_aead_decrypt,
+	.get_mic		= rfc3961_get_mic,
+	.verify_mic		= rfc3961_verify_mic,
+};
+
+const struct krb5_enctype krb5_camellia128_cts_cmac = {
+	.etype		= KRB5_ENCTYPE_CAMELLIA128_CTS_CMAC,
+	.ctype		= KRB5_CKSUMTYPE_CMAC_CAMELLIA128,
+	.name		= "camellia128-cts-cmac",
+	.encrypt_name	= "krb5enc(cmac(camellia),cts(cbc(camellia)))",
+	.cksum_name	= "cmac(camellia)",
+	.hash_name	= NULL,
+	.derivation_enc	= "cts(cbc(camellia))",
+	.key_bytes	= 16,
+	.key_len	= 16,
+	.Kc_len		= 16,
+	.Ke_len		= 16,
+	.Ki_len		= 16,
+	.block_len	= 16,
+	.conf_len	= 16,
+	.cksum_len	= 16,
+	.hash_len	= 16,
+	.prf_len	= 16,
+	.keyed_cksum	= true,
+	.random_to_key	= NULL, /* Identity */
+	.profile	= &rfc6803_crypto_profile,
+};
+
+const struct krb5_enctype krb5_camellia256_cts_cmac = {
+	.etype		= KRB5_ENCTYPE_CAMELLIA256_CTS_CMAC,
+	.ctype		= KRB5_CKSUMTYPE_CMAC_CAMELLIA256,
+	.name		= "camellia256-cts-cmac",
+	.encrypt_name	= "krb5enc(cmac(camellia),cts(cbc(camellia)))",
+	.cksum_name	= "cmac(camellia)",
+	.hash_name	= NULL,
+	.derivation_enc	= "cts(cbc(camellia))",
+	.key_bytes	= 32,
+	.key_len	= 32,
+	.Kc_len		= 32,
+	.Ke_len		= 32,
+	.Ki_len		= 32,
+	.block_len	= 16,
+	.conf_len	= 16,
+	.cksum_len	= 16,
+	.hash_len	= 16,
+	.prf_len	= 16,
+	.keyed_cksum	= true,
+	.random_to_key	= NULL, /* Identity */
+	.profile	= &rfc6803_crypto_profile,
+};
diff --git a/include/crypto/krb5.h b/include/crypto/krb5.h
index b8fda81379ab..62d998e62f47 100644
--- a/include/crypto/krb5.h
+++ b/include/crypto/krb5.h
@@ -35,6 +35,8 @@ struct scatterlist;
 #define KRB5_ENCTYPE_AES256_CTS_HMAC_SHA384_192	0x0014
 #define KRB5_ENCTYPE_ARCFOUR_HMAC		0x0017
 #define KRB5_ENCTYPE_ARCFOUR_HMAC_EXP		0x0018
+#define KRB5_ENCTYPE_CAMELLIA128_CTS_CMAC	0x0019
+#define KRB5_ENCTYPE_CAMELLIA256_CTS_CMAC	0x001a
 #define KRB5_ENCTYPE_UNKNOWN			0x01ff
 
 #define KRB5_CKSUMTYPE_CRC32			0x0001
@@ -47,6 +49,8 @@ struct scatterlist;
 #define KRB5_CKSUMTYPE_HMAC_SHA1_DES3		0x000c
 #define KRB5_CKSUMTYPE_HMAC_SHA1_96_AES128	0x000f
 #define KRB5_CKSUMTYPE_HMAC_SHA1_96_AES256	0x0010
+#define KRB5_CKSUMTYPE_CMAC_CAMELLIA128		0x0011
+#define KRB5_CKSUMTYPE_CMAC_CAMELLIA256		0x0012
 #define KRB5_CKSUMTYPE_HMAC_SHA256_128_AES128	0x0013
 #define KRB5_CKSUMTYPE_HMAC_SHA384_192_AES256	0x0014
 #define KRB5_CKSUMTYPE_HMAC_MD5_ARCFOUR		-138 /* Microsoft md5 hmac cksumtype */


