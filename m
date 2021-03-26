Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFBD34A1A4
	for <lists+linux-crypto@lfdr.de>; Fri, 26 Mar 2021 07:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbhCZGTK (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 26 Mar 2021 02:19:10 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:14484 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbhCZGSj (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 26 Mar 2021 02:18:39 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4F6BZD5QVXzyNvF;
        Fri, 26 Mar 2021 14:16:36 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.498.0; Fri, 26 Mar 2021 14:18:26 +0800
From:   Meng Yu <yumeng18@huawei.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC:     <linux-crypto@vger.kernel.org>, <xuzaibo@huawei.com>,
        <wangzhou1@hisilicon.com>, <yumeng18@huawei.com>,
        <linux-kernel@vger.kernel.org>, <shenyang39@huawei.com>
Subject: [PATCH] pkcs7: Use octal permissions '0444'
Date:   Fri, 26 Mar 2021 14:15:56 +0800
Message-ID: <1616739356-48848-1-git-send-email-yumeng18@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Fixed following checkpatch warning:
Symbolic permissions 'S_IWUSR | S_IRUGO' are not preferred. Consider
using octal permissions '0644'.

Signed-off-by: Meng Yu <yumeng18@huawei.com>
---
 crypto/asymmetric_keys/pkcs7_key_type.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/pkcs7_key_type.c b/crypto/asymmetric_keys/pkcs7_key_type.c
index b930d3b..55a5be7 100644
--- a/crypto/asymmetric_keys/pkcs7_key_type.c
+++ b/crypto/asymmetric_keys/pkcs7_key_type.c
@@ -18,7 +18,7 @@ MODULE_DESCRIPTION("PKCS#7 testing key type");
 MODULE_AUTHOR("Red Hat, Inc.");
 
 static unsigned pkcs7_usage;
-module_param_named(usage, pkcs7_usage, uint, S_IWUSR | S_IRUGO);
+module_param_named(usage, pkcs7_usage, uint, 0644);
 MODULE_PARM_DESC(pkcs7_usage,
 		 "Usage to specify when verifying the PKCS#7 message");
 
-- 
2.8.1

