Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF75876FA21
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Aug 2023 08:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbjHDGbZ (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Aug 2023 02:31:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjHDGbZ (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Aug 2023 02:31:25 -0400
Received: from out28-73.mail.aliyun.com (out28-73.mail.aliyun.com [115.124.28.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04D3E70;
        Thu,  3 Aug 2023 23:31:23 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.1060332|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_alarm|0.0657725-0.000712165-0.933515;FP=13354101027781010926|1|1|3|0|-1|-1|-1;HT=ay29a033018047201;MF=wuyonggang001@208suo.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.U8FEBQo_1691130665;
Received: from localhost.localdomain(mailfrom:wuyonggang001@208suo.com fp:SMTPD_---.U8FEBQo_1691130665)
          by smtp.aliyun-inc.com;
          Fri, 04 Aug 2023 14:31:18 +0800
From:   Yonggang Wu <wuyonggang001@208suo.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net
Cc:     linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yonggang Wu <wuyonggang001@208suo.com>
Subject: [PATCH] lib: crypto: Modify format error
Date:   Fri,  4 Aug 2023 14:30:43 +0800
Message-Id: <20230804063043.26149-1-wuyonggang001@208suo.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

Fix the error(s):
space prohibited after that open square bracket '['

Signed-off-by: Yonggang Wu <wuyonggang001@208suo.com>
---
 lib/crypto/gf128mul.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/crypto/gf128mul.c b/lib/crypto/gf128mul.c
index 8f8c45e0cdcf..96ef5f312911 100644
--- a/lib/crypto/gf128mul.c
+++ b/lib/crypto/gf128mul.c
@@ -208,11 +208,11 @@ void gf128mul_lle(be128 *r, const be128 *b)
 	for (i = 0;;) {
 		u8 ch = ((u8 *)b)[15 - i];
 
-		be128_xor(r, r, &p[ 0 + !(ch & 0x80)]);
-		be128_xor(r, r, &p[ 2 + !(ch & 0x40)]);
-		be128_xor(r, r, &p[ 4 + !(ch & 0x20)]);
-		be128_xor(r, r, &p[ 6 + !(ch & 0x10)]);
-		be128_xor(r, r, &p[ 8 + !(ch & 0x08)]);
+		be128_xor(r, r, &p[0 + !(ch & 0x80)]);
+		be128_xor(r, r, &p[2 + !(ch & 0x40)]);
+		be128_xor(r, r, &p[4 + !(ch & 0x20)]);
+		be128_xor(r, r, &p[6 + !(ch & 0x10)]);
+		be128_xor(r, r, &p[8 + !(ch & 0x08)]);
 		be128_xor(r, r, &p[10 + !(ch & 0x04)]);
 		be128_xor(r, r, &p[12 + !(ch & 0x02)]);
 		be128_xor(r, r, &p[14 + !(ch & 0x01)]);
-- 
2.40.1

