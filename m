Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8F7CE8732
	for <lists+linux-crypto@lfdr.de>; Tue, 29 Oct 2019 12:32:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730258AbfJ2Lcg (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Tue, 29 Oct 2019 07:32:36 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:37285 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbfJ2Lcf (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Tue, 29 Oct 2019 07:32:35 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iPPjj-0006XG-Df; Tue, 29 Oct 2019 11:32:31 +0000
From:   Colin King <colin.king@canonical.com>
To:     Corentin Labbe <clabbe@baylibre.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] crypto: amlogic: ensure error variable err is set before returning it
Date:   Tue, 29 Oct 2019 11:32:30 +0000
Message-Id: <20191029113230.7050-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently when the call to crypto_engine_alloc_init fails the error
return path returns an uninitialized value in the variable err. Fix
this by setting err to -ENOMEM.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: 48fe583fe541 ("crypto: amlogic - Add crypto accelerator for amlogic GXL")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/crypto/amlogic/amlogic-gxl-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/crypto/amlogic/amlogic-gxl-core.c b/drivers/crypto/amlogic/amlogic-gxl-core.c
index db5b421e88d8..fa05fce1c0de 100644
--- a/drivers/crypto/amlogic/amlogic-gxl-core.c
+++ b/drivers/crypto/amlogic/amlogic-gxl-core.c
@@ -162,6 +162,7 @@ static int meson_allocate_chanlist(struct meson_dev *mc)
 		if (!mc->chanlist[i].engine) {
 			dev_err(mc->dev, "Cannot allocate engine\n");
 			i--;
+			err = -ENOMEM;
 			goto error_engine;
 		}
 		err = crypto_engine_start(mc->chanlist[i].engine);
-- 
2.20.1

