Return-Path: <linux-crypto+bounces-20565-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NM1MBLggGleCAMAu9opvQ
	(envelope-from <linux-crypto+bounces-20565-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 02 Feb 2026 18:34:10 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F5F7CFA26
	for <lists+linux-crypto@lfdr.de>; Mon, 02 Feb 2026 18:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ABBCD300BB84
	for <lists+linux-crypto@lfdr.de>; Mon,  2 Feb 2026 17:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534DF385ED7;
	Mon,  2 Feb 2026 17:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="bNmdjjWD"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF0B2798E5
	for <linux-crypto@vger.kernel.org>; Mon,  2 Feb 2026 17:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770053648; cv=none; b=bgAxAsAXo2dXd/z5OTdry8rpEWeSf+nmySNAOGjHsA6Ndm0A543Dqz1Ruh0TqavshwWZQn4KRKEzCT5BkCmdm57TeqdmJVnuEmqnWzwVF06dClhvg0NHNGB/pChDDL5llzxDQebCKM07MBwtoi89aQS0QHS6MgrMCn3KfBKePdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770053648; c=relaxed/simple;
	bh=mjoBRn1KMFiT+6qQ1vMWJYzOJs4r/llNDgDPoJbub2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AWgko4/SmiaT69gG+vCTmyaKBGo07/qLxV4T2QIJLzkpZ8d4tCxZlMZSrzy9hfpDxqVjzt5ZK7POt9y2ipPl+aAqR+Cl0YSdGLIABM8EGwBPDokuG8UGFjBVE8Jdw8RB65Srio0ORtKN9FV+YHkRp3FRC1NELM02/Y4lpZjbBuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=bNmdjjWD; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770053644;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=qCJFF5AJAwgHihlo6Xmy7iPivmvop9cFNk1pmrP3CIM=;
	b=bNmdjjWDHXthTahTyuS4rIJbzfzuyKVRg2Lr+bo04sg6Cqw/L86iB+17kQcIkUnP1mgJx6
	MhYkWXvPre2L44fiD8odGGObK0CTl/vGUH21YexWh2TYVh/PTJuADZ8p9gOL60D1HD6Fpb
	cYEMyV3Xv3QAoVNpCpULwbGTcNe1t50=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Srujana Challa <schalla@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	"Dr. David Alan Gilbert" <linux@treblig.org>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: octeontx - Replace scnprintf with strscpy in print_ucode_info
Date: Mon,  2 Feb 2026 18:33:21 +0100
Message-ID: <20260202173323.865842-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-20565-lists,linux-crypto=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 5F5F7CFA26
X-Rspamd-Action: no action

Replace scnprintf("%s", ...) with the faster and more direct strscpy().
Remove the parentheses while we're at it.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
index 9f5601c0280b..4ff28bd131d4 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptpf_ucode.c
@@ -10,6 +10,7 @@
 
 #include <linux/ctype.h>
 #include <linux/firmware.h>
+#include <linux/string.h>
 #include <linux/string_choices.h>
 #include "otx_cpt_common.h"
 #include "otx_cptpf_ucode.h"
@@ -509,13 +510,12 @@ EXPORT_SYMBOL_GPL(otx_cpt_uc_supports_eng_type);
 static void print_ucode_info(struct otx_cpt_eng_grp_info *eng_grp,
 			     char *buf, int size)
 {
-	if (eng_grp->mirror.is_ena) {
+	if (eng_grp->mirror.is_ena)
 		scnprintf(buf, size, "%s (shared with engine_group%d)",
 			  eng_grp->g->grp[eng_grp->mirror.idx].ucode[0].ver_str,
 			  eng_grp->mirror.idx);
-	} else {
-		scnprintf(buf, size, "%s", eng_grp->ucode[0].ver_str);
-	}
+	else
+		strscpy(buf, eng_grp->ucode[0].ver_str, size);
 }
 
 static void print_engs_info(struct otx_cpt_eng_grp_info *eng_grp,
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


