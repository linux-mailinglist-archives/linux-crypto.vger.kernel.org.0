Return-Path: <linux-crypto+bounces-24625-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6OzbF70uF2rd7wcAu9opvQ
	(envelope-from <linux-crypto+bounces-24625-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 27 May 2026 19:49:49 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 571B75E8840
	for <lists+linux-crypto@lfdr.de>; Wed, 27 May 2026 19:49:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF6BC303315E
	for <lists+linux-crypto@lfdr.de>; Wed, 27 May 2026 17:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD8A02566F7;
	Wed, 27 May 2026 17:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FyfAbnck"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25951A9B46
	for <linux-crypto@vger.kernel.org>; Wed, 27 May 2026 17:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779904056; cv=none; b=N7wTv76hqTfAXfCAYq6QZb3idoYV2eWeCeKRmj/yxHxkzMbPqPg1p+1jSMLVAdyhN+1+wOEE6Qo2naAM2ifgEuiQVgdxBqxkOZ6ns1JXnNaNVHwnMx3XyxgOI8grHy10N0mRrnWMwwxG6Kv6aAmn6o4b33Bv3VdRS0w4ASE1Z20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779904056; c=relaxed/simple;
	bh=hm4y6kH5kzUNT/2+Gd3ENjrVKXo+zqOEpG2c4R80X00=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jtby58Gv1TFurCzbcdHdOA5n4jsbtbPxZ3FCC4pxln2MCFxm8E990LDJ4BJXs7T0s3eQgPCQ5Z3yR283heJfhxdsRQSRHPP3RX0XWtvckngbImp7oonsQCc38U8YHapO63wnN0VRwctMNaMYBdAqyMUJn0zwg43Uvm+1vV9GYF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FyfAbnck; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779904042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eKwrM6BKAaIKt0ttg+AsSn2MV5pMHrvve+XIoKLy3P0=;
	b=FyfAbnckHaA4eWHH9TzQse8H7DYznXfqLqJF/Z5RVTuBStRjZ8aSU5lU/vsUhHKQMMizJZ
	4Vw5rFN28cP2K5eteRe7D8r/7jInlxg3eg/VIdgEZ5juv/Tkx2aWDIm5uh5mfhRe4Pvnns
	Jt0xBLqs6MWzkMrEa13d0k9yNQrXso0=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>,
	Karthikeyan Gopal <karthikeyan.gopal@intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: qat - simplify adf_service_mask_to_string helper
Date: Wed, 27 May 2026 19:46:55 +0200
Message-ID: <20260527174655.1390543-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1100; i=thorsten.blum@linux.dev; h=from:subject; bh=hm4y6kH5kzUNT/2+Gd3ENjrVKXo+zqOEpG2c4R80X00=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFnievydmxr8dmvNaInaVvVjnePuhH1nZ/GU2c3f+SPxH Ze3ZpZIRykLgxgXg6yYIsuDWT9m+JbWVG4yidgJM4eVCWQIAxenAExEtp+RYe6sAxGL2Is/dV47 HFuvEuj9q2hZEy+H4YfgRebObP577zH8M1u3YGHLE7tFtkel1eclpi+5EP3TcM+B+LOTOWcEu0z 5zQ0A
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24625-lists,linux-crypto=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 571B75E8840
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use a single scnprintf() for each set bit and drop the offset in the
else branch to simplify adf_service_mask_to_string().

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/intel/qat/qat_common/adf_cfg_services.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/intel/qat/qat_common/adf_cfg_services.c b/drivers/crypto/intel/qat/qat_common/adf_cfg_services.c
index 21b21ac78e53..baf563c6f9b7 100644
--- a/drivers/crypto/intel/qat/qat_common/adf_cfg_services.c
+++ b/drivers/crypto/intel/qat/qat_common/adf_cfg_services.c
@@ -93,10 +93,9 @@ static int adf_service_mask_to_string(unsigned long mask, char *buf, size_t len)
 	for_each_set_bit(bit, &mask, SVC_COUNT) {
 		if (offset)
 			offset += scnprintf(buf + offset, len - offset,
-					    ADF_SERVICES_DELIMITER);
-
-		offset += scnprintf(buf + offset, len - offset, "%s",
-				    adf_cfg_services[bit]);
+				ADF_SERVICES_DELIMITER "%s", adf_cfg_services[bit]);
+		else
+			offset += scnprintf(buf, len, "%s", adf_cfg_services[bit]);
 	}
 
 	return 0;

