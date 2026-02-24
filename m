Return-Path: <linux-crypto+bounces-21097-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFAGITcdnWmuMwQAu9opvQ
	(envelope-from <linux-crypto+bounces-21097-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 24 Feb 2026 04:38:31 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 268E91816E1
	for <lists+linux-crypto@lfdr.de>; Tue, 24 Feb 2026 04:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9BFA83038AF1
	for <lists+linux-crypto@lfdr.de>; Tue, 24 Feb 2026 03:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 040D22571DD;
	Tue, 24 Feb 2026 03:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6HjcWEc"
X-Original-To: linux-crypto@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00C11DFDB8
	for <linux-crypto@vger.kernel.org>; Tue, 24 Feb 2026 03:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771904308; cv=none; b=GQSV9sIofLin/guSnvk5a/22BWiYGRXuJNwDWOX1F34G3fDpWj6bfqgW/AWMMyCw9+bX3k0MyxzXZf3Fj6KMObf/j4ndd+PALhPxr5EOhupFa5EW5B7MjbnMwi+oTCArlh89sLo3vR5xJc6v92aoVmFKahdwnBcj8wprLyhH3Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771904308; c=relaxed/simple;
	bh=AQ7wRpa7ObzMbfwHrvhqO2GcUse26RCo0EiVjbu8bMg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oTgKMfzrbJHi/OeHrLqhnhrSL7tN+FPt5LUPjO1LYiIfwxH+begZtIvo6BpAvCF2njcBbRxfykDpStINso/LPjDVzpPwIzckIqe1+faFtEpGbJzjsUuVX4wNSmo0O8tmlxSlM9Ao9sPJlUrygDefJPagMt5XXdWvo4Gouo61wYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6HjcWEc; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-823c56765fdso2247325b3a.1
        for <linux-crypto@vger.kernel.org>; Mon, 23 Feb 2026 19:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771904307; x=1772509107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G0vDFPJrpp4pp3C40ZUyENH/CeuoltgNbPtbXe2UeWk=;
        b=N6HjcWEcyi9YyrJmVFArEoVVuDPTo0X0mqSGeNGq76XWH5TgOidKcJRnC17spSyOJz
         8VNHRUmaGjneQkihRL76nQDSjOObl7kw3cimtVRmDHRVW714i9/31khdiahrVuLwBzyz
         Im3DS/qtGkh8BWfzJx0ZuVPdtI9Yiu1oz/gng9XhaslX/Tx9mkQeqpFajmQHqryKNnDF
         mOYB3fmaOGK9/Sox5A51z1EZsTC8VkZIXAxV9SrnvknW/waE2JZNTzwod9915WfDHia7
         B1FKzrBcVjWMPTx+JVq1OC+80Yd2GVUqTkD8iFfeuxV56U+O737O9IIXT6CeBEykCVEI
         cYTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771904307; x=1772509107;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0vDFPJrpp4pp3C40ZUyENH/CeuoltgNbPtbXe2UeWk=;
        b=AwTzf3BxHMU9FdstgxPvasls4UfL21rmFpRkUEjCpCiNm6WjZajtxkzrYpKFFkg87O
         Kor+2hcHWvlNi3VjpSXgm3N+/QesoboP3ex0M2ch25T63pZzZphbOnENVnpWRIlPW8K1
         gp5WczoKPsbkHtSEI00LuGB0hIU7ywIGuzcFliYqv9BIXDuwj/PUEu4QkJvQsFyelpvX
         Y5TcnwWwjlDbTFMYusOAXN62GsxCCeZQlS70hCFEU0aGsus646qVC/e6B7s41IQbfv/8
         HI8gRQiBUMUk3EGPRoDq08WhLU/dmG1htMacnMxC7G5Co5s/2fF7FABGxZej2mR+cdsO
         YrjA==
X-Gm-Message-State: AOJu0YxKwMHsiLdexnNeqwroCObyV1K8FhnuZg9dEAztpkqabNyxIrTs
	o6otxRPFHz2N+q1ApJeXuUss8gaLWybASE286haGtYM6WV8znyCy6C7E
X-Gm-Gg: ATEYQzwRlWNKPoSqzC+0+UpCYBzWRSXrmg1AuW/TdeXthL7lvHDEtuQf6iaahiIdzLV
	o7c177+aIdOFjeOeZe4WeJE9gkenBC1of2HASlJ6p5+Ri2pA5A8TQA9aEpfK+sAkJ67+Xi0/FpL
	YQ9wudKniVv9l/ZbSESzSxjseTW4pTsY6pQY3V4ClhlI5/bDcLcndb/o6scxyUjyBkikYo+G5PJ
	hEM1DHHERMOWd7UbZKXrrmN2KsDoTM3PgIA6uefuHwZYTwna3OlabG7HWY5zBQLkDt2DXz8sIMS
	KQ4xFO3LYydw4IkPDdzCO5b2FTLYdWKZUgALoNpfRApLWKYL/I1We5IA9rGuSeUJGJas/VFam2M
	4m6T8pgDI2QMri/oaWlYS2rTWnwzGCBBk0lJcVY1q4AcqAntPkWVrbLLDtMfmHV6t1CxJrLcax3
	joQM12KHT2A9ydj6pOxJKrbIfxObs=
X-Received: by 2002:a05:6a00:ad5:b0:81f:3fbd:ccf with SMTP id d2e1a72fcca58-826da8f1917mr8610672b3a.23.1771904306887;
        Mon, 23 Feb 2026 19:38:26 -0800 (PST)
Received: from archlinux ([2408:8340:a622:6ad0:e841:fcfd:4323:9565])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd694eecsm8762520b3a.25.2026.02.23.19.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 19:38:26 -0800 (PST)
From: Sun Chaobo <suncoding913@gmail.com>
To: herbert@gondor.apana.org.au
Cc: linux-crypto@vger.kernel.org,
	Sun Chaobo <suncoding913@gmail.com>
Subject: [PATCH]  crypto: fix spelling errors in comments
Date: Tue, 24 Feb 2026 11:37:56 +0800
Message-ID: <20260224033756.78693-1-suncoding913@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21097-lists,linux-crypto=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suncoding913@gmail.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-crypto];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 268E91816E1
X-Rspamd-Action: no action

