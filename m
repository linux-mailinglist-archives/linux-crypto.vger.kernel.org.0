Return-Path: <linux-crypto+bounces-11658-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA41A85880
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Apr 2025 11:56:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87A7C7B71EC
	for <lists+linux-crypto@lfdr.de>; Fri, 11 Apr 2025 09:54:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF2729C35F;
	Fri, 11 Apr 2025 09:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TyD5AAme"
X-Original-To: linux-crypto@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D38B3298CA6
	for <linux-crypto@vger.kernel.org>; Fri, 11 Apr 2025 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365247; cv=none; b=b1Z3IbonBmLfx5640tvFH2QWLe+r3OYkYn1TUW2aFF/PwDLyyXeB/QMfAZBlLSqLhVEZaLoyrvGrjvKD++Xj06xsOJSQr7tXVWDGaceVBVPlZ59ew8Uf3ndn+AlmscNPnjR00JBKr+AWatjCuB6Sx16pHr+noKbauaPvg0LUldM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365247; c=relaxed/simple;
	bh=QEM68xes22XUacNcMd9pffeItcarVtXcu8XvvQioHc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e2MhS3Ol52RuprPLtcKjcsV8lYy8mQWxV5wdJlmlmrRks3R8D2qhpfX4lsOH2h3oXrwHQ8QYRDSJR+Ymi8g/R4/6INMcCHWWh74uhSpOp1G2Fippsc3cN9fJXhR0jqsW0gH8RCsjD31WQczWqfTk6sZu79yBRhwVs2u4qtY/uRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TyD5AAme; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744365245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ai6vxo/oBlTX+Ub9VlCCOH3T+vZiQ2cLvwDfbfIs3ug=;
	b=TyD5AAmecM15PmnT5TWr3tsgJQiC6bnxUi5Vf5qsVImC6gSc7F21CqjTkedVpFqu7NgD5P
	gMWM3okpcND0NOwD3AIZGeJqXgx40nbhAQSp749ZhM351ep5YmsPIPhypBRvHRFIzF0yWh
	e2Z6ksIKRZgHfX6aTE2htBZflMzjbKY=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-bZiA8lHdNy-2yJYYdoU5ZA-1; Fri,
 11 Apr 2025 05:53:49 -0400
X-MC-Unique: bZiA8lHdNy-2yJYYdoU5ZA-1
X-Mimecast-MFC-AGG-ID: bZiA8lHdNy-2yJYYdoU5ZA_1744365227
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9F1191955D6A;
	Fri, 11 Apr 2025 09:53:47 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.40])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0F863180174E;
	Fri, 11 Apr 2025 09:53:41 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Chuck Lever <chuck.lever@oracle.com>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org
Subject: [PATCH net-next v3 07/14] rxrpc: rxgk: Provide infrastructure and key derivation
Date: Fri, 11 Apr 2025 10:52:52 +0100
Message-ID: <20250411095303.2316168-8-dhowells@redhat.com>
In-Reply-To: <20250411095303.2316168-1-dhowells@redhat.com>
References: <20250411095303.2316168-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Provide some infrastructure for implementing the RxGK transport security
class:

 (1) A definition of an encoding type, including:

	- Relevant crypto-layer names
	- Lengths of the crypto keys and checksums involved
	- Crypto functions specific to the encoding type
	- Crypto scheme used for that type

 (2) A definition of a crypto scheme, including:

	- Underlying crypto handlers
	- The pseudo-random function, PRF, used in base key derivation
	- Functions for deriving usage keys Kc, Ke and Ki
	- Functions for en/decrypting parts of an sk_buff

 (3) A key context, with the usage keys required for a derivative of a
     transport key for a specific key number.  This includes keys for
     securing packets for transmission, extracting received packets and
     dealing with response packets.

 (3) A function to look up an encoding type by number.

 (4) A function to set up a key context and derive the keys.

 (5) A function to set up the keys required to extract the ticket obtained
     from the GSS negotiation in the server.

 (6) Miscellaneous functions for context handling.

