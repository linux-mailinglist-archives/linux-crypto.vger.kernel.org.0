Return-Path: <linux-crypto+bounces-24665-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOr1GscuGGpwfggAu9opvQ
	(envelope-from <linux-crypto+bounces-24665-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Thu, 28 May 2026 14:02:15 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DAA45F1C5D
	for <lists+linux-crypto@lfdr.de>; Thu, 28 May 2026 14:02:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3B6E230CA179
	for <lists+linux-crypto@lfdr.de>; Thu, 28 May 2026 11:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0D33E7BB7;
	Thu, 28 May 2026 11:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Y1yxId+3"
X-Original-To: linux-crypto@vger.kernel.org
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57233E3C6E;
	Thu, 28 May 2026 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779969431; cv=none; b=CmPhwpLRGCP15TGDeQPC1BAg6zDO5FTkoh8w07s7zndlYQAi5S8bnd0uIvxUhxdxLhVbfLoeg6Si3Lzvru84bvCOJ8kT/GfKOD0hFTttPt5n6D+aBPIA4pK3scfxZSfOOOKg+besTMFOWVfQ/CymomZgINcEb/QyuOqojoybUIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779969431; c=relaxed/simple;
	bh=RpfQ9WrTOeup7Sy7rf5/jxtHFHeBZQ6nZTRTz7Z75uc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EukfGkTtkHrnczj/spo96xVAv0rYkkEHmUOS1JNyVug1Q25LzKZGGKIiexTEL7WDuOUO+5LErY8ZEzSz/N7SMP+Q+zFO6vNz7ojxGrnXOuKrF3bOwYbHQvzMBS6cDH7P4THUdh93pQeKxT+6pQJ3FG5H0P9SyGCYWma9zqBZRWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Y1yxId+3; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=qnOoMsLQ6kpgCmvd5NrLA/RVrndZYUZaB+k/6EKH67U=;
	b=Y1yxId+3/eMfDHfGgNQJ8mInjeUMS+GDjgHG5ofrSraxxLLiDluMox6vjtN1epRSIAM2RBmML
	275iy1JydABiBPkrx3pvAzzOT85uROCDA+buh1mAfV3bFid/Ohq7Q+3NUKloJxdyJFvpb1SwtMV
	Pjnxf7CzweHmXv+FurbSwNc=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gR4X95S87zRhQm;
	Thu, 28 May 2026 19:49:13 +0800 (CST)
Received: from kwepemr100008.china.huawei.com (unknown [7.202.195.119])
	by mail.maildlp.com (Postfix) with ESMTPS id B94CD40537;
	Thu, 28 May 2026 19:56:59 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemr100008.china.huawei.com (7.202.195.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 28 May 2026 19:56:59 +0800
From: ZongYu Wu <wuzongyu1@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<fanghao11@huawei.com>, <liulongfang@huawei.com>, <qianweili@huawei.com>,
	<wangzhou1@hisilicon.com>, <huangchenghai2@huawei.com>,
	<linwenkai6@hisilicon.com>
Subject: [PATCH v2 0/5] crypto: hisilicon - improve backlog handling
Date: Thu, 28 May 2026 19:55:26 +0800
Message-ID: <20260528115531.174593-1-wuzongyu1@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr100008.china.huawei.com (7.202.195.119)
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
	FROM_NEQ_ENVFROM(0.00)[wuzongyu1@huawei.com,linux-crypto@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-24665-lists,linux-crypto=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-crypto];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:mid,huawei.com:dkim]
X-Rspamd-Queue-Id: 1DAA45F1C5D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series improves backlog handling for HiSilicon crypto drivers.

The ZIP and HPRE drivers are extended to support backlog queuing when
the hardware queue is temporarily busy. Instead of failing requests
immediately under hardware congestion, requests can now be queued and
resubmitted when previous requests complete.

In addition, three issues in the hisilicon/sec2 driver have been fixed:
- A UAF problem in the backlog path.
- A resource leak issue in non-backlog mode (The software fallback
mechanism has also been removed).
- When the CTR task is terminated, the IV is restored to ensure that
subsequent tasks use the correct IV.

Changes in v2:
- Obtain the service type through enum, not qp->alg_type.
- Move the backlog list empty check to after the req creation,
as frequently checking and skipping in the send_backlog can
affect performance.
- Fix a resource leak issue in non-backlog mode.
- A fix for the CTR mode issue is added.
- Link to v1: https://lore.kernel.org/all/20260518142956.3593934-1-wuzongyu1@huawei.com/

Chenghai Huang (1):
  crypto: hisilicon/zip - add backlog support for zip

Wenkai Lin (3):
  crypto: hisilicon/sec2 - fix UAF in sec_alg_send_backlog
  crypto: hisilicon/sec2 - fix resource leakage issues in non-backlog
    mode
  crypto: hisilicon/sec2 - restore iv for ctr mode

lizhi (1):
  crypto: hisilicon/hpre - implement full backlog support for hpre
    driver

 drivers/crypto/hisilicon/hpre/hpre_crypto.c | 223 +++++++++++----
 drivers/crypto/hisilicon/sec2/sec_crypto.c  |  48 ++--
 drivers/crypto/hisilicon/zip/zip_crypto.c   | 286 +++++++++++++-------
 3 files changed, 371 insertions(+), 186 deletions(-)

-- 
2.33.0


