Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15D1510AC33
	for <lists+linux-crypto@lfdr.de>; Wed, 27 Nov 2019 09:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726852AbfK0It1 (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Wed, 27 Nov 2019 03:49:27 -0500
Received: from foss.arm.com ([217.140.110.172]:44562 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726722AbfK0It0 (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Wed, 27 Nov 2019 03:49:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C5CE131B;
        Wed, 27 Nov 2019 00:49:25 -0800 (PST)
Received: from e110176-lin.kfn.arm.com (unknown [10.50.4.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 664E03F52E;
        Wed, 27 Nov 2019 00:49:24 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>, Hadar Gat <hadar.gat@arm.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] crypto: ccree: fix typos in error msgs
Date:   Wed, 27 Nov 2019 10:49:07 +0200
Message-Id: <20191127084909.14472-4-gilad@benyossef.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191127084909.14472-1-gilad@benyossef.com>
References: <20191127084909.14472-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Hadar Gat <hadar.gat@arm.com>

Fix some typos in error message text.

Signed-off-by: Hadar Gat <hadar.gat@arm.com>
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 drivers/crypto/ccree/cc_driver.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/ccree/cc_driver.c b/drivers/crypto/ccree/cc_driver.c
index 929ae5b468d8..1bbe82fce4a5 100644
--- a/drivers/crypto/ccree/cc_driver.c
+++ b/drivers/crypto/ccree/cc_driver.c
@@ -465,7 +465,7 @@ static int init_cc_resources(struct platform_device *plat_dev)
 
 	rc = cc_fips_init(new_drvdata);
 	if (rc) {
-		dev_err(dev, "CC_FIPS_INIT failed 0x%x\n", rc);
+		dev_err(dev, "cc_fips_init failed 0x%x\n", rc);
 		goto post_debugfs_err;
 	}
 	rc = cc_sram_mgr_init(new_drvdata);
@@ -490,13 +490,13 @@ static int init_cc_resources(struct platform_device *plat_dev)
 
 	rc = cc_buffer_mgr_init(new_drvdata);
 	if (rc) {
-		dev_err(dev, "buffer_mgr_init failed\n");
+		dev_err(dev, "cc_buffer_mgr_init failed\n");
 		goto post_req_mgr_err;
 	}
 
 	rc = cc_pm_init(new_drvdata);
 	if (rc) {
-		dev_err(dev, "ssi_power_mgr_init failed\n");
+		dev_err(dev, "cc_pm_init failed\n");
 		goto post_buf_mgr_err;
 	}
 
-- 
2.23.0

