Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62884CC225
	for <lists+linux-crypto@lfdr.de>; Fri,  4 Oct 2019 19:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389165AbfJDRxP (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Fri, 4 Oct 2019 13:53:15 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:46060 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388880AbfJDRxO (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Fri, 4 Oct 2019 13:53:14 -0400
Received: from beagle7.asicdesigners.com (beagle7.asicdesigners.com [10.192.192.157])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x94Hqr0P005677;
        Fri, 4 Oct 2019 10:52:53 -0700
From:   Ayush Sawal <ayush.sawal@chelsio.com>
To:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        smueller@chronox.de
Cc:     Atul Gupta <atul.gupta@chelsio.com>
Subject: [af_alg v2] crypto:af_alg cast ki_complete ternary op to int
Date:   Fri,  4 Oct 2019 10:50:58 -0700
Message-Id: <20191004175058.11850-1-ayush.sawal@chelsio.com>
X-Mailer: git-send-email 2.20.0.rc2.7.g965798d
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

when libkcapi test is executed  using HW accelerator, cipher operation
return -74.Since af_alg_async_cb->ki_complete treat err as unsigned int,
libkcapi receive 429467222 even though it expect -ve value.

Hence its required to cast resultlen to int so that proper
error is returned to libkcapi.

AEAD one shot non-aligned test 2(libkcapi test)
./../bin/kcapi   -x 10   -c "gcm(aes)" -i 7815d4b06ae50c9c56e87bd7
-k ea38ac0c9b9998c80e28fb496a2b88d9 -a
"853f98a750098bec1aa7497e979e78098155c877879556bb51ddeb6374cbaefc"
-t "c4ce58985b7203094be1d134c1b8ab0b" -q
"b03692f86d1b8b39baf2abb255197c98"

Signed-off-by: Ayush Sawal <ayush.sawal@chelsio.com>
Signed-off-by: Atul Gupta <atul.gupta@chelsio.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

v1: cast err and resultlen to long
Signed-off-by: Ayush Sawal <ayush.sawal@chelsio.com>
---
 crypto/af_alg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 879cf23..0dceaab 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -1043,7 +1043,7 @@ void af_alg_async_cb(struct crypto_async_request *_req, int err)
 	af_alg_free_resources(areq);
 	sock_put(sk);
 
-	iocb->ki_complete(iocb, err ? err : resultlen, 0);
+	iocb->ki_complete(iocb, err ? err : (int)resultlen, 0);
 }
 EXPORT_SYMBOL_GPL(af_alg_async_cb);
 
-- 
1.8.3.1

