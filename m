Return-Path: <linux-crypto+bounces-21899-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oIQFMJfosmljQwAAu9opvQ
	(envelope-from <linux-crypto+bounces-21899-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Mar 2026 17:23:51 +0100
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15678275853
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Mar 2026 17:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 80BCC318877B
	for <lists+linux-crypto@lfdr.de>; Thu, 12 Mar 2026 16:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B423F7E8D;
	Thu, 12 Mar 2026 16:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="FkQyeAB/"
X-Original-To: linux-crypto@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1AB3F7874;
	Thu, 12 Mar 2026 16:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773332328; cv=none; b=e7ZF/9zEqDxR6n+LROcaEViRTZIlL9To+PfBLSl1mOyOCKciXyG0b+BR6UFA3C/w82+69BVy4dxZsAmvwlkfuQ/CCALwKUkxrUMY1snKKg0adkkNCGOos6c62vB9WOQqPwVqjmFrxrmsKx5ynwbyBzyO8S72MkrQYs7PLQVNQ0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773332328; c=relaxed/simple;
	bh=r+H4nN8FEm5hqBTVEcbg+154s0B6+qEaV7hbQZF5BCU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZoQYV6yvDdaMnNrLUAU/ahfsElvHQA8Y0l3dwa4QBKiAOSdPJ0q1iMAaknu0eyNZkw2y63BZ0S0j+xMI/9bwj32oEKvYBuEsxQjn0tJeyfFBdz9RkYLbA21VQr4a5Ltk/qV3YNhPiwL/HTtYmET59bSvwvh8UvzstRBVkc8jNfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=FkQyeAB/; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=VG0dZbZo9KDGej1wf7CUWCHE5nKIFztp1R/yW2wVRKY=; b=FkQyeAB/VV7RF0kXpLFUAlFwvL
	HXDl9sN9WFn2NMcnyOuatdnTn5etxr8r7l+ncxCQrJamiNBLbEnshGUzlpu0cFvPW/Ul3asIXF74A
	OQTYFDB17IMKzM0VXvOGPB7/kZMmIR+qVeS+NQGcpO9H+8c/wtTNw+AZ6JqhiXUvaeaLTTFSDY8nS
	0V6yJLFqyAIQo8h3ZlyioJdOYOfTBWD11gOxS5/0sOjYA4x6kHCw3MJsDvq73q6fouRJq2EUa7vZZ
	uWN5UYEHY53aWAwHEjj5LhVDIHYQG7GRQzGqx5Gq1/Dahx/oqtHROrpokctpLyM5/L5zIBf14kvPQ
	WVKC1k8A==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w0ikH-004fOP-Fd; Thu, 12 Mar 2026 16:18:45 +0000
From: Breno Leitao <leitao@debian.org>
Date: Thu, 12 Mar 2026 09:12:06 -0700
Subject: [PATCH RFC 5/5] tools/workqueue: add CACHE_SHARD support to
 wq_dump.py
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260312-workqueue_sharded-v1-5-2c43a7b861d0@debian.org>
References: <20260312-workqueue_sharded-v1-0-2c43a7b861d0@debian.org>
In-Reply-To: <20260312-workqueue_sharded-v1-0-2c43a7b861d0@debian.org>
To: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, puranjay@kernel.org, 
 linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, Michael van der Westhuizen <rmikey@meta.com>, 
 kernel-team@meta.com, Chuck Lever <chuck.lever@oracle.com>, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-363b9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1483; i=leitao@debian.org;
 h=from:subject:message-id; bh=r+H4nN8FEm5hqBTVEcbg+154s0B6+qEaV7hbQZF5BCU=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpsudLdu6jztiCIa49vWfR67tssVeoNTyxtlM4e
 G2BSgAQvS2JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCabLnSwAKCRA1o5Of/Hh3
 bZiMD/9HmhdhcqFn2Ncw/zabyyHdLOliiElUKHcXEcS64MVyiyyML/7/jidN/oEELOSWa7qmcZq
 QorndoXg9UF0GhV9F0P7wZ3utzL8Z7kIymthUQ6IG3SM1OTMwUGYu3ooLLUQUfSSkFDwrU01rkj
 AIWpV4JZOigopP22XnRcrG4VY+6ewJog19NtlE/Geu0KfUzGDrSUsqjIPRKKY5B2bv1wRJ7rxKw
 SFmBXDWIJ7NuRZ/hL1vkJ/kGcePkyi04c+FOsnXk50Gt2ncEiBs8injNx+O+YBxN81mAbpcRmMC
 mmtXP2CJ+JyowH1LcXuiPMt0skOH0OQkaDNrqro07yTgaemEjek9rJwu8vGfY+g2zI/+gZCvGsY
 pfN/9Oq6wGuQvlN2sOQoMA3TEWZDCIxsK9s2C9FfaQpD1eE7ULjlzQs6jvY+K0cans6AItP5C42
 7RawNU+sIkZGo7pa1TeZNFKiqIu+TyxvvqkKUDRiwGHa32+4F46tm4PYCcqFyd08gI3jZRs/ZzG
 KTnGE0eW7Ybwj9MU+Qr+G6PObV4U0GFThoDg78FqwLmqHMHlnJQY/TzjB54lwwZ0MzPwcDzO1AN
 l1OBNynFfFg3h5CNGLBFav8efnVzrCtofyNRyjr0XOOwCZSnXlF9hkV4k9GzScT2Sd+ZclxbSbn
 kqv+o3SIGuwqGvw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,linux-foundation.org];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21899-lists,linux-crypto=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-crypto@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-crypto];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 15678275853
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
index d29b918306b48..06948ffcfc4b6 100644
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