Fix several spelling mistakes in comments across the following files:

- crypto/tcrypt.c: Correct "intentionaly" to "intentionally"
- crypto/xts.c: Correct "mutliple" to "multiple"

No functional change.

Signed-off-by: Sun Chaobo <suncoding913@gmail.com>
---
 crypto/tcrypt.c | 2 +-
 crypto/xts.c    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/crypto/tcrypt.c b/crypto/tcrypt.c
index aded37546..6374c86a1 100644
--- a/crypto/tcrypt.c
+++ b/crypto/tcrypt.c
@@ -2817,7 +2817,7 @@ static int __init tcrypt_mod_init(void)
 		pr_debug("all tests passed\n");
 	}
 
-	/* We intentionaly return -EAGAIN to prevent keeping the module,
+	/* We intentionally return -EAGAIN to prevent keeping the module,
 	 * unless we're running in fips mode. It does all its work from
 	 * init() and doesn't offer any runtime functionality, but in
 	 * the fips case, checking for a successful load is helpful.
diff --git a/crypto/xts.c b/crypto/xts.c
index 3da8f5e05..ad97c8091 100644
--- a/crypto/xts.c
+++ b/crypto/xts.c
@@ -76,7 +76,7 @@ static int xts_setkey(struct crypto_skcipher *parent, const u8 *key,
 /*
  * We compute the tweak masks twice (both before and after the ECB encryption or
  * decryption) to avoid having to allocate a temporary buffer and/or make
- * mutliple calls to the 'ecb(..)' instance, which usually would be slower than
+ * multiple calls to the 'ecb(..)' instance, which usually would be slower than
  * just doing the gf128mul_x_ble() calls again.
  */
 static int xts_xor_tweak(struct skcipher_request *req, bool second_pass,
-- 
2.53.0


