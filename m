Return-Path: <linux-crypto+bounces-13075-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B8EAB675B
	for <lists+linux-crypto@lfdr.de>; Wed, 14 May 2025 11:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B81113B7233
	for <lists+linux-crypto@lfdr.de>; Wed, 14 May 2025 09:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E034226161;
	Wed, 14 May 2025 09:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="YAAQd5uz"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8D62222D3
	for <linux-crypto@vger.kernel.org>; Wed, 14 May 2025 09:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747214562; cv=none; b=InK2rzh1vZpLN1w/wXSc8cMsaWo4+BlHhGqiOKzoJreEnMffwtUOQZVQOLEHPukDywRP7XEgMuJjf5AmwnufU8tfDtpFtklaTY/sgororC+0iQl+6xKyDDvvOQvVMCRWkrtTZ+cpDAxHFH1UxV11aEECzh+k80osd1eu+/D+4R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747214562; c=relaxed/simple;
	bh=HNUFdAheGCAS5fh5V6LRxONnz1VzpzJy+sd/x/eWalo=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=s5fMP31YpvnNNP6SXpw+9ed43fyCH++WmEuQpb6HpSILdEnYZBHDqn1rI7qQJ5h3r/MqqhhdfWv9xqZ//dvgWU9LpOYGQDMGd6eN1xMFhYu3mJcZosTz4irHhpZdHRgqREnHY6DsAt403EtNLR5fvYrkg5UURwfKqI/2euvfjsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=YAAQd5uz; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=To:Subject:From:References:In-Reply-To:Message-Id:Date:Sender:
	Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=SYMgHCMmudGW2BcUDR/0zlfomZn+xuLsKwhbmNfikB8=; b=YAAQd5uzhLOK8vnxg/njTLT99y
	leBM8JTJG4jTeHjFm5m7E0rQVJVzcxgyCsh8blivBZy8zinSAAHNaLehvzOBorUnZIcCCiO1n1sv6
	AarKcb60/pcUxwueWTMHmULEGPla9hMhvljtFkoFl82RZhZ1icgzAB7CCK1RUoK9ETR16Whxbtg1h
	FKmA6gmNfrWPWf3LFjxukc7o3vzTyI314ensDq8+5fFwoxO6EQfm+NQQO9G16vBmwLGpkp8A+4/gO
	o25qMb+mF+KXonTn1N0t9yMTEBPz3KgzaGkuV7vUzl8gb2gsNg8ZbGNXfLqk8CrKnXfPcFQjxlqAc
	VF5hKpPw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1uF8Jp-0060JQ-1W;
	Wed, 14 May 2025 17:22:30 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Wed, 14 May 2025 17:22:29 +0800
Date: Wed, 14 May 2025 17:22:29 +0800
Message-Id: <dd4c5c4165e0822f45f3d51a4a7e81c8617f3617.1747214319.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1747214319.git.herbert@gondor.apana.org.au>
References: <cover.1747214319.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v3 PATCH 01/11] crypto: hash - Move core export and import into
 internel/hash.h
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

The core export and import functions are targeted at implementors
so move them into internal/hash.h.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 include/crypto/hash.h          | 48 ----------------------------------
 include/crypto/internal/hash.h | 48 ++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/include/crypto/hash.h b/include/crypto/hash.h
index 1760662ad70a..9fc9daaaaab4 100644
--- a/include/crypto/hash.h
+++ b/include/crypto/hash.h
@@ -506,18 +506,6 @@ int crypto_ahash_digest(struct ahash_request *req);
  */
 int crypto_ahash_export(struct ahash_request *req, void *out);
 
-/**
- * crypto_ahash_export_core() - extract core state for message digest
- * @req: reference to the ahash_request handle whose state is exported
- * @out: output buffer of sufficient size that can hold the hash state
- *
- * Export the hash state without the partial block buffer.
- *
- * Context: Softirq or process context.
- * Return: 0 if the export creation was successful; < 0 if an error occurred
- */
-int crypto_ahash_export_core(struct ahash_request *req, void *out);
-
 /**
  * crypto_ahash_import() - import message digest state
  * @req: reference to ahash_request handle the state is imported into
@@ -531,18 +519,6 @@ int crypto_ahash_export_core(struct ahash_request *req, void *out);
  */
 int crypto_ahash_import(struct ahash_request *req, const void *in);
 
