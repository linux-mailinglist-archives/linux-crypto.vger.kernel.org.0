Return-Path: <linux-crypto+bounces-11472-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275FAA7D7B3
	for <lists+linux-crypto@lfdr.de>; Mon,  7 Apr 2025 10:24:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C82116CA30
	for <lists+linux-crypto@lfdr.de>; Mon,  7 Apr 2025 08:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F239221F1A;
	Mon,  7 Apr 2025 08:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IjhwgFB5"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C83F189902
	for <linux-crypto@vger.kernel.org>; Mon,  7 Apr 2025 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744014217; cv=none; b=DgvzZ0QfvgupBpSTPdn1MI91/vdRdpt8cVrVM8RHqsgjyh4NHqIrougPxTsWcdx0TpWynot19e+wof0B2v+y2uYYaqJLem2jNMDFpf6CqfZl8tJNGJfX9280ksviEcMVLwybCOIT6un328LO8DTCpLi1upFJXnZCQrCmBylVqPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744014217; c=relaxed/simple;
	bh=gTK8e1XfS4BWfkRxxIpCzpIg4kO5jqWt0RsRG9KsV5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DCC7vk88vc3eD/jAOqaHoDinVWmVM5/YUj2r6Zs9/kk9qd8K11q8KPBmcyztzjmchh44a6r8yQZ/2gQMBpo61Wijp7eQJneXu+LtKp8A7RRLXbtdoN23xSYNiln1w3yLnLOv+ePX0jG9iGVsHhL1iPcruliz/eSkki7Ax9ypTRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IjhwgFB5; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744014211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kIYcMfCxcDbgrdjbytVwAHyym3Acp6ysa9rwtkKANwA=;
	b=IjhwgFB54PY+PS45BCUrL1D/IV8HnDNgSHUvvT88n1vyka8blQldCo+BcDah5+t0Xs8HeX
	lcI5R5GowUtHc2UmdtsWqziYMHd6TZTxddLpM/6zG4m0z9YQ4ObrgMC/gZIUmISodzoH6R
	Fh3dhkI3lDQ5viRFNB4KZaJI0WGFs9c=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: David Howells <dhowells@redhat.com>,
	Lukas Wunner <lukas@wunner.de>,
	Ignat Korchagin <ignat@cloudflare.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	keyrings@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RESEND PATCH] crypto: x509 - Replace kmalloc() + NUL-termination with kzalloc()
Date: Mon,  7 Apr 2025 10:22:47 +0200
Message-ID: <20250407082247.741684-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use kzalloc() to zero out the one-element array instead of using
kmalloc() followed by a manual NUL-termination.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 crypto/asymmetric_keys/x509_cert_parser.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/crypto/asymmetric_keys/x509_cert_parser.c b/crypto/asymmetric_keys/x509_cert_parser.c
index ee2fdab42334..2ffe4ae90bea 100644
--- a/crypto/asymmetric_keys/x509_cert_parser.c
+++ b/crypto/asymmetric_keys/x509_cert_parser.c
@@ -372,10 +372,9 @@ static int x509_fabricate_name(struct x509_parse_context *ctx, size_t hdrlen,
 
 	/* Empty name string if no material */
 	if (!ctx->cn_size && !ctx->o_size && !ctx->email_size) {
-		buffer = kmalloc(1, GFP_KERNEL);
+		buffer = kzalloc(1, GFP_KERNEL);
 		if (!buffer)
 			return -ENOMEM;
-		buffer[0] = 0;
 		goto done;
 	}
 
-- 
2.49.0


