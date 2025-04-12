Return-Path: <linux-crypto+bounces-11696-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6901DA86B16
	for <lists+linux-crypto@lfdr.de>; Sat, 12 Apr 2025 07:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F61C3B101E
	for <lists+linux-crypto@lfdr.de>; Sat, 12 Apr 2025 05:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 836FA18D626;
	Sat, 12 Apr 2025 05:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="SVlAdl9h"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D63176AB5
	for <linux-crypto@vger.kernel.org>; Sat, 12 Apr 2025 05:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744436224; cv=none; b=IXbML0Ge+L/uYOofxTmETRpq5Cyr8vaEwzoPBz29pa+K1Hvj7cVA9hoitQINRRjASKaUxJ/svOUUIPUHAQ60HvSJ8pQuxKdIh79vOm0GzEgrPxCtMbAbPs6sP0vn/L5Ve4Z/DFXp6qN1WC/MQNkse764ADQM2/FrjD1gI+FREDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744436224; c=relaxed/simple;
	bh=j/w6l3G++EwIOk1v9FiDf3WwPdLnk3iHe3hiSobUlZ4=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=pFBIqfeJ0YzDs0wQp6HVoX0m86F/qxL3m15JZqh118ob9ze7891D5Ms7cavguW2AiVL8UqhcAy/fdxSIjt2MYLzziwcSBZM1/HDIdgx96uhYJ1PnGx0eNaJ8sfhCZz4fw66JLlmMarG0zO5ysEBTcrverR/kqLJGbkGUC/W1C5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=SVlAdl9h; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=To:Subject:From:References:In-Reply-To:Message-Id:Date:Sender:
	Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=yZhJgE03Sch2msb9rK+bkOW1fyFR4wxITfMdC55IZMU=; b=SVlAdl9hO3mpJcZ33jYGA+evBN
	ahc0RSPFIGO49GkFuDBTc2+kGU6mJYptPejymA9B84nAGvkkUQut57yBG7XSZrz7zF2uc1WldtXH6
	A0Prx9nL09qUktYapZ/h3YSzqJ+37hJWeenFTMa8bXYZXXGKyWzCwJ94r6wgSuQT1nznhlhpAMdm0
	PCT2fXEBRZQqg9t8LcBTUy0n++fklW7BbRu+apCj/I3eJzhvZlNez7Xot5ctgEz/IvkuAIwB9dl0i
	v+KLfg251wp5e0VWV1zVcqwgiMxm/p8gcyUEvpKSaHvC9GyHURhTiaI3CKZbK/WM022ggSvBl5Y2k
	SyT9PdrA==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u3TY1-00F2sr-3C;
	Sat, 12 Apr 2025 13:36:59 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Sat, 12 Apr 2025 13:36:57 +0800
Date: Sat, 12 Apr 2025 13:36:57 +0800
Message-Id: <dc20c329dc3d061331b3dd6ee3ed722f70cbc099.1744436095.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1744436095.git.herbert@gondor.apana.org.au>
References: <cover.1744436095.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [v2 PATCH 4/5] Revert "crypto: tcrypt - Restore multibuffer ahash
 tests"
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

This reverts commit c664f034172705a75f3f8a0c409b9bf95b633093.

Remove the multibuffer ahash speed tests again.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 crypto/tcrypt.c | 231 ------------------------------------------------
 1 file changed, 231 deletions(-)

diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index 96f4a66be14c..879fc21dcc16 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -716,207 +716,6 @@ static inline int do_one_ahash_op(struct ahash_request *req, int ret)
 	return crypto_wait_req(ret, wait);
 }
 
