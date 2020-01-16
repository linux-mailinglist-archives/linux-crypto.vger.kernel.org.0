Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C975A13D73D
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Jan 2020 10:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729546AbgAPJuB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Jan 2020 04:50:01 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:60799 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbgAPJuB (ORCPT
        <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Jan 2020 04:50:01 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1is1ml-0007F2-1S; Thu, 16 Jan 2020 09:49:55 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jens Wiklander <jens.wiklander@linaro.org>,
        Gary R Hook <gary.hook@amd.com>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        tee-dev@lists.linaro.org, linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next][resend] tee: fix memory allocation failure checks on drv_data and amdtee
Date:   Thu, 16 Jan 2020 09:49:54 +0000
Message-Id: <20200116094954.54476-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the memory allocation failure checks on drv_data and
amdtee are using IS_ERR rather than checking for a null pointer.
Fix these checks to use the conventional null pointer check.

Addresses-Coverity: ("Dereference null return")
Fixes: 757cc3e9ff1d ("tee: add AMD-TEE driver")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/tee/amdtee/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tee/amdtee/core.c b/drivers/tee/amdtee/core.c
index 9d0cee1c837f..5fda810c79dc 100644
--- a/drivers/tee/amdtee/core.c
+++ b/drivers/tee/amdtee/core.c
@@ -444,11 +444,11 @@ static int __init amdtee_driver_init(void)
 		goto err_fail;
 
 	drv_data = kzalloc(sizeof(*drv_data), GFP_KERNEL);
-	if (IS_ERR(drv_data))
+	if (!drv_data)
 		return -ENOMEM;
 
 	amdtee = kzalloc(sizeof(*amdtee), GFP_KERNEL);
-	if (IS_ERR(amdtee)) {
+	if (!amdtee) {
 		rc = -ENOMEM;
 		goto err_kfree_drv_data;
 	}
-- 
2.24.0

