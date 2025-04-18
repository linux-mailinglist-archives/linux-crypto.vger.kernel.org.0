Return-Path: <linux-crypto+bounces-11929-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B47A93064
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Apr 2025 05:01:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03E5A8E1E21
	for <lists+linux-crypto@lfdr.de>; Fri, 18 Apr 2025 03:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8C626982C;
	Fri, 18 Apr 2025 02:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="HHaZEYi4"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CA3269817
	for <linux-crypto@vger.kernel.org>; Fri, 18 Apr 2025 02:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744945184; cv=none; b=krxD80zKd30E4y0t6ilCqdMh6EtOXkrUPi1ZD2oupBMiCiuuEpb0hmV30xRLJcdu6xlVas8qtvsg9onx+XI6UIRJ07GWg1fAspzsLPY1XVbBBfhG09Gkwd39UmjFtu2hyaOzOBzWPHoQl2DDz8EwVFkbKtj9pkPwHQk2Y47R+1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744945184; c=relaxed/simple;
	bh=LJOfjFeRkKp52blstXNQ1dHwvt6qnDB2X/KFBTwkrig=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=Kbv9BPdmVupIOPXAyrz/yZgX5h0pQMqyHB3tsjZZkt4azsWrpnKa3WD+x2AxA7V4uUMq+Ez2ghOolusCaLNYdPMbw7ZqXW5LrNfwvVnvNXzjfuIAQr0YCB5BTAjQecw0aGLc11KythfMF3t1+unLWPBPvUAfNflfQZHw1LTf3RE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=HHaZEYi4; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=To:Subject:From:References:In-Reply-To:Message-Id:Date:Sender:
	Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2yJu6M9xxUocmxNuKAzeh261+YrPvwTvdf6L3Ez4IX4=; b=HHaZEYi44fdyVvQLSA1e2I+yrS
	myKDr5FqSqRNUuf/agvvr5d3B6BCiXq2sinDS3t1trbhni7yL1apPlIwgLELjg5IvhyTjeQvLCvXi
	mjL7skTmpd/mTqGpR7d+IAHq02abnqLt3aY4Q9QZGP2Ud2YpxKRfKcHhgTifm0653CZ39gGBmU9MM
	ATT5kBNIE54JnMLZ+8TVea7AB1zhETbDBWlVtTKVHKi7PAvEgD69R4fkU6ZLwbfUupwK5HjVhVzvc
	I21Cdbb2wesngdfiL0UDk7mux6jc2pRjdkd6F8UWLZ8hMq0lv+uBATStMExvN1J4nQeAMZvIssKZc
	Gj8FZB+Q==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u5bx4-00Ge88-34;
	Fri, 18 Apr 2025 10:59:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 18 Apr 2025 10:59:38 +0800
Date: Fri, 18 Apr 2025 10:59:38 +0800
Message-Id: <4c5d114839882369933401a83b1bc09bb25a8240.1744945025.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1744945025.git.herbert@gondor.apana.org.au>
References: <cover.1744945025.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v2 PATCH 26/67] crypto: sha1_base - Remove partial block helpers
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

Now that all sha1_base users have been converted to use the API
partial block handling, remove the partial block helpers.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 include/crypto/sha1_base.h | 61 --------------------------------------
 1 file changed, 61 deletions(-)

diff --git a/include/crypto/sha1_base.h b/include/crypto/sha1_base.h
index b23cfad18ce2..62701d136c79 100644
--- a/include/crypto/sha1_base.h
+++ b/include/crypto/sha1_base.h
@@ -31,44 +31,6 @@ static inline int sha1_base_init(struct shash_desc *desc)
 	return 0;
 }
 
-static inline int sha1_base_do_update(struct shash_desc *desc,
-				      const u8 *data,
-				      unsigned int len,
-				      sha1_block_fn *block_fn)
-{
-	struct sha1_state *sctx = shash_desc_ctx(desc);
-	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
-
-	sctx->count += len;
-
-	if (unlikely((partial + len) >= SHA1_BLOCK_SIZE)) {
-		int blocks;
-
-		if (partial) {
-			int p = SHA1_BLOCK_SIZE - partial;
-
-			memcpy(sctx->buffer + partial, data, p);
-			data += p;
-			len -= p;
-
-			block_fn(sctx, sctx->buffer, 1);
-		}
-
-		blocks = len / SHA1_BLOCK_SIZE;
-		len %= SHA1_BLOCK_SIZE;
-
-		if (blocks) {
-			block_fn(sctx, data, blocks);
-			data += blocks * SHA1_BLOCK_SIZE;
-		}
-		partial = 0;
-	}
-	if (len)
-		memcpy(sctx->buffer + partial, data, len);
-
-	return 0;
-}
-
 static inline int sha1_base_do_update_blocks(struct shash_desc *desc,
 					     const u8 *data,
 					     unsigned int len,
@@ -82,29 +44,6 @@ static inline int sha1_base_do_update_blocks(struct shash_desc *desc,
 	return remain;
 }
 
-static inline int sha1_base_do_finalize(struct shash_desc *desc,
-					sha1_block_fn *block_fn)
-{
-	const int bit_offset = SHA1_BLOCK_SIZE - sizeof(__be64);
-	struct sha1_state *sctx = shash_desc_ctx(desc);
-	__be64 *bits = (__be64 *)(sctx->buffer + bit_offset);
-	unsigned int partial = sctx->count % SHA1_BLOCK_SIZE;
-
-	sctx->buffer[partial++] = 0x80;
-	if (partial > bit_offset) {
-		memset(sctx->buffer + partial, 0x0, SHA1_BLOCK_SIZE - partial);
-		partial = 0;
-
-		block_fn(sctx, sctx->buffer, 1);
-	}
-
-	memset(sctx->buffer + partial, 0x0, bit_offset - partial);
-	*bits = cpu_to_be64(sctx->count << 3);
-	block_fn(sctx, sctx->buffer, 1);
-
-	return 0;
-}
-
 static inline int sha1_base_do_finup(struct shash_desc *desc,
 				     const u8 *src, unsigned int len,
 				     sha1_block_fn *block_fn)
-- 
2.39.5


