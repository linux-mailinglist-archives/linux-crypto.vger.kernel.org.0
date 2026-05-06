Return-Path: <linux-crypto+bounces-23782-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CKfKVEI+2mbVQMAu9opvQ
	(envelope-from <linux-crypto+bounces-23782-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 06 May 2026 11:22:25 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FE14D88B6
	for <lists+linux-crypto@lfdr.de>; Wed, 06 May 2026 11:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 12F2A300D920
	for <lists+linux-crypto@lfdr.de>; Wed,  6 May 2026 09:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C299F3E1D01;
	Wed,  6 May 2026 09:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pNKKtZYr"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9592DCC05
	for <linux-crypto@vger.kernel.org>; Wed,  6 May 2026 09:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778059333; cv=none; b=qLC+iibpHbLUOtafsHsmyBoOLq0NNx74czepnAFokeZlj3hcGgSu0sccuBsplDG06TFIhpkr16AIH9rFzSY+NsBKeh/TBvnKA1aR8XWdNrDnxvq9C6x++/5HTUZCBo1CNVMGBzn611xEXE5IhJaIwr/v/TnGGPe0Y/7dWEDUyhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778059333; c=relaxed/simple;
	bh=WkhCFJDl883MO/1RcZGgw4sTRNkifsCKxG+xVSTGCJI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cb9tvQMjOjiUhNVepez8JiFM01PorcqpfupK01O/63RxBpJyt56LzcIaXMCH6JlzmgooC0dsT4lqjmg3IoG43UoSpvNoo6hlYEDJJcoBNznNwHb0c2RcdnOZMGU8zkOhrfKvL5te0UDWGCtddN1HLwP3MfAdE91D5Gqb0wAsWwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pNKKtZYr; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778059319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=FiFTsq2CQ/vsjTzti+pUgVVeWbQ34bGg8rF6uGxZIKc=;
	b=pNKKtZYrd0wcwUuaKGl5czy/Qp1UmqS81HdGyh5IYPLmIAIEP8UV1JixO3GGdZEQUEt6ve
	A3c7VppGBI3YYt0M9ZssfnHyafqjYpb5nGTXDP9e67oaig3LbetjUnvgENOUfON+XsADy8
	0L1Z3tbEAHU2OwZEuqJd05SgTF9uZbE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Gilad Ben-Yossef <gilad@benyossef.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: ccree - replace snprintf("%s") with strscpy
Date: Wed,  6 May 2026 11:21:51 +0200
Message-ID: <20260506092150.177660-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3811; i=thorsten.blum@linux.dev; h=from:subject; bh=WkhCFJDl883MO/1RcZGgw4sTRNkifsCKxG+xVSTGCJI=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJm/OfTfXH6VNz/XySrurceEXduuJLBuei/7Wbq112yO/ l2hjbeWdpSyMIhxMciKKbI8mPVjhm9pTeUmk4idMHNYmUCGMHBxCsBEvLUZGd5efOAwb1X3Z6tA G6nLPOXJjy4t9J+d47fR+mlP6ofHR1kY/rv2vFyxgFP+/Npnmnn3AstfTlvmmL6ht3TV5tBnt3c aMXAAAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 18FE14D88B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23782-lists,linux-crypto=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]

Replace snprintf("%s") with the faster and more direct strscpy().

In cc_aead.c, group the includes while at it.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/ccree/cc_aead.c   |  9 ++++-----
 drivers/crypto/ccree/cc_cipher.c |  7 +++----
 drivers/crypto/ccree/cc_hash.c   | 13 +++++--------
 3 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/drivers/crypto/ccree/cc_aead.c b/drivers/crypto/ccree/cc_aead.c
index 81533681f7fb..088c4603047f 100644
--- a/drivers/crypto/ccree/cc_aead.c
+++ b/drivers/crypto/ccree/cc_aead.c
@@ -3,11 +3,12 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/rtnetlink.h>
+#include <linux/string.h>
 #include <crypto/algapi.h>
 #include <crypto/internal/aead.h>
 #include <crypto/authenc.h>
 #include <crypto/gcm.h>
