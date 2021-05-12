Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E165537B648
	for <lists+linux-crypto@lfdr.de>; Wed, 12 May 2021 08:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbhELGoS (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 12 May 2021 02:44:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3728 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229776AbhELGoQ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 12 May 2021 02:44:16 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Fg4sF0r7ZzmgKn;
        Wed, 12 May 2021 14:39:45 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 14:42:59 +0800
From:   Hui Tang <tanghui20@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/3] crypto: ecdh - fix 'ecdh_init'
Date:   Wed, 12 May 2021 14:40:00 +0800
Message-ID: <1620801602-49287-2-git-send-email-tanghui20@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1620801602-49287-1-git-send-email-tanghui20@huawei.com>
References: <1620801602-49287-1-git-send-email-tanghui20@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

NIST P192 is not unregistered if failed to register NIST P256,
actually it need to unregister the algorithms already registered.

Signed-off-by: Hui Tang <tanghui20@huawei.com>
---
 crypto/ecdh.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/crypto/ecdh.c b/crypto/ecdh.c
index 07eb34f..65fb685 100644
--- a/crypto/ecdh.c
+++ b/crypto/ecdh.c
@@ -182,7 +182,16 @@ static int ecdh_init(void)
 	ret = crypto_register_kpp(&ecdh_nist_p192);
 	ecdh_nist_p192_registered = ret == 0;
 
-	return crypto_register_kpp(&ecdh_nist_p256);
+	ret = crypto_register_kpp(&ecdh_nist_p256);
+	if (ret)
+		goto nist_p256_error;
+
+	return 0;
+
+nist_p256_error:
+	if (ecdh_nist_p192_registered)
+		crypto_unregister_kpp(&ecdh_nist_p192);
+	return ret;
 }
 
 static void ecdh_exit(void)
-- 
2.8.1

