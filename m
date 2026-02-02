Return-Path: <linux-crypto+bounces-20572-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KK+VBsotgWl6EgMAu9opvQ
	(envelope-from <linux-crypto+bounces-20572-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Feb 2026 00:05:46 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF37D294F
	for <lists+linux-crypto@lfdr.de>; Tue, 03 Feb 2026 00:05:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D9F2305595C
	for <lists+linux-crypto@lfdr.de>; Mon,  2 Feb 2026 23:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C89F35773F;
	Mon,  2 Feb 2026 23:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dKCLIIB7"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D8A357A25
	for <linux-crypto@vger.kernel.org>; Mon,  2 Feb 2026 23:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770073316; cv=none; b=fvx5rrAOPQF/MKWQchsgqxNLwkZ7FOaqydWburd4zot46BSU+nwtj2Zk0Bs/bWB9hJGwJ4Wjirx6BTSmCInWxpRYw52sw+WtAgDx4OWMhTFtJXrYyRblAe30gtTG5JOZN5nctg6ndU+tpRbivxgux0MTTzOXgji/tIKFSQ6F7F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770073316; c=relaxed/simple;
	bh=4HajR9oDzuyJDc1r4jBrfluaT9V3NPSsXOAaA8E2Bls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AjmLM8kEeHGP4h4EesRVFtT5Ft7ql8GR75ASrJ03Ooj+UmXhuld67G7b7jmWa9Lk5M2lxZTxwzzfAqs57JIbwyU+GNt4qMpH4Lhja/CcwNSelkt+eHgcnBB8FbprWPLAbT1skHCXHsQG0vnKJaorLaQ8uoJI5GHyPqjnup9KYUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dKCLIIB7; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770073302;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=p6ynb+zgPuGJeSWj6XPcxGqyQpSs9lMJOY2jclvij24=;
	b=dKCLIIB7U62knZoEnxjVd6xQUD2el0rxCOrCHAVUIPsjNCtpdqm+W4BE1MZ7k5FfELlO41
	CAq3moG0l9X4mnsnZPmhs2ussCpv1CIdVRCo6dx2G1Y6EE+C9CH9EW88Ab1TZANYqygnH5
	z7ddt5vIxHcNTgAn7SIdiXDDXLAPIW8=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: =?UTF-8?q?Horia=20Geant=C4=83?= <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Gaurav Jain <gaurav.jain@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: caam - Replace snprintf with strscpy in caam_hash_alloc
Date: Tue,  3 Feb 2026 00:01:17 +0100
Message-ID: <20260202230117.936865-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20572-lists,linux-crypto=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 6EF37D294F
X-Rspamd-Action: no action

Replace snprintf("%s", ...) with the faster and more direct strscpy().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/caam/caamalg_qi2.c | 13 +++++--------
 drivers/crypto/caam/caamhash.c    | 12 ++++--------
 2 files changed, 9 insertions(+), 16 deletions(-)

diff --git a/drivers/crypto/caam/caamalg_qi2.c b/drivers/crypto/caam/caamalg_qi2.c
index 107ccb2ade42..478ef597f33f 100644
--- a/drivers/crypto/caam/caamalg_qi2.c
+++ b/drivers/crypto/caam/caamalg_qi2.c
@@ -19,6 +19,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/fsl/mc.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <linux/string_choices.h>
 #include <soc/fsl/dpaa2-io.h>
 #include <soc/fsl/dpaa2-fd.h>
@@ -4644,16 +4645,12 @@ static struct caam_hash_alg *caam_hash_alloc(struct device *dev,
 	alg = &halg->halg.base;
 
 	if (keyed) {
-		snprintf(alg->cra_name, CRYPTO_MAX_ALG_NAME, "%s",
-			 template->hmac_name);
-		snprintf(alg->cra_driver_name, CRYPTO_MAX_ALG_NAME, "%s",
-			 template->hmac_driver_name);
+		strscpy(alg->cra_name, template->hmac_name);
+		strscpy(alg->cra_driver_name, template->hmac_driver_name);
 		t_alg->is_hmac = true;
 	} else {
-		snprintf(alg->cra_name, CRYPTO_MAX_ALG_NAME, "%s",
-			 template->name);
-		snprintf(alg->cra_driver_name, CRYPTO_MAX_ALG_NAME, "%s",
-			 template->driver_name);
+		strscpy(alg->cra_name, template->name);
+		strscpy(alg->cra_driver_name, template->driver_name);
 		t_alg->ahash_alg.setkey = NULL;
 		t_alg->is_hmac = false;
 	}
diff --git a/drivers/crypto/caam/caamhash.c b/drivers/crypto/caam/caamhash.c
index 25c02e267258..eeb444f8ba85 100644
--- a/drivers/crypto/caam/caamhash.c
+++ b/drivers/crypto/caam/caamhash.c
@@ -1913,16 +1913,12 @@ caam_hash_alloc(struct caam_hash_template *template,
 	alg = &halg->halg.base;
 
 	if (keyed) {
-		snprintf(alg->cra_name, CRYPTO_MAX_ALG_NAME, "%s",
-			 template->hmac_name);
-		snprintf(alg->cra_driver_name, CRYPTO_MAX_ALG_NAME, "%s",
-			 template->hmac_driver_name);
+		strscpy(alg->cra_name, template->hmac_name);
+		strscpy(alg->cra_driver_name, template->hmac_driver_name);
 		t_alg->is_hmac = true;
 	} else {
-		snprintf(alg->cra_name, CRYPTO_MAX_ALG_NAME, "%s",
-			 template->name);
-		snprintf(alg->cra_driver_name, CRYPTO_MAX_ALG_NAME, "%s",
-			 template->driver_name);
+		strscpy(alg->cra_name, template->name);
+		strscpy(alg->cra_driver_name, template->driver_name);
 		halg->setkey = NULL;
 		t_alg->is_hmac = false;
 	}
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


