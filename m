Return-Path: <linux-crypto+bounces-22691-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLkVOUMYzWnOaAYAu9opvQ
	(envelope-from <linux-crypto+bounces-22691-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 01 Apr 2026 15:06:11 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B47837AEF1
	for <lists+linux-crypto@lfdr.de>; Wed, 01 Apr 2026 15:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F192B30216CA
	for <lists+linux-crypto@lfdr.de>; Wed,  1 Apr 2026 13:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943AD40F8D7;
	Wed,  1 Apr 2026 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="nQ14M+Wd"
X-Original-To: linux-crypto@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2189E31716B;
	Wed,  1 Apr 2026 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775048659; cv=none; b=ZW2JmwISFcMD0bdlmdWWYl5s7pPuaWL2DCR9tRDxwf17MUVssEj4l2b4jARYNBiAOjMrNi5sGcWfZGI1r3IFT5mkEc9gquM4eS0hjJl8vSNmwfM1Hx6TcTNaPHEY19Cp9g9LJrnFsFAKqjUenmiLxBeRlcHqTcJTLGmAlL1vbAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775048659; c=relaxed/simple;
	bh=sk11Fbdh26mbZFGSaKsfAPdaxJv6aqELEvTG+kfANY8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IBjQqtuY7ejYU4b+zkFH9eR9Xpk9AOe5Gio7VfGNV7lMDi4OZK3ctwjDrO0SG9NqDAE2SiVDWEdacP4z3DXzuqmeSl+osXQAhxupez8zn3jHyz0dlB4jVjs5wJE2GbKx3YrtBEwlMb7uDzSg6cieCPoz2EHW0mQCSK+EXwj9+7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=nQ14M+Wd; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=s1zLcZo6T2vsPWGFhNUJfP3VcN0QHQLQX6og1NFcSS8=; b=nQ14M+Wd+CqjTuMB3MrLxJJlgt
	z40Gun3z/bLZlPcbFRSOPv10hvBdli5tD8yMDQJbDsKOT9tRN2dgjNEpK20cNBQvOILlzh9syMIHe
	2o+JbpOFu3KWUQTELPzDF9GyEjDT8jOzJa0CmlO35QpeFNKlh3NWpZwjJbBm9RgwhfI2bx/T7T5O7
	BF7v3GJLIhtrzHDly6p+KWf/sQ41l/JBT2GyPyDDF57ljKD3yT3XA4b4dz34z1EKNdm6PS93iMmrp
	XEHnCaIRrmUI/PXV+CMMCus+aymuqE7qCtvWQ717yQz785UEEAPLhwv4fvun1/l6HHKmEjjakNudS
	gjajLjHQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1w7vF3-0030PP-2d;
	Wed, 01 Apr 2026 13:04:16 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 01 Apr 2026 06:03:52 -0700
Subject: [PATCH v3 1/6] workqueue: fix typo in WQ_AFFN_SMT comment
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-workqueue_sharded-v3-1-ab0b9336bf0b@debian.org>
References: <20260401-workqueue_sharded-v3-0-ab0b9336bf0b@debian.org>
In-Reply-To: <20260401-workqueue_sharded-v3-0-ab0b9336bf0b@debian.org>
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, puranjay@kernel.org, 
 linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Michael van der Westhuizen <rmikey@meta.com>, 
 kernel-team@meta.com, Chuck Lever <chuck.lever@oracle.com>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.16-dev-453a6
X-Developer-Signature: v=1; a=openpgp-sha256; l=759; i=leitao@debian.org;
 h=from:subject:message-id; bh=sk11Fbdh26mbZFGSaKsfAPdaxJv6aqELEvTG+kfANY8=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpzRfIiT7JiBCn2ThsK9IDWf1TOGVXT6dMKy0iT
 bLLZodqAfiJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCac0XyAAKCRA1o5Of/Hh3
 bdNYD/964ZjjevJW677B/TZsbzfyV0JJaOoNt+mpn35vYvh/+LMuFKZIH+Z3utWLFIXj7KO+I80
 IG2obg+/nXYZyxgCYDZkTnniM2iczJXYDFyAtrtla8o2WZ+KnWEKBYEb2cwj4F+NpMSej2uodmE
 0ZPSLZy1ybCZaYPJ3D/A0tcMooGQjf3Da6IyEA631gDpTTgjwRK8iEpMuGwj1bZgKAv5N3K5CXk
 05oJB5vCqEzRLlvVCHS6xD3jCsZyqVy7EctRArIZZE+pCv8wGLnJWAtAdopZH54ufic+mTm794i
 ucUt2JKCvmexqr6TdvJ1E26EbClD0uYXPsBXtNgCOb/gfufGrqcY79S+qZ9uvI1BNPhZluI1qLT
 zlRWPErC7QatbAd7r7fN8/NN7O6uZMs9yECd6+KCbcyf/Sp0zt3T8pKeB+7Z/C2V6HP8lWkZ5aV
 bjAjBrrPnd96ESbSmY29UY4JgNGRQ+2RnAC9bwKeJOQDNDtcCKXywGK+UiDz3CiBCXgruFsCZUJ
 jlTkvxY0qbk4bFIBhtVmlk+D3lxTsdI1FBfAupDQv81ZK0NtPbJEyMJ1K/gpTUsIAk5/cYNhLmK
 rd68UN/2vzhHOFbklC7R71g5+YNMprfSxHrdnsbECsVS2VZ6+NHWTklZNsZm/GnRFyzo+RnLnEl
 MBQ4IhSlohoAd2g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[debian.org];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linux-foundation.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22691-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1B47837AEF1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Fix "poer" -> "per" in the WQ_AFFN_SMT enum comment.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/workqueue.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index a4749f56398f..17543aec2a6e 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -131,7 +131,7 @@ struct rcu_work {
 enum wq_affn_scope {
 	WQ_AFFN_DFL,			/* use system default */
 	WQ_AFFN_CPU,			/* one pod per CPU */
-	WQ_AFFN_SMT,			/* one pod poer SMT */
+	WQ_AFFN_SMT,			/* one pod per SMT */
 	WQ_AFFN_CACHE,			/* one pod per LLC */
 	WQ_AFFN_NUMA,			/* one pod per NUMA node */
 	WQ_AFFN_SYSTEM,			/* one pod across the whole system */

-- 
2.52.0


