Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 596C5349E9D
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Mar 2021 02:24:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCZBXd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 25 Mar 2021 21:23:33 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14879 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhCZBX0 (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 25 Mar 2021 21:23:26 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F641b2WFXz9tC1;
        Fri, 26 Mar 2021 09:21:23 +0800 (CST)
Received: from huawei.com (10.67.165.24) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.498.0; Fri, 26 Mar 2021
 09:23:15 +0800
From:   Kai Ye <yekai13@huawei.com>
To:     <herbert@gondor.apana.org.au>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangzhou1@hisilicon.com>, <yekai13@huawei.com>
Subject: [PATCH 1/3] crypto: atmel - use memzero_explicit() for clearing data
Date:   Fri, 26 Mar 2021 09:20:46 +0800
Message-ID: <1616721648-56258-2-git-send-email-yekai13@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1616721648-56258-1-git-send-email-yekai13@huawei.com>
References: <1616721648-56258-1-git-send-email-yekai13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

use memzero_explicit instead of memset to clear sensitive data, such as key.

Signed-off-by: Kai Ye <yekai13@huawei.com>
---
 drivers/crypto/atmel-sha.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/atmel-sha.c b/drivers/crypto/atmel-sha.c
index 352d80c..4a08b2a 100644
--- a/drivers/crypto/atmel-sha.c
+++ b/drivers/crypto/atmel-sha.c
@@ -1622,7 +1622,7 @@ static inline void atmel_sha_hmac_key_init(struct atmel_sha_hmac_key *hkey)
 static inline void atmel_sha_hmac_key_release(struct atmel_sha_hmac_key *hkey)
 {
 	kfree(hkey->keydup);
-	memset(hkey, 0, sizeof(*hkey));
+	memzero_explicit(hkey, sizeof(*hkey));
 }
 
 static inline int atmel_sha_hmac_key_set(struct atmel_sha_hmac_key *hkey,
-- 
2.8.1

