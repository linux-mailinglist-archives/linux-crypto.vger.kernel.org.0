Return-Path: <linux-crypto+bounces-24036-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED3wCJf+BWrFdwIAu9opvQ
	(envelope-from <linux-crypto+bounces-24036-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 14 May 2026 18:55:51 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C863544F8F
	for <lists+linux-crypto@lfdr.de>; Thu, 14 May 2026 18:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7CF013043445
	for <lists+linux-crypto@lfdr.de>; Thu, 14 May 2026 16:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1514F2D238A;
	Thu, 14 May 2026 16:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="fSUXlmMw"
X-Original-To: linux-crypto@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E97344D9A
	for <linux-crypto@vger.kernel.org>; Thu, 14 May 2026 16:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778777719; cv=none; b=pLXYFbZVwGhLPiDhntcSn1BccgaK5mEwWGSagDYGWJ1YSlXKDDNnz8O3k5xBSdHsvl+/y5HiRA4dMSbWNm2xq5MwDfvQnTtKnr5ObDmM5GHX/Jx0YuzsGPyFqLvw6voVJWKpAjrjK97mtm29enMt/1x09tjSPgFYCVvwCFk1rY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778777719; c=relaxed/simple;
	bh=v7o5JznVlPNo7AD+88VwjdqH7OaDNTvDjI3KRzcUXw0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EpNy+gA2jDIwOA8kEchUznXjP3wLTr1u7msnK7BmkuiZMPyzeXmwmnqizWpfzkKuUUl3aWaCeBqRFypN9WBtt4kJj2A+ob4ywo91PkIBFjWYhW8TkF9gHkeDHxXfCVTPM26B/KAHkN77QKtZuxp+DxE9AsYFUY1AaFx7E/nVnCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=fSUXlmMw; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778777715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rhs4rPnXJOnQ0TMkpeTOhKZgfpfxJZD8kt9kby3x2Ic=;
	b=fSUXlmMwCdhNDt00FA+dopT9YjAk8uWWdF4LImcZAEuaHI3dKCRNmtztsJlmWZSUraLtEc
	kaW84RLkrlaZdKcevJ1Sn9b5ITooevsWxZ+pVLnuevJtm1nPmA5sYXHWU4dq7CW/rsnrMB
	pOAjq4MYGzV8d87vrf+Dkob67/v2k9I=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-crypto@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: riscv - replace min_t with min in riscv64_aes_ctr_crypt
Date: Thu, 14 May 2026 18:55:10 +0200
Message-ID: <20260514165509.527721-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1194; i=thorsten.blum@linux.dev; h=from:subject; bh=v7o5JznVlPNo7AD+88VwjdqH7OaDNTvDjI3KRzcUXw0=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFms//Ke3XPp1V5QG+v/tPrUyZJu6y/ed/v7X4rZzPY3f y+6yZmjo5SFQYyLQVZMkeXBrB8zfEtrKjeZROyEmcPKBDKEgYtTACbS5sjwT8HTfOFK9gPTr3/f rlr23DHw4bufvxLeLD73b1mHuKOdrjwjw5XdLU4LPkodMLrcd2bL/8XTPtRGb/30p4Xnm/m657e /iTADAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 3C863544F8F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-24036-lists,linux-crypto=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Action: no action

Use the simpler min() macro since the values are unsigned and
compatible.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 arch/riscv/crypto/aes-riscv64-glue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/crypto/aes-riscv64-glue.c b/arch/riscv/crypto/aes-riscv64-glue.c
index 8bbf7f348c23..bbd920c9e29d 100644
--- a/arch/riscv/crypto/aes-riscv64-glue.c
+++ b/arch/riscv/crypto/aes-riscv64-glue.c
@@ -19,6 +19,7 @@
 #include <crypto/scatterwalk.h>
 #include <crypto/xts.h>
 #include <linux/linkage.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 
 asmlinkage void aes_ecb_encrypt_zvkned(const struct crypto_aes_ctx *key,
@@ -266,8 +267,7 @@ static int riscv64_aes_ctr_crypt(struct skcipher_request *req)
 			 * operation into two at the point where the overflow
 			 * will occur.  After the first part, add the carry bit.
 			 */
-			p1_nbytes = min_t(unsigned int, nbytes,
-					  (nblocks - ctr32) * AES_BLOCK_SIZE);
+			p1_nbytes = min(nbytes, (nblocks - ctr32) * AES_BLOCK_SIZE);
 			aes_ctr32_crypt_zvkned_zvkb(ctx, walk.src.virt.addr,
 						    walk.dst.virt.addr,
 						    p1_nbytes, req->iv);