-/**
- * crypto_ahash_import_core() - import core state
- * @req: reference to ahash_request handle the state is imported into
- * @in: buffer holding the state
- *
- * Import the hash state without the partial block buffer.
- *
- * Context: Softirq or process context.
- * Return: 0 if the import was successful; < 0 if an error occurred
- */
-int crypto_ahash_import_core(struct ahash_request *req, const void *in);
-
 /**
  * crypto_ahash_init() - (re)initialize message digest handle
  * @req: ahash_request handle that already is initialized with all necessary
@@ -933,18 +909,6 @@ int crypto_hash_digest(struct crypto_ahash *tfm, const u8 *data,
  */
 int crypto_shash_export(struct shash_desc *desc, void *out);
 
-/**
- * crypto_shash_export_core() - extract core state for message digest
- * @desc: reference to the operational state handle whose state is exported
- * @out: output buffer of sufficient size that can hold the hash state
- *
- * Export the hash state without the partial block buffer.
- *
- * Context: Softirq or process context.
- * Return: 0 if the export creation was successful; < 0 if an error occurred
- */
-int crypto_shash_export_core(struct shash_desc *desc, void *out);
-
 /**
  * crypto_shash_import() - import operational state
  * @desc: reference to the operational state handle the state imported into
@@ -959,18 +923,6 @@ int crypto_shash_export_core(struct shash_desc *desc, void *out);
  */
 int crypto_shash_import(struct shash_desc *desc, const void *in);
 
-/**
- * crypto_shash_import_core() - import core state
- * @desc: reference to the operational state handle the state imported into
- * @in: buffer holding the state
- *
- * Import the hash state without the partial block buffer.
- *
- * Context: Softirq or process context.
- * Return: 0 if the import was successful; < 0 if an error occurred
- */
-int crypto_shash_import_core(struct shash_desc *desc, const void *in);
-
 /**
  * crypto_shash_init() - (re)initialize message digest
  * @desc: operational state handle that is already filled
diff --git a/include/crypto/internal/hash.h b/include/crypto/internal/hash.h
index f2bbdb74e11a..ef5ea75ac5c8 100644
--- a/include/crypto/internal/hash.h
+++ b/include/crypto/internal/hash.h
@@ -305,5 +305,53 @@ static inline unsigned int crypto_shash_coresize(struct crypto_shash *tfm)
 #define HASH_REQUEST_ZERO(name) \
 	memzero_explicit(__##name##_req, sizeof(__##name##_req))
 
+/**
+ * crypto_ahash_export_core() - extract core state for message digest
+ * @req: reference to the ahash_request handle whose state is exported
+ * @out: output buffer of sufficient size that can hold the hash state
+ *
+ * Export the hash state without the partial block buffer.
+ *
+ * Context: Softirq or process context.
+ * Return: 0 if the export creation was successful; < 0 if an error occurred
+ */
+int crypto_ahash_export_core(struct ahash_request *req, void *out);
+
+/**
+ * crypto_ahash_import_core() - import core state
+ * @req: reference to ahash_request handle the state is imported into
+ * @in: buffer holding the state
+ *
+ * Import the hash state without the partial block buffer.
+ *
+ * Context: Softirq or process context.
+ * Return: 0 if the import was successful; < 0 if an error occurred
+ */
+int crypto_ahash_import_core(struct ahash_request *req, const void *in);
+
+/**
+ * crypto_shash_export_core() - extract core state for message digest
+ * @desc: reference to the operational state handle whose state is exported
+ * @out: output buffer of sufficient size that can hold the hash state
+ *
+ * Export the hash state without the partial block buffer.
+ *
+ * Context: Softirq or process context.
+ * Return: 0 if the export creation was successful; < 0 if an error occurred
+ */
+int crypto_shash_export_core(struct shash_desc *desc, void *out);
+
+/**
+ * crypto_shash_import_core() - import core state
+ * @desc: reference to the operational state handle the state imported into
+ * @in: buffer holding the state
+ *
+ * Import the hash state without the partial block buffer.
+ *
+ * Context: Softirq or process context.
+ * Return: 0 if the import was successful; < 0 if an error occurred
+ */
+int crypto_shash_import_core(struct shash_desc *desc, const void *in);
+
 #endif	/* _CRYPTO_INTERNAL_HASH_H */
 
-- 
2.39.5


