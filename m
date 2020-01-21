Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4400143A21
	for <lists+linux-crypto@lfdr.de>; Tue, 21 Jan 2020 10:58:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgAUJ5s (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 21 Jan 2020 04:57:48 -0500
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:10340 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728794AbgAUJ5r (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 21 Jan 2020 04:57:47 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04446;MF=tianjia.zhang@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0ToHfB4z_1579600654;
Received: from localhost(mailfrom:tianjia.zhang@linux.alibaba.com fp:SMTPD_---0ToHfB4z_1579600654)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 21 Jan 2020 17:57:34 +0800
From:   Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] crypto: proc - simplify the c_show function
Date:   Tue, 21 Jan 2020 17:57:18 +0800
Message-Id: <20200121095718.52404-7-tianjia.zhang@linux.alibaba.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200121095718.52404-1-tianjia.zhang@linux.alibaba.com>
References: <20200121095718.52404-1-tianjia.zhang@linux.alibaba.com>
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

The path with the CRYPTO_ALG_LARVAL flag has jumped to the end before

Signed-off-by: Tianjia Zhang <tianjia.zhang@linux.alibaba.com>
---
 crypto/proc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/proc.c b/crypto/proc.c
index 7b91557adccb..08d8c2bc7e62 100644
--- a/crypto/proc.c
+++ b/crypto/proc.c
@@ -60,7 +60,7 @@ static int c_show(struct seq_file *m, void *p)
 		goto out;
 	}
 	
-	switch (alg->cra_flags & (CRYPTO_ALG_TYPE_MASK | CRYPTO_ALG_LARVAL)) {
+	switch (alg->cra_flags & CRYPTO_ALG_TYPE_MASK) {
 	case CRYPTO_ALG_TYPE_CIPHER:
 		seq_printf(m, "type         : cipher\n");
 		seq_printf(m, "blocksize    : %u\n", alg->cra_blocksize);
-- 
2.17.1

