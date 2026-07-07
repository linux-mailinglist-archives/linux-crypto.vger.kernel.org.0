Return-Path: <linux-crypto+bounces-25664-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 74wdDvCQTGo7mQEAu9opvQ
	(envelope-from <linux-crypto+bounces-25664-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 07 Jul 2026 07:38:56 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C4019717817
	for <lists+linux-crypto@lfdr.de>; Tue, 07 Jul 2026 07:38:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=j9CIqI5l;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25664-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25664-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C420C3048558
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Jul 2026 05:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E369390230;
	Tue,  7 Jul 2026 05:37:21 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C37C3876A7;
	Tue,  7 Jul 2026 05:37:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783402641; cv=none; b=InKIXvLDAH0Pur9IEJjqbTXqwTvSvN1fjdvTFUa/oVoUirfMhs1M1JeIkk/jobFBOXejrhyW7gGeZlHEEeDU64IGrXHPeEvVKlLl5prR9XVE4Y19705yJFqpkxdUXwVkrT7gjP7xyQtgrMqqnNfg2KEvhZcOyu/6S+O6kKTYiqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783402641; c=relaxed/simple;
	bh=ClpRpTE30qtpsHDN8Xyx4u7oh1CymsivBZHOJqaDwBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=in/LVFrvhu1KRdknj+/vs+0lpZFqjAI/dbqhPhT0WXgG7axd2XDdX0XLY24hta8HCNgEkbyjxZmDLr7I/A7TYKwO/U8Thtgm/qjFcY2rOjOgpLg82jn3XvHKIXdqxnJfepmfV+th5DluGG+x2DgMWdFEpIFcxsg+3IJQpOEzfvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j9CIqI5l; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE5F1F000E9;
	Tue,  7 Jul 2026 05:37:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783402639;
	bh=Nm+ZSR6EliONaoK4vTF3/6bHV5ZbkqQmrJQg/sxM+Hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j9CIqI5lIKB8P1dnCcgb0g2cR1XitDjPPA4ocIRUIlAA5koIIhNuLnHlD3i8tKp2C
	 6vcnrAMrFm6P5QI9IZHvOZ4YXpIwUoe2Igh886Hd5/3I24IbbXDgabjq0k8GYmv+8D
	 Mep/x/Jc8Z6c+nqCi90SW6qj/FbrS2lim7W6PwLbBR+EudYAHvqE4XmrI0uH65SsS3
	 7FfHMpmgilGHIuXJ5nv2mzcdn6m9rgZ5JDUd8P7gZSX4etQ9DBwGzhsofYZQ6ej8Kj
	 rcFELWu46yAVe6O1tR2cATJ59OxG6p96+e2amuUUTeRwyiGtNKlxPQ/+HajQSaSruY
	 d174z+3vFsQuw==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 10/33] crypto: aes - Add CTR and XCTR support using library
Date: Mon,  6 Jul 2026 22:34:40 -0700
Message-ID: <20260707053503.209874-11-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707053503.209874-1-ebiggers@kernel.org>
References: <20260707053503.209874-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ebiggers@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25664-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C4019717817

Implement the "ctr(aes)" and "xctr(aes)" crypto_skcipher algorithms
using the corresponding library functions.

Among other benefits, this allows the architecture-optimized AES-CTR and
AES-XCTR code to be migrated into the library while still leaving it
accessible via crypto_skcipher, eliminating lots of boilerplate code.

For now the cra_priority is set to just 110, since the
architecture-optimized implementations of these algorithms haven't yet
been migrated into the library.  It will be boosted once that happens.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 crypto/Kconfig |  1 +
 crypto/aes.c   | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index 3d30d79878c2..dd6785c68620 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -360,6 +360,7 @@ config CRYPTO_AES
 	select CRYPTO_LIB_AES
 	select CRYPTO_LIB_AES_CBC if CRYPTO_CBC || CRYPTO_CTS
 	select CRYPTO_LIB_AES_CBC_MACS if CRYPTO_CMAC || CRYPTO_XCBC || CRYPTO_CCM
+	select CRYPTO_LIB_AES_CTR if CRYPTO_CTR || CRYPTO_XCTR
 	select CRYPTO_LIB_AES_ECB if CRYPTO_ECB
 	select CRYPTO_HASH if CRYPTO_CMAC || CRYPTO_XCBC || CRYPTO_CCM
 	# CRYPTO_SKCIPHER should be selected only if a mode that needs it is
