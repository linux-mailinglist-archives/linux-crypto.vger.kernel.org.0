Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8204D2226F7
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Jul 2020 17:29:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbgGPP3L (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Jul 2020 11:29:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59968 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728415AbgGPP3K (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Jul 2020 11:29:10 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jw5oj-0003p5-5r; Thu, 16 Jul 2020 15:29:01 +0000
From:   Colin King <colin.king@canonical.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Ard Biesheuvel <ardb@kernel.org>, linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: xts: use memmove to avoid overlapped memory copy
Date:   Thu, 16 Jul 2020 16:29:00 +0100
Message-Id: <20200716152900.1709694-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a memcpy that performs a potential overlapped memory copy
from source b to destination b + 1.  Fix this by using the safer
memmove instead.

Addresses-Coverity: ("Overlapping buffer in memory copy")
Fixes: 8083b1bf8163 ("crypto: xts - add support for ciphertext stealing")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 crypto/xts.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/crypto/xts.c b/crypto/xts.c
index 3565f3b863a6..fa3e6e7b7043 100644
--- a/crypto/xts.c
+++ b/crypto/xts.c
@@ -169,7 +169,7 @@ static int cts_final(struct skcipher_request *req,
 				      offset - XTS_BLOCK_SIZE);
 
 	scatterwalk_map_and_copy(b, rctx->tail, 0, XTS_BLOCK_SIZE, 0);
-	memcpy(b + 1, b, tail);
+	memmove(b + 1, b, tail);
 	scatterwalk_map_and_copy(b, req->src, offset, tail, 0);
 
 	le128_xor(b, &rctx->t, b);
-- 
2.27.0

