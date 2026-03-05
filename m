Return-Path: <linux-crypto+bounces-21620-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO02FFLMqWl+FQEAu9opvQ
	(envelope-from <linux-crypto+bounces-21620-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 05 Mar 2026 19:32:50 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B07F216FE0
	for <lists+linux-crypto@lfdr.de>; Thu, 05 Mar 2026 19:32:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C62D5300E199
	for <lists+linux-crypto@lfdr.de>; Thu,  5 Mar 2026 18:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 848413E7162;
	Thu,  5 Mar 2026 18:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbfK0bah"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 463E63DA5A5
	for <linux-crypto@vger.kernel.org>; Thu,  5 Mar 2026 18:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772735561; cv=none; b=qTJ9kBs9qU3Mhi+4IvlkVomTp4JoBEkCy4eJz2fMImx8rSZBpfML20dAfMsLaueLigVU2HfJK1sHnoa0hFzsvD1FNO2zjnP2jmlnD0teX0n/Qpq4jT/B1WCLkYEJmD9v49MN/GswkPZ9bQjfKbr/9sw6jmh2lJ0DkDbEHpPDVIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772735561; c=relaxed/simple;
	bh=57VdQhKyrFy1IExHr+T2rSktoWweVK9HwyXpS1FzsRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mtTA+sEm0PFpAXEAtLH1VoZWH9SY9eD7AKExOGY4+27RXhKPZt7uns9Zfm3MdqMTSHktOnWQoGsNNOLuu2LfLGX9If6VvV9WpzwX3foO4/mx+ZAi7NOEFKX8SsaEAkRiTU2O1WVTpJYnxdsUWXF19NlJG3xM7tUHUPos4/h3OT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbfK0bah; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8296d553142so1276083b3a.3
        for <linux-crypto@vger.kernel.org>; Thu, 05 Mar 2026 10:32:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772735560; x=1773340360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4FzuoEEpRY+L14uQlsGmCRGMqZLXTc3G6agjBXy78yU=;
        b=bbfK0bah7BW8mhwg/MKqZJvTcjI72M1OgMVB/A61MSwn+nBpDxuKsvP3f/BYzNiO9P
         NRvRLlAQGMYd3Y8CEm20zQUwBWBg2GTKasgK+GgiIkeec3IBxZWz0MrtPE4AH3YXudcx
         nXAHc6GwObIQgWrXIu6LprxB0JuuHGFFzwVzaP+aZxJmrH0X5jDxD/jHXDD8A6c+RZTl
         UgiHnpB96Uef6Tjj/I+ZH0HwOFwmGIQpwPT8iZstKWTraby1FsoezcKyFkGn86E8mASe
         qRCdHDlSgmSRNOsMUwOxZLjAZnbuTFhsltHW5iQ+Se2tn2996llRmsqXArnanfQpd3at
         PiMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772735560; x=1773340360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4FzuoEEpRY+L14uQlsGmCRGMqZLXTc3G6agjBXy78yU=;
        b=FcFA7IAoTRSgS/VVvZyHD6FI3b/XLncgUVd4b5boJ666/D/SbftpLZ9zy2X9QdfTFY
         Svd9OC4fLros2icfED3ptlYn9OvZbuRbRPIP9nZ+UngK7J17NVWXFzAT7FmWtBCT4Kq/
         FufzmQSTZiRIMftg3wpQYVtf2VaF86ti4NO0j39H9ZcOROj9pwekfrMRMuL9MR5v9CY3
         tFPDv1N8GOCkov8qS5rAxt4wJaOuwC2Iqyk3NFqvSc1YXXLzPLZbB6V04BU1TQ8NyWPe
         /3KDCAPCOL1JZ8iGiun/h937byTx7dxGgEEPJU3lydrZ2eWpFX0ftPA1aYEy8uksni7j
         Qtjw==
X-Forwarded-Encrypted: i=1; AJvYcCX8TBsXKT+TjJni9TEMFKQTu0eQ30LvbRqXbXIlUsBbU3wB8lHWRckOTN1Umw+a8LG0OmxUs0MBu8XNLLs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxYkv5vq5WBoG8jIrIYaq67DuMqHWaJ67t45hoVBJXOHpOQRKl
	fkcFlltWu/DI739lYmLUIiCr3Q3ry5z3bW/ECSVOYeF/uOqpHLxIy8BP
X-Gm-Gg: ATEYQzzkiS9GrxoLvsdO0kjggIn/L3KykPO63QwMMQ/FNjaMmfWEzqKNmaM3Zs7fD5L
	4A4bq/bfCGUENDBy5OIz4S022f1uYMUkcn91QpYOvnXNB7JCMt1ex5gUbrseWwSH6LQ3gOyVLr4
	6+piJh7MslEGkMBwraxXHYq5lVs5MkLv5Q1ZDV1JeiG5m8SV4A8XAlzV+dNT4bIwOjCSnbVac4N
	e/3r6iXDewUPT+TJHGeAQTbJrtMcOyaKCdsGwh7XrhTbzQM1EoSMyYmj58B5cdiR23A8KPqmGXy
	zXQhRwNQ/bPCqGIlgaM4xCtiHB7Gqx3vJV7IdCMQxeafP8pXYEFZ8bnbNoFU4aaregiYsjyHq7S
	KQoD2OW3aTazGJmQvGKyXiHUHWFPfKYMUjruAMXtal5h68N50qRiqQsIx1QNx2P477avLTsHFht
	tde8YwMVPD1Bcg133ehS+96xPxf0FIYQ==
X-Received: by 2002:a05:6a00:2482:b0:829:7245:92f7 with SMTP id d2e1a72fcca58-8299aa203e0mr484415b3a.3.1772735559482;
        Thu, 05 Mar 2026 10:32:39 -0800 (PST)
Received: from arm-server.. ([2001:288:7001:2724:1a31:bfff:fe58:b622])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829898e1417sm2554420b3a.62.2026.03.05.10.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 10:32:39 -0800 (PST)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: herbert@gondor.apana.org.au,
	davem@davemloft.net,
	catalin.marinas@arm.com,
	will@kernel.org,
	linux-crypto@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 1/1] crypto: arm64/aes-neonbs - Move key expansion off the stack
