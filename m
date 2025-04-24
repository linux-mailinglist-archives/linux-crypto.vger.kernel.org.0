Return-Path: <linux-crypto+bounces-12244-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BC15A9AAE7
	for <lists+linux-crypto@lfdr.de>; Thu, 24 Apr 2025 12:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C8A14A1602
	for <lists+linux-crypto@lfdr.de>; Thu, 24 Apr 2025 10:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BFC722DF8D;
	Thu, 24 Apr 2025 10:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b="WsXXVa4o"
X-Original-To: linux-crypto@vger.kernel.org
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C763223DC6
	for <linux-crypto@vger.kernel.org>; Thu, 24 Apr 2025 10:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.6.53.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745491647; cv=none; b=ViLSJkI4lr0iu78+CkzDY1cng+oRCjwCK3vfN1W1F2sQPnXnTmKFBeMEU+0bn0ZWAM8aGvzuG/L5t80wRY1fh/82TAqyw4WeO/9X5+StmBW12MCjS8LqIDAq4mA/xAavzSoW0kEe+xqWxXx5vzKFnrIDE9wN/Q9zZNKvMtwQz8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745491647; c=relaxed/simple;
	bh=CBRU/eGA6+8aaYxf0VrvEFjY5A+UA/Fgt8K/oBY8J2s=;
	h=Date:Message-Id:In-Reply-To:References:From:Subject:To; b=U8JJJ8DqZqZUXYdFf6K3LtW1YL2Rq8vmQWzl4tBu7Ue5NxhaWSG9dPi0WrknB6kcUPerK/Ba9Ye5XOFO3Xauq78fHNa85Xm2TajlTUVUq8K4q4MCqQHXWC+VxCWvSK1WfmvjOTGi7mDNRqHh9P5A1imtWNC4CY9XBvrmH0ZiBeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au; spf=pass smtp.mailfrom=gondor.apana.org.au; dkim=pass (2048-bit key) header.d=hmeau.com header.i=@hmeau.com header.b=WsXXVa4o; arc=none smtp.client-ip=144.6.53.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gondor.apana.org.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gondor.apana.org.au
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com;
	s=formenos; h=To:Subject:From:References:In-Reply-To:Message-Id:Date:Sender:
	Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=c6GpcTkVft1TAZ051ptj2wdqaG8QtNQc6h/yaPSV8Dw=; b=WsXXVa4oTgdyU1qTwujYJWwm7Q
	E9ox/uMaLYS0qxq+ud9lDr3LlsFEh7EIZ92d+i4MUjqSwWIsaPTLXE1Wg877Z47o/iOl8DSD9RLgY
	uE6vVW6dfAcI/L7jRPqoapYdIQuQH+c5PZAoMXlHlJNG14cx2//LFqmkCmPNwmtE3K7uoSSemhoaD
	cg570t/DfwKSlnLesAND6759y/hdHHo/p5Uhs7lB5mVm6xZj1BLp3rr1tPYe2ZFUKx912UDA4M6yM
	S0HIjbK3WIDeEMSXyql5juFfuENERpE5ZL3F+t/VG8p2zmqgMfplcy5qEpiXWOZMRBdJ/Oj6v4PMx
	lQ/vi6lw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
	by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
	id 1u7u6z-000fNZ-1v;
	Thu, 24 Apr 2025 18:47:22 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 24 Apr 2025 18:47:21 +0800
Date: Thu, 24 Apr 2025 18:47:21 +0800
Message-Id: <82fa7de99e3cff9935673912f0f1b774e210c7de.1745490652.git.herbert@gondor.apana.org.au>
In-Reply-To: <cover.1745490652.git.herbert@gondor.apana.org.au>
References: <cover.1745490652.git.herbert@gondor.apana.org.au>
From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 11/15] crypto: testmgr/poly1305 - Use setkey on poly1305
To: Linux Crypto Mailing List <linux-crypto@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

Use the new setkey interface for poly1305 instead of supplying
the key via the first two blocks.

Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
---
 crypto/testmgr.h | 112 ++++++++++++++++++++++++++---------------------
 1 file changed, 62 insertions(+), 50 deletions(-)

