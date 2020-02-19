Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B414164523
	for <lists+linux-crypto@lfdr.de>; Wed, 19 Feb 2020 14:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726891AbgBSNRq (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 19 Feb 2020 08:17:46 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:23011 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727589AbgBSNRq (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 19 Feb 2020 08:17:46 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R231e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0TqNBlJ8_1582118252;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0TqNBlJ8_1582118252)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 19 Feb 2020 21:17:32 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        ebiggers@kernel.org, pvanleeuwen@rambus.com, zohar@linux.ibm.com
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] X.509: fix debugging information without newline tag
Date:   Wed, 19 Feb 2020 21:17:31 +0800
Message-Id: <20200219131731.46087-1-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Added missing newline tag to this line of pr_devel debug information.

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/asymmetric_keys/x509_public_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/asymmetric_keys/x509_public_key.c b/crypto/asymmetric_keys/x509_public_key.c
index feccec08b244..4553619ea01d 100644
--- a/crypto/asymmetric_keys/x509_public_key.c
+++ b/crypto/asymmetric_keys/x509_public_key.c
@@ -140,7 +140,7 @@ int x509_check_for_self_signed(struct x509_certificate *cert)
 		goto out;
 	}
 
-	pr_devel("Cert Self-signature verified");
+	pr_devel("Cert Self-signature verified\n");
 	cert->self_signed = true;
 
 out:
-- 
2.17.1

