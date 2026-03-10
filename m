Return-Path: <linux-crypto+bounces-21768-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPBnJlzkr2lwdQIAu9opvQ
	(envelope-from <linux-crypto+bounces-21768-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Mar 2026 10:29:00 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E725C248664
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Mar 2026 10:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1302B301A29C
	for <lists+linux-crypto@lfdr.de>; Tue, 10 Mar 2026 09:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3004E43D4EF;
	Tue, 10 Mar 2026 09:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b="FGH/mSFO"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [180.181.231.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC48313E10
	for <linux-crypto@vger.kernel.org>; Tue, 10 Mar 2026 09:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.181.231.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773134923; cv=none; b=FRi7SVHFRbZhieYwe51st46eF5mAeyMoYIVYzdqszFJ3gv0btCHA3wAAylyM70BHxXhPW1naA9PWH+Xdfwm4h/pS2vp7lhbKy+NGfnpQ3sZHlAiGQpG/FeS9EoU5aPXeEziwAOyBRs+uwvscvHAtF3aRf/gCkwUXvhBjc5AIDDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773134923; c=relaxed/simple;
	bh=Iq+CMdj5TRyEMGx0pRH7GGi3ap8UCWNG8U4lvHHUY6E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OaOPj/ECCm8vJeO4Qd+SqdxxsquNtYRJsFKgWJknfMHSscmv4MEz9sl4uwWLM3MsGU+kI+1VpOC9xsJ/DFnIVGWLo7R9zo249QLXpD0djHrNTSIAfeCsI4Eff+HEwhM1aL+diXjqTChYlgE+hAy17+CSv4U56p4ConRgZwCAYBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=gondor.apana.org.au header.i=@gondor.apana.org.au header.b=FGH/mSFO; arc=none smtp.client-ip=180.181.231.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=gondor.apana.org.au; s=h01; h=Content-Type:MIME-Version:Message-ID:Subject:
	Cc:To:From:Date:cc:to:subject:message-id:date:from:content-type:in-reply-to:
	references:reply-to; bh=ngP83g0YvT//3KocYj6ICwrJLalxQCzr+AcdYQR6dMs=; b=FGH/m
	SFOcWZDbdcebEQ4SI7/UfNqWCde+/nWYSyVeCd5l0YJvs6AL0IplBJCzUn2RzquhxJSRxh675tMKm
	3jqaueidqcnkNuo+b6K0n1y4R26ZkSZXC+QAWRHtWVx5cM38gzGp61PoYXffOC73RM4SKS9XQdVFD
	DJYHlJmqildCUrHY2E1C0fxjjc/EDbgoMz4kvDUExqekKjrkjLxdTF+2rRs+p/2T/vWkOBQ7cQbHv
	yOvEa2m8+GaGWb0Irio7vtntcz/6/BATaMFpoOAjYbug7QSKz0LTU5tmNe348cMF34OEouehYVkxY
	nTKhb8uoaJzUA4gxtcFEJgNbfIULg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1vztO9-00D5wt-2Y;
	Tue, 10 Mar 2026 17:28:30 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 10 Mar 2026 18:28:29 +0900
Date: Tue, 10 Mar 2026 18:28:29 +0900
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
	Akhil R <akhilrajeev@nvidia.com>
Cc: Guangwu Zhang <guazhang@redhat.com>
Subject: [PATCH] crypto: tegra - Disable softirqs before finalizing request
Message-ID: <aa_kPXrFeOmhydP6@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: E725C248664
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[gondor.apana.org.au:?];
	TAGGED_FROM(0.00)[bounces-21768-lists,linux-crypto=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	R_DKIM_TEMPFAIL(0.00)[gondor.apana.org.au:s=h01];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[herbert@gondor.apana.org.au,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_DNSFAIL(0.00)[apana.org.au : SPF/DKIM temp error,quarantine];
	NEURAL_HAM(-0.00)[-0.906];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,apana.org.au:url,apana.org.au:email]
X-Rspamd-Action: no action

Softirqs must be disabled when calling the finalization fucntion on
a request.

Reported-by: Guangwu Zhang <guazhang@redhat.com>
Fixes: 0880bb3b00c8 ("crypto: tegra - Add Tegra Security Engine driver")
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/drivers/crypto/tegra/tegra-se-aes.c b/drivers/crypto/tegra/tegra-se-aes.c
index 0e07d0523291..8b91f00b9c31 100644
--- a/drivers/crypto/tegra/tegra-se-aes.c
+++ b/drivers/crypto/tegra/tegra-se-aes.c
@@ -4,6 +4,7 @@
  * Crypto driver to handle block cipher algorithms using NVIDIA Security Engine.
  */
 
+#include <linux/bottom_half.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
@@ -333,7 +334,9 @@ static int tegra_aes_do_one_req(struct crypto_engine *engine, void *areq)
 		tegra_key_invalidate_reserved(ctx->se, key2_id, ctx->alg);
 
 out_finalize:
+	local_bh_disable();
 	crypto_finalize_skcipher_request(se->engine, req, ret);
+	local_bh_enable();
 
 	return 0;
 }
@@ -1261,7 +1264,9 @@ static int tegra_ccm_do_one_req(struct crypto_engine *engine, void *areq)
 		tegra_key_invalidate_reserved(ctx->se, rctx->key_id, ctx->alg);
 
 out_finalize:
+	local_bh_disable();
 	crypto_finalize_aead_request(ctx->se->engine, req, ret);
+	local_bh_enable();
 
 	return 0;
 }
@@ -1347,7 +1352,9 @@ static int tegra_gcm_do_one_req(struct crypto_engine *engine, void *areq)
 		tegra_key_invalidate_reserved(ctx->se, rctx->key_id, ctx->alg);
 
 out_finalize:
+	local_bh_disable();
 	crypto_finalize_aead_request(ctx->se->engine, req, ret);
+	local_bh_enable();
 
 	return 0;
 }
@@ -1745,7 +1752,9 @@ static int tegra_cmac_do_one_req(struct crypto_engine *engine, void *areq)
 	if (tegra_key_is_reserved(rctx->key_id))
 		tegra_key_invalidate_reserved(ctx->se, rctx->key_id, ctx->alg);
 
+	local_bh_disable();
 	crypto_finalize_hash_request(se->engine, req, ret);
+	local_bh_enable();
 
 	return 0;
 }
diff --git a/drivers/crypto/tegra/tegra-se-hash.c b/drivers/crypto/tegra/tegra-se-hash.c
index 4a298ace6e9f..79f1e5c9b729 100644
--- a/drivers/crypto/tegra/tegra-se-hash.c
+++ b/drivers/crypto/tegra/tegra-se-hash.c
@@ -4,6 +4,7 @@
  * Crypto driver to handle HASH algorithms using NVIDIA Security Engine.
  */
 
+#include <linux/bottom_half.h>
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/module.h>
@@ -546,7 +547,9 @@ static int tegra_sha_do_one_req(struct crypto_engine *engine, void *areq)
 	}
 
 out:
+	local_bh_disable();
 	crypto_finalize_hash_request(se->engine, req, ret);
+	local_bh_enable();
 
 	return 0;
 }
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