-struct test_mb_ahash_data {
-	struct scatterlist sg[XBUFSIZE];
-	char result[64];
-	struct ahash_request *req;
-	struct crypto_wait wait;
-	char *xbuf[XBUFSIZE];
-};
-
-static inline int do_mult_ahash_op(struct test_mb_ahash_data *data, u32 num_mb,
-				   int *rc)
-{
-	int i, err;
-
-	/* Fire up a bunch of concurrent requests */
-	err = crypto_ahash_digest(data[0].req);
-
-	/* Wait for all requests to finish */
-	err = crypto_wait_req(err, &data[0].wait);
-	if (num_mb < 2)
-		return err;
-
-	for (i = 0; i < num_mb; i++) {
-		rc[i] = ahash_request_err(data[i].req);
-		if (rc[i]) {
-			pr_info("concurrent request %d error %d\n", i, rc[i]);
-			err = rc[i];
-		}
-	}
-
-	return err;
-}
-
-static int test_mb_ahash_jiffies(struct test_mb_ahash_data *data, int blen,
-				 int secs, u32 num_mb)
-{
-	unsigned long start, end;
-	int bcount;
-	int ret = 0;
-	int *rc;
-
-	rc = kcalloc(num_mb, sizeof(*rc), GFP_KERNEL);
-	if (!rc)
-		return -ENOMEM;
-
-	for (start = jiffies, end = start + secs * HZ, bcount = 0;
-	     time_before(jiffies, end); bcount++) {
-		ret = do_mult_ahash_op(data, num_mb, rc);
-		if (ret)
-			goto out;
-	}
-
-	pr_cont("%d operations in %d seconds (%llu bytes)\n",
-		bcount * num_mb, secs, (u64)bcount * blen * num_mb);
-
-out:
-	kfree(rc);
-	return ret;
-}
-
-static int test_mb_ahash_cycles(struct test_mb_ahash_data *data, int blen,
-				u32 num_mb)
-{
-	unsigned long cycles = 0;
-	int ret = 0;
-	int i;
-	int *rc;
-
-	rc = kcalloc(num_mb, sizeof(*rc), GFP_KERNEL);
-	if (!rc)
-		return -ENOMEM;
-
-	/* Warm-up run. */
-	for (i = 0; i < 4; i++) {
-		ret = do_mult_ahash_op(data, num_mb, rc);
-		if (ret)
-			goto out;
-	}
-
-	/* The real thing. */
-	for (i = 0; i < 8; i++) {
-		cycles_t start, end;
-
-		start = get_cycles();
-		ret = do_mult_ahash_op(data, num_mb, rc);
-		end = get_cycles();
-
-		if (ret)
-			goto out;
-
-		cycles += end - start;
-	}
-
-	pr_cont("1 operation in %lu cycles (%d bytes)\n",
-		(cycles + 4) / (8 * num_mb), blen);
-
-out:
-	kfree(rc);
-	return ret;
-}
-
-static void test_mb_ahash_speed(const char *algo, unsigned int secs,
-				struct hash_speed *speed, u32 num_mb)
-{
-	struct test_mb_ahash_data *data;
-	struct crypto_ahash *tfm;
-	unsigned int i, j, k;
-	int ret;
-
-	data = kcalloc(num_mb, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return;
-
-	tfm = crypto_alloc_ahash(algo, 0, 0);
-	if (IS_ERR(tfm)) {
-		pr_err("failed to load transform for %s: %ld\n",
-			algo, PTR_ERR(tfm));
-		goto free_data;
-	}
-
-	for (i = 0; i < num_mb; ++i) {
-		if (testmgr_alloc_buf(data[i].xbuf))
-			goto out;
-
-		crypto_init_wait(&data[i].wait);
-
-		data[i].req = ahash_request_alloc(tfm, GFP_KERNEL);
-		if (!data[i].req) {
-			pr_err("alg: hash: Failed to allocate request for %s\n",
-			       algo);
-			goto out;
-		}
-
-
-		if (i) {
-			ahash_request_set_callback(data[i].req, 0, NULL, NULL);
-			ahash_request_chain(data[i].req, data[0].req);
-		} else
-			ahash_request_set_callback(data[0].req, 0,
-						   crypto_req_done,
-						   &data[0].wait);
-
-		sg_init_table(data[i].sg, XBUFSIZE);
-		for (j = 0; j < XBUFSIZE; j++) {
-			sg_set_buf(data[i].sg + j, data[i].xbuf[j], PAGE_SIZE);
-			memset(data[i].xbuf[j], 0xff, PAGE_SIZE);
-		}
-	}
-
-	pr_info("\ntesting speed of multibuffer %s (%s)\n", algo,
-		get_driver_name(crypto_ahash, tfm));
-
-	for (i = 0; speed[i].blen != 0; i++) {
-		/* For some reason this only tests digests. */
-		if (speed[i].blen != speed[i].plen)
-			continue;
-
-		if (speed[i].blen > XBUFSIZE * PAGE_SIZE) {
-			pr_err("template (%u) too big for tvmem (%lu)\n",
-			       speed[i].blen, XBUFSIZE * PAGE_SIZE);
-			goto out;
-		}
-
-		if (klen)
-			crypto_ahash_setkey(tfm, tvmem[0], klen);
-
-		for (k = 0; k < num_mb; k++)
-			ahash_request_set_crypt(data[k].req, data[k].sg,
-						data[k].result, speed[i].blen);
-
-		pr_info("test%3u "
-			"(%5u byte blocks,%5u bytes per update,%4u updates): ",
-			i, speed[i].blen, speed[i].plen,
-			speed[i].blen / speed[i].plen);
-
-		if (secs) {
-			ret = test_mb_ahash_jiffies(data, speed[i].blen, secs,
-						    num_mb);
-			cond_resched();
-		} else {
-			ret = test_mb_ahash_cycles(data, speed[i].blen, num_mb);
-		}
-
-
-		if (ret) {
-			pr_err("At least one hashing failed ret=%d\n", ret);
-			break;
-		}
-	}
-
-out:
-	ahash_request_free(data[0].req);
-
-	for (k = 0; k < num_mb; ++k)
-		testmgr_free_buf(data[k].xbuf);
-
-	crypto_free_ahash(tfm);
-
-free_data:
-	kfree(data);
-}
-
 static int test_ahash_jiffies_digest(struct ahash_request *req, int blen,
 				     char *out, int secs)
 {
@@ -2584,36 +2383,6 @@ static int do_test(const char *alg, u32 type, u32 mask, int m, u32 num_mb)
 		test_ahash_speed("sm3", sec, generic_hash_speed_template);
 		if (mode > 400 && mode < 500) break;
 		fallthrough;
-	case 450:
-		test_mb_ahash_speed("sha1", sec, generic_hash_speed_template,
-				    num_mb);
-		if (mode > 400 && mode < 500) break;
-		fallthrough;
-	case 451:
-		test_mb_ahash_speed("sha256", sec, generic_hash_speed_template,
-				    num_mb);
-		if (mode > 400 && mode < 500) break;
-		fallthrough;
-	case 452:
-		test_mb_ahash_speed("sha512", sec, generic_hash_speed_template,
-				    num_mb);
-		if (mode > 400 && mode < 500) break;
-		fallthrough;
-	case 453:
-		test_mb_ahash_speed("sm3", sec, generic_hash_speed_template,
-				    num_mb);
-		if (mode > 400 && mode < 500) break;
-		fallthrough;
-	case 454:
-		test_mb_ahash_speed("streebog256", sec,
-				    generic_hash_speed_template, num_mb);
-		if (mode > 400 && mode < 500) break;
-		fallthrough;
-	case 455:
-		test_mb_ahash_speed("streebog512", sec,
-				    generic_hash_speed_template, num_mb);
-		if (mode > 400 && mode < 500) break;
-		fallthrough;
 	case 499:
 		break;
 
-- 
2.39.5


