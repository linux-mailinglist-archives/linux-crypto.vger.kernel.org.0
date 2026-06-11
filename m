Return-Path: <linux-crypto+bounces-25053-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Ij3sOD9oKmpyowMAu9opvQ
	(envelope-from <linux-crypto+bounces-25053-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 09:48:15 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F77166F87F
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 09:48:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=HzydCfzT;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25053-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25053-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEAC2317A3AB
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 07:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E418A3B960C;
	Thu, 11 Jun 2026 07:37:02 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615DF368284
	for <linux-crypto@vger.kernel.org>; Thu, 11 Jun 2026 07:36:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781163422; cv=none; b=hSoQzd2oouTLa91g7yw/c6jNyOVkRMA656vBNyhcUVvUrOwq7fKX73umKucRAg7y/JFGxBeep7mbOiOuq6f/cUb15MqqHoxE8jGeFTb9kQZXq7qDoUYMiRsIpf82H5SZFok4OaIwuNrrqgkTXlb+BkD6MQJW8mx5xi/jer28nTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781163422; c=relaxed/simple;
	bh=EeaXwZxB7xGd9GPflgOfVy04KtMiUvsFZg2kvMcA91M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MFdYRQbtqqqrpIbwYbNkTLFUvVA8ofTWOGHXfFbP2BdPgQ0+knA+eXX7B7Dx5Jh2Fp0f2dm1SMhbw5PeLYGhB92MBb/BcqaNF/q8x1BJsuyn8NyMG/LPDtVg/R3UoQUcjEhEHB0XVElVPIhCLnHXC/msX0mJMoa3KstN2wbJ1Gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HzydCfzT; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 30476C49F68;
	Thu, 11 Jun 2026 07:37:00 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E8C3C5FF03;
	Thu, 11 Jun 2026 07:36:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 970C0106B9E59;
	Thu, 11 Jun 2026 09:36:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781163417; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=iBA4D2k/z03IMYfZIE6ZMjlz7WKJXNjn4xB2OnKhaI8=;
	b=HzydCfzT0e10Xdl/RVuv770tXJD3kg9l+JMnmT5Lwl+ibNy9//BPZjI1OdPBkjKj868NRk
	uHnf4rSsQU1tCWORPGQA+UFMLx4nvSg8Qv0gGgZcnThXNmXEbuYQvcIbvyxISFH+rNGqOu
	b3lTJJcDisVtQHZrWGHPqCZeeh5zmBQ6fVORuMEthH/RUFf0eMjlQBMZ/b6JDYFp+H3FNg
	/G6n7f7O6lQ6Uf+1oLDfs73pnvw2Ju0tEyi+yakoYnYTiGU80mHxJK0wB01HZFQhjp8Hrv
	rHnWL+v5NqVn+X9wS+0yhR3PVkfIGBdiKxEAnmWW4raCmgVj9KiTzDMEyxPrDQ==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Thu, 11 Jun 2026 09:36:08 +0200
Subject: [PATCH v2 14/19] crypto: talitos/aead - Use macro for algorithm
 definitions
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-7-1-rc1_talitos_cleanup-v2-14-aa4a813ce69b@bootlin.com>
References: <20260611-7-1-rc1_talitos_cleanup-v2-0-aa4a813ce69b@bootlin.com>
In-Reply-To: <20260611-7-1-rc1_talitos_cleanup-v2-0-aa4a813ce69b@bootlin.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Christophe Leroy <chleroy@kernel.org>, linux-crypto@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Paul Louvel <paul.louvel@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781163398; l=24908;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=EeaXwZxB7xGd9GPflgOfVy04KtMiUvsFZg2kvMcA91M=;
 b=x/XyyWmwcbalhJNP+uTU4+A/vbb2kk8wt4qa7YRUyOqdjOwFbW0CZjQAd9zkxygAas9Cvo9Ca
 slAhqYHjIKEChqXcZec9X1KtLKPJ1ijLybi71wIim4XNQPwc9iYxCgM
X-Developer-Key: i=paul.louvel@bootlin.com; a=ed25519;
 pk=eLW50NT18UAvUT5cAcYf88zNbBCZDLFXuptpyLVhVIU=
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25053-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[paul.louvel@bootlin.com,linux-crypto@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:thomas.petazzoni@bootlin.com,m:herve.codina@bootlin.com,m:chleroy@kernel.org,m:linux-crypto@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:paul.louvel@bootlin.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[paul.louvel@bootlin.com,linux-crypto@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5F77166F87F

Replace the repetitive struct initializer entries with preprocessor
macros.

The fallback setkey assignment (aead_alg->setkey ?: aead_setkey) is
replaced by specifying the correct setkey handler directly in each macro
invocation.

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/crypto/talitos/talitos-aead.c | 679 +++++++++++-----------------------
 1 file changed, 218 insertions(+), 461 deletions(-)

diff --git a/drivers/crypto/talitos/talitos-aead.c b/drivers/crypto/talitos/talitos-aead.c
index 5537f2b6317f..cd1b8e6d371b 100644
--- a/drivers/crypto/talitos/talitos-aead.c
+++ b/drivers/crypto/talitos/talitos-aead.c
@@ -405,463 +405,225 @@ static void talitos_cra_exit_aead(struct crypto_aead *tfm)
 	talitos_cra_exit(crypto_aead_tfm(tfm));
 }
 
+#define TALITOS_AEAD_ALG_COMMON(name, name_prefix, set_key, block_size, \
+				max_auth_size, template, priority)      \
+	{ \
+		.type = CRYPTO_ALG_TYPE_AEAD, \
+		.alg.aead = { \
+			.base = { \
+				.cra_name = name, \
+				.cra_driver_name = name"-talitos"name_prefix, \
+				.cra_blocksize = block_size, \
+				.cra_flags = CRYPTO_ALG_ASYNC | \
+					     CRYPTO_ALG_ALLOCATES_MEMORY | \
+					     CRYPTO_ALG_KERN_DRIVER_ONLY, \
+				.cra_priority = (priority), \
+				.cra_ctxsize = sizeof(struct talitos_ctx), \
+				.cra_module = THIS_MODULE, \
+			}, \
+			.ivsize = block_size, \
+			.maxauthsize = max_auth_size, \
+			.setkey = set_key, \
+			.init = talitos_cra_init_aead, \
+			.exit = talitos_cra_exit_aead, \
+			.encrypt = aead_encrypt, \
+			.decrypt = aead_decrypt, \
+		}, \
+		.desc_hdr_template = template, \
+	}
+
+#define TALITOS_AEAD_ALG(name, set_key, block_size, max_auth_size, template)  \
+	TALITOS_AEAD_ALG_COMMON(name, "", set_key, block_size, max_auth_size, \
+				template, TALITOS_CRA_PRIORITY)
+
+#define TALITOS_AEAD_ALG_HSNA(name, set_key, block_size, max_auth_size, \
+			      template)                                 \
+	TALITOS_AEAD_ALG_COMMON(name, "-hsna", set_key, block_size,     \
+				max_auth_size, template,                \
+				TALITOS_CRA_PRIORITY_AEAD_HSNA)
+
 static struct talitos_alg_template aead_driver_algs[] = {
-	{	.type = CRYPTO_ALG_TYPE_AEAD,
-		.alg.aead = {
-			.base = {
-				.cra_name = "authenc(hmac(sha1),cbc(aes))",
-				.cra_driver_name = "authenc-hmac-sha1-"
-						   "cbc-aes-talitos",
-				.cra_blocksize = AES_BLOCK_SIZE,
-				.cra_flags = CRYPTO_ALG_ASYNC |
-					     CRYPTO_ALG_ALLOCATES_MEMORY,
-			},
-			.ivsize = AES_BLOCK_SIZE,
-			.maxauthsize = SHA1_DIGEST_SIZE,
-		},
-		.desc_hdr_template = DESC_HDR_TYPE_IPSEC_ESP |
-				     DESC_HDR_SEL0_AESU |
-				     DESC_HDR_MODE0_AESU_CBC |
-				     DESC_HDR_SEL1_MDEUA |
-				     DESC_HDR_MODE1_MDEU_INIT |
-				     DESC_HDR_MODE1_MDEU_PAD |
-				     DESC_HDR_MODE1_MDEU_SHA1_HMAC,
-	},
-	{	.type = CRYPTO_ALG_TYPE_AEAD,
-		.priority = TALITOS_CRA_PRIORITY_AEAD_HSNA,
-		.alg.aead = {
-			.base = {
-				.cra_name = "authenc(hmac(sha1),cbc(aes))",
-				.cra_driver_name = "authenc-hmac-sha1-"
-						   "cbc-aes-talitos-hsna",
-				.cra_blocksize = AES_BLOCK_SIZE,
-				.cra_flags = CRYPTO_ALG_ASYNC |
-					     CRYPTO_ALG_ALLOCATES_MEMORY,
-			},
-			.ivsize = AES_BLOCK_SIZE,
-			.maxauthsize = SHA1_DIGEST_SIZE,
-		},
-		.desc_hdr_template = DESC_HDR_TYPE_HMAC_SNOOP_NO_AFEU |
-				     DESC_HDR_SEL0_AESU |
-				     DESC_HDR_MODE0_AESU_CBC |
-				     DESC_HDR_SEL1_MDEUA |
-				     DESC_HDR_MODE1_MDEU_INIT |
-				     DESC_HDR_MODE1_MDEU_PAD |
-				     DESC_HDR_MODE1_MDEU_SHA1_HMAC,
-	},
-	{	.type = CRYPTO_ALG_TYPE_AEAD,
-		.alg.aead = {
-			.base = {
-				.cra_name = "authenc(hmac(sha1),"
-					    "cbc(des3_ede))",
-				.cra_driver_name = "authenc-hmac-sha1-"
-						   "cbc-3des-talitos",
-				.cra_blocksize = DES3_EDE_BLOCK_SIZE,
-				.cra_flags = CRYPTO_ALG_ASYNC |
-					     CRYPTO_ALG_ALLOCATES_MEMORY,
-			},
-			.ivsize = DES3_EDE_BLOCK_SIZE,
-			.maxauthsize = SHA1_DIGEST_SIZE,
-			.setkey = aead_des3_setkey,
-		},
-		.desc_hdr_template = DESC_HDR_TYPE_IPSEC_ESP |
-				     DESC_HDR_SEL0_DEU |
-				     DESC_HDR_MODE0_DEU_CBC |
-				     DESC_HDR_MODE0_DEU_3DES |
-				     DESC_HDR_SEL1_MDEUA |
-				     DESC_HDR_MODE1_MDEU_INIT |
-				     DESC_HDR_MODE1_MDEU_PAD |
-				     DESC_HDR_MODE1_MDEU_SHA1_HMAC,
-	},
-	{	.type = CRYPTO_ALG_TYPE_AEAD,
-		.priority = TALITOS_CRA_PRIORITY_AEAD_HSNA,
-		.alg.aead = {
-			.base = {
-				.cra_name = "authenc(hmac(sha1),"
-					    "cbc(des3_ede))",
-				.cra_driver_name = "authenc-hmac-sha1-"
-						   "cbc-3des-talitos-hsna",
-				.cra_blocksize = DES3_EDE_BLOCK_SIZE,
-				.cra_flags = CRYPTO_ALG_ASYNC |
-					     CRYPTO_ALG_ALLOCATES_MEMORY,
-			},
-			.ivsize = DES3_EDE_BLOCK_SIZE,
-			.maxauthsize = SHA1_DIGEST_SIZE,
-			.setkey = aead_des3_setkey,
-		},
-		.desc_hdr_template = DESC_HDR_TYPE_HMAC_SNOOP_NO_AFEU |
-				     DESC_HDR_SEL0_DEU |
-				     DESC_HDR_MODE0_DEU_CBC |
-				     DESC_HDR_MODE0_DEU_3DES |
-				     DESC_HDR_SEL1_MDEUA |
-				     DESC_HDR_MODE1_MDEU_INIT |
-				     DESC_HDR_MODE1_MDEU_PAD |
-				     DESC_HDR_MODE1_MDEU_SHA1_HMAC,
-	},
-	{       .type = CRYPTO_ALG_TYPE_AEAD,
-		.alg.aead = {
-			.base = {
-				.cra_name = "authenc(hmac(sha224),cbc(aes))",
-				.cra_driver_name = "authenc-hmac-sha224-"
-						   "cbc-aes-talitos",
-				.cra_blocksize = AES_BLOCK_SIZE,
-				.cra_flags = CRYPTO_ALG_ASYNC |
-					     CRYPTO_ALG_ALLOCATES_MEMORY,
-			},
-			.ivsize = AES_BLOCK_SIZE,
-			.maxauthsize = SHA224_DIGEST_SIZE,
-		},
-		.desc_hdr_template = DESC_HDR_TYPE_IPSEC_ESP |
-				     DESC_HDR_SEL0_AESU |
-				     DESC_HDR_MODE0_AESU_CBC |
-				     DESC_HDR_SEL1_MDEUA |
-				     DESC_HDR_MODE1_MDEU_INIT |
-				     DESC_HDR_MODE1_MDEU_PAD |
-				     DESC_HDR_MODE1_MDEU_SHA224_HMAC,
-	},
-	{       .type = CRYPTO_ALG_TYPE_AEAD,
-		.priority = TALITOS_CRA_PRIORITY_AEAD_HSNA,
-		.alg.aead = {
-			.base = {
-				.cra_name = "authenc(hmac(sha224),cbc(aes))",
-				.cra_driver_name = "authenc-hmac-sha224-"
-						   "cbc-aes-talitos-hsna",
-				.cra_blocksize = AES_BLOCK_SIZE,
-				.cra_flags = CRYPTO_ALG_ASYNC |
-					     CRYPTO_ALG_ALLOCATES_MEMORY,
-			},
-			.ivsize = AES_BLOCK_SIZE,
-			.maxauthsize = SHA224_DIGEST_SIZE,
-		},
-		.desc_hdr_template = DESC_HDR_TYPE_HMAC_SNOOP_NO_AFEU |
-				     DESC_HDR_SEL0_AESU |
-				     DESC_HDR_MODE0_AESU_CBC |
-				     DESC_HDR_SEL1_MDEUA |
-				     DESC_HDR_MODE1_MDEU_INIT |
-				     DESC_HDR_MODE1_MDEU_PAD |
-				     DESC_HDR_MODE1_MDEU_SHA224_HMAC,
-	},
-	{	.type = CRYPTO_ALG_TYPE_AEAD,
-		.alg.aead = {
-			.base = {
-				.cra_name = "authenc(hmac(sha224),"
-					    "cbc(des3_ede))",
-				.cra_driver_name = "authenc-hmac-sha224-"
-						   "cbc-3des-talitos",
-				.cra_blocksize = DES3_EDE_BLOCK_SIZE,
-				.cra_flags = CRYPTO_ALG_ASYNC |
-					     CRYPTO_ALG_ALLOCATES_MEMORY,
-			},
-			.ivsize = DES3_EDE_BLOCK_SIZE,
-			.maxauthsize = SHA224_DIGEST_SIZE,
-			.setkey = aead_des3_setkey,
-		},
-		.desc_hdr_template = DESC_HDR_TYPE_IPSEC_ESP |
-				     DESC_HDR_SEL0_DEU |
-				     DESC_HDR_MODE0_DEU_CBC |
-				     DESC_HDR_MODE0_DEU_3DES |
-				     DESC_HDR_SEL1_MDEUA |
-				     DESC_HDR_MODE1_MDEU_INIT |
-				     DESC_HDR_MODE1_MDEU_PAD |
-				     DESC_HDR_MODE1_MDEU_SHA224_HMAC,
-	},
-	{	.type = CRYPTO_ALG_TYPE_AEAD,
-		.priority = TALITOS_CRA_PRIORITY_AEAD_HSNA,
-		.alg.aead = {
-			.base = {
-				.cra_name = "authenc(hmac(sha224),"
-					    "cbc(des3_ede))",
-				.cra_driver_name = "authenc-hmac-sha224-"
-						   "cbc-3des-talitos-hsna",
-				.cra_blocksize = DES3_EDE_BLOCK_SIZE,
-				.cra_flags = CRYPTO_ALG_ASYNC |
-					     CRYPTO_ALG_ALLOCATES_MEMORY,
-			},
-			.ivsize = DES3_EDE_BLOCK_SIZE,
-			.maxauthsize = SHA224_DIGEST_SIZE,
-			.setkey = aead_des3_setkey,
-		},
-		.desc_hdr_template = DESC_HDR_TYPE_HMAC_SNOOP_NO_AFEU |
-				     DESC_HDR_SEL0_DEU |
-				     DESC_HDR_MODE0_DEU_CBC |
-				     DESC_HDR_MODE0_DEU_3DES |
-				     DESC_HDR_SEL1_MDEUA |
-				     DESC_HDR_MODE1_MDEU_INIT |
-				     DESC_HDR_MODE1_MDEU_PAD |
-				     DESC_HDR_MODE1_MDEU_SHA224_HMAC,
-	},
-	{	.type = CRYPTO_ALG_TYPE_AEAD,
-		.alg.aead = {
-			.base = {
-				.cra_name = "authenc(hmac(sha256),cbc(aes))",
-				.cra_driver_name = "authenc-hmac-sha256-"
-						   "cbc-aes-talitos",
-				.cra_blocksize = AES_BLOCK_SIZE,
-				.cra_flags = CRYPTO_ALG_ASYNC |
-					     CRYPTO_ALG_ALLOCATES_MEMORY,
-			},
-			.ivsize = AES_BLOCK_SIZE,
-			.maxauthsize = SHA256_DIGEST_SIZE,
-		},
-		.desc_hdr_template = DESC_HDR_TYPE_IPSEC_ESP |
-				     DESC_HDR_SEL0_AESU |
-				     DESC_HDR_MODE0_AESU_CBC |
-				     DESC_HDR_SEL1_MDEUA |
-				     DESC_HDR_MODE1_MDEU_INIT |
-				     DESC_HDR_MODE1_MDEU_PAD |
-				     DESC_HDR_MODE1_MDEU_SHA256_HMAC,
-	},
-	{	.type = CRYPTO_ALG_TYPE_AEAD,
-		.priority = TALITOS_CRA_PRIORITY_AEAD_HSNA,
-		.alg.aead = {
-			.base = {
-				.cra_name = "authenc(hmac(sha256),cbc(aes))",
-				.cra_driver_name = "authenc-hmac-sha256-"
-						   "cbc-aes-talitos-hsna",
-				.cra_blocksize = AES_BLOCK_SIZE,
-				.cra_flags = CRYPTO_ALG_ASYNC |
-					     CRYPTO_ALG_ALLOCATES_MEMORY,
-			},
-			.ivsize = AES_BLOCK_SIZE,
-			.maxauthsize = SHA256_DIGEST_SIZE,
-		},
-		.desc_hdr_template = DESC_HDR_TYPE_HMAC_SNOOP_NO_AFEU |
-				     DESC_HDR_SEL0_AESU |
-				     DESC_HDR_MODE0_AESU_CBC |
-				     DESC_HDR_SEL1_MDEUA |
-				     DESC_HDR_MODE1_MDEU_INIT |
-				     DESC_HDR_MODE1_MDEU_PAD |
-				     DESC_HDR_MODE1_MDEU_SHA256_HMAC,
-	},
-	{	.type = CRYPTO_ALG_TYPE_AEAD,
-		.alg.aead = {
-			.base = {
-				.cra_name = "authenc(hmac(sha256),"
-					    "cbc(des3_ede))",
-				.cra_driver_name = "authenc-hmac-sha256-"
-						   "cbc-3des-talitos",
-				.cra_blocksize = DES3_EDE_BLOCK_SIZE,
-				.cra_flags = CRYPTO_ALG_ASYNC |
-					     CRYPTO_ALG_ALLOCATES_MEMORY,
-			},
-			.ivsize = DES3_EDE_BLOCK_SIZE,
-			.maxauthsize = SHA256_DIGEST_SIZE,
-			.setkey = aead_des3_setkey,
-		},
-		.desc_hdr_template = DESC_HDR_TYPE_IPSEC_ESP |
-				     DESC_HDR_SEL0_DEU |
-				     DESC_HDR_MODE0_DEU_CBC |
-				     DESC_HDR_MODE0_DEU_3DES |
-				     DESC_HDR_SEL1_MDEUA |
-				     DESC_HDR_MODE1_MDEU_INIT |
-				     DESC_HDR_MODE1_MDEU_PAD |
-				     DESC_HDR_MODE1_MDEU_SHA256_HMAC,
-	},
-	{	.type = CRYPTO_ALG_TYPE_AEAD,
-		.priority = TALITOS_CRA_PRIORITY_AEAD_HSNA,
-		.alg.aead = {
-			.base = {
-				.cra_name = "authenc(hmac(sha256),"
-					    "cbc(des3_ede))",
-				.cra_driver_name = "authenc-hmac-sha256-"
-						   "cbc-3des-talitos-hsna",
-				.cra_blocksize = DES3_EDE_BLOCK_SIZE,
-				.cra_flags = CRYPTO_ALG_ASYNC |
-					     CRYPTO_ALG_ALLOCATES_MEMORY,
-			},
-			.ivsize = DES3_EDE_BLOCK_SIZE,
-			.maxauthsize = SHA256_DIGEST_SIZE,
-			.setkey = aead_des3_setkey,
-		},
-		.desc_hdr_template = DESC_HDR_TYPE_HMAC_SNOOP_NO_AFEU |
-				     DESC_HDR_SEL0_DEU |
-				     DESC_HDR_MODE0_DEU_CBC |
-				     DESC_HDR_MODE0_DEU_3DES |
-				     DESC_HDR_SEL1_MDEUA |
-				     DESC_HDR_MODE1_MDEU_INIT |
-				     DESC_HDR_MODE1_MDEU_PAD |
-				     DESC_HDR_MODE1_MDEU_SHA256_HMAC,
-	},
-	{	.type = CRYPTO_ALG_TYPE_AEAD,
-		.alg.aead = {
-			.base = {
-				.cra_name = "authenc(hmac(sha384),cbc(aes))",
-				.cra_driver_name = "authenc-hmac-sha384-"
-						   "cbc-aes-talitos",
-				.cra_blocksize = AES_BLOCK_SIZE,
-				.cra_flags = CRYPTO_ALG_ASYNC |
-					     CRYPTO_ALG_ALLOCATES_MEMORY,
-			},
-			.ivsize = AES_BLOCK_SIZE,
-			.maxauthsize = SHA384_DIGEST_SIZE,
-		},
-		.desc_hdr_template = DESC_HDR_TYPE_IPSEC_ESP |
-				     DESC_HDR_SEL0_AESU |
-				     DESC_HDR_MODE0_AESU_CBC |
-				     DESC_HDR_SEL1_MDEUB |
-				     DESC_HDR_MODE1_MDEU_INIT |
-				     DESC_HDR_MODE1_MDEU_PAD |
-				     DESC_HDR_MODE1_MDEUB_SHA384_HMAC,
-	},
-	{	.type = CRYPTO_ALG_TYPE_AEAD,
-		.alg.aead = {
-			.base = {
-				.cra_name = "authenc(hmac(sha384),"
-					    "cbc(des3_ede))",
-				.cra_driver_name = "authenc-hmac-sha384-"
-						   "cbc-3des-talitos",
-				.cra_blocksize = DES3_EDE_BLOCK_SIZE,
-				.cra_flags = CRYPTO_ALG_ASYNC |
-					     CRYPTO_ALG_ALLOCATES_MEMORY,
-			},
-			.ivsize = DES3_EDE_BLOCK_SIZE,
-			.maxauthsize = SHA384_DIGEST_SIZE,
-			.setkey = aead_des3_setkey,
-		},
-		.desc_hdr_template = DESC_HDR_TYPE_IPSEC_ESP |
-				     DESC_HDR_SEL0_DEU |
-				     DESC_HDR_MODE0_DEU_CBC |
-				     DESC_HDR_MODE0_DEU_3DES |
-				     DESC_HDR_SEL1_MDEUB |
-				     DESC_HDR_MODE1_MDEU_INIT |
-				     DESC_HDR_MODE1_MDEU_PAD |
-				     DESC_HDR_MODE1_MDEUB_SHA384_HMAC,
-	},
-	{	.type = CRYPTO_ALG_TYPE_AEAD,
-		.alg.aead = {
-			.base = {
-				.cra_name = "authenc(hmac(sha512),cbc(aes))",
-				.cra_driver_name = "authenc-hmac-sha512-"
-						   "cbc-aes-talitos",
-				.cra_blocksize = AES_BLOCK_SIZE,
-				.cra_flags = CRYPTO_ALG_ASYNC |
-					     CRYPTO_ALG_ALLOCATES_MEMORY,
-			},
-			.ivsize = AES_BLOCK_SIZE,
-			.maxauthsize = SHA512_DIGEST_SIZE,
-		},
-		.desc_hdr_template = DESC_HDR_TYPE_IPSEC_ESP |
-				     DESC_HDR_SEL0_AESU |
-				     DESC_HDR_MODE0_AESU_CBC |
-				     DESC_HDR_SEL1_MDEUB |
-				     DESC_HDR_MODE1_MDEU_INIT |
-				     DESC_HDR_MODE1_MDEU_PAD |
-				     DESC_HDR_MODE1_MDEUB_SHA512_HMAC,
-	},
-	{	.type = CRYPTO_ALG_TYPE_AEAD,
-		.alg.aead = {
-			.base = {
-				.cra_name = "authenc(hmac(sha512),"
-					    "cbc(des3_ede))",
-				.cra_driver_name = "authenc-hmac-sha512-"
-						   "cbc-3des-talitos",
-				.cra_blocksize = DES3_EDE_BLOCK_SIZE,
-				.cra_flags = CRYPTO_ALG_ASYNC |
-					     CRYPTO_ALG_ALLOCATES_MEMORY,
-			},
-			.ivsize = DES3_EDE_BLOCK_SIZE,
-			.maxauthsize = SHA512_DIGEST_SIZE,
-			.setkey = aead_des3_setkey,
-		},
-		.desc_hdr_template = DESC_HDR_TYPE_IPSEC_ESP |
-				     DESC_HDR_SEL0_DEU |
-				     DESC_HDR_MODE0_DEU_CBC |
-				     DESC_HDR_MODE0_DEU_3DES |
-				     DESC_HDR_SEL1_MDEUB |
-				     DESC_HDR_MODE1_MDEU_INIT |
-				     DESC_HDR_MODE1_MDEU_PAD |
-				     DESC_HDR_MODE1_MDEUB_SHA512_HMAC,
-	},
-	{	.type = CRYPTO_ALG_TYPE_AEAD,
-		.alg.aead = {
-			.base = {
-				.cra_name = "authenc(hmac(md5),cbc(aes))",
-				.cra_driver_name = "authenc-hmac-md5-"
-						   "cbc-aes-talitos",
-				.cra_blocksize = AES_BLOCK_SIZE,
-				.cra_flags = CRYPTO_ALG_ASYNC |
-					     CRYPTO_ALG_ALLOCATES_MEMORY,
-			},
-			.ivsize = AES_BLOCK_SIZE,
-			.maxauthsize = MD5_DIGEST_SIZE,
-		},
-		.desc_hdr_template = DESC_HDR_TYPE_IPSEC_ESP |
-				     DESC_HDR_SEL0_AESU |
-				     DESC_HDR_MODE0_AESU_CBC |
-				     DESC_HDR_SEL1_MDEUA |
-				     DESC_HDR_MODE1_MDEU_INIT |
-				     DESC_HDR_MODE1_MDEU_PAD |
-				     DESC_HDR_MODE1_MDEU_MD5_HMAC,
-	},
-	{	.type = CRYPTO_ALG_TYPE_AEAD,
-		.priority = TALITOS_CRA_PRIORITY_AEAD_HSNA,
-		.alg.aead = {
-			.base = {
-				.cra_name = "authenc(hmac(md5),cbc(aes))",
-				.cra_driver_name = "authenc-hmac-md5-"
-						   "cbc-aes-talitos-hsna",
-				.cra_blocksize = AES_BLOCK_SIZE,
-				.cra_flags = CRYPTO_ALG_ASYNC |
-					     CRYPTO_ALG_ALLOCATES_MEMORY,
-			},
-			.ivsize = AES_BLOCK_SIZE,
-			.maxauthsize = MD5_DIGEST_SIZE,
-		},
-		.desc_hdr_template = DESC_HDR_TYPE_HMAC_SNOOP_NO_AFEU |
-				     DESC_HDR_SEL0_AESU |
-				     DESC_HDR_MODE0_AESU_CBC |
-				     DESC_HDR_SEL1_MDEUA |
-				     DESC_HDR_MODE1_MDEU_INIT |
-				     DESC_HDR_MODE1_MDEU_PAD |
-				     DESC_HDR_MODE1_MDEU_MD5_HMAC,
-	},
-	{	.type = CRYPTO_ALG_TYPE_AEAD,
-		.alg.aead = {
-			.base = {
-				.cra_name = "authenc(hmac(md5),cbc(des3_ede))",
-				.cra_driver_name = "authenc-hmac-md5-"
-						   "cbc-3des-talitos",
-				.cra_blocksize = DES3_EDE_BLOCK_SIZE,
-				.cra_flags = CRYPTO_ALG_ASYNC |
-					     CRYPTO_ALG_ALLOCATES_MEMORY,
-			},
-			.ivsize = DES3_EDE_BLOCK_SIZE,
-			.maxauthsize = MD5_DIGEST_SIZE,
-			.setkey = aead_des3_setkey,
-		},
-		.desc_hdr_template = DESC_HDR_TYPE_IPSEC_ESP |
-				     DESC_HDR_SEL0_DEU |
-				     DESC_HDR_MODE0_DEU_CBC |
-				     DESC_HDR_MODE0_DEU_3DES |
-				     DESC_HDR_SEL1_MDEUA |
-				     DESC_HDR_MODE1_MDEU_INIT |
-				     DESC_HDR_MODE1_MDEU_PAD |
-				     DESC_HDR_MODE1_MDEU_MD5_HMAC,
-	},
-	{	.type = CRYPTO_ALG_TYPE_AEAD,
-		.priority = TALITOS_CRA_PRIORITY_AEAD_HSNA,
-		.alg.aead = {
-			.base = {
-				.cra_name = "authenc(hmac(md5),cbc(des3_ede))",
-				.cra_driver_name = "authenc-hmac-md5-"
-						   "cbc-3des-talitos-hsna",
-				.cra_blocksize = DES3_EDE_BLOCK_SIZE,
-				.cra_flags = CRYPTO_ALG_ASYNC |
-					     CRYPTO_ALG_ALLOCATES_MEMORY,
-			},
-			.ivsize = DES3_EDE_BLOCK_SIZE,
-			.maxauthsize = MD5_DIGEST_SIZE,
-			.setkey = aead_des3_setkey,
-		},
-		.desc_hdr_template = DESC_HDR_TYPE_HMAC_SNOOP_NO_AFEU |
-				     DESC_HDR_SEL0_DEU |
-				     DESC_HDR_MODE0_DEU_CBC |
-				     DESC_HDR_MODE0_DEU_3DES |
-				     DESC_HDR_SEL1_MDEUA |
-				     DESC_HDR_MODE1_MDEU_INIT |
-				     DESC_HDR_MODE1_MDEU_PAD |
-				     DESC_HDR_MODE1_MDEU_MD5_HMAC,
-	},
+	/* AEAD algorithms.  These use a single-pass ipsec_esp descriptor */
+
+	/* sha1 auth */
+
+	TALITOS_AEAD_ALG("authenc(hmac(sha1),cbc(aes))", aead_setkey,
+			 AES_BLOCK_SIZE, SHA1_DIGEST_SIZE,
+			 DESC_HDR_TYPE_IPSEC_ESP | DESC_HDR_SEL0_AESU |
+				 DESC_HDR_MODE0_AESU_CBC | DESC_HDR_SEL1_MDEUA |
+				 DESC_HDR_MODE1_MDEU_INIT |
+				 DESC_HDR_MODE1_MDEU_PAD |
+				 DESC_HDR_MODE1_MDEU_SHA1_HMAC),
+
+	TALITOS_AEAD_ALG_HSNA(
+		"authenc(hmac(sha1),cbc(aes))", aead_setkey, AES_BLOCK_SIZE,
+		SHA1_DIGEST_SIZE,
+		DESC_HDR_TYPE_HMAC_SNOOP_NO_AFEU | DESC_HDR_SEL0_AESU |
+			DESC_HDR_MODE0_AESU_CBC | DESC_HDR_SEL1_MDEUA |
+			DESC_HDR_MODE1_MDEU_INIT | DESC_HDR_MODE1_MDEU_PAD |
+			DESC_HDR_MODE1_MDEU_SHA1_HMAC),
+
+	TALITOS_AEAD_ALG("authenc(hmac(sha1),cbc(des3_ede))", aead_des3_setkey,
+			 DES3_EDE_BLOCK_SIZE, SHA1_DIGEST_SIZE,
+			 DESC_HDR_TYPE_IPSEC_ESP | DESC_HDR_SEL0_DEU |
+				 DESC_HDR_MODE0_DEU_CBC |
+				 DESC_HDR_MODE0_DEU_3DES | DESC_HDR_SEL1_MDEUA |
+				 DESC_HDR_MODE1_MDEU_INIT |
+				 DESC_HDR_MODE1_MDEU_PAD |
+				 DESC_HDR_MODE1_MDEU_SHA1_HMAC),
+
+	TALITOS_AEAD_ALG_HSNA(
+		"authenc(hmac(sha1),cbc(des3_ede))", aead_des3_setkey,
+		DES3_EDE_BLOCK_SIZE, SHA1_DIGEST_SIZE,
+		DESC_HDR_TYPE_HMAC_SNOOP_NO_AFEU | DESC_HDR_SEL0_DEU |
+			DESC_HDR_MODE0_DEU_CBC | DESC_HDR_MODE0_DEU_3DES |
+			DESC_HDR_SEL1_MDEUA | DESC_HDR_MODE1_MDEU_INIT |
+			DESC_HDR_MODE1_MDEU_PAD |
+			DESC_HDR_MODE1_MDEU_SHA1_HMAC),
+
+	/* sha224 auth */
+
+	TALITOS_AEAD_ALG("authenc(hmac(sha224),cbc(aes))", aead_setkey,
+			 AES_BLOCK_SIZE, SHA224_DIGEST_SIZE,
+			 DESC_HDR_TYPE_IPSEC_ESP | DESC_HDR_SEL0_AESU |
+				 DESC_HDR_MODE0_AESU_CBC | DESC_HDR_SEL1_MDEUA |
+				 DESC_HDR_MODE1_MDEU_INIT |
+				 DESC_HDR_MODE1_MDEU_PAD |
+				 DESC_HDR_MODE1_MDEU_SHA224_HMAC),
+
+	TALITOS_AEAD_ALG_HSNA(
+		"authenc(hmac(sha224),cbc(aes))", aead_setkey, AES_BLOCK_SIZE,
+		SHA224_DIGEST_SIZE,
+		DESC_HDR_TYPE_HMAC_SNOOP_NO_AFEU | DESC_HDR_SEL0_AESU |
+			DESC_HDR_MODE0_AESU_CBC | DESC_HDR_SEL1_MDEUA |
+			DESC_HDR_MODE1_MDEU_INIT | DESC_HDR_MODE1_MDEU_PAD |
+			DESC_HDR_MODE1_MDEU_SHA224_HMAC),
+
+	TALITOS_AEAD_ALG(
+		"authenc(hmac(sha224),cbc(des3_ede))", aead_des3_setkey,
+		DES3_EDE_BLOCK_SIZE, SHA224_DIGEST_SIZE,
+		DESC_HDR_TYPE_IPSEC_ESP | DESC_HDR_SEL0_DEU |
+			DESC_HDR_MODE0_DEU_CBC | DESC_HDR_MODE0_DEU_3DES |
+			DESC_HDR_SEL1_MDEUA | DESC_HDR_MODE1_MDEU_INIT |
+			DESC_HDR_MODE1_MDEU_PAD |
+			DESC_HDR_MODE1_MDEU_SHA224_HMAC),
+
+	TALITOS_AEAD_ALG_HSNA(
+		"authenc(hmac(sha224),cbc(des3_ede))", aead_des3_setkey,
+		DES3_EDE_BLOCK_SIZE, SHA224_DIGEST_SIZE,
+		DESC_HDR_TYPE_HMAC_SNOOP_NO_AFEU | DESC_HDR_SEL0_DEU |
+			DESC_HDR_MODE0_DEU_CBC | DESC_HDR_MODE0_DEU_3DES |
+			DESC_HDR_SEL1_MDEUA | DESC_HDR_MODE1_MDEU_INIT |
+			DESC_HDR_MODE1_MDEU_PAD |
+			DESC_HDR_MODE1_MDEU_SHA224_HMAC),
+
+	/* sha256 auth */
+
+	TALITOS_AEAD_ALG("authenc(hmac(sha256),cbc(aes))", aead_setkey,
+			 AES_BLOCK_SIZE, SHA256_DIGEST_SIZE,
+			 DESC_HDR_TYPE_IPSEC_ESP | DESC_HDR_SEL0_AESU |
+				 DESC_HDR_MODE0_AESU_CBC | DESC_HDR_SEL1_MDEUA |
+				 DESC_HDR_MODE1_MDEU_INIT |
+				 DESC_HDR_MODE1_MDEU_PAD |
+				 DESC_HDR_MODE1_MDEU_SHA256_HMAC),
+
+	TALITOS_AEAD_ALG_HSNA(
+		"authenc(hmac(sha256),cbc(aes))", aead_setkey, AES_BLOCK_SIZE,
+		SHA256_DIGEST_SIZE,
+		DESC_HDR_TYPE_HMAC_SNOOP_NO_AFEU | DESC_HDR_SEL0_AESU |
+			DESC_HDR_MODE0_AESU_CBC | DESC_HDR_SEL1_MDEUA |
+			DESC_HDR_MODE1_MDEU_INIT | DESC_HDR_MODE1_MDEU_PAD |
+			DESC_HDR_MODE1_MDEU_SHA256_HMAC),
+
+	TALITOS_AEAD_ALG(
+		"authenc(hmac(sha256),cbc(des3_ede))", aead_des3_setkey,
+		DES3_EDE_BLOCK_SIZE, SHA256_DIGEST_SIZE,
+		DESC_HDR_TYPE_IPSEC_ESP | DESC_HDR_SEL0_DEU |
+			DESC_HDR_MODE0_DEU_CBC | DESC_HDR_MODE0_DEU_3DES |
+			DESC_HDR_SEL1_MDEUA | DESC_HDR_MODE1_MDEU_INIT |
+			DESC_HDR_MODE1_MDEU_PAD |
+			DESC_HDR_MODE1_MDEU_SHA256_HMAC),
+
+	TALITOS_AEAD_ALG_HSNA(
+		"authenc(hmac(sha256),cbc(des3_ede))", aead_des3_setkey,
+		DES3_EDE_BLOCK_SIZE, SHA256_DIGEST_SIZE,
+		DESC_HDR_TYPE_HMAC_SNOOP_NO_AFEU | DESC_HDR_SEL0_DEU |
+			DESC_HDR_MODE0_DEU_CBC | DESC_HDR_MODE0_DEU_3DES |
+			DESC_HDR_SEL1_MDEUA | DESC_HDR_MODE1_MDEU_INIT |
+			DESC_HDR_MODE1_MDEU_PAD |
+			DESC_HDR_MODE1_MDEU_SHA256_HMAC),
+
+	/* sha384 auth */
+
+	TALITOS_AEAD_ALG("authenc(hmac(sha384),cbc(aes))", aead_setkey,
+			 AES_BLOCK_SIZE, SHA384_DIGEST_SIZE,
+			 DESC_HDR_TYPE_IPSEC_ESP | DESC_HDR_SEL0_AESU |
+				 DESC_HDR_MODE0_AESU_CBC | DESC_HDR_SEL1_MDEUB |
+				 DESC_HDR_MODE1_MDEU_INIT |
+				 DESC_HDR_MODE1_MDEU_PAD |
+				 DESC_HDR_MODE1_MDEUB_SHA384_HMAC),
+
+	TALITOS_AEAD_ALG(
+		"authenc(hmac(sha384),cbc(des3_ede))", aead_des3_setkey,
+		DES3_EDE_BLOCK_SIZE, SHA384_DIGEST_SIZE,
+		DESC_HDR_TYPE_IPSEC_ESP | DESC_HDR_SEL0_DEU |
+			DESC_HDR_MODE0_DEU_CBC | DESC_HDR_MODE0_DEU_3DES |
+			DESC_HDR_SEL1_MDEUB | DESC_HDR_MODE1_MDEU_INIT |
+			DESC_HDR_MODE1_MDEU_PAD |
+			DESC_HDR_MODE1_MDEUB_SHA384_HMAC),
+
+	/* sha512 auth */
+
+	TALITOS_AEAD_ALG("authenc(hmac(sha512),cbc(aes))", aead_setkey,
+			 AES_BLOCK_SIZE, SHA512_DIGEST_SIZE,
+			 DESC_HDR_TYPE_IPSEC_ESP | DESC_HDR_SEL0_AESU |
+				 DESC_HDR_MODE0_AESU_CBC | DESC_HDR_SEL1_MDEUB |
+				 DESC_HDR_MODE1_MDEU_INIT |
+				 DESC_HDR_MODE1_MDEU_PAD |
+				 DESC_HDR_MODE1_MDEUB_SHA512_HMAC),
+
+	TALITOS_AEAD_ALG(
+		"authenc(hmac(sha512),cbc(des3_ede))", aead_des3_setkey,
+		DES3_EDE_BLOCK_SIZE, SHA512_DIGEST_SIZE,
+		DESC_HDR_TYPE_IPSEC_ESP | DESC_HDR_SEL0_DEU |
+			DESC_HDR_MODE0_DEU_CBC | DESC_HDR_MODE0_DEU_3DES |
+			DESC_HDR_SEL1_MDEUB | DESC_HDR_MODE1_MDEU_INIT |
+			DESC_HDR_MODE1_MDEU_PAD |
+			DESC_HDR_MODE1_MDEUB_SHA512_HMAC),
+
+	/* md5 auth */
+
+	TALITOS_AEAD_ALG("authenc(hmac(md5),cbc(aes))", aead_setkey,
+			 AES_BLOCK_SIZE, MD5_DIGEST_SIZE,
+			 DESC_HDR_TYPE_IPSEC_ESP | DESC_HDR_SEL0_AESU |
+				 DESC_HDR_MODE0_AESU_CBC | DESC_HDR_SEL1_MDEUA |
+				 DESC_HDR_MODE1_MDEU_INIT |
+				 DESC_HDR_MODE1_MDEU_PAD |
+				 DESC_HDR_MODE1_MDEU_MD5_HMAC),
+
+	TALITOS_AEAD_ALG_HSNA(
+		"authenc(hmac(md5),cbc(aes))", aead_setkey, AES_BLOCK_SIZE,
+		MD5_DIGEST_SIZE,
+		DESC_HDR_TYPE_HMAC_SNOOP_NO_AFEU | DESC_HDR_SEL0_AESU |
+			DESC_HDR_MODE0_AESU_CBC | DESC_HDR_SEL1_MDEUA |
+			DESC_HDR_MODE1_MDEU_INIT | DESC_HDR_MODE1_MDEU_PAD |
+			DESC_HDR_MODE1_MDEU_MD5_HMAC),
+
+	TALITOS_AEAD_ALG(
+		"authenc(hmac(md5),cbc(des3_ede))", aead_des3_setkey,
+		DES3_EDE_BLOCK_SIZE, MD5_DIGEST_SIZE,
+		DESC_HDR_TYPE_IPSEC_ESP | DESC_HDR_SEL0_DEU |
+			DESC_HDR_MODE0_DEU_CBC | DESC_HDR_MODE0_DEU_3DES |
+			DESC_HDR_SEL1_MDEUA | DESC_HDR_MODE1_MDEU_INIT |
+			DESC_HDR_MODE1_MDEU_PAD | DESC_HDR_MODE1_MDEU_MD5_HMAC),
+
+	TALITOS_AEAD_ALG_HSNA(
+		"authenc(hmac(md5),cbc(des3_ede))", aead_des3_setkey,
+		DES3_EDE_BLOCK_SIZE, MD5_DIGEST_SIZE,
+		DESC_HDR_TYPE_HMAC_SNOOP_NO_AFEU | DESC_HDR_SEL0_DEU |
+			DESC_HDR_MODE0_DEU_CBC | DESC_HDR_MODE0_DEU_3DES |
+			DESC_HDR_SEL1_MDEUA | DESC_HDR_MODE1_MDEU_INIT |
+			DESC_HDR_MODE1_MDEU_PAD | DESC_HDR_MODE1_MDEU_MD5_HMAC),
 };
 
 int talitos_register_aead(struct device *dev)
@@ -883,11 +645,6 @@ int talitos_register_aead(struct device *dev)
 		if (has_ftr_sec1(priv))
 			alg->cra_alignmask = 3;
 
-		aead_alg->init = talitos_cra_init_aead;
-		aead_alg->exit = talitos_cra_exit_aead;
-		aead_alg->setkey = aead_alg->setkey ?: aead_setkey;
-		aead_alg->encrypt = aead_encrypt;
-		aead_alg->decrypt = aead_decrypt;
 		if (!(priv->features & TALITOS_FTR_SHA224_HWINIT) &&
 		    !strncmp(alg->cra_name, "authenc(hmac(sha224)", 20)) {
 			continue;

-- 
2.54.0


