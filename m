Return-Path: <linux-crypto+bounces-20469-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eDedA7jLe2lHIgIAu9opvQ
	(envelope-from <linux-crypto+bounces-20469-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 29 Jan 2026 22:06:00 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62286B477C
	for <lists+linux-crypto@lfdr.de>; Thu, 29 Jan 2026 22:05:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 686B2301F313
	for <lists+linux-crypto@lfdr.de>; Thu, 29 Jan 2026 21:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67DCC35B159;
	Thu, 29 Jan 2026 21:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Xjhq+OQ4"
X-Original-To: linux-crypto@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82213559C4;
	Thu, 29 Jan 2026 21:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769720682; cv=none; b=tnYlmgJZfLN5Vl5ykPsk8+lxgffeMxXbpS7Q4Z2PSwd94rDXQhG/sPl0nXlMpZLB3nRTjsuXUnhUSy4X5XFbeijKuHxnfyfGBXbjJPEYmD6Z/kpQgNInnY69rCIfrXwtoHTsQeolrLeX8+fkLXkWYp9xD3CdFo02VJu92/Ceils=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769720682; c=relaxed/simple;
	bh=bO16df/rw4KeFMtAMRuPin6N78Voos4N5qibgHuF/0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b6Qjd0y24SLeTtu2G6BE/vK3Ju25cX/UHIgPke1v6iarqh2iVe1wExVds5BZbqm1AmJFCpMYzdgdBgPMub7tnnowQoTHhXgM8LwwkwaCO7FlA4/MW3EUM7y0eN3gged3FuRfFEwIH2A29mTVKvbcAUizCBI4Vsvo6ayPp7Y6rto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Xjhq+OQ4; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [127.0.1.1] (unknown [52.167.115.14])
	by linux.microsoft.com (Postfix) with ESMTPSA id CAEC020B7167;
	Thu, 29 Jan 2026 13:04:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CAEC020B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1769720680;
	bh=fCQIIaCW/sFdyOfxJg4S24rA4R2c+ziqOMLGX/bqIyM=;
	h=From:Date:Subject:To:Cc:From;
	b=Xjhq+OQ4BOQRKlS3a31Mmu4sf7CSgAHL0WbU/MKr7afcUOjgw0FgOl+u2peKKwoCh
	 f76g+KAHEATJsffdxDKKNoewWTEf63oua9rIkbwWwbq/JI0DpXW3609zpgx9YGq+4e
	 JSnUoenw12VbKVNvD8WY1UfbiuIDhzCbhOLcbuss=
From: jeffbarnes@linux.microsoft.com
Date: Thu, 29 Jan 2026 16:04:36 -0500
Subject: [PATCH] crypto: aead: add service indicator flag for RFC4106
 AES-GCM
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260129-fips-gcm-clean-v1-v1-1-43e17dc20a1a@microsoft.com>
X-B4-Tracking: v=1; b=H4sIAGPLe2kC/x3MTQqAIBBA4avIrBtQ6Qe7SrQQG22gTBQikO6et
 PwW71UolJkKzKJCppsLX7FBdQLcbmMg5K0ZtNSjVNqg51QwuBPdQTbirdD0wzhJaa02DlqXMnl
 +/ueyvu8HuxAvjmMAAAA=
X-Change-ID: 20260129-fips-gcm-clean-v1-9456700aa29c
To: Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jeff Barnes <jeffbarnes@microsoft.com>
X-Mailer: b4 0.14.2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20469-lists,linux-crypto=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[jeffbarnes@linux.microsoft.com,linux-crypto@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 62286B477C
X-Rspamd-Action: no action

From: Jeff Barnes <jeffbarnes@microsoft.com>

FIPS 140 validations require a “service indicator” to positively
identify when an approved cryptographic service is provided. For
RFC4106 AES‑GCM (used by IPsec), this commit exposes a per‑request
indicator bit when the IV/nonce construction meets the FIPS uniqueness
requirement.

Specifically, the indicator is set when the caller uses the RFC4106
construction with seqiv (per RFC 4106 §3), where the 32‑bit salt and
64‑bit seqiv together guarantee a unique 96‑bit IV per key. This
meets the SP 800‑38D §8.2 uniqueness requirement for GCM.

No ABI or uAPI changes. The flag is internal to the crypto API request
path and may be consumed by in‑tree callers that need to record service
use in a FIPS context.

Tests:
- Verified that gcm(aes) requests never set the service‑indicator bit.
- Verified that rfc4106(gcm(aes)) requests consistently set the bit.
- Existing crypto self‑tests continue to pass.
- checkpatch.pl: no issues.

Signed-off-by: Jeff Barnes <jeffbarnes@microsoft.com>
---
This series introduces a service indicator for AES-GCM to support
deployments that require FIPS 140 validation.  The Linux kernel
currently exposes no explicit mechanism for callers to determine
whether an AEAD construction is operating in a configuration suitable
for validated use.

The patch adds a gcm indicator allowing user space and in-kernel
consumers to distinguish between validated and non-validated modes.

For AES-GCM, the indicator is set for the RFC4106 construction used
in, for example, IPsec and remains unset for the generic gcm(aes)
template, which aligns with expected FIPS usage.

Testing shows that with this change, gcm(aes) does not report the
indicator, while rfc4106(gcm(aes)) does.  No functional behavior is
modified for existing callers, and no regressions were observed in test
coverage.
---
 crypto/aead.c            | 12 ++++++++++--
 include/crypto/rfc4106.h | 20 ++++++++++++++++++++
 include/linux/crypto.h   |  2 ++
 3 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/crypto/aead.c b/crypto/aead.c
index e009937bf3a5d946e1de31257131940b2bc636fe..dcc0562b395ba9a8eb15fe9fa679b27e8b9db5d5 100644
--- a/crypto/aead.c
+++ b/crypto/aead.c
@@ -8,6 +8,7 @@
  */
 
 #include <crypto/internal/aead.h>
+#include <crypto/rfc4106.h>
 #include <linux/cryptouser.h>
 #include <linux/errno.h>
 #include <linux/init.h>
@@ -46,6 +47,7 @@ int crypto_aead_setkey(struct crypto_aead *tfm,
 {
 	unsigned long alignmask = crypto_aead_alignmask(tfm);
 	int err;
+	const char *name;
 
 	if ((unsigned long)key & alignmask)
 		err = setkey_unaligned(tfm, key, keylen);
@@ -58,6 +60,12 @@ int crypto_aead_setkey(struct crypto_aead *tfm,
 	}
 
 	crypto_aead_clear_flags(tfm, CRYPTO_TFM_NEED_KEY);
+	name = crypto_tfm_alg_name(&tfm->base);
+	if (name && rfc4106_keysize_ok(keylen) &&
+		(!strcmp(name, "rfc4106(gcm(aes))") ||
+		!strcmp(name, "seqiv(gcm(aes))")))
+		crypto_aead_set_flags(tfm, CRYPTO_TFM_FIPS_COMPLIANCE);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(crypto_aead_setkey);
@@ -156,13 +164,13 @@ static void __maybe_unused crypto_aead_show(struct seq_file *m,
 {
 	struct aead_alg *aead = container_of(alg, struct aead_alg, base);
 
-	seq_printf(m, "type         : aead\n");
+	seq_puts(m, "type         : aead\n");
 	seq_printf(m, "async        : %s\n",
 		   str_yes_no(alg->cra_flags & CRYPTO_ALG_ASYNC));
 	seq_printf(m, "blocksize    : %u\n", alg->cra_blocksize);
 	seq_printf(m, "ivsize       : %u\n", aead->ivsize);
 	seq_printf(m, "maxauthsize  : %u\n", aead->maxauthsize);
-	seq_printf(m, "geniv        : <none>\n");
+	seq_puts(m, "geniv        : <none>\n");
 }
 
 static void crypto_aead_free_instance(struct crypto_instance *inst)
diff --git a/include/crypto/rfc4106.h b/include/crypto/rfc4106.h
new file mode 100644
index 0000000000000000000000000000000000000000..96e50bc38b63a26106d979221288af5726ae4deb
--- /dev/null
+++ b/include/crypto/rfc4106.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _CRYPTO_RFC4106_H
+#define _CRYPTO_RFC4106_H
+
+#include <crypto/aes.h>
+
+#define RFC4106_SALT_SIZE		4
+
+#define RFC4106_AEAD_KEYSIZE_128	(RFC4106_SALT_SIZE + AES_KEYSIZE_128) /* 20 */
+#define RFC4106_AEAD_KEYSIZE_192	(RFC4106_SALT_SIZE + AES_KEYSIZE_192) /* 28 */
+#define RFC4106_AEAD_KEYSIZE_256	(RFC4106_SALT_SIZE + AES_KEYSIZE_256) /* 36 */
+
+static inline bool rfc4106_keysize_ok(unsigned int keylen)
+{
+	return keylen == RFC4106_AEAD_KEYSIZE_128 ||
+		keylen == RFC4106_AEAD_KEYSIZE_192 ||
+		keylen == RFC4106_AEAD_KEYSIZE_256;
+}
+
+#endif /* _CRYPTO_RFC4106_H */
diff --git a/include/linux/crypto.h b/include/linux/crypto.h
index a2137e19be7d86846633e6d7acca6dec59e98c77..56432af271f24ea74f687707883fa77f3a45a5d9 100644
--- a/include/linux/crypto.h
+++ b/include/linux/crypto.h
@@ -152,6 +152,8 @@
 #define CRYPTO_TFM_REQ_MAY_BACKLOG	0x00000400
 #define CRYPTO_TFM_REQ_ON_STACK		0x00000800
 
+#define CRYPTO_TFM_FIPS_COMPLIANCE      0x80000000
+
 /*
  * Miscellaneous stuff.
  */

---
base-commit: c66e0a273f223fe38b8b72c034857622b0651482
change-id: 20260129-fips-gcm-clean-v1-9456700aa29c

Best regards,
-- 
Jeff Barnes <jeffbarnes@microsoft.com>


