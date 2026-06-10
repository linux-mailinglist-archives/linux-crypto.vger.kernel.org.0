Return-Path: <linux-crypto+bounces-25007-lists+linux-crypto=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-crypto@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id X7pwDtHAKGpXJAMAu9opvQ
	(envelope-from <linux-crypto+bounces-25007-lists+linux-crypto=lfdr.de@vger.kernel.org>)
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Jun 2026 03:41:37 +0200
X-Original-To: lists+linux-crypto@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DA1A665469
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Jun 2026 03:41:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=huawei.com header.s=dkim header.b=sDJRQ4ta;
	spf=pass (mail.lfdr.de: domain of "linux-crypto+bounces-25007-lists+linux-crypto=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-crypto+bounces-25007-lists+linux-crypto=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=huawei.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1D1AE30325A7
	for <lists+linux-crypto@lfdr.de>; Wed, 10 Jun 2026 01:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E62328466F;
	Wed, 10 Jun 2026 01:34:48 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from canpmsgout10.his.huawei.com (canpmsgout10.his.huawei.com [113.46.200.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9291C27AC31;
	Wed, 10 Jun 2026 01:34:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781055287; cv=none; b=uD6XxOcrl2+esZMT3F5UxEWetGUs5ZG+3hyAr4JfGa+L5jnSGC62xaQ2gOQKVz5+6UTyF1UoWjRg2zWCq+/kUMAqkaANPH8RVMNe+UVRWQzA25gLK/8AJVkQZ4M/S/FURywY43fXCsYHtZDhlUGxvmr3FRV8P943cK2UYbHrwTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781055287; c=relaxed/simple;
	bh=RpDlFmoaL6fP/Fh6Zo74YHQDi1nPidAuVYgxB5T9rP8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pk9P98OyRZ9YJrFuEynJYBylMYBfcIX6wN9q2G529fzWsZzc+mViDi2sDLV2hnaRQO0HB+cVm9px9wNH3h6DMDWVZIsQiYPaegB0X9yMbNklkXk3vg4rbCDuHEgSSEeHYD0R3i4pp+TCDB+a9uMApxDU6CEOSusJ7N6EFpG3FB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=sDJRQ4ta; arc=none smtp.client-ip=113.46.200.225
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=fsJv/QMhLT5GMl33vhwMXp5cDRu3eIkqfuH1+wY1z6s=;
	b=sDJRQ4talTv2URGca5fUtOkqG5EdsxbhbHVRjbcHlmn4OXHXF8GiGU+A0tP/r1BVn/SVdWMbR
	LhR4tPiUZthZJ+p1D6RYFO+aAmCTcrygiswsgucAe51uIDGe0n3C2uI9MSYhfX1QjdFyXJlhCY7
	QRiv2pQBsBG/3HBd8GAICmw=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout10.his.huawei.com (SkyGuard) with ESMTPS id 4gZp5y0WhCz1K9CG;
	Wed, 10 Jun 2026 09:26:46 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
	by mail.maildlp.com (Postfix) with ESMTPS id C72D44056A;
	Wed, 10 Jun 2026 09:34:38 +0800 (CST)
Received: from kwepemq200001.china.huawei.com (7.202.195.16) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Jun 2026 09:34:38 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemq200001.china.huawei.com (7.202.195.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 10 Jun 2026 09:34:38 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <shenyang39@huawei.com>, <fanghao11@huawei.com>, <liulongfang@huawei.com>,
	<qianweili@huawei.com>, <wangzhou1@hisilicon.com>,
	<herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: update hisilicon zip driver maintainer
Date: Wed, 10 Jun 2026 09:34:37 +0800
Message-ID: <20260610013437.1354503-1-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemq200001.china.huawei.com (7.202.195.16)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[huawei.com:D:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-25007-lists,linux-crypto=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,hisilicon.com:url,hisilicon.com:email];
	FROM_NEQ_ENVFROM(0.00)[huangchenghai2@huawei.com,linux-crypto@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:shenyang39@huawei.com,m:fanghao11@huawei.com,m:liulongfang@huawei.com,m:qianweili@huawei.com,m:wangzhou1@hisilicon.com,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:linux-kernel@vger.kernel.org,m:linux-crypto@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[huangchenghai2@huawei.com,linux-crypto@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ALIAS_RESOLVED(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	TAGGED_RCPT(0.00)[linux-crypto];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6DA1A665469

Add Chenghai Huang as the maintainer of the hisilicon zip driver,
replacing Yang Shen.

Signed-off-by: Chenghai Huang<huangchenghai2@huawei.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 882214b0e7db..7c66740aeb3c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11714,7 +11714,7 @@ W:	http://www.hisilicon.com
 F:	drivers/spi/spi-hisi-sfc-v3xx.c
 
 HISILICON ZIP Controller DRIVER
-M:	Yang Shen <shenyang39@huawei.com>
+M:	Chenghai Huang<huangchenghai2@huawei.com>
 M:	Zhou Wang <wangzhou1@hisilicon.com>
 L:	linux-crypto@vger.kernel.org
 S:	Maintained
-- 
2.43.0


