Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D630D1AB3F0
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Apr 2020 00:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732304AbgDOWuD (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 15 Apr 2020 18:50:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:52998 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725800AbgDOWuB (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 15 Apr 2020 18:50:01 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jOqqp-0003Ne-TH; Wed, 15 Apr 2020 22:49:47 +0000
From:   Colin King <colin.king@canonical.com>
To:     Ayush Sawal <ayush.sawal@chelsio.com>,
        Vinay Kumar Yadav <vinay.yadav@chelsio.com>,
        Rohit Maheshwari <rohitm@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: chelsio: remove redundant assignment to variable error
Date:   Wed, 15 Apr 2020 23:49:47 +0100
Message-Id: <20200415224947.1565311-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable error is being initialized with a value that is never read
and it is being updated later with a new value.  The initialization is
redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/crypto/chelsio/chcr_algo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/chelsio/chcr_algo.c b/drivers/crypto/chelsio/chcr_algo.c
index c29b80dd30d8..5d3000fdd5f4 100644
--- a/drivers/crypto/chelsio/chcr_algo.c
+++ b/drivers/crypto/chelsio/chcr_algo.c
@@ -1757,7 +1757,7 @@ static int chcr_ahash_final(struct ahash_request *req)
 	struct uld_ctx *u_ctx = ULD_CTX(h_ctx(rtfm));
 	struct chcr_context *ctx = h_ctx(rtfm);
 	u8 bs = crypto_tfm_alg_blocksize(crypto_ahash_tfm(rtfm));
-	int error = -EINVAL;
+	int error;
 	unsigned int cpu;
 
 	cpu = get_cpu();
-- 
2.25.1

