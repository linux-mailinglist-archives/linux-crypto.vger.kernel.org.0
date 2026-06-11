Return-Path: <linux-crypto+bounces-25057-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LWz/CFFoKmp2owMAu9opvQ
	(envelope-from <linux-crypto+bounces-25057-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 09:48:33 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A82D866F88F
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 09:48:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=PacLUqiX;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25057-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25057-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4DCF032DA7D8
	for <lists+linux-crypto@lfdr.de>; Thu, 11 Jun 2026 07:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6213BAD84;
	Thu, 11 Jun 2026 07:37:03 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602663B47F0
	for <linux-crypto@vger.kernel.org>; Thu, 11 Jun 2026 07:37:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781163423; cv=none; b=qgx+3MhDSlS+Svo0KlTG63hVP0MH+vA4N30MTKnZgrETnvvOcGpw4JEeq95RTOTBVxRcpdZjRtK2MUCQT7uFYhiW8NkFWKUFeH1qxdDimAcJKosbSHglDad0th81ozoYQdm2SSVQi8uQbhTcso/eUnASQkRKUecirRO87RxFuqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781163423; c=relaxed/simple;
	bh=mf68YKG1f0Xk2qobTLo+uFtYew/AID81zJWuiPfBFyE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JbbNwLy2jCEhqtVESgboLkZsZOqk7py4lmeNv3gSn191u/KnLSxOQlbfJaABhdkCOJl+fI4oMOEmD9jZ2GJ+K6xQyxDnWgaimXgO4IrLGHwfsNzVJPpS3M178sj2qNLLF1Soj9sBuP/5UhNKX9rAelQJM63Vr/BJAAeXOA4Yx7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=PacLUqiX; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E156BC49F63;
	Thu, 11 Jun 2026 07:37:01 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A56625FF03;
	Thu, 11 Jun 2026 07:36:59 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8EAD2106B9E5B;
	Thu, 11 Jun 2026 09:36:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781163419; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=n5Ickrc8ieQAfBeOFJgw8612NS6GRIwY7y2anLp1MVU=;
	b=PacLUqiXJyLXWq31OP4efDQihzmR+S5zMcD1BZNge5cVbueZbYlRrtsCdTUkrk2vuxYEnI
	LP2tqUbAj6Xce0FmMVKdcuWAGYwqeATwd78OO6NRj2ZyO2Ab14DFXE/A3UorMzc6UkFjWk
	JWgqCRsiidwIKvm8tcZPeZHQRdHEGsBTxKYAPB8ywTQbP4YfYZi/PN+P4AGydHUwGZrgSJ
	wO7bi8+wzh8TVvnFfys9oFOajdsiIEXFOnRzlXwhiRHEo9WYk0Ee+VMuNQ1j5qJVhqvBoc
	1oJ8lk5r2VTEB45kkf44YA5NWPzL1W1Jf0lr/acW3prHBg17K+PAr2lZv3Qs0Q==
From: Paul Louvel <paul.louvel@bootlin.com>
Date: Thu, 11 Jun 2026 09:36:10 +0200
Subject: [PATCH v2 16/19] crypto: talitos - Introduce is_sec1() helper with
 static key support
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-7-1-rc1_talitos_cleanup-v2-16-aa4a813ce69b@bootlin.com>
References: <20260611-7-1-rc1_talitos_cleanup-v2-0-aa4a813ce69b@bootlin.com>
In-Reply-To: <20260611-7-1-rc1_talitos_cleanup-v2-0-aa4a813ce69b@bootlin.com>
To: Herbert Xu <herbert@gondor.apana.org.au>, 
 "David S. Miller" <davem@davemloft.net>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Herve Codina <herve.codina@bootlin.com>, 
 Christophe Leroy <chleroy@kernel.org>, linux-crypto@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Paul Louvel <paul.louvel@bootlin.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781163398; l=2752;
 i=paul.louvel@bootlin.com; s=20260313; h=from:subject:message-id;
 bh=mf68YKG1f0Xk2qobTLo+uFtYew/AID81zJWuiPfBFyE=;
 b=No+RK6f4CnVjZ4Hq9vMMexBfCuHf8JCVkt2qIyV8jZaOc4481Bg5+l/LW5tXr3SYKZRuG+Djd
 urqx5p6HSRYASFj34d0TkbgQNZ0K81iL4/ehIxawAci4YGMyzVc8dPi
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
	TAGGED_FROM(0.00)[bounces-25057-lists,linux-crypto=lfdr.de];
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
X-Rspamd-Queue-Id: A82D866F88F

In preparation for per-SEC-version code paths, introduce an is_sec1()
inline helper that abstracts the SEC version check behind a static key.
The goal is to remove all bool is_sec1 parameters from the call chain via
the is_sec1() helper.

Signed-off-by: Paul Louvel <paul.louvel@bootlin.com>
---
 drivers/crypto/talitos/talitos.c | 10 +++++++++-
 drivers/crypto/talitos/talitos.h | 28 ++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/talitos/talitos.c b/drivers/crypto/talitos/talitos.c
index ff938cc4e837..c93e3b551f6d 100644
--- a/drivers/crypto/talitos/talitos.c
+++ b/drivers/crypto/talitos/talitos.c
@@ -1196,8 +1196,12 @@ static int talitos_probe(struct platform_device *ofdev)
 				  TALITOS_FTR_SHA224_HWINIT |
 				  TALITOS_FTR_HMAC_OK;
 
-	if (of_device_is_compatible(np, "fsl,sec1.0"))
+	if (of_device_is_compatible(np, "fsl,sec1.0")) {
 		priv->features |= TALITOS_FTR_SEC1;
+		talitos_init_branch(true);
+	} else {
+		talitos_init_branch(false);
+	}
 
 	if (of_device_is_compatible(np, "fsl,sec1.2")) {
 		priv->reg_deu = priv->reg + TALITOS12_DEU;
@@ -1317,6 +1321,10 @@ static int talitos_probe(struct platform_device *ofdev)
 	return err;
 }
 
+#if defined(CONFIG_CRYPTO_DEV_TALITOS1) && defined(CONFIG_CRYPTO_DEV_TALITOS2)
+DEFINE_STATIC_KEY_FALSE(talitos_is_sec1);
+#endif
+
 static const struct of_device_id talitos_match[] = {
 #ifdef CONFIG_CRYPTO_DEV_TALITOS1
 	{
diff --git a/drivers/crypto/talitos/talitos.h b/drivers/crypto/talitos/talitos.h
index 3cbce0be705d..b0d176c7dab2 100644
--- a/drivers/crypto/talitos/talitos.h
+++ b/drivers/crypto/talitos/talitos.h
@@ -14,6 +14,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/hw_random.h>
 #include <linux/interrupt.h>
+#include <linux/jump_label.h>
 #include <linux/scatterlist.h>
 #include <linux/types.h>
 
@@ -224,6 +225,33 @@ struct talitos_crypto_alg {
 #define TALITOS_FTR_HMAC_OK 0x00000008
 #define TALITOS_FTR_SEC1 0x00000010
 
+#if defined(CONFIG_CRYPTO_DEV_TALITOS1) && defined(CONFIG_CRYPTO_DEV_TALITOS2)
+DECLARE_STATIC_KEY_FALSE(talitos_is_sec1);
+
+static __always_inline bool is_sec1(void)
+{
+	return static_branch_unlikely(&talitos_is_sec1);
+}
+
+static inline void talitos_init_branch(bool sec1)
+{
+	if (sec1)
+		static_branch_enable(&talitos_is_sec1);
+}
+
+#else
+
+static __always_inline bool is_sec1(void)
+{
+	return IS_ENABLED(CONFIG_CRYPTO_DEV_TALITOS1);
+}
+
+static inline void talitos_init_branch(bool sec1)
+{
+}
+
+#endif
+
 /*
  * If both CONFIG_CRYPTO_DEV_TALITOS1 and CONFIG_CRYPTO_DEV_TALITOS2 are
  * defined, we check the features which are set according to the device tree.

-- 
2.54.0


