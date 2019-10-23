Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7C9E194A
	for <lists+linux-crypto@lfdr.de>; Wed, 23 Oct 2019 13:48:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404929AbfJWLsd (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 23 Oct 2019 07:48:33 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:59025 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404655AbfJWLsc (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 23 Oct 2019 07:48:32 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iNF7o-000451-Tl; Wed, 23 Oct 2019 11:48:24 +0000
From:   Colin King <colin.king@canonical.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Vic Wu <vic.wu@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: mediatek: remove redundant bitwise-or
Date:   Wed, 23 Oct 2019 12:48:24 +0100
Message-Id: <20191023114824.30509-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Bitwise-or'ing 0xffffffff with the u32 variable ctr is the same result
as assigning the value to ctr.  Remove the redundant bitwise-or and
just use an assignment.

Addresses-Coverity: ("Suspicious &= or |= constant expression")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/crypto/mediatek/mtk-aes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/mediatek/mtk-aes.c b/drivers/crypto/mediatek/mtk-aes.c
index 90c9644fb8a8..d43410259113 100644
--- a/drivers/crypto/mediatek/mtk-aes.c
+++ b/drivers/crypto/mediatek/mtk-aes.c
@@ -591,7 +591,7 @@ static int mtk_aes_ctr_transfer(struct mtk_cryp *cryp, struct mtk_aes_rec *aes)
 	start = ctr;
 	end = start + blocks - 1;
 	if (end < start) {
-		ctr |= 0xffffffff;
+		ctr = 0xffffffff;
 		datalen = AES_BLOCK_SIZE * -start;
 		fragmented = true;
 	}
-- 
2.20.1

