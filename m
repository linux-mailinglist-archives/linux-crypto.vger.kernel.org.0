Return-Path: <linux-crypto+bounces-4390-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EDE8CF336
	for <lists+linux-crypto@lfdr.de>; Sun, 26 May 2024 11:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F4AD282024
	for <lists+linux-crypto@lfdr.de>; Sun, 26 May 2024 09:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6CCAE573;
	Sun, 26 May 2024 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SC3gEs3N"
X-Original-To: linux-crypto@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7EBDDD2;
	Sun, 26 May 2024 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716716518; cv=none; b=Umn75NdGUZBO6sZv0UgoMsRAXWtM/JMO7T61FMZD3Q+D0BAa5HWvRjl5JadWbIEZe35vxLPca0QBtmXtU/b3x+x199/A6MrsrS4LWe4f8F8Xy7WTK5UNnPCaea4wSThS9jLx0UdtyCELIYX8qpFnIdH0O5jM74OdXXsc0ABC49o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716716518; c=relaxed/simple;
	bh=hj9aSXmnmwSbu28OCRJJjrZQuJAzurHLfzA/RXtw/jQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NDsdkYcU9BCkgSN32d4GYZDl0JGCqTiurS6lz4VVDBmJ/Qy+IPGpI1lzlX6/ENi5B+RNaEKJGnls0DZ64NSDui/6mFdJf7dheOCBH6C5PDto9cRfdYZLvhiXfoeKKc5kjVIpo3reCx/nI2WEDNl8VwfIPIdGV7rU/SVBVkraXqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SC3gEs3N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EA1EC4AF09;
	Sun, 26 May 2024 09:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716716518;
	bh=hj9aSXmnmwSbu28OCRJJjrZQuJAzurHLfzA/RXtw/jQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SC3gEs3Ne9OGE24JY7PDMC0Kv0qeJyrtWQ8ai15MC5HYp6DGQZNtsZwhccGHMlEaq
	 R+wOBS3TAnwCD14mhPBxsDnoOc/a8CBG2TzBDWaUUgG2sdCJxe+IdwJcwP/EdCuFE2
	 e9jbJPhUnXWXqsJbPsV2xV2C+Ty86j28Ro0HlytJMCZCt0clHfUxNP1pbIXakmkKYd
	 7QaYXeYoJ2puHhwlxpcMebncZ/58uA8aUhdkfk1jq6MScEP7vnhjhm0oSs+cwhRi2W
	 WmNF3xmiQuhWoqkyKX+eJykgvoc9tjXK3fQJffe5aZqizwRWiXrngGwPVfvBePJ2AJ
	 zC9zykl3uRGUQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
	syzbot+0cb5bb0f4bf9e79db3b3@syzkaller.appspotmail.com,
	Daniel Jordan <daniel.m.jordan@oracle.com>,
	Sasha Levin <sashal@kernel.org>,
	steffen.klassert@secunet.com,
	linux-crypto@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 03/15] padata: Disable BH when taking works lock on MT path
Date: Sun, 26 May 2024 05:41:35 -0400
Message-ID: <20240526094152.3412316-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240526094152.3412316-1-sashal@kernel.org>
References: <20240526094152.3412316-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.1
Content-Transfer-Encoding: 8bit

From: Herbert Xu <herbert@gondor.apana.org.au>

[ Upstream commit 58329c4312031603bb1786b44265c26d5065fe72 ]

As the old padata code can execute in softirq context, disable
softirqs for the new padata_do_mutithreaded code too as otherwise
lockdep will get antsy.

Reported-by: syzbot+0cb5bb0f4bf9e79db3b3@syzkaller.appspotmail.com
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Acked-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/padata.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/padata.c b/kernel/padata.c
index e3f639ff16707..53f4bc9127127 100644
--- a/kernel/padata.c
+++ b/kernel/padata.c
@@ -106,7 +106,7 @@ static int __init padata_work_alloc_mt(int nworks, void *data,
 {
 	int i;
 
-	spin_lock(&padata_works_lock);
+	spin_lock_bh(&padata_works_lock);
 	/* Start at 1 because the current task participates in the job. */
 	for (i = 1; i < nworks; ++i) {
 		struct padata_work *pw = padata_work_alloc();
@@ -116,7 +116,7 @@ static int __init padata_work_alloc_mt(int nworks, void *data,
 		padata_work_init(pw, padata_mt_helper, data, 0);
 		list_add(&pw->pw_list, head);
 	}
-	spin_unlock(&padata_works_lock);
+	spin_unlock_bh(&padata_works_lock);
 
 	return i;
 }
@@ -134,12 +134,12 @@ static void __init padata_works_free(struct list_head *works)
 	if (list_empty(works))
 		return;
 
-	spin_lock(&padata_works_lock);
+	spin_lock_bh(&padata_works_lock);
 	list_for_each_entry_safe(cur, next, works, pw_list) {
 		list_del(&cur->pw_list);
 		padata_work_free(cur);
 	}
-	spin_unlock(&padata_works_lock);
+	spin_unlock_bh(&padata_works_lock);
 }
 
 static void padata_parallel_worker(struct work_struct *parallel_work)
-- 
2.43.0