Date: Fri,  6 Mar 2026 02:32:24 +0800
Message-ID: <20260305183229.150599-2-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260305183229.150599-1-yphbchou0911@gmail.com>
References: <20260305183229.150599-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3B07F216FE0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21620-lists,linux-crypto=lfdr.de];
	FREEMAIL_CC(0.00)[ccns.ncku.edu.tw,gmail.com];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yphbchou0911@gmail.com,linux-crypto@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

aesbs_setkey() and aesbs_cbc_ctr_setkey() trigger -Wframe-larger-than=
warnings due to struct crypto_aes_ctx being allocated on the stack,
causing the frame size to exceed 1024 bytes.

Allocate struct crypto_aes_ctx on the heap instead to reduce stack
usage. Use a goto-based cleanup path to ensure memzero_explicit() and
kfree() are always called.

Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
---
 arch/arm64/crypto/aes-neonbs-glue.c | 39 ++++++++++++++++++-----------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/arch/arm64/crypto/aes-neonbs-glue.c b/arch/arm64/crypto/aes-neonbs-glue.c
index cb87c8fc66b3..a24b66fd5cad 100644
--- a/arch/arm64/crypto/aes-neonbs-glue.c
+++ b/arch/arm64/crypto/aes-neonbs-glue.c
@@ -76,19 +76,25 @@ static int aesbs_setkey(struct crypto_skcipher *tfm, const u8 *in_key,
 			unsigned int key_len)
 {
 	struct aesbs_ctx *ctx = crypto_skcipher_ctx(tfm);
-	struct crypto_aes_ctx rk;
+	struct crypto_aes_ctx *rk;
 	int err;
 
-	err = aes_expandkey(&rk, in_key, key_len);
+	rk = kmalloc(sizeof(*rk), GFP_KERNEL);
+	if (!rk)
+		return -ENOMEM;
+
+	err = aes_expandkey(rk, in_key, key_len);
 	if (err)
-		return err;
+		goto out;
 
 	ctx->rounds = 6 + key_len / 4;
 
 	scoped_ksimd()
-		aesbs_convert_key(ctx->rk, rk.key_enc, ctx->rounds);
-
-	return 0;
+		aesbs_convert_key(ctx->rk, rk->key_enc, ctx->rounds);
+out:
+	memzero_explicit(rk, sizeof(*rk));
+	kfree(rk);
+	return err;
 }
 
 static int __ecb_crypt(struct skcipher_request *req,
@@ -133,22 +139,27 @@ static int aesbs_cbc_ctr_setkey(struct crypto_skcipher *tfm, const u8 *in_key,
 			    unsigned int key_len)
 {
 	struct aesbs_cbc_ctr_ctx *ctx = crypto_skcipher_ctx(tfm);
-	struct crypto_aes_ctx rk;
+	struct crypto_aes_ctx *rk;
 	int err;
 
-	err = aes_expandkey(&rk, in_key, key_len);
+	rk = kmalloc(sizeof(*rk), GFP_KERNEL);
+	if (!rk)
+		return -ENOMEM;
+
+	err = aes_expandkey(rk, in_key, key_len);
 	if (err)
-		return err;
+		goto out;
 
 	ctx->key.rounds = 6 + key_len / 4;
 
-	memcpy(ctx->enc, rk.key_enc, sizeof(ctx->enc));
+	memcpy(ctx->enc, rk->key_enc, sizeof(ctx->enc));
 
 	scoped_ksimd()
-		aesbs_convert_key(ctx->key.rk, rk.key_enc, ctx->key.rounds);
-	memzero_explicit(&rk, sizeof(rk));
-
-	return 0;
+		aesbs_convert_key(ctx->key.rk, rk->key_enc, ctx->key.rounds);
+out:
+	memzero_explicit(rk, sizeof(*rk));
+	kfree(rk);
+	return err;
 }
 
 static int cbc_encrypt(struct skcipher_request *req)
-- 
2.48.1


