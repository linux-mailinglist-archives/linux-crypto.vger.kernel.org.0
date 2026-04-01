Return-Path: <linux-crypto+bounces-22694-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIBAFogazWnOaAYAu9opvQ
	(envelope-from <linux-crypto+bounces-22694-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 01 Apr 2026 15:15:52 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BEEA837B0C3
	for <lists+linux-crypto@lfdr.de>; Wed, 01 Apr 2026 15:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05D2731182C3
	for <lists+linux-crypto@lfdr.de>; Wed,  1 Apr 2026 13:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C79D3314AE;
	Wed,  1 Apr 2026 13:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="R62WKQMm"
X-Original-To: linux-crypto@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553F2411634;
	Wed,  1 Apr 2026 13:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775048671; cv=none; b=DWdKGq84CMpx+XTASh5KJx+FrpSW3p8fFnCtIVmyFt1sLdOW7hK8cPztbVFT9e7XI+8QKY5r55gp1nwLqUhl5wQugY2FwyH/bc/AzvwVO/X0b5hmtuUJUtu8OSIk30LnNLvs8GLsN+C9C96VpB0Dt0+nOX9dnWXoEiDLch3IqVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775048671; c=relaxed/simple;
	bh=WC6GVYqqH6uJpxirkIWe/Ma1i1dg1WyP1WFJSYjEFjY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PKn6MlcJPFq1gWK+xsKCdmC0zse1lFt6XHlbvzYW1cEgWv5KlrKp6DGY63rmqKrGctUt2M/kHzfsIL8gXbAkiRLfeER49KiBoU1qfNO5+1InvIqf4PlZHIMG9DFQbnVQ/OX9XBGB0v8dadjfjABsiJ4Hsex69XzRz3a2lcKCRkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=R62WKQMm; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=/9/FcUTrB1glb7awiHGGVzYmo0mRbW1klav76bPoW60=; b=R62WKQMmSVF7JrKZHW7GoZjp/G
	XH4VEWaWutQULOGDZcsBgaL4YA6JtRibQYr3NSGzkMvH6Li37wA6ixO0Tstnm8dMHmfuBrLJCmE8j
	OTAriTsZaNkOOOz++/fhr+0a/v9lUU3fb8YfIfElu0f+Wfwiy6c3fM5Q4kydzCi2/i6d8ZmLdJFc2
	ESWBrrxmdQIbv21LYGPUZpu6DqWneF+CV0bLTOdTh5f6V3R4z4h0Ri1sJjPde5CbgldeyOvpP3FDc
	B5C8qpCKUpoGsiugwBKOHHGZu9kiueORr1RkNHo9Sk1n6eAaylctgE1XMr2ljN5TGWbaKj7/dpsaa
	8EnPZudg==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1w7vFF-0030Py-2y;
	Wed, 01 Apr 2026 13:04:28 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 01 Apr 2026 06:03:55 -0700
Subject: [PATCH v3 4/6] tools/workqueue: add CACHE_SHARD support to
 wq_dump.py
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260401-workqueue_sharded-v3-4-ab0b9336bf0b@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1481; i=leitao@debian.org;
 h=from:subject:message-id; bh=WC6GVYqqH6uJpxirkIWe/Ma1i1dg1WyP1WFJSYjEFjY=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpzRfIFsglWU/C6Vu4ZEjPNoX8kONRE6ru70gtc
 j/UX2j27waJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCac0XyAAKCRA1o5Of/Hh3
 bZV/EACVte0wYZbmP8dVyCvQZd/6j6sp5gNvtm32/fXSaQcZtB0CxXsodhwelKGhlAFY2LEGDR4
 2tu5Le3H2JxrEqSyB3AEGUXJMljIWvIcHBnpN5beQ6Y8aLEAz4VAm/f+kOXTTANGLAOis0fAZZ8
 lTnh8Hw9Q44u+kml0aDbSLPxq67UqxA5j5MDwXWdqliEqDG34I3Vrf1fNBa5cChEBBW56uZYUht
 1LJqyzddRQazp34CYmNUTnJP0HDpGdkZfh7QTKlRFoRMuVsjd9/wL84F3npVklm0HfyqMqM7vYS
 4N250fofPv7n8BBgh14dDxxTkjIcH+TvXVRuWW9m54kmBLuBBODCcH/pKzeJtUpZWsQIrXPa2Xo
 W2hsEvu0kCCKo3VM908UUcd+cAXaJyz29MakVrABtjX4SRLnzFoInocLGAjYrF9/OO+TitLgK4F
 Y2XcHfc2m8cVrLeICOdf8CjCRwt6oOxJAVjYXX7RQrFF4UbLBmmMQSsTzqDBaZAD98kGJNxG31O
 F+KUDX7Iym9ykWg9F95xkPfLIy30LtvrzUN2OOtqdku/qokUXkW+AuGXcVsB4km1wKsazpBTz5H
 sgal8n2CViD8ngbxjepG81WUa6JJFdy2wFacA2/5Pr1UUN2YeTYKvJrbdUak99HpL6UPvvBN1jR
 VNCe+6GqIh0UQ7A==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
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
	TAGGED_FROM(0.00)[bounces-22694-lists,linux-crypto=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.936];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wq_dump.py:url]
X-Rspamd-Queue-Id: BEEA837B0C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The WQ_AFFN_CACHE_SHARD affinity scope was added to the kernel but
wq_dump.py was not updated to enumerate it. Add the missing constant
lookup and include it in the affinity scopes iteration so that drgn
output shows the CACHE_SHARD pod topology alongside the other scopes.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 tools/workqueue/wq_dump.py | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/workqueue/wq_dump.py b/tools/workqueue/wq_dump.py
index d29b918306b4..06948ffcfc4b 100644
--- a/tools/workqueue/wq_dump.py
+++ b/tools/workqueue/wq_dump.py
@@ -107,6 +107,7 @@ WQ_MEM_RECLAIM          = prog['WQ_MEM_RECLAIM']
 WQ_AFFN_CPU             = prog['WQ_AFFN_CPU']
 WQ_AFFN_SMT             = prog['WQ_AFFN_SMT']
 WQ_AFFN_CACHE           = prog['WQ_AFFN_CACHE']
+WQ_AFFN_CACHE_SHARD     = prog['WQ_AFFN_CACHE_SHARD']
 WQ_AFFN_NUMA            = prog['WQ_AFFN_NUMA']
 WQ_AFFN_SYSTEM          = prog['WQ_AFFN_SYSTEM']
 
@@ -138,7 +139,7 @@ def print_pod_type(pt):
         print(f' [{cpu}]={pt.cpu_pod[cpu].value_()}', end='')
     print('')
 
-for affn in [WQ_AFFN_CPU, WQ_AFFN_SMT, WQ_AFFN_CACHE, WQ_AFFN_NUMA, WQ_AFFN_SYSTEM]:
+for affn in [WQ_AFFN_CPU, WQ_AFFN_SMT, WQ_AFFN_CACHE, WQ_AFFN_CACHE_SHARD, WQ_AFFN_NUMA, WQ_AFFN_SYSTEM]:
     print('')
     print(f'{wq_affn_names[affn].string_().decode().upper()}{" (default)" if affn == wq_affn_dfl else ""}')
     print_pod_type(wq_pod_types[affn])

-- 
2.52.0


