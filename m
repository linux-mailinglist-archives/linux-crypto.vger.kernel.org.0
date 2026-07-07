Return-Path: <linux-crypto+bounces-25666-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0QUdIgiRTGpAmQEAu9opvQ
	(envelope-from <linux-crypto+bounces-25666-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 07 Jul 2026 07:39:20 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D443F71782D
	for <lists+linux-crypto@lfdr.de>; Tue, 07 Jul 2026 07:39:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=SThXOhbC;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25666-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25666-lists+linux-crypto=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CE1B3053312
	for <lists+linux-crypto@lfdr.de>; Tue,  7 Jul 2026 05:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3933947B8;
	Tue,  7 Jul 2026 05:37:22 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F0C388396;
	Tue,  7 Jul 2026 05:37:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783402641; cv=none; b=Dzz3CgDsVmyqNsszXVpiqeBcGUNlfSkwmliwAIfxLi/Fid+Jtu0jtkq9GZwP/3/00qwuzvCVNGi3k0JFe4PhyljhyK893CX+7oKONFMCg7vnIMfuNdWgH+xfNQfbot7E99+duOKxpnsg0gc9wdPyK7TwO2ZY+SEunjgJSU/nnPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783402641; c=relaxed/simple;
	bh=uSQy4Amm/38N6ESqiZJhAlE2s2caWXWom63PmE5ftWs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epO2rW7lfkaeZq4u9s+KZUbWoPN39WOsa/8k9UUwOemjQUmNZtQ2CkLHkHfil08qAl/xLA9dp5BnazIj+o/cjt9vbhTPdFhBN5c9bL5ev2IcGWUb6DqSW/iRRcEvg+c141a7Cb64NfPI97XSfVSFzAwK6hqC7o//hhyT3L5O6qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SThXOhbC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3623C1F00A3E;
	Tue,  7 Jul 2026 05:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783402639;
	bh=SJdfiHDEEuIh49TgFQbX2oZTzzfX7Iu5+VGVFQjLTGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SThXOhbCCVUtOpiVrX/cK36agM2fCYUkKp7WntkKpUel00G6SZqADS7B4g7ofgi0p
	 AUEcPKOY/AIsCHSf1L4bo4isYmtaTw2EcFp+8gFvJOojntvh/HjUqeY1zHfGusL5lM
	 CD5mgTTBJqi2/E/HY6XbO3RsYm58A+fTEMyxDEIPKbZ6aCvf316/IUgklCdczdX91V
	 hnBT8z/mM8vJcGhJi0SJQRsSK8MjEJM1jJmAvjx2e4kRHEPPzHb4cTj/lB455zqfuB
	 w6TlkUzE4Vhz//uoArBV84t2QG1oqCdSKNlsPmKS6EwcUaFvgpeDgmm+sBGDWNA2Wk
	 G7f5CZf+r7x9g==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Eric Biggers <ebiggers@kernel.org>
Subject: [PATCH 11/33] crypto: aes - Add XTS support using library
Date: Mon,  6 Jul 2026 22:34:41 -0700
Message-ID: <20260707053503.209874-12-ebiggers@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ebiggers@kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-25666-lists,linux-crypto=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D443F71782D

Implement the "xts(aes)" crypto_skcipher algorithm using the
corresponding library functions.

Among other benefits, this allows the architecture-optimized AES-XTS
code to be migrated into the library while still leaving it accessible
via crypto_skcipher, eliminating lots of boilerplate code.

Fast paths similar to what x86_64 uses (to eliminate the scatterlist
walking overhead) are included.  So we'll get that optimization for all
architectures.

For now the cra_priority is set to just 110, since the
architecture-optimized implementations of this algorithm haven't yet
been migrated into the library.  It will be boosted once that happens.

Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 crypto/Kconfig |   1 +
 crypto/aes.c   | 120 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 121 insertions(+)

diff --git a/crypto/Kconfig b/crypto/Kconfig
index dd6785c68620..5e573051c903 100644
--- a/crypto/Kconfig
+++ b/crypto/Kconfig
@@ -362,6 +362,7 @@ config CRYPTO_AES
 	select CRYPTO_LIB_AES_CBC_MACS if CRYPTO_CMAC || CRYPTO_XCBC || CRYPTO_CCM
 	select CRYPTO_LIB_AES_CTR if CRYPTO_CTR || CRYPTO_XCTR
 	select CRYPTO_LIB_AES_ECB if CRYPTO_ECB
+	select CRYPTO_LIB_AES_XTS if CRYPTO_XTS
 	select CRYPTO_HASH if CRYPTO_CMAC || CRYPTO_XCBC || CRYPTO_CCM
 	# CRYPTO_SKCIPHER should be selected only if a mode that needs it is
 	# enabled, but that doesn't work due to a recursive dependency caused by
diff --git a/crypto/aes.c b/crypto/aes.c
index 0919818bed03..a59eb57c86de 100644
--- a/crypto/aes.c
+++ b/crypto/aes.c
@@ -9,6 +9,7 @@
 #include <crypto/aes-cbc.h>
 #include <crypto/aes-ctr.h>
 #include <crypto/aes-ecb.h>
+#include <crypto/aes-xts.h>
 #include <crypto/aes.h>
 #include <crypto/algapi.h>
 #include <crypto/internal/hash.h>
@@ -477,6 +478,105 @@ static __maybe_unused int crypto_aes_xctr_crypt(struct skcipher_request *req)
 	return 0;
 }
 