-#include <linux/rtnetlink.h>
 #include <crypto/internal/des.h>
 #include "cc_driver.h"
 #include "cc_buffer_mgr.h"
@@ -2569,11 +2570,9 @@ static struct cc_crypto_alg *cc_create_aead_alg(struct cc_alg_template *tmpl,
 
 	alg = &tmpl->template_aead;
 
-	if (snprintf(alg->base.cra_name, CRYPTO_MAX_ALG_NAME, "%s",
-		     tmpl->name) >= CRYPTO_MAX_ALG_NAME)
+	if (strscpy(alg->base.cra_name, tmpl->name) < 0)
 		return ERR_PTR(-EINVAL);
-	if (snprintf(alg->base.cra_driver_name, CRYPTO_MAX_ALG_NAME, "%s",
-		     tmpl->driver_name) >= CRYPTO_MAX_ALG_NAME)
+	if (strscpy(alg->base.cra_driver_name, tmpl->driver_name) < 0)
 		return ERR_PTR(-EINVAL);
 
 	alg->base.cra_module = THIS_MODULE;
diff --git a/drivers/crypto/ccree/cc_cipher.c b/drivers/crypto/ccree/cc_cipher.c
index e2cbfdf7a0e4..5339b3796c80 100644
--- a/drivers/crypto/ccree/cc_cipher.c
+++ b/drivers/crypto/ccree/cc_cipher.c
@@ -3,6 +3,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/string.h>
 #include <crypto/algapi.h>
 #include <crypto/internal/skcipher.h>
 #include <crypto/internal/des.h>
@@ -1386,11 +1387,9 @@ static struct cc_crypto_alg *cc_create_alg(const struct cc_alg_template *tmpl,
 
 	memcpy(alg, &tmpl->template_skcipher, sizeof(*alg));
 
-	if (snprintf(alg->base.cra_name, CRYPTO_MAX_ALG_NAME, "%s",
-		     tmpl->name) >= CRYPTO_MAX_ALG_NAME)
+	if (strscpy(alg->base.cra_name, tmpl->name) < 0)
 		return ERR_PTR(-EINVAL);
-	if (snprintf(alg->base.cra_driver_name, CRYPTO_MAX_ALG_NAME, "%s",
-		     tmpl->driver_name) >= CRYPTO_MAX_ALG_NAME)
+	if (strscpy(alg->base.cra_driver_name, tmpl->driver_name) < 0)
 		return ERR_PTR(-EINVAL);
 
 	alg->base.cra_module = THIS_MODULE;
diff --git a/drivers/crypto/ccree/cc_hash.c b/drivers/crypto/ccree/cc_hash.c
index c6d085c8ff79..e090692e4371 100644
--- a/drivers/crypto/ccree/cc_hash.c
+++ b/drivers/crypto/ccree/cc_hash.c
@@ -3,6 +3,7 @@
 
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/string.h>
 #include <crypto/algapi.h>
 #include <crypto/hash.h>
 #include <crypto/md5.h>
@@ -1834,16 +1835,12 @@ static struct cc_hash_alg *cc_alloc_hash_alg(struct cc_hash_template *template,
 	alg = &halg->halg.base;
 
 	if (keyed) {
-		snprintf(alg->cra_name, CRYPTO_MAX_ALG_NAME, "%s",
-			 template->mac_name);
-		snprintf(alg->cra_driver_name, CRYPTO_MAX_ALG_NAME, "%s",
-			 template->mac_driver_name);
+		strscpy(alg->cra_name, template->mac_name);
+		strscpy(alg->cra_driver_name, template->mac_driver_name);
 	} else {
 		halg->setkey = NULL;
-		snprintf(alg->cra_name, CRYPTO_MAX_ALG_NAME, "%s",
-			 template->name);
-		snprintf(alg->cra_driver_name, CRYPTO_MAX_ALG_NAME, "%s",
-			 template->driver_name);
+		strscpy(alg->cra_name, template->name);
+		strscpy(alg->cra_driver_name, template->driver_name);
 	}
 	alg->cra_module = THIS_MODULE;
 	alg->cra_ctxsize = sizeof(struct cc_hash_ctx) + crypto_dma_padding();

