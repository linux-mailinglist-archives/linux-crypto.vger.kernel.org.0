Return-Path: <linux-crypto+bounces-280-lists+linux-crypto=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4710A7F8AC7
	for <lists+linux-crypto@lfdr.de>; Sat, 25 Nov 2023 13:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45C271C20BF0
	for <lists+linux-crypto@lfdr.de>; Sat, 25 Nov 2023 12:33:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A90E514F94
	for <lists+linux-crypto@lfdr.de>; Sat, 25 Nov 2023 12:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-crypto@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960E610E7;
	Sat, 25 Nov 2023 03:50:12 -0800 (PST)
Received: from kwepemm000009.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Scqm314bLzMnLh;
	Sat, 25 Nov 2023 19:45:23 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm000009.china.huawei.com (7.193.23.227) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 25 Nov 2023 19:50:09 +0800
From: Weili Qian <qianweili@huawei.com>
To: <herbert@gondor.apana.org.au>
CC: <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>
Subject: [PATCH 0/3] crypto: hisilicon - some cleanups for hisilicon drivers
Date: Sat, 25 Nov 2023 19:50:08 +0800
Message-ID: <20231125115011.22519-1-qianweili@huawei.com>
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
 kwepemm000009.china.huawei.com (7.193.23.227)
X-CFilter-Loop: Reflected

Some cleanups for hisilicon drivers, and add comments
to improve the code readability.

Weili Qian (3):
  crypto: hisilicon/sgl - small cleanups for sgl.c
  crypto: hisilicon/qm - simplify the status of qm
  crypto: hisilicon/qm - add comments and remove redundant array element

 Documentation/ABI/testing/debugfs-hisi-hpre |   2 +-
 Documentation/ABI/testing/debugfs-hisi-sec  |   2 +-
 Documentation/ABI/testing/debugfs-hisi-zip  |   2 +-
 drivers/crypto/hisilicon/debugfs.c          |   4 +
 drivers/crypto/hisilicon/qm.c               | 141 ++++----------------
 drivers/crypto/hisilicon/qm_common.h        |   4 -
 drivers/crypto/hisilicon/sgl.c              |  12 +-
 include/linux/hisi_acc_qm.h                 |   8 +-
 8 files changed, 42 insertions(+), 133 deletions(-)

-- 
2.33.0