The keys and key derivation functions are described in:

	tools.ietf.org/html/draft-wilkinson-afs3-rxgk-11

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Herbert Xu <herbert@gondor.apana.org.au>
cc: "David S. Miller" <davem@davemloft.net>
cc: Chuck Lever <chuck.lever@oracle.com>
cc: Eric Dumazet <edumazet@google.com>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: linux-crypto@vger.kernel.org
cc: netdev@vger.kernel.org
---
 net/rxrpc/Kconfig       |  23 ++++
 net/rxrpc/Makefile      |   3 +-
 net/rxrpc/ar-internal.h |   3 +
 net/rxrpc/rxgk_common.h |  48 +++++++
 net/rxrpc/rxgk_kdf.c    | 288 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 364 insertions(+), 1 deletion(-)
 create mode 100644 net/rxrpc/rxgk_common.h
 create mode 100644 net/rxrpc/rxgk_kdf.c

diff --git a/net/rxrpc/Kconfig b/net/rxrpc/Kconfig
index a20986806fea..f60b81c66078 100644
--- a/net/rxrpc/Kconfig
+++ b/net/rxrpc/Kconfig
@@ -67,6 +67,29 @@ config RXKAD
 
 	  See Documentation/networking/rxrpc.rst.
 
+config RXGK
+	bool "RxRPC GSSAPI security"
+	select CRYPTO_KRB5
+	select CRYPTO_MANAGER
+	select CRYPTO_KRB5ENC
+	select CRYPTO_AUTHENC
+	select CRYPTO_SKCIPHER
+	select CRYPTO_HASH_INFO
+	select CRYPTO_HMAC
+	select CRYPTO_CMAC
+	select CRYPTO_SHA1
+	select CRYPTO_SHA256
+	select CRYPTO_SHA512
+	select CRYPTO_CBC
+	select CRYPTO_CTS
+	select CRYPTO_AES
+	select CRYPTO_CAMELLIA
+	help
+	  Provide the GSSAPI-based RxGK security class for AFS.  Keys are added
+	  with add_key().
+
+	  See Documentation/networking/rxrpc.rst.
+
 config RXPERF
 	tristate "RxRPC test service"
 	help
diff --git a/net/rxrpc/Makefile b/net/rxrpc/Makefile
index 0981941dea73..3eda77a0266b 100644
--- a/net/rxrpc/Makefile
+++ b/net/rxrpc/Makefile
@@ -40,6 +40,7 @@ rxrpc-y := \
 rxrpc-$(CONFIG_PROC_FS) += proc.o
 rxrpc-$(CONFIG_RXKAD) += rxkad.o
 rxrpc-$(CONFIG_SYSCTL) += sysctl.o
-
+rxrpc-$(CONFIG_RXGK) += \
+	rxgk_kdf.o
 
 obj-$(CONFIG_RXPERF) += rxperf.o
diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 31d05784c530..a776f08d10b3 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -558,6 +558,9 @@ struct rxrpc_connection {
 			struct rxrpc_crypt csum_iv;	/* packet checksum base */
 			u32	nonce;		/* response re-use preventer */
 		} rxkad;
+		struct {
+			u64	start_time;	/* The start time for TK derivation */
+		} rxgk;
 	};
 	struct sk_buff		*tx_response;	/* Response packet to be transmitted */
 	unsigned long		flags;
