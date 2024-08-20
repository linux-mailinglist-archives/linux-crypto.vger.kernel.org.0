Return-Path: <linux-crypto+bounces-6125-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 978E295803F
	for <lists+linux-crypto@lfdr.de>; Tue, 20 Aug 2024 09:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26563B227B8
	for <lists+linux-crypto@lfdr.de>; Tue, 20 Aug 2024 07:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E12718A6D3;
	Tue, 20 Aug 2024 07:45:59 +0000 (UTC)
X-Original-To: linux-crypto@vger.kernel.org
Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4B918C032;
	Tue, 20 Aug 2024 07:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724139959; cv=none; b=DvfW5RU8u0F4ySzZZy5Wg2Qn2l6KLmOv+esKD73mttdB4VTsby42vRCzFPlQyX0MdLJ1dyEhwHtg63BTCWuajaxeO/nuo2kZKWNa3SHJzVdl6UgZ5pE7ZPLyLYA6mrjogQA4wLv1kJMS8mgq2XxBpd8zZ4/UKMCbdxU9LyRD2wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724139959; c=relaxed/simple;
	bh=GiNQDAoi4zuzHePeXuBOmU33vVoEeDsxOHAMolrzHrY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=AHKvWS5N1nYF30oyv4DBa5TYK7FmcermZvW6ENuYdjrJAuebvdw8IPIV+hXiTDSsQxvM2NbCffvKDT8PBUYkIEPG+V4K3RZPhZ+fGnSSVDNyPgWyoYS3cnlVbWlwZ4Usa9nK207wsH0jfIoHjsW/8rxFIbXJfBS1ynKPh8X1RNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee366c448f1f39-39744;
	Tue, 20 Aug 2024 15:42:43 +0800 (CST)
X-RM-TRANSID:2ee366c448f1f39-39744
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from ubuntu.localdomain (unknown[223.108.79.99])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee766c448f2318-fe51a;
	Tue, 20 Aug 2024 15:42:43 +0800 (CST)
X-RM-TRANSID:2ee766c448f2318-fe51a
From: Zhu Jun <zhujun2@cmss.chinamobile.com>
To: mario.limonciello@amd.com
Cc: linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhu Jun <zhujun2@cmss.chinamobile.com>
Subject: [PATCH] tools/crypto:Remove unused variable
Date: Tue, 20 Aug 2024 00:42:42 -0700
Message-Id: <20240820074242.4926-1-zhujun2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-crypto@vger.kernel.org
List-Id: <linux-crypto.vger.kernel.org>
List-Subscribe: <mailto:linux-crypto+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-crypto+unsubscribe@vger.kernel.org>

the variable is never referenced in the code, just remove them.

Signed-off-by: Zhu Jun <zhujun2@cmss.chinamobile.com>
---
 tools/crypto/ccp/dbc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/crypto/ccp/dbc.c b/tools/crypto/ccp/dbc.c
index a807df0f0597..80248d3d3a5a 100644
--- a/tools/crypto/ccp/dbc.c
+++ b/tools/crypto/ccp/dbc.c
@@ -57,7 +57,6 @@ int process_param(int fd, int msg_index, __u8 *signature, int *data)
 		.msg_index = msg_index,
 		.param = *data,
 	};
-	int ret;
 
 	assert(signature);
 	assert(data);
-- 
2.17.1