diff --git a/crypto/aes.c b/crypto/aes.c
index 5999f8117ce7..0919818bed03 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -7,6 +7,7 @@
 
 #include <crypto/aes-cbc-macs.h>
 #include <crypto/aes-cbc.h>
+#include <crypto/aes-ctr.h>
 #include <crypto/aes-ecb.h>
 #include <crypto/aes.h>
 #include <crypto/algapi.h>
@@ -451,6 +452,31 @@ crypto_aes_cbc_cts_decrypt(struct skcipher_request *req)
 	return crypto_aes_cbc_cts_crypt_nonlinear(req, /* enc= */ false);
 }
 
+/* AES-CTR */
+
+static __maybe_unused int crypto_aes_ctr_crypt(struct skcipher_request *req)
+{
+	const struct aes_enckey *key =
+		crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
+
+	AES_CRYPT_SG(aes_ctr, req->dst, req->src, req->cryptlen, 0, req->iv,
+		     key);
+	return 0;
+}
+
+/* AES-XCTR */
+
+static __maybe_unused int crypto_aes_xctr_crypt(struct skcipher_request *req)
+{
+	const struct aes_enckey *key =
+		crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
+	u64 ctr = 1;
+
+	AES_CRYPT_SG(aes_xctr, req->dst, req->src, req->cryptlen, 0, &ctr,
+		     req->iv, key);
+	return 0;
+}
+
 static struct skcipher_alg skcipher_algs[] = {
 #if IS_ENABLED(CONFIG_CRYPTO_ECB)
 	{
@@ -499,6 +525,40 @@ static struct skcipher_alg skcipher_algs[] = {
 		.decrypt = crypto_aes_cbc_cts_decrypt,
 	},
 #endif
+#if IS_ENABLED(CONFIG_CRYPTO_CTR)
+	{
+		.base.cra_name = "ctr(aes)",
+		.base.cra_driver_name = "ctr-aes-lib",
+		.base.cra_priority = 110,
+		.base.cra_blocksize = 1,
+		.base.cra_ctxsize = sizeof(struct aes_enckey),
+		.base.cra_module = THIS_MODULE,
+		.min_keysize = AES_MIN_KEY_SIZE,
+		.max_keysize = AES_MAX_KEY_SIZE,
+		.ivsize = AES_BLOCK_SIZE,
+		.chunksize = AES_BLOCK_SIZE,
+		.setkey = crypto_aes_skcipher_setenckey,
+		.encrypt = crypto_aes_ctr_crypt,
+		.decrypt = crypto_aes_ctr_crypt,
+	},
+#endif
+#if IS_ENABLED(CONFIG_CRYPTO_XCTR)
+	{
+		.base.cra_name = "xctr(aes)",
+		.base.cra_driver_name = "xctr-aes-lib",
+		.base.cra_priority = 110,
+		.base.cra_blocksize = 1,
+		.base.cra_ctxsize = sizeof(struct aes_enckey),
+		.base.cra_module = THIS_MODULE,
+		.min_keysize = AES_MIN_KEY_SIZE,
+		.max_keysize = AES_MAX_KEY_SIZE,
+		.ivsize = AES_BLOCK_SIZE,
+		.chunksize = AES_BLOCK_SIZE,
+		.setkey = crypto_aes_skcipher_setenckey,
+		.encrypt = crypto_aes_xctr_crypt,
+		.decrypt = crypto_aes_xctr_crypt,
+	},
+#endif
 };
 
 static int __init crypto_aes_mod_init(void)
@@ -571,3 +631,11 @@ MODULE_ALIAS_CRYPTO("cbc-aes-lib");
 MODULE_ALIAS_CRYPTO("cts(cbc(aes))");
 MODULE_ALIAS_CRYPTO("cts-cbc-aes-lib");
 #endif
+#if IS_ENABLED(CONFIG_CRYPTO_CTR)
+MODULE_ALIAS_CRYPTO("ctr(aes)");
+MODULE_ALIAS_CRYPTO("ctr-aes-lib");
+#endif
+#if IS_ENABLED(CONFIG_CRYPTO_XCTR)
+MODULE_ALIAS_CRYPTO("xctr(aes)");
+MODULE_ALIAS_CRYPTO("xctr-aes-lib");
+#endif
-- 
2.54.0


