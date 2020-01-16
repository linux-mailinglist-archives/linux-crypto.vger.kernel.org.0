Return-Path: <linux-crypto-owner@vger.kernel.org>
X-Original-To: lists+linux-crypto@lfdr.de
Delivered-To: lists+linux-crypto@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4337613D7A5
	for <lists+linux-crypto@lfdr.de>; Thu, 16 Jan 2020 11:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730562AbgAPKPB (ORCPT <rfc822;lists+linux-crypto@lfdr.de>);
        Thu, 16 Jan 2020 05:15:01 -0500
Received: from foss.arm.com ([217.140.110.172]:47446 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726832AbgAPKPB (ORCPT <rfc822;linux-crypto@vger.kernel.org>);
        Thu, 16 Jan 2020 05:15:01 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 01EB4139F;
        Thu, 16 Jan 2020 02:15:01 -0800 (PST)
Received: from e110176-lin.arm.com (unknown [10.50.4.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9D77C3F534;
        Thu, 16 Jan 2020 02:14:59 -0800 (PST)
From:   Gilad Ben-Yossef <gilad@benyossef.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Ofir Drang <ofir.drang@arm.com>, Hadar Gat <hadar.gat@arm.com>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/11] crypto: ccree: fix typos in error msgs
Date:   Thu, 16 Jan 2020 12:14:36 +0200
Message-Id: <20200116101447.20374-2-gilad@benyossef.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200116101447.20374-1-gilad@benyossef.com>
References: <20200116101447.20374-1-gilad@benyossef.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-crypto-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-crypto.vger.kernel.org>
X-Mailing-List: linux-crypto@vger.kernel.org

From: Hadar Gat <hadar.gat@arm.com>

Fixed typos in ccree error msgs.

Signed-off-by: Hadar Gat <hadar.gat@arm.com>
---
 drivers/crypto/ccree/cc_request_mgr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/ccree/cc_request_mgr.c b/drivers/crypto/ccree/cc_request_mgr.c
index a5606dc04b06..d37b4ab50a25 100644
--- a/drivers/crypto/ccree/cc_request_mgr.c
+++ b/drivers/crypto/ccree/cc_request_mgr.c
@@ -423,7 +423,7 @@ int cc_send_request(struct cc_drvdata *drvdata, struct cc_crypto_req *cc_req,
 
 	rc = cc_pm_get(dev);
 	if (rc) {
-		dev_err(dev, "ssi_power_mgr_runtime_get returned %x\n", rc);
+		dev_err(dev, "cc_pm_get returned %x\n", rc);
 		return rc;
 	}
 
@@ -473,7 +473,7 @@ int cc_send_sync_request(struct cc_drvdata *drvdata,
 
 	rc = cc_pm_get(dev);
 	if (rc) {
-		dev_err(dev, "ssi_power_mgr_runtime_get returned %x\n", rc);
+		dev_err(dev, "cc_pm_get returned %x\n", rc);
 		return rc;
 	}
 
-- 
2.23.0

