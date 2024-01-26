Return-Path: <linux-crypto+bounces-1669-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1035783D7AA
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jan 2024 11:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8CC21F2F9EA
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Jan 2024 10:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE4F6A32B;
	Fri, 26 Jan 2024 09:39:18 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA516A32A;
	Fri, 26 Jan 2024 09:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261958; cv=none; b=e2J+yHY4QE9IjJ9JdCX1QfwD3hsV/7geC0nIGA589yRpxjLKVg8W07AjsGSFIlXHL57c1HfFybGKkTD0kSsOTP35gz3PPT3mQQYeb8GrTu222tt7dARpl7NqgxRVFSDXe9PRadid3lwdPpyglT6qWtt9tc+ZsGWB8SXsIaq1Md4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261958; c=relaxed/simple;
	bh=Lf3encN/F8/HuCIppMQ0kCZkOPYn0JSFA0SPxEOdeLA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=b2LtDMVilRSRLM95IUgVZ9kLG7Wr8vov79Y0Kj0uVjITaKCMdPsL7lTyccE1beLrk+3yXbvHQWTFtBmxYiKATKMZAvW3NrGoUwLsvxIcVYizrb9HLYNbPrgXaSzPmlOt8ZGMzWUJUIlIt9TNW9ayMVqAMpBiGgKFv3z8ide0U2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TLt030cF2zvVLK;
	Fri, 26 Jan 2024 17:37:39 +0800 (CST)
Received: from dggpeml500001.china.huawei.com (unknown [7.185.36.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 69B46140136;
	Fri, 26 Jan 2024 17:39:13 +0800 (CST)
Received: from huawei.com (10.69.192.56) by dggpeml500001.china.huawei.com
 (7.185.36.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 17:39:13 +0800
From: Qi Tao <taoqi10@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
	<liulongfang@huawei.com>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Subject: [PATCH v2 0/4] some updates and cleanups for hisilicon/sec2.
Date: Fri, 26 Jan 2024 17:38:24 +0800
Message-ID: <20240126093828.14131-1-taoqi10@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500001.china.huawei.com (7.185.36.227)

This seires patch mainly add some RAS registers to enhance the 
DFX positioning function and fix some cleanup issues.

[PATCH v1 3/4] -> [PATCH v2 3/4]
	sec_sqe3->c_len_ivin |= cpu_to_le32(c_req->c_len);
-	sec_sqe3->tag = cpu_to_le64((unsigned long)(uintptr_t)req);
+	sec_sqe3->tag = cpu_to_le64((unsigned long)req);

Other patches are not modified.

Qi Tao (3):
  crypto: hisilicon/sec2 - updates the sec DFX function register
  crypto: hisilicon/sec2 - modify nested macro call
  crypto: hisilicon/sec2 - fix some cleanup issues

Wenkai Lin (1):
  crypto: hisilicon/sec - remove unused parameter

  drivers/crypto/hisilicon/sec2/sec_crypto.c | 33 ++++++++--------------
  drivers/crypto/hisilicon/sec2/sec_main.c   |  5 ++++
  2 files changed, 17 insertions(+), 21 deletions(-)

-- 
2.33.0