diff --git a/crypto/testmgr.h b/crypto/testmgr.h
index afc10af59b0a..09db05b90b5c 100644
--- a/crypto/testmgr.h
+++ b/crypto/testmgr.h
@@ -8842,6 +8842,11 @@ static const struct hash_testvec hmac_sha3_512_tv_template[] = {
 
 static const struct hash_testvec poly1305_tv_template[] = {
 	{ /* Test Vector #1 */
+		.key		= "\x00\x00\x00\x00\x00\x00\x00\x00"
+				  "\x00\x00\x00\x00\x00\x00\x00\x00"
+				  "\x00\x00\x00\x00\x00\x00\x00\x00"
+				  "\x00\x00\x00\x00\x00\x00\x00\x00",
+		.ksize		= 32,
 		.plaintext	= "\x00\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00"
@@ -8849,20 +8854,17 @@ static const struct hash_testvec poly1305_tv_template[] = {
 				  "\x00\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00"
-				  "\x00\x00\x00\x00\x00\x00\x00\x00"
-				  "\x00\x00\x00\x00\x00\x00\x00\x00"
-				  "\x00\x00\x00\x00\x00\x00\x00\x00"
-				  "\x00\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00",
-		.psize		= 96,
+		.psize		= 64,
 		.digest		= "\x00\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00",
 	}, { /* Test Vector #2 */
-		.plaintext	= "\x00\x00\x00\x00\x00\x00\x00\x00"
+		.key		= "\x00\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00"
 				  "\x36\xe5\xf6\xb5\xc5\xe0\x60\x70"
-				  "\xf0\xef\xca\x96\x22\x7a\x86\x3e"
-				  "\x41\x6e\x79\x20\x73\x75\x62\x6d"
+				  "\xf0\xef\xca\x96\x22\x7a\x86\x3e",
+		.ksize		= 32,
+		.plaintext	= "\x41\x6e\x79\x20\x73\x75\x62\x6d"
 				  "\x69\x73\x73\x69\x6f\x6e\x20\x74"
 				  "\x6f\x20\x74\x68\x65\x20\x49\x45"
 				  "\x54\x46\x20\x69\x6e\x74\x65\x6e"
@@ -8909,15 +8911,16 @@ static const struct hash_testvec poly1305_tv_template[] = {
 				  "\x20\x77\x68\x69\x63\x68\x20\x61"
 				  "\x72\x65\x20\x61\x64\x64\x72\x65"
 				  "\x73\x73\x65\x64\x20\x74\x6f",
-		.psize		= 407,
+		.psize		= 375,
 		.digest		= "\x36\xe5\xf6\xb5\xc5\xe0\x60\x70"
 				  "\xf0\xef\xca\x96\x22\x7a\x86\x3e",
 	}, { /* Test Vector #3 */
-		.plaintext	= "\x36\xe5\xf6\xb5\xc5\xe0\x60\x70"
+		.key		= "\x36\xe5\xf6\xb5\xc5\xe0\x60\x70"
 				  "\xf0\xef\xca\x96\x22\x7a\x86\x3e"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00"
-				  "\x00\x00\x00\x00\x00\x00\x00\x00"
-				  "\x41\x6e\x79\x20\x73\x75\x62\x6d"
+				  "\x00\x00\x00\x00\x00\x00\x00\x00",
+		.ksize		= 32,
+		.plaintext	= "\x41\x6e\x79\x20\x73\x75\x62\x6d"
 				  "\x69\x73\x73\x69\x6f\x6e\x20\x74"
 				  "\x6f\x20\x74\x68\x65\x20\x49\x45"
 				  "\x54\x46\x20\x69\x6e\x74\x65\x6e"
@@ -8964,15 +8967,16 @@ static const struct hash_testvec poly1305_tv_template[] = {
 				  "\x20\x77\x68\x69\x63\x68\x20\x61"
 				  "\x72\x65\x20\x61\x64\x64\x72\x65"
 				  "\x73\x73\x65\x64\x20\x74\x6f",
-		.psize		= 407,
+		.psize		= 375,
 		.digest		= "\xf3\x47\x7e\x7c\xd9\x54\x17\xaf"
 				  "\x89\xa6\xb8\x79\x4c\x31\x0c\xf0",
 	}, { /* Test Vector #4 */
-		.plaintext	= "\x1c\x92\x40\xa5\xeb\x55\xd3\x8a"
+		.key		= "\x1c\x92\x40\xa5\xeb\x55\xd3\x8a"
 				  "\xf3\x33\x88\x86\x04\xf6\xb5\xf0"
 				  "\x47\x39\x17\xc1\x40\x2b\x80\x09"
-				  "\x9d\xca\x5c\xbc\x20\x70\x75\xc0"
-				  "\x27\x54\x77\x61\x73\x20\x62\x72"
+				  "\x9d\xca\x5c\xbc\x20\x70\x75\xc0",
+		.ksize		= 32,
+		.plaintext	= "\x27\x54\x77\x61\x73\x20\x62\x72"
 				  "\x69\x6c\x6c\x69\x67\x2c\x20\x61"
 				  "\x6e\x64\x20\x74\x68\x65\x20\x73"
 				  "\x6c\x69\x74\x68\x79\x20\x74\x6f"
@@ -8988,73 +8992,79 @@ static const struct hash_testvec poly1305_tv_template[] = {
 				  "\x68\x65\x20\x6d\x6f\x6d\x65\x20"
 				  "\x72\x61\x74\x68\x73\x20\x6f\x75"
 				  "\x74\x67\x72\x61\x62\x65\x2e",
-		.psize		= 159,
+		.psize		= 127,
 		.digest		= "\x45\x41\x66\x9a\x7e\xaa\xee\x61"
 				  "\xe7\x08\xdc\x7c\xbc\xc5\xeb\x62",
 	}, { /* Test Vector #5 */
-		.plaintext	= "\x02\x00\x00\x00\x00\x00\x00\x00"
+		.key		= "\x02\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00"
-				  "\x00\x00\x00\x00\x00\x00\x00\x00"
-				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\x00\x00\x00\x00\x00\x00\x00\x00",
+		.ksize		= 32,
+		.plaintext	= "\xff\xff\xff\xff\xff\xff\xff\xff"
 				  "\xff\xff\xff\xff\xff\xff\xff\xff",
-		.psize		= 48,
+		.psize		= 16,
 		.digest		= "\x03\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00",
 	}, { /* Test Vector #6 */
-		.plaintext	= "\x02\x00\x00\x00\x00\x00\x00\x00"
+		.key		= "\x02\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00"
 				  "\xff\xff\xff\xff\xff\xff\xff\xff"
-				  "\xff\xff\xff\xff\xff\xff\xff\xff"
-				  "\x02\x00\x00\x00\x00\x00\x00\x00"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff",
+		.ksize		= 32,
+		.plaintext	= "\x02\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00",
-		.psize		= 48,
+		.psize		= 16,
 		.digest		= "\x03\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00",
 	}, { /* Test Vector #7 */
-		.plaintext	= "\x01\x00\x00\x00\x00\x00\x00\x00"
+		.key		= "\x01\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00"
-				  "\x00\x00\x00\x00\x00\x00\x00\x00"
-				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\x00\x00\x00\x00\x00\x00\x00\x00",
+		.ksize		= 32,
+		.plaintext	= "\xff\xff\xff\xff\xff\xff\xff\xff"
 				  "\xff\xff\xff\xff\xff\xff\xff\xff"
 				  "\xf0\xff\xff\xff\xff\xff\xff\xff"
 				  "\xff\xff\xff\xff\xff\xff\xff\xff"
 				  "\x11\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00",
-		.psize		= 80,
+		.psize		= 48,
 		.digest		= "\x05\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00",
 	}, { /* Test Vector #8 */
-		.plaintext	= "\x01\x00\x00\x00\x00\x00\x00\x00"
+		.key		= "\x01\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00"
-				  "\x00\x00\x00\x00\x00\x00\x00\x00"
-				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\x00\x00\x00\x00\x00\x00\x00\x00",
+		.ksize		= 32,
+		.plaintext	= "\xff\xff\xff\xff\xff\xff\xff\xff"
 				  "\xff\xff\xff\xff\xff\xff\xff\xff"
 				  "\xfb\xfe\xfe\xfe\xfe\xfe\xfe\xfe"
 				  "\xfe\xfe\xfe\xfe\xfe\xfe\xfe\xfe"
 				  "\x01\x01\x01\x01\x01\x01\x01\x01"
 				  "\x01\x01\x01\x01\x01\x01\x01\x01",
-		.psize		= 80,
+		.psize		= 48,
 		.digest		= "\x00\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00",
 	}, { /* Test Vector #9 */
-		.plaintext	= "\x02\x00\x00\x00\x00\x00\x00\x00"
+		.key		= "\x02\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00"
-				  "\x00\x00\x00\x00\x00\x00\x00\x00"
-				  "\xfd\xff\xff\xff\xff\xff\xff\xff"
+				  "\x00\x00\x00\x00\x00\x00\x00\x00",
+		.ksize		= 32,
+		.plaintext	= "\xfd\xff\xff\xff\xff\xff\xff\xff"
 				  "\xff\xff\xff\xff\xff\xff\xff\xff",
-		.psize		= 48,
+		.psize		= 16,
 		.digest		= "\xfa\xff\xff\xff\xff\xff\xff\xff"
 				  "\xff\xff\xff\xff\xff\xff\xff\xff",
 	}, { /* Test Vector #10 */
-		.plaintext	= "\x01\x00\x00\x00\x00\x00\x00\x00"
+		.key		= "\x01\x00\x00\x00\x00\x00\x00\x00"
 				  "\x04\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00"
-				  "\x00\x00\x00\x00\x00\x00\x00\x00"
-				  "\xe3\x35\x94\xd7\x50\x5e\x43\xb9"
+				  "\x00\x00\x00\x00\x00\x00\x00\x00",
+		.ksize		= 32,
+		.plaintext	= "\xe3\x35\x94\xd7\x50\x5e\x43\xb9"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00"
 				  "\x33\x94\xd7\x50\x5e\x43\x79\xcd"
 				  "\x01\x00\x00\x00\x00\x00\x00\x00"
@@ -9062,24 +9072,30 @@ static const struct hash_testvec poly1305_tv_template[] = {
 				  "\x00\x00\x00\x00\x00\x00\x00\x00"
 				  "\x01\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00",
-		.psize		= 96,
+		.psize		= 64,
 		.digest		= "\x14\x00\x00\x00\x00\x00\x00\x00"
 				  "\x55\x00\x00\x00\x00\x00\x00\x00",
 	}, { /* Test Vector #11 */
-		.plaintext	= "\x01\x00\x00\x00\x00\x00\x00\x00"
+		.key		= "\x01\x00\x00\x00\x00\x00\x00\x00"
 				  "\x04\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00"
-				  "\x00\x00\x00\x00\x00\x00\x00\x00"
-				  "\xe3\x35\x94\xd7\x50\x5e\x43\xb9"
+				  "\x00\x00\x00\x00\x00\x00\x00\x00",
+		.ksize		= 32,
+		.plaintext	= "\xe3\x35\x94\xd7\x50\x5e\x43\xb9"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00"
 				  "\x33\x94\xd7\x50\x5e\x43\x79\xcd"
 				  "\x01\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00",
-		.psize		= 80,
+		.psize		= 48,
 		.digest		= "\x13\x00\x00\x00\x00\x00\x00\x00"
 				  "\x00\x00\x00\x00\x00\x00\x00\x00",
 	}, { /* Regression test for overflow in AVX2 implementation */
+		.key		= "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff"
+				  "\xff\xff\xff\xff\xff\xff\xff\xff",
+		.ksize		= 32,
 		.plaintext	= "\xff\xff\xff\xff\xff\xff\xff\xff"
 				  "\xff\xff\xff\xff\xff\xff\xff\xff"
 				  "\xff\xff\xff\xff\xff\xff\xff\xff"
@@ -9113,12 +9129,8 @@ static const struct hash_testvec poly1305_tv_template[] = {
 				  "\xff\xff\xff\xff\xff\xff\xff\xff"
 				  "\xff\xff\xff\xff\xff\xff\xff\xff"
 				  "\xff\xff\xff\xff\xff\xff\xff\xff"
-				  "\xff\xff\xff\xff\xff\xff\xff\xff"
-				  "\xff\xff\xff\xff\xff\xff\xff\xff"
-				  "\xff\xff\xff\xff\xff\xff\xff\xff"
-				  "\xff\xff\xff\xff\xff\xff\xff\xff"
 				  "\xff\xff\xff\xff",
-		.psize		= 300,
+		.psize		= 268,
 		.digest		= "\xfb\x5e\x96\xd8\x61\xd5\xc7\xc8"
 				  "\x78\xe5\x87\xcc\x2d\x5a\x22\xe1",
 	}
-- 
2.39.5