+/* AES-XTS */
+
+static __maybe_unused int crypto_aes_xts_setkey(struct crypto_skcipher *tfm,
+						const u8 *in_key,
+						unsigned int key_len)
+{
+	struct aes_xts_key *key = crypto_skcipher_ctx(tfm);
+	int flags = (crypto_skcipher_get_flags(tfm) &
+		     CRYPTO_TFM_REQ_FORBID_WEAK_KEYS) ?
+			    XTS_FORBID_WEAK_KEYS :
+			    0;
+
+	return aes_xts_preparekey(key, in_key, key_len, flags);
+}
+
+static void aes_xts_crypt_wrapper(u8 *dst, const u8 *src, size_t len,
+				  u8 iv[AES_BLOCK_SIZE],
+				  const struct aes_xts_key *key, bool enc,
+				  bool *cont)
+{
+	if (enc)
+		aes_xts_encrypt(dst, src, len, iv, key, *cont);
+	else
+		aes_xts_decrypt(dst, src, len, iv, key, *cont);
+	*cont = true;
+}
+
+/*
+ * This handles AES-XTS en/decryption requests that use a nonlinear scattelist
+ * layout or where HIGHMEM is enabled.
+ */
+static noinline int crypto_aes_xts_crypt_nonlinear(struct skcipher_request *req,
+						   bool enc)
+{
+	const struct aes_xts_key *key =
+		crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
+	u8 tmp[2 * AES_BLOCK_SIZE] __aligned(__alignof__(long));
+	unsigned int main_len = req->cryptlen;
+	unsigned int tail_len = main_len % AES_BLOCK_SIZE;
+	bool cont = false;
+
+	if (unlikely(tail_len)) {
+		/*
+		 * Ciphertext stealing is needed.
+		 * Just do the last two blocks separately.
+		 */
+		tail_len += AES_BLOCK_SIZE;
+		main_len -= tail_len;
+	}
+
+	AES_CRYPT_SG(aes_xts_crypt_wrapper, req->dst, req->src, main_len, 0,
+		     req->iv, key, enc, &cont);
+
+	if (unlikely(tail_len)) {
+		memcpy_from_sglist(tmp, req->src, main_len, tail_len);
+		aes_xts_crypt_wrapper(tmp, tmp, tail_len, req->iv, key, enc,
+				      &cont);
+		memcpy_to_sglist(req->dst, main_len, tmp, tail_len);
+		memzero_explicit(tmp, sizeof(tmp));
+	}
+	return 0;
+}
+
+static __maybe_unused int crypto_aes_xts_encrypt(struct skcipher_request *req)
+{
+	const struct aes_xts_key *key =
+		crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
+
+	if (unlikely(req->cryptlen < AES_BLOCK_SIZE))
+		return -EINVAL;
+	if (!IS_ENABLED(CONFIG_HIGHMEM) &&
+	    likely(req->src->length >= req->cryptlen &&
+		   req->dst->length >= req->cryptlen)) {
+		/* Fast path */
+		aes_xts_encrypt(sg_virt(req->dst), sg_virt(req->src),
+				req->cryptlen, req->iv, key, /* cont= */ false);
+		return 0;
+	}
+	return crypto_aes_xts_crypt_nonlinear(req, /* enc= */ true);
+}
+
+static __maybe_unused int crypto_aes_xts_decrypt(struct skcipher_request *req)
+{
+	const struct aes_xts_key *key =
+		crypto_skcipher_ctx(crypto_skcipher_reqtfm(req));
+
+	if (unlikely(req->cryptlen < AES_BLOCK_SIZE))
+		return -EINVAL;
+	if (!IS_ENABLED(CONFIG_HIGHMEM) &&
+	    likely(req->src->length >= req->cryptlen &&
+		   req->dst->length >= req->cryptlen)) {
+		/* Fast path */
+		aes_xts_decrypt(sg_virt(req->dst), sg_virt(req->src),
+				req->cryptlen, req->iv, key, /* cont= */ false);
+		return 0;
+	}
+	return crypto_aes_xts_crypt_nonlinear(req, /* enc= */ false);
+}
+
 static struct skcipher_alg skcipher_algs[] = {
 #if IS_ENABLED(CONFIG_CRYPTO_ECB)
 	{
@@ -559,6 +659,22 @@ static struct skcipher_alg skcipher_algs[] = {
 		.decrypt = crypto_aes_xctr_crypt,
 	},
 #endif
+#if IS_ENABLED(CONFIG_CRYPTO_XTS)
+	{
+		.base.cra_name = "xts(aes)",
+		.base.cra_driver_name = "xts-aes-lib",
+		.base.cra_priority = 110,
+		.base.cra_blocksize = AES_BLOCK_SIZE,
+		.base.cra_ctxsize = sizeof(struct aes_xts_key),
+		.base.cra_module = THIS_MODULE,
+		.min_keysize = 2 * AES_MIN_KEY_SIZE,
+		.max_keysize = 2 * AES_MAX_KEY_SIZE,
+		.ivsize = AES_BLOCK_SIZE,
+		.setkey = crypto_aes_xts_setkey,
+		.encrypt = crypto_aes_xts_encrypt,
+		.decrypt = crypto_aes_xts_decrypt,
+	},
+#endif
 };
 
 static int __init crypto_aes_mod_init(void)
@@ -639,3 +755,7 @@ MODULE_ALIAS_CRYPTO("ctr-aes-lib");
 MODULE_ALIAS_CRYPTO("xctr(aes)");
 MODULE_ALIAS_CRYPTO("xctr-aes-lib");
 #endif
+#if IS_ENABLED(CONFIG_CRYPTO_XTS)
+MODULE_ALIAS_CRYPTO("xts(aes)");
+MODULE_ALIAS_CRYPTO("xts-aes-lib");
+#endif
-- 
2.54.0