diff --git a/net/rxrpc/rxgk_common.h b/net/rxrpc/rxgk_common.h
new file mode 100644
index 000000000000..da1464e65766
--- /dev/null
+++ b/net/rxrpc/rxgk_common.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/* Common bits for GSSAPI-based RxRPC security.
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <crypto/krb5.h>
+#include <crypto/skcipher.h>
+#include <crypto/hash.h>
+
+/*
+ * Per-key number context.  This is replaced when the connection is rekeyed.
+ */
+struct rxgk_context {
+	refcount_t		usage;
+	unsigned int		key_number;	/* Rekeying number (goes in the rx header) */
+	unsigned long		flags;
+#define RXGK_TK_NEEDS_REKEY	0		/* Set if this needs rekeying */
+	unsigned long		expiry;		/* Expiration time of this key */
+	long long		bytes_remaining; /* Remaining Tx lifetime of this key */
+	const struct krb5_enctype *krb5;	/* RxGK encryption type */
+	const struct rxgk_key	*key;
+
+	/* We need up to 7 keys derived from the transport key, but we don't
+	 * actually need the transport key.  Each key is derived by
+	 * DK(TK,constant).
+	 */
+	struct crypto_aead	*tx_enc;	/* Transmission key */
+	struct crypto_aead	*rx_enc;	/* Reception key */
+	struct crypto_shash	*tx_Kc;		/* Transmission checksum key */
+	struct crypto_shash	*rx_Kc;		/* Reception checksum key */
+	struct crypto_aead	*resp_enc;	/* Response packet enc key */
+};
+
+/*
+ * rxgk_kdf.c
+ */
+void rxgk_put(struct rxgk_context *gk);
+struct rxgk_context *rxgk_generate_transport_key(struct rxrpc_connection *conn,
+						 const struct rxgk_key *key,
+						 unsigned int key_number,
+						 gfp_t gfp);
+int rxgk_set_up_token_cipher(const struct krb5_buffer *server_key,
+			     struct crypto_aead **token_key,
+			     unsigned int enctype,
+			     const struct krb5_enctype **_krb5,
+			     gfp_t gfp);
diff --git a/net/rxrpc/rxgk_kdf.c b/net/rxrpc/rxgk_kdf.c
new file mode 100644
index 000000000000..b4db5aa30e5b
--- /dev/null
+++ b/net/rxrpc/rxgk_kdf.c
@@ -0,0 +1,288 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* RxGK transport key derivation.
+ *
+ * Copyright (C) 2025 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
+#include <linux/key-type.h>
+#include <linux/slab.h>
+#include <keys/rxrpc-type.h>
+#include "ar-internal.h"
+#include "rxgk_common.h"
+
+#define round16(x) (((x) + 15) & ~15)
+
+/*
+ * Constants used to derive the keys and hmacs actually used for doing stuff.
+ */
+#define RXGK_CLIENT_ENC_PACKET		1026U // 0x402
+#define RXGK_CLIENT_MIC_PACKET          1027U // 0x403
+#define RXGK_SERVER_ENC_PACKET          1028U // 0x404
+#define RXGK_SERVER_MIC_PACKET          1029U // 0x405
+#define RXGK_CLIENT_ENC_RESPONSE        1030U // 0x406
+#define RXGK_SERVER_ENC_TOKEN           1036U // 0x40c
+
+static void rxgk_free(struct rxgk_context *gk)
+{
+	if (gk->tx_Kc)
+		crypto_free_shash(gk->tx_Kc);
+	if (gk->rx_Kc)
+		crypto_free_shash(gk->rx_Kc);
+	if (gk->tx_enc)
+		crypto_free_aead(gk->tx_enc);
+	if (gk->rx_enc)
+		crypto_free_aead(gk->rx_enc);
+	if (gk->resp_enc)
+		crypto_free_aead(gk->resp_enc);
+	kfree(gk);
+}
+
+void rxgk_put(struct rxgk_context *gk)
+{
+	if (gk && refcount_dec_and_test(&gk->usage))
+		rxgk_free(gk);
+}
+
+/*
+ * Transport key derivation function.
+ *
+ *      TK = random-to-key(PRF+(K0, L,
+ *                         epoch || cid || start_time || key_number))
+ *      [tools.ietf.org/html/draft-wilkinson-afs3-rxgk-11 sec 8.3]
+ */
+static int rxgk_derive_transport_key(struct rxrpc_connection *conn,
+				     struct rxgk_context *gk,
+				     const struct rxgk_key *rxgk,
+				     struct krb5_buffer *TK,
+				     gfp_t gfp)
+{
+	const struct krb5_enctype *krb5 = gk->krb5;
+	struct krb5_buffer conn_info;
+	unsigned int L = krb5->key_bytes;
+	__be32 *info;
+	u8 *buffer;
+	int ret;
+
+	_enter("");
+
+	conn_info.len = sizeof(__be32) * 5;
+
+	buffer = kzalloc(round16(conn_info.len), gfp);
+	if (!buffer)
+		return -ENOMEM;
+
+	conn_info.data = buffer;
+
+	info = (__be32 *)conn_info.data;
+	info[0] = htonl(conn->proto.epoch);
+	info[1] = htonl(conn->proto.cid);
+	info[2] = htonl(conn->rxgk.start_time >> 32);
+	info[3] = htonl(conn->rxgk.start_time >>  0);
+	info[4] = htonl(gk->key_number);
+
+	ret = crypto_krb5_calc_PRFplus(krb5, &rxgk->key, L, &conn_info, TK, gfp);
+	kfree_sensitive(buffer);
+	_leave(" = %d", ret);
+	return ret;
+}
+
+/*
+ * Set up the ciphers for the usage keys.
+ */
+static int rxgk_set_up_ciphers(struct rxrpc_connection *conn,
+			       struct rxgk_context *gk,
+			       const struct rxgk_key *rxgk,
+			       gfp_t gfp)
+{
+	const struct krb5_enctype *krb5 = gk->krb5;
+	struct crypto_shash *shash;
+	struct crypto_aead *aead;
+	struct krb5_buffer TK;
+	bool service = rxrpc_conn_is_service(conn);
+	int ret;
+	u8 *buffer;
+
+	buffer = kzalloc(krb5->key_bytes, gfp);
+	if (!buffer)
+		return -ENOMEM;
+
+	TK.len = krb5->key_bytes;
+	TK.data = buffer;
+
+	ret = rxgk_derive_transport_key(conn, gk, rxgk, &TK, gfp);
+	if (ret < 0)
+		goto out;
+
+	aead = crypto_krb5_prepare_encryption(krb5, &TK, RXGK_CLIENT_ENC_RESPONSE, gfp);
+	if (IS_ERR(aead))
+		goto aead_error;
+	gk->resp_enc = aead;
+
+	if (crypto_aead_blocksize(gk->resp_enc) != krb5->block_len ||
+	    crypto_aead_authsize(gk->resp_enc) != krb5->cksum_len) {
+		pr_notice("algo inconsistent with krb5 table %u!=%u or %u!=%u\n",
+			  crypto_aead_blocksize(gk->resp_enc), krb5->block_len,
+			  crypto_aead_authsize(gk->resp_enc), krb5->cksum_len);
+		ret = -EINVAL;
+		goto out;
+	}
+
+	if (service) {
+		switch (conn->security_level) {
+		case RXRPC_SECURITY_AUTH:
+			shash = crypto_krb5_prepare_checksum(
+				krb5, &TK, RXGK_SERVER_MIC_PACKET, gfp);
+			if (IS_ERR(shash))
+				goto hash_error;
+			gk->tx_Kc = shash;
+			shash = crypto_krb5_prepare_checksum(
+				krb5, &TK, RXGK_CLIENT_MIC_PACKET, gfp);
+			if (IS_ERR(shash))
+				goto hash_error;
+			gk->rx_Kc = shash;
+			break;
+		case RXRPC_SECURITY_ENCRYPT:
+			aead = crypto_krb5_prepare_encryption(
+				krb5, &TK, RXGK_SERVER_ENC_PACKET, gfp);
+			if (IS_ERR(aead))
+				goto aead_error;
+			gk->tx_enc = aead;
+			aead = crypto_krb5_prepare_encryption(
+				krb5, &TK, RXGK_CLIENT_ENC_PACKET, gfp);
+			if (IS_ERR(aead))
+				goto aead_error;
+			gk->rx_enc = aead;
+			break;
+		}
+	} else {
+		switch (conn->security_level) {
+		case RXRPC_SECURITY_AUTH:
+			shash = crypto_krb5_prepare_checksum(
+				krb5, &TK, RXGK_CLIENT_MIC_PACKET, gfp);
+			if (IS_ERR(shash))
+				goto hash_error;
+			gk->tx_Kc = shash;
+			shash = crypto_krb5_prepare_checksum(
+				krb5, &TK, RXGK_SERVER_MIC_PACKET, gfp);
+			if (IS_ERR(shash))
+				goto hash_error;
+			gk->rx_Kc = shash;
+			break;
+		case RXRPC_SECURITY_ENCRYPT:
+			aead = crypto_krb5_prepare_encryption(
+				krb5, &TK, RXGK_CLIENT_ENC_PACKET, gfp);
+			if (IS_ERR(aead))
+				goto aead_error;
+			gk->tx_enc = aead;
+			aead = crypto_krb5_prepare_encryption(
+				krb5, &TK, RXGK_SERVER_ENC_PACKET, gfp);
+			if (IS_ERR(aead))
+				goto aead_error;
+			gk->rx_enc = aead;
+			break;
+		}
+	}
+
+	ret = 0;
+out:
+	kfree_sensitive(buffer);
+	return ret;
+aead_error:
+	ret = PTR_ERR(aead);
+	goto out;
+hash_error:
+	ret = PTR_ERR(shash);
+	goto out;
+}
+
+/*
+ * Derive a transport key for a connection and then derive a bunch of usage
+ * keys from it and set up ciphers using them.
+ */
+struct rxgk_context *rxgk_generate_transport_key(struct rxrpc_connection *conn,
+						 const struct rxgk_key *key,
+						 unsigned int key_number,
+						 gfp_t gfp)
+{
+	struct rxgk_context *gk;
+	unsigned long lifetime;
+	int ret = -ENOPKG;
+
+	_enter("");
+
+	gk = kzalloc(sizeof(*gk), GFP_KERNEL);
+	if (!gk)
+		return ERR_PTR(-ENOMEM);
+	refcount_set(&gk->usage, 1);
+	gk->key		= key;
+	gk->key_number	= key_number;
+
+	gk->krb5 = crypto_krb5_find_enctype(key->enctype);
+	if (!gk->krb5)
+		goto err_tk;
+
+	ret = rxgk_set_up_ciphers(conn, gk, key, gfp);
+	if (ret)
+		goto err_tk;
+
+	/* Set the remaining number of bytes encrypted with this key that may
+	 * be transmitted before rekeying.  Note that the spec has been
+	 * interpreted differently on this point...
+	 */
+	switch (key->bytelife) {
+	case 0:
+	case 63:
+		gk->bytes_remaining = LLONG_MAX;
+		break;
+	case 1 ... 62:
+		gk->bytes_remaining = 1LL << key->bytelife;
+		break;
+	default:
+		gk->bytes_remaining = key->bytelife;
+		break;
+	}
+
+	/* Set the time after which rekeying must occur */
+	if (key->lifetime) {
+		lifetime = min_t(u64, key->lifetime, INT_MAX / HZ);
+		lifetime *= HZ;
+	} else {
+		lifetime = MAX_JIFFY_OFFSET;
+	}
+	gk->expiry = jiffies + lifetime;
+	return gk;
+
+err_tk:
+	rxgk_put(gk);
+	_leave(" = %d", ret);
+	return ERR_PTR(ret);
+}
+
+/*
+ * Use the server secret key to set up the ciphers that will be used to extract
+ * the token from a response packet.
+ */
+int rxgk_set_up_token_cipher(const struct krb5_buffer *server_key,
+			     struct crypto_aead **token_aead,
+			     unsigned int enctype,
+			     const struct krb5_enctype **_krb5,
+			     gfp_t gfp)
+{
+	const struct krb5_enctype *krb5;
+	struct crypto_aead *aead;
+
+	krb5 = crypto_krb5_find_enctype(enctype);
+	if (!krb5)
+		return -ENOPKG;
+
+	aead = crypto_krb5_prepare_encryption(krb5, server_key, RXGK_SERVER_ENC_TOKEN, gfp);
+	if (IS_ERR(aead))
+		return PTR_ERR(aead);
+
+	*_krb5 = krb5;
+	*token_aead = aead;
+	return 0;
+}


