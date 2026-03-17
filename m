Return-Path: <linux-crypto+bounces-22065-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eA0bBT+HuWncJAIAu9opvQ
	(envelope-from <linux-crypto+bounces-22065-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 17:54:23 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C37732AE9F4
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 17:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76DF5303DA31
	for <lists+linux-crypto@lfdr.de>; Tue, 17 Mar 2026 16:54:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79E03F54BE;
	Tue, 17 Mar 2026 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EpzFASh2"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D47D3EF641
	for <linux-crypto@vger.kernel.org>; Tue, 17 Mar 2026 16:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766436; cv=none; b=UEbnW8Y0Ejvyiu5qGgWtOFGq0qSyqXqmpvsF7fDALUuCEJ1FRvQllXQmacmC23NASCdwRALgUxOo0FlPARN6HGXsUdlVh+LnWY0GlDPBTSIbjMFCB5NGlS/jRNx0NCpwIBf5HKoawOSWObmLHlrQFukenPD5q5OJNaLGz0+2FdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766436; c=relaxed/simple;
	bh=uUZqgp56tETGHnqGOVMnhu/DmaoMiy26Kaph7kGSWAU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gX8r1EpOs3bTvYGgAvfDJaE5YO7x9upSm7CCmBCaaO5OMR/se3bNN8WKjPtMHOGKFApNQ2W3P+rnpdPdo+7crpXsTeM/NFWhZ/IvysiCKV13jrwdK8xVzUa6Axx/IcoePhm3eyD0Ov8xWsWem809x3l5rrFknE5NsMyvgVwaxsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EpzFASh2; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773766423;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AB4PjFxa6AWYuYKRdmkExBbCIEkIbBbhTthhg8WwMeA=;
	b=EpzFASh2ZKCjNH2eBsBSN4FxoAHY49Z+Dn2wROKsqo2nMJC6GGQC1KyRmWVaNcdLm4Pkik
	r92aJAJU2TEL8B1rmpSNKUEzWBvuEqK9Ks+bF7gxdyqvwIWKiZTcYxUIiglHpY1OfQlUqN
	+wSC74kkBsxrwTh3Kre8yDEl0v9XKNU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: marvell/cesa - use memcpy_and_pad in mv_cesa_ahash_export
Date: Tue, 17 Mar 2026 17:52:57 +0100
Message-ID: <20260317165258.1304521-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=813; i=thorsten.blum@linux.dev; h=from:subject; bh=uUZqgp56tETGHnqGOVMnhu/DmaoMiy26Kaph7kGSWAU=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJk72145zatvuDyh+emKhBNnWht4dhvIaYmGlM3OnZimd kOgOzizo5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACbi7MnIcHDFmRXufxm2pdVE Lf+c8p/T8riSbuPqRSlcFlN1rkgXdDMyTBNMTv2ed3S34N/QCo3A2k/WeZ8+VpvWVtl7tZ6/cZW RDwA=
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22065-lists,linux-crypto=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: C37732AE9F4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace memset() followed by memcpy() with memcpy_and_pad() to simplify
the code and to write to 'cache' only once.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/marvell/cesa/hash.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/crypto/marvell/cesa/hash.c b/drivers/crypto/marvell/cesa/hash.c
index 5103d36cdfdb..2f203042d9bd 100644
--- a/drivers/crypto/marvell/cesa/hash.c
+++ b/drivers/crypto/marvell/cesa/hash.c
@@ -847,8 +847,7 @@ static int mv_cesa_ahash_export(struct ahash_request *req, void *hash,
 
 	*len = creq->len;
 	memcpy(hash, creq->state, digsize);
-	memset(cache, 0, blocksize);
-	memcpy(cache, creq->cache, creq->cache_ptr);
+	memcpy_and_pad(cache, blocksize, creq->cache, creq->cache_ptr, 0);
 
 	return 0;
 }

