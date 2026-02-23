Return-Path: <linux-crypto+bounces-21072-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCM0DiZ5nGlfIAQAu9opvQ
	(envelope-from <linux-crypto+bounces-21072-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 23 Feb 2026 16:58:30 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7D7179336
	for <lists+linux-crypto@lfdr.de>; Mon, 23 Feb 2026 16:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2C1753038724
	for <lists+linux-crypto@lfdr.de>; Mon, 23 Feb 2026 15:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B65E2F6565;
	Mon, 23 Feb 2026 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IUmEVtwM"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67CE2F1FEF
	for <linux-crypto@vger.kernel.org>; Mon, 23 Feb 2026 15:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771862294; cv=none; b=U62MBirfp9UazOgU0lX57QTfN826gWa57vwHiglxVJxKClajpyJTR+32PB5B71Mxdn4WeLg1EJfnvSY/zTJVDRQw7JJJwkYP2q1IA0pVjvhLbcm8vPU/qtR0Uh5aYVgcqAFMBk+EitnCXLPC8OcjLaDyULhyFW2b9I+6d+WgCHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771862294; c=relaxed/simple;
	bh=mQnuDEKWShZxHCAe3ZafiMoJtQlBKAfcOErwkIASlsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jBArTqZAfwIHVv4jtRl6cNi5/+jWG3pYyrV4OnAzd8u4AOEx4+0Bv2relQm7jQbXbQnnc6/rR3FUfeCNR0lV5t/Ryae6SZlR9SJGt+tuPXAEBCKuWS0rS4DKrcZhzKWnUgy1W++I1aPPB4qNGdrG2zcaNurWQ9qtxSvOfa38qtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IUmEVtwM; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771862288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HDCuQsJdgvN7tW2QCN8u4ujpqzhZbbHYre6HGExVag8=;
	b=IUmEVtwMzz2jn1gShMhiue1sI5aqaPZARoKVbocXcNWm9PGW2fbcBH2zG3U311p4gWNeXl
	VEYDt33spMT6wOMZPmgeFDLdm2ksBpnAS2ajY5hOPzMu2hWfK2dt95pOk0PGMTkRiqo3TK
	rfkv0Bgl8Oxchc+cAh0PrYXxJke4XxY=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Thara Gopinath <thara.gopinath@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-crypto@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: qce - Replace snprintf("%s") with strscpy
Date: Mon, 23 Feb 2026 16:57:55 +0100
Message-ID: <20260223155756.340931-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21072-lists,linux-crypto=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,gondor.apana.org.au,davemloft.net];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CE7D7179336
X-Rspamd-Action: no action

Replace snprintf("%s", ...) with the faster and more direct strscpy().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/qce/aead.c     | 6 +++---
 drivers/crypto/qce/sha.c      | 6 +++---
 drivers/crypto/qce/skcipher.c | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/crypto/qce/aead.c b/drivers/crypto/qce/aead.c
index 97b56e92ea33..1647d2329982 100644
--- a/drivers/crypto/qce/aead.c
+++ b/drivers/crypto/qce/aead.c
@@ -5,6 +5,7 @@
  */
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
+#include <linux/string.h>
 #include <crypto/gcm.h>
 #include <crypto/authenc.h>
 #include <crypto/internal/aead.h>
@@ -768,9 +769,8 @@ static int qce_aead_register_one(const struct qce_aead_def *def, struct qce_devi
 
 	alg = &tmpl->alg.aead;
 
-	snprintf(alg->base.cra_name, CRYPTO_MAX_ALG_NAME, "%s", def->name);
-	snprintf(alg->base.cra_driver_name, CRYPTO_MAX_ALG_NAME, "%s",
-		 def->drv_name);
+	strscpy(alg->base.cra_name, def->name);
+	strscpy(alg->base.cra_driver_name, def->drv_name);
 
 	alg->base.cra_blocksize		= def->blocksize;
 	alg->chunksize			= def->chunksize;
diff --git a/drivers/crypto/qce/sha.c b/drivers/crypto/qce/sha.c
index 71b748183cfa..87071f315088 100644
--- a/drivers/crypto/qce/sha.c
+++ b/drivers/crypto/qce/sha.c
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
+#include <linux/string.h>
 #include <crypto/internal/hash.h>
 
 #include "common.h"
@@ -489,9 +490,8 @@ static int qce_ahash_register_one(const struct qce_ahash_def *def,
 	base->cra_module = THIS_MODULE;
 	base->cra_init = qce_ahash_cra_init;
 
-	snprintf(base->cra_name, CRYPTO_MAX_ALG_NAME, "%s", def->name);
-	snprintf(base->cra_driver_name, CRYPTO_MAX_ALG_NAME, "%s",
-		 def->drv_name);
+	strscpy(base->cra_name, def->name);
+	strscpy(base->cra_driver_name, def->drv_name);
 
 	INIT_LIST_HEAD(&tmpl->entry);
 	tmpl->crypto_alg_type = CRYPTO_ALG_TYPE_AHASH;
diff --git a/drivers/crypto/qce/skcipher.c b/drivers/crypto/qce/skcipher.c
index ffb334eb5b34..b9a931037fdc 100644
--- a/drivers/crypto/qce/skcipher.c
+++ b/drivers/crypto/qce/skcipher.c
@@ -7,6 +7,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/moduleparam.h>
+#include <linux/string.h>
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <crypto/aes.h>
@@ -446,9 +447,8 @@ static int qce_skcipher_register_one(const struct qce_skcipher_def *def,
 
 	alg = &tmpl->alg.skcipher;
 
-	snprintf(alg->base.cra_name, CRYPTO_MAX_ALG_NAME, "%s", def->name);
-	snprintf(alg->base.cra_driver_name, CRYPTO_MAX_ALG_NAME, "%s",
-		 def->drv_name);
+	strscpy(alg->base.cra_name, def->name);
+	strscpy(alg->base.cra_driver_name, def->drv_name);
 
 	alg->base.cra_blocksize		= def->blocksize;
 	alg->chunksize			= def->chunksize;
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


