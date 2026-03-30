Return-Path: <linux-crypto+bounces-22565-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDLOMXQXyml85AUAu9opvQ
	(envelope-from <linux-crypto+bounces-22565-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Mar 2026 08:25:56 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C69355E3D
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Mar 2026 08:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6CEBC300B98C
	for <lists+linux-crypto@lfdr.de>; Mon, 30 Mar 2026 06:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1AA394795;
	Mon, 30 Mar 2026 06:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="MFdx9+jz"
X-Original-To: linux-crypto@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09093939C2;
	Mon, 30 Mar 2026 06:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774851940; cv=none; b=b1P5q3fjrsL8Es2OD2bihOdbhNaxjV9a/LkwLzHwJDGi8iWRip/0AdnHRpCeAuDFGztgpiSpzmVWZFY6+RU7RWChTFyuj2jSQLSi45ee6MTh0194oqIXXQzgnzXTolrRpAfKSin5JNN/jK/vrnfmpkDqbNNz6snoQ9nk6puFoXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774851940; c=relaxed/simple;
	bh=V2iM7WWAPZkuHcB840wa/HGvAJM+pOuflSG+IT9cOMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U7/LBp+vUj8ZL9uBscS14wDMFyQVCJtputatrFMEoHygo7EHyK8EH9zEleX5oNMr9cqGVPZYAjZ/dcx8I/if766ZK/qNWeafDZXB6wDX0XOIGEw5d2/BIB3+rssaGrpz92PWm1gk/4q9iS8DDVOHEnCPoKWO0mWuGG4Q4T4BjqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=MFdx9+jz; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qIbWKuJDaAn0koYK5nyi+7ngsUGOIfzghBpw89mahkU=;
	b=MFdx9+jzFxpmVxc9UfAfQRnnnqNMWXhwhUPbdjOiOWtzzk+codqPtSSampGzP3sAv9pMvvDOl
	talsGLLbvbRq/Lu4nrv9dPpb1YsK4c+ycS7iPVjDuDdfwezqRNgbT1DI6Y0BotqkzDaxwgilOEE
	juaXtrT1eJnMG6nOkt/kgts=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fkh123xkQzcb59;
	Mon, 30 Mar 2026 14:19:34 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 49832203A0;
	Mon, 30 Mar 2026 14:25:35 +0800 (CST)
Received: from kwepemq200001.china.huawei.com (7.202.195.16) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Mar 2026 14:25:33 +0800
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemq200001.china.huawei.com (7.202.195.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 30 Mar 2026 14:25:32 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<fanghao11@huawei.com>, <liulongfang@huawei.com>, <qianweili@huawei.com>,
	<wangzhou1@hisilicon.com>, <yinzhushuai@huawei.com>
Subject: [PATCH 1/5] crypto: hisilicon - fix the format string type error
Date: Mon, 30 Mar 2026 14:25:27 +0800
Message-ID: <20260330062531.2976138-2-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260330062531.2976138-1-huangchenghai2@huawei.com>
References: <20260330062531.2976138-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq200001.china.huawei.com (7.202.195.16)
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	FROM_NEQ_ENVFROM(0.00)[huangchenghai2@huawei.com,linux-crypto@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-22565-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:dkim,huawei.com:email,huawei.com:mid]
X-Rspamd-Queue-Id: 44C69355E3D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Zhushuai Yin <yinzhushuai@huawei.com>

1. The return value val of sec_debugfs_atomic64_get is of the
u64 type, but %lld instead of %llu is used in DEFINE_DEBUGFS_ATTRIBUTE.
Fix it.
2. In debugfs.c, since the types of q_depth and xeq_depth are u16,
the results of q_depth - 1 and xeq_depth - 1 are int rather than
u16. Use %d for int.

Signed-off-by: Zhushuai Yin <yinzhushuai@huawei.com>
Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 drivers/crypto/hisilicon/debugfs.c       | 4 ++--
 drivers/crypto/hisilicon/sec2/sec_main.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/hisilicon/debugfs.c b/drivers/crypto/hisilicon/debugfs.c
index 5d8b4112c543..e5878558dc64 100644
--- a/drivers/crypto/hisilicon/debugfs.c
+++ b/drivers/crypto/hisilicon/debugfs.c
@@ -305,7 +305,7 @@ static int q_dump_param_parse(struct hisi_qm *qm, char *s,
 
 	ret = kstrtou32(presult, 0, e_id);
 	if (ret || *e_id >= q_depth) {
-		dev_err(dev, "Please input sqe num (0-%u)", q_depth - 1);
+		dev_err(dev, "Please input sqe num (0-%d)", q_depth - 1);
 		return -EINVAL;
 	}
 
@@ -388,7 +388,7 @@ static int qm_eq_aeq_dump(struct hisi_qm *qm, char *s, char *name)
 	}
 
 	if (xeqe_id >= xeq_depth) {
-		dev_err(dev, "Please input eqe or aeqe num (0-%u)", xeq_depth - 1);
+		dev_err(dev, "Please input eqe or aeqe num (0-%d)", xeq_depth - 1);
 		return -EINVAL;
 	}
 
diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 6647b7340827..056bd8f4da5a 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -909,7 +909,7 @@ static int sec_debugfs_atomic64_set(void *data, u64 val)
 }
 
 DEFINE_DEBUGFS_ATTRIBUTE(sec_atomic64_ops, sec_debugfs_atomic64_get,
-			 sec_debugfs_atomic64_set, "%lld\n");
+			 sec_debugfs_atomic64_set, "%llu\n");
 
 static int sec_regs_show(struct seq_file *s, void *unused)
 {
-- 
2.33.0


